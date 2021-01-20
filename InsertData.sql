/*Gender*/
INSERT INTO Gender(Name) VALUES('Мужской');
INSERT INTO Gender(Name) VALUES('Женский');

COMMIT;

/*Position*/
INSERT INTO Position(Name) VALUES('Тренер');
INSERT INTO Position(Name) VALUES('Массажист');
INSERT INTO Position(Name) VALUES('Врач');

COMMIT;

/*Country*/
INSERT INTO Country(Name) VALUES('Россия');
INSERT INTO Country(Name) VALUES('Англия');
INSERT INTO Country(Name) VALUES('Франция');
INSERT INTO Country(Name) VALUES('Япония');

COMMIT;

/*City*/
INSERT INTO City(Name, ID_Country) VALUES('Москва', 1);
INSERT INTO City(Name, ID_Country) VALUES('Воронеж', 1);
INSERT INTO City(Name, ID_Country) VALUES('Манчестер', 2);
INSERT INTO City(Name, ID_Country) VALUES('Бирмингем', 2);
INSERT INTO City(Name, ID_Country) VALUES('Ница', 3);
INSERT INTO City(Name, ID_Country) VALUES('Канны', 3);
INSERT INTO City(Name, ID_Country) VALUES('Токио', 4);
INSERT INTO City(Name, ID_Country) VALUES('Осака', 4);

COMMIT;

/*Location*/
INSERT INTO Location(Stadium_name, Address, Coating_type, Places_count, ID_City)
VALUES('Зенит арена', 'Нижне-моравская 45', 'Исскуственная трава', 5000, 1);
INSERT INTO Location(Stadium_name, Address, Coating_type, Places_count, ID_City)
VALUES('Спорт риаль', 'Европейская 15', 'Исскуственная трава', 10000, 3);
INSERT INTO Location(Stadium_name, Address, Coating_type, Places_count, ID_City)
VALUES('Барто конил', 'Кардиля 18_д', 'Асфальт', 4000, 5);
INSERT INTO Location(Stadium_name, Address, Coating_type, Places_count, ID_City)
VALUES('Курио стад', 'Среднии пруда 1*', 'Исскуственная трава', 5500, 7);
INSERT INTO Location(Stadium_name, Address, Coating_type, Places_count, ID_City)
VALUES('Школьный двор', 'Сосновый бор 90', 'Грязь', 3500, 7);

COMMIT;

/*Owner*/
INSERT INTO Owner(First_name, Last_name, Patronymic) VALUES ('Лоуренс', 'Эллисон', 'Джозеф');
INSERT INTO Owner(First_name, Last_name, Patronymic) VALUES ('Роберт', 'Майнер', 'Нимрод');
INSERT INTO Owner(First_name, Last_name, Patronymic) VALUES ('Эдвард', 'Рогин', 'Эд');
INSERT INTO Owner(First_name, Last_name, Patronymic) VALUES ('Джеймс', 'Гослинг', 'Джава');

COMMIT;

/*Club*/
INSERT INTO Club(Name, ID_Country) VALUES('Спартак', 1);
INSERT INTO Club(Name, ID_Country) VALUES('Манчестер Юнайтед', 2);

COMMIT;

/*ClubOwner*/
INSERT INTO ClubOwner(ID_Club, ID_Owner, Profit, Ownership_percentage) VALUES(1, 1, 50000, 20);
INSERT INTO ClubOwner(ID_Club, ID_Owner, Profit, Ownership_percentage) VALUES(1, 2, 200000, 80);
INSERT INTO ClubOwner(ID_Club, ID_Owner, Profit, Ownership_percentage) VALUES(2, 3, 30000, 20);
INSERT INTO ClubOwner(ID_Club, ID_Owner, Profit, Ownership_percentage) VALUES(2, 4, 70000, 50);
INSERT INTO ClubOwner(ID_Club, ID_Owner, Profit, Ownership_percentage) VALUES(2, 1, 40000, 30);

COMMIT;

/*Command*/
INSERT INTO Command(Name, Rating, ID_Club) VALUES('Факел топ', 5, 1);
INSERT INTO Command(Name, Rating, ID_Club) VALUES('Барселона', 4, 1);
INSERT INTO Command(Name, Rating, ID_Club) VALUES('Ливерпуль', 8, 2);
INSERT INTO Command(Name, Rating, ID_Club) VALUES('Тру футболисты', 9, 2);

COMMIT;

/*Player*/
INSERT INTO Player(First_name, Last_name, Patronymic, Birth_date, Scored_goals, Beated_goals, ID_Command, ID_Gender, Salary) 
VALUES('Иван', 'Иванов-Иванко', 'Иванович', TO_DATE('08/10/1990', 'MM/DD/YYYY'), 2, 3, 1, 1, 10000);
INSERT INTO Player(First_name, Last_name, Patronymic, Birth_date, Scored_goals, Beated_goals, ID_Command, ID_Gender, Salary) 
VALUES('Петр', 'Петров-Петко', 'Петрович', TO_DATE('07/13/1991', 'MM/DD/YYYY'), 3, 1, 1, 1, 20000);
INSERT INTO Player(First_name, Last_name, Patronymic, Birth_date, Scored_goals, Beated_goals, ID_Command, ID_Gender, Salary) 
VALUES('Кер', 'Кан', 'Кар', TO_DATE('12/10/1994', 'MM/DD/YYYY'), 2, 4, 1, 1, 30000);
INSERT INTO Player(First_name, Last_name, Patronymic, Birth_date, Scored_goals, Beated_goals, ID_Command, ID_Gender, Salary) 
VALUES('Сидр', 'Сидров', 'Сидрович', TO_DATE('03/15/1993', 'MM/DD/YYYY'), 0, 2, 2, 1, 30000);
INSERT INTO Player(First_name, Last_name, Patronymic, Birth_date, Scored_goals, Beated_goals, ID_Command, ID_Gender, Salary) 
VALUES('Нурлан', 'Дайтен', 'Ляхов', TO_DATE('10/04/1995', 'MM/DD/YYYY'), 5, 4, 2, 1, 10000);
INSERT INTO Player(First_name, Last_name, Patronymic, Birth_date, Scored_goals, Beated_goals, ID_Command, ID_Gender, Salary) 
VALUES('Аки', 'Кан', 'Дуни', TO_DATE('01/30/1991', 'MM/DD/YYYY'), 5, 2, 2, 1, 30000);
INSERT INTO Player(First_name, Last_name, Patronymic, Birth_date, Scored_goals, Beated_goals, ID_Command, ID_Gender, Salary) 
VALUES('Андрей', 'Рогин', 'Романов', TO_DATE('05/20/1990', 'MM/DD/YYYY'), 0, 3, 3, 1, 20000);
INSERT INTO Player(First_name, Last_name, Patronymic, Birth_date, Scored_goals, Beated_goals, ID_Command, ID_Gender, Salary) 
VALUES('Саня', 'Тавров', 'Алехандров', TO_DATE('02/20/1978', 'MM/DD/YYYY'), 3, 0, 3, 1, 40000);
INSERT INTO Player(First_name, Last_name, Patronymic, Birth_date, Scored_goals, Beated_goals, ID_Command, ID_Gender, Salary)
VALUES('Лионель', 'Месси', 'Иванович', TO_DATE('09/30/1992', 'MM/DD/YYYY'), 2, 2, 4, 1, 30000);
INSERT INTO Player(First_name, Last_name, Patronymic, Birth_date, Scored_goals, Beated_goals, ID_Command, ID_Gender, Salary) 
VALUES('Рональдинио', 'Карп', 'Иванович', TO_DATE('05/10/1979', 'MM/DD/YYYY'), 1, 3, 4, 1, 25000);
INSERT INTO Player(First_name, Last_name, Patronymic, Birth_date, Scored_goals, Beated_goals, ID_Command, ID_Gender, Salary) 
VALUES('Аки', 'Кан', 'Аль', TO_DATE('08/20/1993', 'MM/DD/YYYY'), 4, 0, NULL, 1, 40000);

COMMIT;

/*Worker*/
INSERT INTO Worker(First_name, Last_name, Patronymic, Birth_date, Salary, ID_Position, ID_Gender) 
VALUES('Леомель', 'Гостес', 'Вангер', TO_DATE('01/10/1988', 'MM/DD/YYYY'), 50000, 1, 1);
INSERT INTO Worker(First_name, Last_name, Patronymic, Birth_date, Salary, ID_Position, ID_Gender) 
VALUES('Варин', 'Рогин', 'Санти', TO_DATE('02/09/1989', 'MM/DD/YYYY'), 15000, 1, 1);
INSERT INTO Worker(First_name, Last_name, Patronymic, Birth_date, Salary, ID_Position, ID_Gender) 
VALUES('Диана', 'Лугина', 'Ивановна', TO_DATE('03/20/1998', 'MM/DD/YYYY'), 5000, 1, 2);
INSERT INTO Worker(First_name, Last_name, Patronymic, Birth_date, Salary, ID_Position, ID_Gender) 
VALUES('Валерия', 'Новина', 'Анатольевна', TO_DATE('04/15/1992', 'MM/DD/YYYY'), 10000, 1, 2);
INSERT INTO Worker(First_name, Last_name, Patronymic, Birth_date, Salary, ID_Position, ID_Gender) 
VALUES('Анастасия', 'Кариева', 'Александровна', TO_DATE('05/06/1994', 'MM/DD/YYYY'), 25000, 2, 2);
INSERT INTO Worker(First_name, Last_name, Patronymic, Birth_date, Salary, ID_Position, ID_Gender) 
VALUES('Екатерина', 'Колнева', 'Петровна', TO_DATE('06/10/1990', 'MM/DD/YYYY'), 20000, 3, 2);

COMMIT;

/*CommandWorker*/
INSERT INTO CommandWorker(ID_Command, ID_Worker, Date_start, Date_end) 
VALUES(1, 1, TO_DATE('05/06/2009', 'MM/DD/YYYY'), TO_DATE('03/08/2013', 'MM/DD/YYYY'));
INSERT INTO CommandWorker(ID_Command, ID_Worker, Date_start, Date_end) 
VALUES(2, 1, TO_DATE('04/10/2014', 'MM/DD/YYYY'), NULL);
INSERT INTO CommandWorker(ID_Command, ID_Worker, Date_start, Date_end) 
VALUES(2, 2, TO_DATE('08/06/2011', 'MM/DD/YYYY'), TO_DATE('06/08/2014', 'MM/DD/YYYY'));
INSERT INTO CommandWorker(ID_Command, ID_Worker, Date_start, Date_end) 
VALUES(3, 2, TO_DATE('02/01/2015', 'MM/DD/YYYY'), NULL);
INSERT INTO CommandWorker(ID_Command, ID_Worker, Date_start, Date_end) 
VALUES(1, 3, TO_DATE('08/06/2008', 'MM/DD/YYYY'), NULL);
INSERT INTO CommandWorker(ID_Command, ID_Worker, Date_start, Date_end) 
VALUES(4, 4, TO_DATE('01/04/2011', 'MM/DD/YYYY'), NULL);
INSERT INTO CommandWorker(ID_Command, ID_Worker, Date_start, Date_end) 
VALUES(3, 5, TO_DATE('06/10/2010', 'MM/DD/YYYY'), NULL);
INSERT INTO CommandWorker(ID_Command, ID_Worker, Date_start, Date_end) 
VALUES(1, 6, TO_DATE('02/16/2012', 'MM/DD/YYYY'), NULL);

COMMIT;

/*TrainingBase*/
INSERT INTO TrainingBase(Name, Adress, Field_count, ID_City) VALUES('Стадион мечты', 'Московский проспект 19а', 3, 2);
INSERT INTO TrainingBase(Name, Adress, Field_count, ID_City) VALUES('Обычный стадион', 'Авто ряйзево 6', 2, 5);
INSERT INTO TrainingBase(Name, Adress, Field_count, ID_City) VALUES('Норм стадион', 'Центральная 12', 4, 4);
INSERT INTO TrainingBase(Name, Adress, Field_count, ID_City) VALUES('Такой себе стадион', 'Люке сит 7б', 1, 8);

COMMIT;

/*Assemble*/
INSERT INTO Assemble(ID_TrainingBase, ID_Club, ID_Command, Date_start, Date_end) 
VALUES(2, 1, 1, TO_DATE('05/01/2019', 'MM/DD/YYYY'), TO_DATE('05/21/2019', 'MM/DD/YYYY'));
INSERT INTO Assemble(ID_TrainingBase, ID_Club, ID_Command, Date_start, Date_end) 
VALUES(2, 1, 2, TO_DATE('07/05/2019', 'MM/DD/YYYY'), TO_DATE('08/05/2019', 'MM/DD/YYYY'));
INSERT INTO Assemble(ID_TrainingBase, ID_Club, ID_Command, Date_start, Date_end) 
VALUES(2, 1, 3, TO_DATE('02/09/2019', 'MM/DD/YYYY'), TO_DATE('03/04/2019', 'MM/DD/YYYY'));
INSERT INTO Assemble(ID_TrainingBase, ID_Club, ID_Command, Date_start, Date_end) 
VALUES(4, 2, 1, TO_DATE('08/10/2019', 'MM/DD/YYYY'), TO_DATE('09/01/2019', 'MM/DD/YYYY'));
INSERT INTO Assemble(ID_TrainingBase, ID_Club, ID_Command, Date_start, Date_end) 
VALUES(4, 2, 2, TO_DATE('04/20/2019', 'MM/DD/YYYY'), TO_DATE('05/10/2019', 'MM/DD/YYYY'));
INSERT INTO Assemble(ID_TrainingBase, ID_Club, ID_Command, Date_start, Date_end) 
VALUES(4, 2, 3, TO_DATE('03/06/2019', 'MM/DD/YYYY'), TO_DATE('04/11/2019', 'MM/DD/YYYY'));

COMMIT;

/*Competition*/
INSERT INTO Competition(Date_start, Date_end, Name, Type, Prize_pool, ID_City ) 
VALUES (TO_DATE('05/05/2016', 'MM/DD/YYYY'), TO_DATE('06/06/2016', 'MM/DD/YYYY'), 'При рут', 'Кубок мира', 1000000, 2);
INSERT INTO Competition(Date_start, Date_end, Name, Type, Prize_pool, ID_City ) 
VALUES (TO_DATE('06/06/2017', 'MM/DD/YYYY'), TO_DATE('07/07/2017', 'MM/DD/YYYY'), 'Ай кае', 'Чемпионат', 10000000, 4);
INSERT INTO Competition(Date_start, Date_end, Name, Type, Prize_pool, ID_City ) 
VALUES (TO_DATE('07/07/2018', 'MM/DD/YYYY'), TO_DATE('08/08/2018', 'MM/DD/YYYY'), 'Су тре', 'Кубок Европы', 5000000, 6);
INSERT INTO Competition(Date_start, Date_end, Name, Type, Prize_pool, ID_City ) 
VALUES (TO_DATE('08/08/2019', 'MM/DD/YYYY'), TO_DATE('09/09/2019', 'MM/DD/YYYY'), 'Кар но', 'Мировые соревнования', 100000000, 8);
INSERT INTO Competition(Date_start, Date_end, Name, Type, Prize_pool, ID_City ) 
VALUES (TO_DATE('09/09/2019', 'MM/DD/YYYY'), TO_DATE('10/10/2019', 'MM/DD/YYYY'), 'Топ пот', 'Чемпионат России', 10000, 2);

COMMIT;

/*Match*/
INSERT INTO Match(ID_Command1, ID_Command2, ID_Competition, ID_Location, Num, 
Event_date, Season, Type, Ticket_price, Sold_tickets_count, Weather, Score1, Score2) 
VALUES(1, 2, 1, 1, 1, TO_TIMESTAMP('2016-05-15 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Лига', 'Дружеский', 500, 5000, 'Солнечно', 2, 3);
INSERT INTO Match(ID_Command1, ID_Command2, ID_Competition, ID_Location, Num, 
Event_date, Season, Type, Ticket_price, Sold_tickets_count, Weather, Score1, Score2) 
VALUES(2, 3, 1, 2, 2, TO_TIMESTAMP('2016-05-25 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Лига', 'Дружеский', 400, 10000, 'Солнечно', 3, 1);
INSERT INTO Match(ID_Command1, ID_Command2, ID_Competition, ID_Location, Num, 
Event_date, Season, Type, Ticket_price, Sold_tickets_count, Weather, Score1, Score2) 
VALUES(1, 3, 2, 3, 1, TO_TIMESTAMP('2017-06-15 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Лига', 'Дружеский', 700, 15000, 'Дождливо', 3, 3);
INSERT INTO Match(ID_Command1, ID_Command2, ID_Competition, ID_Location, Num, 
Event_date, Season, Type, Ticket_price, Sold_tickets_count, Weather, Score1, Score2) 
VALUES(1, 2, 2, 4, 2, TO_TIMESTAMP('2017-06-25 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Лига', 'Дружеский', 500, 5000, 'Солнечно', 1, 1);
INSERT INTO Match(ID_Command1, ID_Command2, ID_Competition, ID_Location, Num, 
Event_date, Season, Type, Ticket_price, Sold_tickets_count, Weather, Score1, Score2) 
VALUES(2, 3, 3, 1, 1, TO_TIMESTAMP('2018-07-15 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Лига', 'Дружеский', 1000, 8000, 'Солнечно', 4, 3);
INSERT INTO Match(ID_Command1, ID_Command2, ID_Competition, ID_Location, Num, 
Event_date, Season, Type, Ticket_price, Sold_tickets_count, Weather, Score1, Score2) 
VALUES(1, 3, 3, 2, 2, TO_TIMESTAMP('2018-07-25 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Лига', 'Дружеский', 800, 12000, 'Туманно', 4, 0);
INSERT INTO Match(ID_Command1, ID_Command2, ID_Competition, ID_Location, Num, 
Event_date, Season, Type, Ticket_price, Sold_tickets_count, Weather, Score1, Score2) 
VALUES(1, 2, 4, 3, 1, TO_TIMESTAMP('2019-08-15 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Лига', 'Дружеский', 1500, 6000, 'Солнечно', 0, 3);
INSERT INTO Match(ID_Command1, ID_Command2, ID_Competition, ID_Location, Num, 
Event_date, Season, Type, Ticket_price, Sold_tickets_count, Weather, Score1, Score2) 
VALUES(2, 3, 4, 4, 2, TO_TIMESTAMP('2019-08-25 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Лига', 'Дружеский', 500, 5500, 'Дождливо', 4, 3);
INSERT INTO Match(ID_Command1, ID_Command2, ID_Competition, ID_Location, Num, 
Event_date, Season, Type, Ticket_price, Sold_tickets_count, Weather, Score1, Score2) 
VALUES(4, 3, 5, 1, 1, TO_TIMESTAMP('2019-09-10 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Лига', 'Дружеский', 800, 8000, 'Солнечно', 1, 0);
INSERT INTO Match(ID_Command1, ID_Command2, ID_Competition, ID_Location, Num, 
Event_date, Season, Type, Ticket_price, Sold_tickets_count, Weather, Score1, Score2) 
VALUES(4, 2, 5, 2, 2, TO_TIMESTAMP('2019-09-15 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Лига', 'Дружеский', 600, 15500, 'Дождливо', 2, 3);
INSERT INTO Match(ID_Command1, ID_Command2, ID_Competition, ID_Location, Num, 
Event_date, Season, Type, Ticket_price, Sold_tickets_count, Weather, Score1, Score2) 
VALUES(1, 4, 5, 3, 1, TO_TIMESTAMP('2019-09-20 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Лига', 'Дружеский', 600, 11000, 'Солнечно', 3, 0);
INSERT INTO Match(ID_Command1, ID_Command2, ID_Competition, ID_Location, Num, 
Event_date, Season, Type, Ticket_price, Sold_tickets_count, Weather, Score1, Score2) 
VALUES(4, 2, 5, 4, 2, TO_TIMESTAMP('2019-09-25 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Лига', 'Дружеский', 600, 10500, 'Туманно', 0, 3);

COMMIT;