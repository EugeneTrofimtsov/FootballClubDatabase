/*Country*/
DROP TABLE Country CASCADE CONSTRAINTS;
DROP SEQUENCE country_sequence;

CREATE TABLE Country
(
	ID_Country           INT NOT NULL ,
	Name                 VARCHAR2(30) NOT NULL ,
CONSTRAINT  XPKCountry PRIMARY KEY (ID_Country)
);

CREATE SEQUENCE country_sequence START WITH 1;

CREATE OR REPLACE TRIGGER country_on_insert 
    BEFORE INSERT ON Country 
    FOR EACH ROW
BEGIN
    SELECT country_sequence.NEXTVAL
    INTO   :new.ID_Country
    FROM   dual;
END;
/

/*Club*/
DROP TABLE Club CASCADE CONSTRAINTS;
DROP SEQUENCE club_sequence;

CREATE TABLE Club
(
	ID_Club              INT NOT NULL ,
	Name                 VARCHAR2(30) NOT NULL ,
	ID_Country           INT NULL ,
CONSTRAINT  XPKClub PRIMARY KEY (ID_Club),
CONSTRAINT R_18 FOREIGN KEY (ID_Country) REFERENCES Country (ID_Country) ON DELETE SET NULL
);

CREATE SEQUENCE club_sequence START WITH 1;

CREATE OR REPLACE TRIGGER club_on_insert 
    BEFORE INSERT ON Club 
    FOR EACH ROW
BEGIN
    SELECT club_sequence.NEXTVAL
    INTO   :new.ID_Club
    FROM   dual;
END;
/

/*Command*/
DROP TABLE Command CASCADE CONSTRAINTS;
DROP SEQUENCE command_sequence;

CREATE TABLE Command
(
	ID_Command           INT NOT NULL ,
	Name                 VARCHAR2(30) NOT NULL ,
	Rating               INT DEFAULT 0 ,
	ID_Club              INT NOT NULL ,
CONSTRAINT  XPKCommand PRIMARY KEY (ID_Command),
CONSTRAINT R_1 FOREIGN KEY (ID_Club) REFERENCES Club (ID_Club)
);

CREATE SEQUENCE command_sequence START WITH 1;

CREATE OR REPLACE TRIGGER command_on_insert 
    BEFORE INSERT ON Command 
    FOR EACH ROW
BEGIN
    SELECT command_sequence.NEXTVAL
    INTO   :new.ID_Command
    FROM   dual;
END;
/

/*City*/
DROP TABLE City CASCADE CONSTRAINTS;
DROP SEQUENCE city_sequence;

CREATE TABLE City
(
	ID_City              INT NOT NULL ,
	Name                 VARCHAR2(30) NOT NULL ,
	ID_Country           INT NULL ,
CONSTRAINT  XPKCity PRIMARY KEY (ID_City),
CONSTRAINT R_17 FOREIGN KEY (ID_Country) REFERENCES Country (ID_Country) ON DELETE SET NULL
);

CREATE SEQUENCE city_sequence START WITH 1;

CREATE OR REPLACE TRIGGER city_on_insert 
    BEFORE INSERT ON City 
    FOR EACH ROW
BEGIN
    SELECT city_sequence.NEXTVAL
    INTO   :new.ID_City
    FROM   dual;
END;
/

/*Competition*/
DROP TABLE Competition CASCADE CONSTRAINTS;
DROP SEQUENCE competition_sequence;

CREATE TABLE Competition
(
	ID_Competition       INT NOT NULL ,
	Date_start           DATE NULL ,
	Date_end             DATE NULL ,
	Name                 VARCHAR2(30) NOT NULL ,
	Type                 VARCHAR2(30) NOT NULL ,
	Prize_pool           INT NOT NULL ,
	ID_City              INT NULL ,
CONSTRAINT  XPKCompetition PRIMARY KEY (ID_Competition),
CONSTRAINT R_20 FOREIGN KEY (ID_City) REFERENCES City (ID_City) ON DELETE SET NULL
);

CREATE SEQUENCE competition_sequence START WITH 1;

CREATE OR REPLACE TRIGGER competition_on_insert 
    BEFORE INSERT ON Competition 
    FOR EACH ROW
BEGIN
    SELECT competition_sequence.NEXTVAL
    INTO   :new.ID_Competition
    FROM   dual;
END;
/

/*Location*/
DROP TABLE Location CASCADE CONSTRAINTS;
DROP SEQUENCE location_sequence;

CREATE TABLE Location
(
	ID_Location          INT NOT NULL ,
	Stadium_name         VARCHAR2(30) NOT NULL ,
	Address              VARCHAR2(30) NOT NULL ,
	Coating_type         VARCHAR2(30) NOT NULL ,
	Places_count         INT NOT NULL ,
	ID_City              INT NULL ,
CONSTRAINT  XPKLocation PRIMARY KEY (ID_Location),
CONSTRAINT R_21 FOREIGN KEY (ID_City) REFERENCES City (ID_City) ON DELETE SET NULL
);

CREATE SEQUENCE location_sequence START WITH 1;

CREATE OR REPLACE TRIGGER location_on_insert 
    BEFORE INSERT ON Location 
    FOR EACH ROW
BEGIN
    SELECT location_sequence.NEXTVAL
    INTO   :new.ID_Location
    FROM   dual;
END;
/

/*Match*/
DROP TABLE Match;
DROP SEQUENCE match_sequence;

CREATE TABLE Match
(
	ID_Match             INT NOT NULL ,
	ID_Command1          INT NOT NULL ,
	ID_Command2          INT NOT NULL ,
	ID_Competition       INT NOT NULL ,
	ID_Location          INT NOT NULL ,
	Num                  INT NOT NULL ,
	Event_date           TIMESTAMP NOT NULL ,
	Season               VARCHAR2(30) NOT NULL ,
	Type                 VARCHAR2(30) NOT NULL ,
	Ticket_price         INT NOT NULL ,
	Sold_tickets_count   INT NOT NULL ,
	Weather              VARCHAR2(30) NOT NULL ,
	Score1               INT NOT NULL ,
	Score2               INT NOT NULL ,
CONSTRAINT  XPKMatch PRIMARY KEY (ID_Match),
CONSTRAINT R_9 FOREIGN KEY (ID_Command1) REFERENCES Command (ID_Command),
CONSTRAINT R_11 FOREIGN KEY (ID_Command2) REFERENCES Command (ID_Command),
CONSTRAINT R_12 FOREIGN KEY (ID_Competition) REFERENCES Competition (ID_Competition),
CONSTRAINT R_13 FOREIGN KEY (ID_Location) REFERENCES Location (ID_Location)
);

CREATE SEQUENCE match_sequence START WITH 1;

CREATE OR REPLACE TRIGGER match_on_insert 
    BEFORE INSERT ON Match 
    FOR EACH ROW
BEGIN
    SELECT match_sequence.NEXTVAL
    INTO   :new.ID_Match
    FROM   dual;
END;
/

/*TrainingBase*/
DROP TABLE TrainingBase CASCADE CONSTRAINTS;
DROP SEQUENCE trainingbase_sequence;

CREATE TABLE TrainingBase
(
	ID_TrainingBase      INT NOT NULL ,
	Name                 VARCHAR2(30) NOT NULL ,
	Adress               VARCHAR2(30) NOT NULL ,
	Field_count          INT NOT NULL ,
	ID_City              INT NULL ,
CONSTRAINT  XPKTrainingBases PRIMARY KEY (ID_TrainingBase),
CONSTRAINT R_19 FOREIGN KEY (ID_City) REFERENCES City (ID_City) ON DELETE SET NULL
);

CREATE SEQUENCE trainingbase_sequence START WITH 1;

CREATE OR REPLACE TRIGGER trainingbase_on_insert 
    BEFORE INSERT ON TrainingBase 
    FOR EACH ROW
BEGIN
    SELECT trainingbase_sequence.NEXTVAL
    INTO   :new.ID_TrainingBase
    FROM   dual;
END;
/

/*Assemble*/
DROP TABLE Assemble;
DROP SEQUENCE assemble_sequence;

CREATE TABLE Assemble
(
	ID_Assemble          INT NOT NULL ,
	ID_TrainingBase      INT NOT NULL ,
	ID_Club              INT NOT NULL ,
	ID_Command           INT NOT NULL ,
	Date_start           DATE NULL ,
	Date_end             DATE NULL ,
CONSTRAINT  XPKAssembles PRIMARY KEY (ID_Assemble),
CONSTRAINT R_6 FOREIGN KEY (ID_TrainingBase) REFERENCES TrainingBase (ID_TrainingBase),
CONSTRAINT R_7 FOREIGN KEY (ID_Club) REFERENCES Club (ID_Club),
CONSTRAINT R_8 FOREIGN KEY (ID_Command) REFERENCES Command (ID_Command)
);

CREATE SEQUENCE assemble_sequence START WITH 1;

CREATE OR REPLACE TRIGGER assemble_on_insert 
    BEFORE INSERT ON Assemble 
    FOR EACH ROW
BEGIN
    SELECT assemble_sequence.NEXTVAL
    INTO   :new.ID_Assemble
    FROM   dual;
END;
/

/*Position*/
DROP TABLE Position CASCADE CONSTRAINTS;
DROP SEQUENCE position_sequence;

CREATE TABLE Position
(
	ID_Position          INT NOT NULL ,
	Name                 VARCHAR2(30) NOT NULL ,
CONSTRAINT  XPKPosition PRIMARY KEY (ID_Position)
);

CREATE SEQUENCE position_sequence START WITH 1;

CREATE OR REPLACE TRIGGER position_on_insert 
    BEFORE INSERT ON Position 
    FOR EACH ROW
BEGIN
    SELECT position_sequence.NEXTVAL
    INTO   :new.ID_Position
    FROM   dual;
END;
/

/*Gender*/
DROP TABLE Gender CASCADE CONSTRAINTS;
DROP SEQUENCE gender_sequence;

CREATE TABLE Gender
(
	ID_Gender            INT NOT NULL ,
	Name                 VARCHAR2(30) NOT NULL ,
CONSTRAINT  XPKGender PRIMARY KEY (ID_Gender)
);

CREATE SEQUENCE gender_sequence START WITH 1;

CREATE OR REPLACE TRIGGER gender_on_insert 
    BEFORE INSERT ON Gender 
    FOR EACH ROW
BEGIN
    SELECT gender_sequence.NEXTVAL
    INTO   :new.ID_Gender
    FROM   dual;
END;
/

/*Worker*/
DROP TABLE Worker CASCADE CONSTRAINTS;
DROP SEQUENCE worker_sequence;

CREATE TABLE Worker
(
	ID_Worker            INT NOT NULL ,
	First_name           VARCHAR2(30) NOT NULL ,
	Last_name            VARCHAR2(30) NOT NULL ,
	Patronymic           VARCHAR2(30) NOT NULL ,
	Birth_date           DATE NOT NULL ,
	Salary               INT NOT NULL ,
	ID_Position          INT NOT NULL ,
	ID_Gender            INT NULL ,
CONSTRAINT  XPKWorkers PRIMARY KEY (ID_Worker),
CONSTRAINT R_14 FOREIGN KEY (ID_Position) REFERENCES Position (ID_Position),
CONSTRAINT R_16 FOREIGN KEY (ID_Gender) REFERENCES Gender (ID_Gender) ON DELETE SET NULL
);

CREATE SEQUENCE worker_sequence START WITH 1;

CREATE OR REPLACE TRIGGER worker_on_insert 
    BEFORE INSERT ON Worker 
    FOR EACH ROW
BEGIN
    SELECT worker_sequence.NEXTVAL
    INTO   :new.ID_Worker
    FROM   dual;
END;
/

/*CommandWorker*/
DROP TABLE CommandWorker;

CREATE TABLE CommandWorker
(
	ID_Command           INT NOT NULL ,
	ID_Worker            INT NOT NULL ,
	Date_start           DATE NULL ,
	Date_end             DATE NULL ,
CONSTRAINT  XPKCommandWorker PRIMARY KEY (ID_Command,ID_Worker),
CONSTRAINT R_22 FOREIGN KEY (ID_Command) REFERENCES Command (ID_Command),
CONSTRAINT R_23 FOREIGN KEY (ID_Worker) REFERENCES Worker (ID_Worker)
);

/*Player*/
DROP TABLE Player;
DROP SEQUENCE player_sequence;

CREATE TABLE Player
(
	ID_Player            INT NOT NULL ,
	First_name           VARCHAR2(30) NOT NULL ,
	Last_name            VARCHAR2(30) NOT NULL ,
	Patronymic           VARCHAR2(30) NOT NULL ,
	Birth_date           DATE NOT NULL ,
	Scored_goals         INT DEFAULT 0 ,
	Beated_goals         INT DEFAULT 0 ,
	ID_Command           INT NULL ,
	ID_Gender            INT NULL ,
	Salary               INT NOT NULL ,
CONSTRAINT  XPKPlayers PRIMARY KEY (ID_Player),
CONSTRAINT R_4 FOREIGN KEY (ID_Command) REFERENCES Command (ID_Command) ON DELETE SET NULL ,
CONSTRAINT R_15 FOREIGN KEY (ID_Gender) REFERENCES Gender (ID_Gender) ON DELETE SET NULL
);

CREATE SEQUENCE player_sequence START WITH 1;

CREATE OR REPLACE TRIGGER player_on_insert 
    BEFORE INSERT ON Player 
    FOR EACH ROW
BEGIN
    SELECT player_sequence.NEXTVAL
    INTO   :new.ID_Player
    FROM   dual;
END;
/

/*Owner*/
DROP TABLE Owner CASCADE CONSTRAINTS;
DROP SEQUENCE owner_sequence;

CREATE TABLE Owner
(
	ID_Owner             INT NOT NULL ,
	First_name           VARCHAR2(30) NOT NULL ,
	Last_name            VARCHAR2(30) NOT NULL ,
	Patronymic           VARCHAR2(30) NOT NULL ,
CONSTRAINT  XPKOwner PRIMARY KEY (ID_Owner)
);

CREATE SEQUENCE owner_sequence START WITH 1;

CREATE OR REPLACE TRIGGER owner_on_insert 
    BEFORE INSERT ON Owner 
    FOR EACH ROW
BEGIN
    SELECT owner_sequence.NEXTVAL
    INTO   :new.ID_Owner
    FROM   dual;
END;
/

/*ClubOwner*/
DROP TABLE ClubOwner;

CREATE TABLE ClubOwner
(
	ID_Club              INT NOT NULL ,
	ID_Owner             INT NOT NULL ,
	Profit               INT DEFAULT 0 ,
	Ownership_percentage SMALLINT NOT NULL ,
CONSTRAINT  XPKClubOwner PRIMARY KEY (ID_Club,ID_Owner),
CONSTRAINT R_2 FOREIGN KEY (ID_Club) REFERENCES Club (ID_Club),
CONSTRAINT R_3 FOREIGN KEY (ID_Owner) REFERENCES Owner (ID_Owner)
);