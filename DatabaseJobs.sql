select * from all_synonyms where table_owner = 'MYUSER';

select * from user_triggers;
show errors;

CREATE OR REPLACE TRIGGER validate_player_salary
BEFORE INSERT OR UPDATE OF salary ON player
FOR EACH ROW
DECLARE
	CUR_PROFIT INT;
	ADD_PROFIT INT;
	CLUB_PROFIT INT;
BEGIN
	IF INSERTING THEN ADD_PROFIT := :NEW.salary;
	ELSIF UPDATING THEN ADD_PROFIT := :NEW.salary - :OLD.salary;
	END IF;
	SELECT SUM(profit) INTO CLUB_PROFIT FROM clubowner WHERE id_club = (SELECT id_club FROM command WHERE id_command = :NEW.id_command);
	SELECT SUM(salary) INTO CUR_PROFIT FROM player WHERE id_command = :NEW.id_command;
	IF CLUB_PROFIT <= CUR_PROFIT + ADD_PROFIT THEN
	RAISE_APPLICATION_ERROR (-20111, 'We will not take out such an expensive purchase.');
	END IF;
END;
/

// CUR = 60000 // MAX = 250000 //
INSERT INTO Player(First_name, Last_name, Patronymic, Birth_date, Scored_goals, Beated_goals, ID_Command, ID_Gender, Salary) 
VALUES('Тест1', 'Тест', 'Тест', TO_DATE('09/09/1990', 'MM/DD/YYYY'), 0, 0, 1, 1, 120000);
INSERT INTO Player(First_name, Last_name, Patronymic, Birth_date, Scored_goals, Beated_goals, ID_Command, ID_Gender, Salary) 
VALUES('Тест2', 'Тест', 'Тест', TO_DATE('09/09/1990', 'MM/DD/YYYY'), 0, 0, 1, 1, 120000);

DELETE FROM player WHERE first_name LIKE 'Тест%';

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE SEQUENCE match_history_sequence START WITH 1;

CREATE TABLE match_history
(
	ID_Match_History     INT NOT NULL,
	ID_Command1          INT NOT NULL,
	ID_Command2          INT NOT NULL,
	ID_Competition       INT NOT NULL,
	ID_Location          INT NOT NULL,
	Num                  INT NOT NULL,
	Event_date           TIMESTAMP NOT NULL,
	Season               VARCHAR2(30) NOT NULL,
	Type                 VARCHAR2(30) NOT NULL,
	Ticket_price         INT NOT NULL,
	Sold_tickets_count   INT NOT NULL,
	Weather              VARCHAR2(30) NOT NULL,
	Score1               INT NOT NULL,
	Score2               INT NOT NULL,
	User_name            VARCHAR2(30) NOT NULL,
	Delete_date          TIMESTAMP NOT NULL
);

CREATE OR REPLACE TRIGGER delete_match_history
AFTER DELETE ON match
FOR EACH ROW
DECLARE
	ID_Match_History INT;
BEGIN
	SELECT match_history_sequence.NEXTVAL INTO ID_Match_History FROM dual;
	INSERT INTO match_history(ID_Match_History, ID_Command1, ID_Command2, ID_Competition, ID_Location, Num, 
	Event_date, Season, Type, Ticket_price, Sold_tickets_count, Weather, Score1, Score2, User_name, Delete_date)
	VALUES (ID_Match_History, :OLD.ID_Command1, :OLD.ID_Command2, :OLD.ID_Competition, :OLD.ID_Location, :OLD.Num, :OLD.Event_date,
	:OLD.Season, :OLD.Type, :OLD.Ticket_price, :OLD.Sold_tickets_count, :OLD.Weather, :OLD.Score1, :OLD.Score2, USER, SYSDATE);
END;
/

INSERT INTO Match(ID_Command1, ID_Command2, ID_Competition, ID_Location, Num, 
Event_date, Season, Type, Ticket_price, Sold_tickets_count, Weather, Score1, Score2) 
VALUES(1, 2, 1, 1, 1, TO_TIMESTAMP('2015-05-15 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Тест', 'Дружеский', 5000, 5000, 'Солнечно', 0, 0);

DELETE FROM match WHERE season = 'Тест';

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

UPDATE city SET name = 'Москва' WHERE id_city = 1;
UPDATE city SET name = 'Воронеж' WHERE id_city = 2;

ALTER SYSTEM KILL SESSION

SELECT SID, SERIAL#, USERNAME FROM V$SESSION WHERE SID IN (SELECT BLOCKING_SESSION FROM V$SESSION);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

SHOW PARAMETER background_dump_dest;

ALTER SYSTEM SET audit_trail=‘DB’ SCOPE=SPFILE;
shutdown immediate/startup

AUDIT SELECT, UPDATE on city;

SELECT username, obj_name, action_name, extended_timestamp
FROM sys.dba_audit_trail
WHERE user IS NOT NULL AND obj_name IS NOT NULL
ORDER BY 4;

begin dbms_fga.add_policy (
	object_schema => 'MYUSER',
	object_name => 'CITY',
	policy_name => 'AUDIT_CITY',
	audit_column => 'NAME',
	enable => TRUE, 
	statement_types => 'UPDATE');
end;
/

SELECT db_user, object_name, extended_timestamp, statement_type, sql_text FROM sys.dba_fga_audit_trail;

begin dbms_fga.drop_policy (
	object_schema => 'MYUSER',
	object_name => 'CITY',
	policy_name => 'AUDIT_CITY');
end;
/

CREATE SEQUENCE audit_city_sequence START WITH 1;

CREATE TABLE audit_city
(
ID_audit_job NUMBER(6),
Db_user VARCHAR2(255),
Os_user VARCHAR2(30),
Time_stamp DATE,
id_value VARCHAR2(10),
old_value VARCHAR2(30),
new_value VARCHAR2(30)
);

CREATE OR REPLACE TRIGGER audit_city_trigger
BEFORE UPDATE OF name ON city
FOR EACH ROW
DECLARE
	ID_audit INT;
BEGIN
	SELECT audit_city_sequence.NEXTVAL INTO ID_audit FROM dual;
	INSERT INTO audit_city(ID_audit_job, Db_user, Os_user, Time_stamp, id_value, old_value, new_value)
	VALUES (ID_audit, USER, SYS_CONTEXT('USERENV', 'OS_USER'), SYSDATE, :OLD.ID_City, :OLD.Name, :NEW.Name);
END;
/

ALTER SYSTEM SET audit_trail=‘NONE’ SCOPE=SPFILE;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

select * from USER_SCHEDULER_JOBS;
select * from USER_SCHEDULER_PROGRAMS;
select * from USER_SCHEDULER_SCHEDULES;
select * from USER_SCHEDULER_RUNNING_JOBS;
select * from USER_SCHEDULER_JOB_RUN_DETAILS;

CREATE PROCEDURE generate_names AS
BEGIN
UPDATE city SET name = (SELECT DBMS_RANDOM. STRING('A', 10) FROM DUAL) WHERE id_city = 1;
END;
/

BEGIN
DBMS_SCHEDULER.CREATE_PROGRAM (
program_name => 'my_program',
program_type => 'STORED_PROCEDURE',
program_action => 'generate_names');
END;
/

EXECUTE DBMS_SCHEDULER.ENABLE ('my_program')

BEGIN
DBMS_SCHEDULER.CREATE_SCHEDULE (
schedule_name => 'my_schedule',
start_date => SYSTIMESTAMP,
end_date => SYSTIMESTAMP + INTERVAL '30' day,
repeat_interval => 'FREQ=SECONDLY; INTERVAL=3');
END;
/

BEGIN
DBMS_SCHEDULER.CREATE_JOB (
job_name => 'my_job',
program_name => 'my_program',
schedule_name => 'my_schedule');
END;
/

EXECUTE DBMS_SCHEDULER.ENABLE ('my_job')

BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE (
name => 'my_schedule',
attribute => 'repeat_interval',
value => 'FREQ=SECONDLY; INTERVAL=10');
END;
/

BEGIN
DBMS_SCHEDULER.DROP_JOB ('my_job');
END;
/

BEGIN
DBMS_SCHEDULER.DROP_SCHEDULE ('my_schedule');
END;
/

BEGIN
DBMS_SCHEDULER.DROP_PROGRAM ('my_program');
END;
/

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

select name, value from v$spparameter where name = 'control_files';

ALTER DATABASE BACKUP CONTROLFILE TO TRACE AS 'C:\oracle\cf_orcl.sql';

c:\app\etrofimtsov\diag\rdbms\orcl\orcl\trace - alert.log

show parameter db_recovery_file_dest_size;
ALTER SYSTEM SET db_recovery_file_dest_size = 8589934592 SCOPE=BOTH;
db_recovery_file_dest = C:\app\etrofimtsov\flash_recovery_area

show parameter log_archive_dest;
show parameter log_archive_dest_1;
show parameter log_archive_format;

SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
ALTER DATABASE ARCHIVELOG;
ALTER DATABASE OPEN;

SELECT status FROM v$instance; # OPEN

ARCHIVE LOG LIST

SELECT name FROM v$datafile;
SELECT member FROM v$logfile;
SELECT name FROM v$controlfile;

rman
connect target sys/admin;

CONFIGURE CHANNEL DEVICE TYPE DISK FORMAT 'C:\oracle\BACKUP\%d_%s.%T';
CONFIGURE RETENTION POLICY TO REDUNDANCY 2;
CONFIGURE CONTROLFILE AUTOBACKUP ON;
BACKUP DATABASE PLUS ARCHIVELOG; #  полное резервное копирование БД вместе с архивами redo.log
LIST BACKUP;

select * from city;
INSERT INTO city(Name, ID_Country) VALUES('Апаран', 4);
commit;

ORA-01157: cannot identify/lock data file 6 - see DBWR trace file
ORA-01110: data file 6: 'C:\APP\ETROFIMTSOV\ORADATA\ORCL\DATAFILE\TEST1.DBF'

ALTER DATABASE DATAFILE 6 OFFLINE;

RESTORE DATAFILE 6;
RECOVER DATAFILE 6;

ALTER DATABASE DATAFILE 6 ONLINE;

ORA-00205: error in identifying control file, check alert log for more info

RESTORE CONTROLFILE FROM AUTOBACKUP;
RECOVER DATABASE;

ALTER DATABASE OPEN RESETLOGS;

BACKUP INCREMENTAL LEVEL 0 TABLESPACE mytbs;
select * from city;
INSERT INTO city(Name, ID_Country) VALUES('Параран', 4);
commit;
BACKUP INCREMENTAL LEVEL 1 TABLESPACE mytbs;

CROSSCHECK BACKUP;
DELETE NOPROMPT OBSOLETE;