/*1. Выбрать все данные о футболистах. Результат отсортировать по фамилии в лексикографическом порядке, по имени и отчеству
в порядке обратном лексикографическому.*/

SELECT
    id_player,
    first_name,
    last_name,
    patronymic,
    birth_date,
    scored_goals,
    beated_goals,
    id_command,
    id_gender,
    salary
FROM
    player
ORDER BY
    last_name ASC,
    first_name DESC,
    patronymic DESC;

/*2. Выбрать фамилию и инициалы футболистов в одном столбце, дату рождения в формате год, число, название месяца, дата рождения.
Результат отсортировать по возрасту игроков в порядке убывания.*/

SELECT
    last_name
    || ' '
    || substr(first_name, 1, 1)
    || '. '
    || substr(patronymic, 1, 1)
    || '.' AS fio,
    to_char(birth_date, 'YYYY DD MONTH') AS date1,
    birth_date AS date2
FROM
    player
ORDER BY
    birth_date DESC;

/*3. Выбрать игроков с фамилией из трех или четырех букв. Результат отсортировать по длине фамилии.*/

SELECT
    id_player,
    first_name,
    last_name,
    patronymic,
    birth_date,
    scored_goals,
    beated_goals,
    id_command,
    id_gender,
    salary
FROM
    player
WHERE
    last_name LIKE '___'
    OR last_name LIKE '____'
ORDER BY
    length(last_name);

/*4. Выбрать названия улиц, которые не содержат символы, -,_,\.*/

SELECT
    address
FROM
    location
WHERE
    address NOT LIKE '%-%'
    AND address NOT LIKE '%,%'
    AND address NOT LIKE '%*%'
    AND address NOT LIKE '%\%'
    AND address NOT LIKE '%/%'
    AND address NOT LIKE '%.%'
    AND address NOT LIKE '%!_%' ESCAPE '!';

/*5. Выбрать ФИО футболистов, для которых не указана команда.*/

SELECT
    first_name,
    last_name,
    patronymic
FROM
    player
WHERE
    id_command IS NULL;

/*6. Выбрать ФИО игроков, возраст которых менее 26 лет.*/

SELECT
    first_name,
    last_name,
    patronymic
FROM
    player
WHERE
    floor(months_between(current_date, birth_date) / 12) < 26;

/*7. Выбрать все данные об игроках, рожденных зимой.*/

SELECT
    id_player,
    first_name,
    last_name,
    patronymic,
    birth_date,
    scored_goals,
    beated_goals,
    id_command,
    id_gender,
    salary
FROM
    player
WHERE
    EXTRACT(MONTH FROM birth_date) IN (
        12,
        1,
        2
    );

/*8. Выбрать ФИО персонала, работающего с командами с id равному 3, 4, 5, 7 или 9.*/

SELECT
    first_name,
    last_name,
    patronymic
FROM
    worker
    JOIN commandworker ON worker.id_worker = commandworker.id_worker
WHERE
    id_command IN (
        3,
        4,
        5,
        7,
        9
    )
    AND date_end IS NULL;

/*9. Выбрать id и ФИО персонала заглавными буквами с зарплатой от 20000 до 45 000.*/

SELECT
    id_worker,
    upper(first_name) AS first_name,
    upper(last_name) AS last_name,
    upper(patronymic) AS patronymic
FROM
    worker
WHERE
    salary BETWEEN 20000 AND 45000;

/*10.Выбрать данные игроков с двойной фамилией, принявших участие в матчах, проходивших весной и летом.*/

SELECT DISTINCT
    player.id_player,
    player.first_name,
    player.last_name,
    player.patronymic,
    player.birth_date,
    player.scored_goals,
    player.beated_goals,
    player.id_command,
    player.id_gender,
    player.salary
FROM
    player
    JOIN command ON player.id_command = command.id_command
    JOIN match ON command.id_command = match.id_command1
WHERE
    last_name LIKE '%-%'
    AND EXTRACT(MONTH FROM event_date) IN (
        3,
        4,
        5,
        6,
        7,
        8
    );

/*11.Выбрать минимальную прибыль от клуба.*/

SELECT
    MIN(sum_profit) AS min_profit
FROM
    (
        SELECT
            SUM(profit) AS sum_profit
        FROM
            club
            JOIN clubowner ON club.id_club = clubowner.id_club
        GROUP BY
            club.id_club
    );

/*12.Выбрать среднюю продолжительность соревнований.*/

SELECT
    to_char(floor(AVG(date_end - date_start)))
    || ' days' AS duration
FROM
    competition;

/*13.Выбрать максимальную и минимальную зарплату обслуживающего персонала.*/

SELECT
    MAX(salary) AS max_salary,
    MIN(salary) AS min_salary
FROM
    worker;

/*14.Выбрать среднюю цену билета на матчи, проходившие осенью, и среднюю цену билета на матчи, проходившие весной.*/

SELECT
    (
        SELECT
            AVG(ticket_price)
        FROM
            match
        WHERE
            EXTRACT(MONTH FROM event_date) IN (
                9,
                10,
                11
            )
    ) AS autumn_price,
    (
        SELECT
            AVG(ticket_price)
        FROM
            match
        WHERE
            EXTRACT(MONTH FROM event_date) IN (
                3,
                4,
                5
            )
    ) AS spring_price
FROM
    sys.dual;

/*Another way of 14*/

SELECT
    AVG(
        CASE
            WHEN EXTRACT(MONTH FROM event_date) IN(
                9, 10, 11
            ) THEN
                ticket_price
        END
    ) AS autumn_price,
    AVG(
        CASE
            WHEN EXTRACT(MONTH FROM event_date) IN(
                3, 4, 5
            ) THEN
                ticket_price
        END
    ) AS spring_price
FROM
    match;

/*15.Для каждого года рождения вывести количество игроков, рожденных в этом году.*/

SELECT
    EXTRACT(YEAR FROM birth_date) AS year,
    COUNT(*) AS birth_count
FROM
    player
GROUP BY
    EXTRACT(YEAR FROM birth_date);

/*16.Выбрать ФИО футболиста, название команды. Результат отсортировать по команде, возрасту игрока, фамилии, имени, отчеству.*/

SELECT
    player.first_name,
    player.last_name,
    player.patronymic,
    command.name AS command_name
FROM
    player
    JOIN command ON player.id_command = command.id_command
ORDER BY
    command.name,
    floor(months_between(current_date, player.birth_date) / 12),
    player.last_name,
    player.first_name,
    player.patronymic;

/*17.Выбрать данные о стадионах, на которых проходили матчи, без повторений.*/

SELECT DISTINCT
    location.id_location,
    location.stadium_name,
    location.address,
    location.coating_type,
    location.places_count,
    location.id_city
FROM
    location
    JOIN match ON location.id_location = match.id_location;

/*18.Выбрать фамилию и инициалы игроков (в одном столбце), названия команд, название клуба, год, дату проведения матча, 
название типа матча, название состязаний, стадион, счет матча. Результат отсортировать по типу матча, дате проведения.*/

SELECT
    player.last_name
    || ' '
    || substr(player.first_name, 1, 1)
    || '. '
    || substr(player.patronymic, 1, 1)
    || '.' AS fio,
    command.name       AS command_name,
    club.name          AS club_name,
    EXTRACT(YEAR FROM match.event_date) AS event_year,
    match.event_date,
    match.type,
    competition.name   AS competition_name,
    location.stadium_name,
    to_char(match.score1)
    || ':'
    || to_char(match.score2) AS match_score
FROM
    player
    JOIN command ON player.id_command = command.id_command
    JOIN club ON command.id_club = club.id_club
    JOIN match ON command.id_command = match.id_command1
    JOIN location ON match.id_location = location.id_location
    JOIN competition ON match.id_competition = competition.id_competition
ORDER BY
    match.type,
    match.event_date;

/*19.Выбрать название соревнования и количество матчей.*/

SELECT
    competition.name AS competition_name,
    COUNT(match.id_match) AS matches_count
FROM
    competition
    JOIN match ON competition.id_competition = match.id_competition
GROUP BY
    competition.id_competition,
    competition.name;

/*20.Выбрать название команды и количество турниров, в которых она принимала участие. 
В результат должны войти только российские команды.*/

SELECT
    command.name AS command_name,
    COUNT(DISTINCT competition.id_competition) AS competitions_count
FROM
    command
    JOIN club ON command.id_club = club.id_club
    JOIN country ON club.id_country = country.id_country
    JOIN match ON command.id_command = match.id_command1
                  OR command.id_command = match.id_command2
    JOIN competition ON match.id_competition = competition.id_competition
WHERE
    country.name = 'Россия'
GROUP BY
    command.id_command,
    command.name;

/*21.Выбрать для каждой команды название, название клуба и количество игроков.*/

SELECT
    command.name   AS command_name,
    club.name      AS club_name,
    COUNT(id_player) AS players_count
FROM
    command
    JOIN club ON command.id_club = club.id_club
    JOIN player ON command.id_command = player.id_command
GROUP BY
    command.id_command,
    command.name,
    club.id_club,
    club.name;

/*22.Выбрать названия команд, которые приняли участие в 5 матчах и более. Результат отсортировать по количеству матчей.*/

SELECT
    command.name,
    COUNT(match.id_match) AS match_count
FROM
    command
    JOIN match ON command.id_command = match.id_command1
                  OR command.id_command = match.id_command2
GROUP BY
    command.id_command,
    command.name
HAVING
    COUNT(match.id_match) >= 5
ORDER BY
    COUNT(match.id_match);

/*23.Выбрать названия команд, которые приняли участие только в одном соревновании и сыграли более 3 матчей.*/

SELECT
    command.name,
    COUNT(match.id_match) AS match_count
FROM
    command
    JOIN match ON command.id_command = match.id_command1
                  OR command.id_command = match.id_command2
    JOIN competition ON match.id_competition = competition.id_competition
GROUP BY
    command.id_command,
    command.name
HAVING COUNT(match.id_match) > 3
       AND COUNT(DISTINCT competition.id_competition) = 1;

/*24.Выбрать названия команд, состоящие из двух слов и более, принявшие участие в более чем трех соревнованиях. 
Результат отсортировать по названию команд в порядке обратном лексикографическому.*/

SELECT
    command.name,
    COUNT(DISTINCT competition.id_competition) AS competitions_count
FROM
    command
    JOIN match ON command.id_command = match.id_command1
                  OR command.id_command = match.id_command2
    JOIN competition ON match.id_competition = competition.id_competition
WHERE
    command.name LIKE '% %'
GROUP BY
    command.id_command,
    command.name
HAVING
    COUNT(DISTINCT competition.id_competition) > 3
ORDER BY
    command.name DESC;

/*25.Выбрать фамилию и инициалы игроков, если количество забитых мячей равно 0, то во втором столбце результирующей таблицы 
вывести сообщение 'Данных нет'.*/

SELECT
    last_name
    || ' '
    || substr(first_name, 1, 1)
    || '. '
    || substr(patronymic, 1, 1)
    || '.' AS fio,
    CASE scored_goals
        WHEN 0 THEN
            'Данных нет'
        ELSE
            to_char(scored_goals)
    END AS scored_goals
FROM
    player;

/*26.Выбрать название команды, название соревнования, количество матчей, которые были выиграны, количество матчей, которые были
проиграны, количество матчей, сыгранных в ничью.*/
/*50.Выбрать для каждой команды и каждого соревнования количество выигрышей, проигрышей и ничьих*/

WITH full_info_table AS (
    SELECT
        command.name       AS command_name,
        competition.name   AS competition_name
    FROM
        command
        JOIN match ON command.id_command = match.id_command1
                      OR command.id_command = match.id_command2
        JOIN competition ON match.id_competition = competition.id_competition
)
SELECT
    command_name,
    competition_name,
    (
        SELECT
            COUNT(match.id_match)
        FROM
            match
            JOIN command ON command.id_command = match.id_command1
            JOIN competition ON match.id_competition = competition.id_competition
        WHERE
            ( command.name = full_info_table.command_name
              AND competition.name = full_info_table.competition_name
              AND match.score1 > match.score2 )
    ) + (
        SELECT
            COUNT(match.id_match)
        FROM
            match
            JOIN command ON command.id_command = match.id_command2
            JOIN competition ON match.id_competition = competition.id_competition
        WHERE
            ( command.name = full_info_table.command_name
              AND competition.name = full_info_table.competition_name
              AND match.score1 < match.score2 )
    ) AS wins,
    (
        SELECT
            COUNT(match.id_match)
        FROM
            match
            JOIN command ON command.id_command = match.id_command1
            JOIN competition ON match.id_competition = competition.id_competition
        WHERE
            ( command.name = full_info_table.command_name
              AND competition.name = full_info_table.competition_name
              AND match.score2 > match.score1 )
    ) + (
        SELECT
            COUNT(match.id_match)
        FROM
            match
            JOIN command ON command.id_command = match.id_command2
            JOIN competition ON match.id_competition = competition.id_competition
        WHERE
            ( command.name = full_info_table.command_name
              AND competition.name = full_info_table.competition_name
              AND match.score2 < match.score1 )
    ) AS losses,
    (
        SELECT
            COUNT(match.id_match)
        FROM
            match
            JOIN command ON command.id_command = match.id_command1
            JOIN competition ON match.id_competition = competition.id_competition
        WHERE
            ( command.name = full_info_table.command_name
              AND competition.name = full_info_table.competition_name
              AND match.score1 = match.score2 )
    ) + (
        SELECT
            COUNT(match.id_match)
        FROM
            match
            JOIN command ON command.id_command = match.id_command2
            JOIN competition ON match.id_competition = competition.id_competition
        WHERE
            ( command.name = full_info_table.command_name
              AND competition.name = full_info_table.competition_name
              AND match.score2 = match.score1 )
    ) AS draws
FROM
    full_info_table
GROUP BY
    command_name,
    competition_name
ORDER BY
    command_name,
    competition_name;
    
/*Another way of 26*/

WITH full_info_table AS (
    SELECT DISTINCT
        command_info.name       AS command_name,
        competition_info.name   AS competition_name,
        (
            SELECT
                COUNT(match.id_match)
            FROM
                match
                JOIN command ON command.id_command = match.id_command1
                JOIN competition ON match.id_competition = competition.id_competition
            WHERE
                ( command.name = command_info.name
                  AND competition.name = competition_info.name
                  AND match.score1 > match.score2 )
        ) AS wins,
        (
            SELECT
                COUNT(match.id_match)
            FROM
                match
                JOIN command ON command.id_command = match.id_command1
                JOIN competition ON match.id_competition = competition.id_competition
            WHERE
                ( command.name = command_info.name
                  AND competition.name = competition_info.name
                  AND match.score2 > match.score1 )
        ) AS losses,
        (
            SELECT
                COUNT(match.id_match)
            FROM
                match
                JOIN command ON command.id_command = match.id_command1
                JOIN competition ON match.id_competition = competition.id_competition
            WHERE
                ( command.name = command_info.name
                  AND competition.name = competition_info.name
                  AND match.score1 = match.score2 )
        ) AS draws
    FROM
        command       command_info
        JOIN match ON command_info.id_command = match.id_command1
                      OR command_info.id_command = match.id_command2
        JOIN competition   competition_info ON match.id_competition = competition_info.id_competition
    UNION ALL
    SELECT DISTINCT
        command_info.name       AS command_name,
        competition_info.name   AS competition_name,
        (
            SELECT
                COUNT(match.id_match)
            FROM
                match
                JOIN command ON command.id_command = match.id_command2
                JOIN competition ON match.id_competition = competition.id_competition
            WHERE
                ( command.name = command_info.name
                  AND competition.name = competition_info.name
                  AND match.score1 < match.score2 )
        ) AS wins,
        (
            SELECT
                COUNT(match.id_match)
            FROM
                match
                JOIN command ON command.id_command = match.id_command2
                JOIN competition ON match.id_competition = competition.id_competition
            WHERE
                ( command.name = command_info.name
                  AND competition.name = competition_info.name
                  AND match.score2 < match.score1 )
        ) AS losses,
        (
            SELECT
                COUNT(match.id_match)
            FROM
                match
                JOIN command ON command.id_command = match.id_command2
                JOIN competition ON match.id_competition = competition.id_competition
            WHERE
                ( command.name = command_info.name
                  AND competition.name = competition_info.name
                  AND match.score2 = match.score1 )
        ) AS draws
    FROM
        command       command_info
        JOIN match ON command_info.id_command = match.id_command1
                      OR command_info.id_command = match.id_command2
        JOIN competition   competition_info ON match.id_competition = competition_info.id_competition
)
SELECT
    command_name,
    competition_name,
    SUM(wins) AS wins,
    SUM(losses) AS losses,
    SUM(draws) AS draws
FROM
    full_info_table
GROUP BY
    command_name,
    competition_name
ORDER BY
    command_name,
    competition_name;

/*27.Выбрать ФИО игроков старше 30 лет, принявших участие в 2 и более матчах, учитывать только те матчи, которые состоялись 
на российских стадионах.*/

SELECT
    player.first_name,
    player.last_name,
    player.patronymic,
    COUNT(match.id_match) AS matches_count
FROM
    player
    JOIN command ON player.id_command = command.id_command
    JOIN match ON command.id_command = match.id_command1
                  OR command.id_command = match.id_command2
    JOIN location ON match.id_location = location.id_location
    JOIN city ON location.id_city = city.id_city
    JOIN country ON city.id_country = country.id_country
WHERE
    country.name = 'Россия'
    AND floor(months_between(current_date, player.birth_date) / 12) > 30
GROUP BY
    player.first_name,
    player.last_name,
    player.patronymic
HAVING
    COUNT(match.id_match) >= 2;

/*28.Выбрать все данные о самом молодом игроке.*/

SELECT
    id_player,
    first_name,
    last_name,
    patronymic,
    birth_date,
    scored_goals,
    beated_goals,
    id_command,
    id_gender,
    salary
FROM
    player
WHERE
    birth_date = (
        SELECT
            MAX(birth_date)
        FROM
            player
    );

/*29.Выбрать название команды, в которой играет самый старший игрок.*/

SELECT
    command.name
FROM
    command
    JOIN player ON command.id_command = player.id_command
WHERE
    birth_date = (
        SELECT
            MIN(birth_date)
        FROM
            player
    );

/*30.Выбрать названия команд, в которых нет самого молодого и самого старшего игроков.*/

SELECT
    command.name
FROM
    command
MINUS
SELECT
    command.name
FROM
    command
    JOIN player ON command.id_command = player.id_command
WHERE
    birth_date = (
        SELECT
            MIN(birth_date)
        FROM
            player
    )
    OR birth_date = (
        SELECT
            MAX(birth_date)
        FROM
            player
    );
    
/*Another way of 30*/

SELECT
    command.name
FROM
    command
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            player
        WHERE
            command.id_command = player.id_command
            AND ( birth_date = (
                SELECT
                    MIN(birth_date)
                FROM
                    player
            )
                  OR birth_date = (
                SELECT
                    MAX(birth_date)
                FROM
                    player
            ) )
    );

/*31.Выбрать название клуба с наибольшим количеством команд.*/

WITH commands_count_table AS (
    SELECT
        club.name AS club_name,
        COUNT(id_command) AS commands_count
    FROM
        club
        JOIN command ON club.id_club = command.id_club
    GROUP BY
        club.id_club,
        club.name
)
SELECT
    club_name
FROM
    commands_count_table
WHERE
    commands_count = (
        SELECT
            MAX(commands_count)
        FROM
            commands_count_table
    );

/*32.Выбрать названия команд, которые сыграли наибольшее количество матчей.*/

WITH commands_match_count AS (
    SELECT
        command.name AS command_name,
        COUNT(match.id_match) AS match_count
    FROM
        command
        JOIN match ON command.id_command = match.id_command1
                      OR command.id_command = match.id_command2
        JOIN competition ON match.id_competition = competition.id_competition
    GROUP BY
        command.id_command,
        command.name
)
SELECT
    command_name,
    match_count
FROM
    commands_match_count
WHERE
    match_count = (
        SELECT
            MAX(match_count)
        FROM
            commands_match_count
    );

/*33.Выбрать ФИО игрока(ов), забившего наибольшее количество мячей, и ФИО игрока, который стоит вторым по количеству 
забитых мячей. Результирующая таблица должна содержать один столбец с ФИО.*/

SELECT
    fio,
    scored_goals
FROM
    (
        SELECT
            first_name
            || ' '
            || last_name
            || ' '
            || patronymic AS fio,
            scored_goals
        FROM
            player
        ORDER BY
            scored_goals DESC
    )
WHERE
    ROWNUM < 3;
    
/*Another way of 33*/

SELECT
    fio,
    scored_goals
FROM
    (
        SELECT
            first_name
            || ' '
            || last_name
            || ' '
            || patronymic AS fio,
            scored_goals,
            DENSE_RANK() OVER(ORDER BY scored_goals DESC) AS rnk
        FROM
            player
    )
WHERE
    rnk < 3;

/*34.Выбрать все данные об игроках старше среднего возраста игроков.*/

SELECT
    id_player,
    first_name,
    last_name,
    patronymic,
    birth_date,
    scored_goals,
    beated_goals,
    id_command,
    id_gender,
    salary
FROM
    player
WHERE
    floor(months_between(current_date, birth_date) / 12) > (
        SELECT
            AVG(floor(months_between(current_date, birth_date) / 12))
        FROM
            player
    );

/*35.Выбрать год, в который родилось больше всего людей по всей БД, т.е. учитывать директоров, тренеров, игроков.*/

WITH birth_count_years AS (
    SELECT
        birth_year,
        SUM(birth_count) AS sum_birth_count
    FROM
        (
            SELECT
                EXTRACT(YEAR FROM birth_date) AS birth_year,
                COUNT(*) AS birth_count
            FROM
                player
            GROUP BY
                EXTRACT(YEAR FROM birth_date)
            UNION ALL
            SELECT
                EXTRACT(YEAR FROM birth_date) AS year,
                COUNT(*) AS birth_count
            FROM
                worker
            GROUP BY
                EXTRACT(YEAR FROM birth_date)
        )
    GROUP BY
        birth_year
)
SELECT
    birth_year,
    sum_birth_count
FROM
    birth_count_years
WHERE
    sum_birth_count = (
        SELECT
            MAX(sum_birth_count)
        FROM
            birth_count_years
    );

/*36.Выбрать для каждой команды суммарный фонд оплаты труда. Учесть игроков, тренеров и др.*/

SELECT
    command_name,
    SUM(command_salary) AS total_command_salary
FROM
    (
        SELECT
            command.id_command   AS command_id,
            command.name         AS command_name,
            SUM(player.salary) AS command_salary
        FROM
            command
            JOIN player ON command.id_command = player.id_command
        GROUP BY
            command.id_command,
            command.name
        UNION ALL
        SELECT
            command.id_command   AS command_id,
            command.name         AS command_name,
            SUM(worker.salary) AS command_salary
        FROM
            command
            JOIN commandworker ON command.id_command = commandworker.id_command
            JOIN worker ON commandworker.id_worker = worker.id_worker
        WHERE
            commandworker.date_end IS NULL
        GROUP BY
            command.id_command,
            command.name
    )
GROUP BY
    command_id,
    command_name;

/*37.Для каждой команды вывести данные матча, принесшего максимальное количество очков.*/

WITH command_matches AS (
    SELECT
        command_name,
        MAX(match_score) AS max_match_score
    FROM
        (
            SELECT
                command.name AS command_name,
                CASE
                    WHEN command.id_command = match.id_command1 THEN
                        match.score1
                    WHEN command.id_command = match.id_command2 THEN
                        match.score2
                END AS match_score
            FROM
                command
                JOIN match ON command.id_command = match.id_command1
                              OR command.id_command = match.id_command2
        )
    GROUP BY
        command_name
)
SELECT
    command.name,
    max_match_score,
    id_match,
    event_date,
    season,
    type,
    ticket_price,
    sold_tickets_count,
    weather,
    score1,
    score2
FROM
    match
    JOIN command ON match.id_command1 = command.id_command
                    OR match.id_command2 = command.id_command
    JOIN command_matches ON command_matches.command_name = command.name
                            AND ( match.id_command1 = command.id_command
                                  AND command_matches.max_match_score = score1
                                  OR match.id_command2 = command.id_command
                                  AND command_matches.max_match_score = score2 );

/*38.Выбрать название и страну команды, которая ни разу не проиграла.*/

WITH full_info_table AS (
    SELECT DISTINCT
        command_info.name   AS command_name,
        country.name        AS country_name,
        (
            SELECT
                COUNT(match.id_match)
            FROM
                match
                JOIN command ON command.id_command = match.id_command1
            WHERE
                ( command.name = command_info.name
                  AND match.score2 > match.score1 )
        ) AS losses
    FROM
        command command_info
        JOIN club ON command_info.id_club = club.id_club
        JOIN country ON club.id_country = country.id_country
    UNION ALL
    SELECT DISTINCT
        command_info.name   AS command_name,
        country.name        AS country_name,
        (
            SELECT
                COUNT(match.id_match)
            FROM
                match
                JOIN command ON command.id_command = match.id_command2
            WHERE
                ( command.name = command_info.name
                  AND match.score2 < match.score1 )
        ) AS losses
    FROM
        command command_info
        JOIN club ON command_info.id_club = club.id_club
        JOIN country ON club.id_country = country.id_country
)
SELECT
    command_name,
    country_name,
    SUM(losses) AS losses
FROM
    full_info_table
GROUP BY
    command_name,
    country_name
HAVING
    SUM(losses) = 0
ORDER BY
    command_name;
    
/*Another way of 38*/

SELECT
    command_info.name   AS command_name,
    country.name        AS country_name
FROM
    command command_info
    JOIN club ON command_info.id_club = club.id_club
    JOIN country ON club.id_country = country.id_country
WHERE
    NOT EXISTS (
        SELECT
            match.id_match
        FROM
            match
            JOIN command ON command.id_command = match.id_command1
        WHERE
            ( command.name = command_info.name
              AND match.score2 > match.score1 )
        UNION ALL
        SELECT
            match.id_match
        FROM
            match
            JOIN command ON command.id_command = match.id_command2
        WHERE
            ( command.name = command_info.name
              AND match.score2 < match.score1 )
    );

/*39.Выбрать название тренировочной базы, на которой не проходили сборы.*/

SELECT
    name
FROM
    trainingbase
WHERE
    NOT EXISTS (
        SELECT
            id_trainingbase
        FROM
            assemble
        WHERE
            trainingbase.id_trainingbase = assemble.id_trainingbase
    );

/*40.Выбрать название команды, которая приняла участие во всех соревнованиях.*/
/*45.Выбрать название команды, которая приняла участие во всех турнирах без исключения*/

SELECT
    command.name,
    COUNT(DISTINCT competition.id_competition) AS competitions_count
FROM
    command
    JOIN match ON command.id_command = match.id_command1
                  OR command.id_command = match.id_command2
    JOIN competition ON match.id_competition = competition.id_competition
GROUP BY
    command.id_command,
    command.name
HAVING
    COUNT(DISTINCT competition.id_competition) = (
        SELECT
            COUNT(*)
        FROM
            competition
    );

/*41.Выбрать данные последних трех турниров для каждой команды.*/

WITH command_competitions AS (
    SELECT DISTINCT
        command.name       AS command_name,
        competition.id_competition,
        competition.date_start,
        competition.date_end,
        competition.name   AS competition_name,
        competition.type,
        competition.prize_pool
    FROM
        command
        JOIN match ON command.id_command = match.id_command1
                      OR command.id_command = match.id_command2
        JOIN competition ON match.id_competition = competition.id_competition
    ORDER BY
        command.name DESC
)
SELECT
    command_name,
    id_competition,
    date_start,
    date_end,
    competition_name,
    type,
    prize_pool
FROM
    (
        SELECT
            command_competitions.*,
            RANK() OVER(
                PARTITION BY command_name
                ORDER BY
                    date_end DESC
            ) rnk
        FROM
            command_competitions
    )
WHERE
    rnk IN (
        1,
        2,
        3
    );

/*42.Выбрать название страны с максимальным количеством команд.*/

WITH country_commands AS (
    SELECT
        country.name AS country_name,
        COUNT(command.id_command) AS commands_count
    FROM
        country
        JOIN club ON country.id_country = club.id_country
        JOIN command ON club.id_club = command.id_club
    GROUP BY
        country.name
)
SELECT
    country_name,
    commands_count
FROM
    country_commands
WHERE
    commands_count = (
        SELECT
            MAX(commands_count)
        FROM
            country_commands
    );

/*43.Выбрать ФИО игроков имеющих однофамильцев среди владельцев.*/

SELECT
    first_name
    || ' '
    || last_name
    || ' '
    || patronymic AS fio
FROM
    player
WHERE
    EXISTS (
        SELECT
            last_name
        FROM
            owner
        WHERE
            owner.last_name = player.last_name
    );
    
/*Another way of 43*/

SELECT
    player.first_name
    || ' '
    || player.last_name
    || ' '
    || player.patronymic AS fio
FROM
    player
    JOIN owner ON owner.last_name = player.last_name;

/*44.Выбрать количество однофамильцев по всей БД.*/

WITH all_last_names AS (
    SELECT
        last_name
    FROM
        player
    UNION ALL
    SELECT
        last_name
    FROM
        worker
    UNION ALL
    SELECT
        last_name
    FROM
        owner
)
SELECT
    SUM(homonym) AS homonym_count
FROM
    (
        SELECT
            last_name,
            COUNT(*) AS homonym
        FROM
            all_last_names
        GROUP BY
            last_name
        HAVING
            COUNT(*) > 1
    );

/*46.Выбрать название команды, ФИО тренера на сегодняшний день, количество игроков в команде на сегодняшний день, количество
сыгранных матчей. Результата отсортировать по количеству сыгранных матчей в порядке убывания. 
В результирующую таблицу включить все команды, имеющиеся в БД.*/

WITH command_trainers AS (
    SELECT
        command.id_command,
        worker.first_name
        || ' '
        || worker.last_name
        || ' '
        || worker.patronymic AS trainer_fio
    FROM
        worker
        JOIN position ON worker.id_position = position.id_position
        JOIN commandworker ON worker.id_worker = commandworker.id_worker
        JOIN command ON commandworker.id_command = command.id_command
    WHERE
        commandworker.date_end IS NULL
        AND position.name = 'Тренер'
)
SELECT
    command.name,
    trainer_fio,
    COUNT(DISTINCT player.id_player) AS players_count,
    COUNT(DISTINCT match.id_match) AS match_count
FROM
    command
    JOIN player ON command.id_command = player.id_command
    JOIN match ON command.id_command = match.id_command1
                  OR command.id_command = match.id_command2
    JOIN command_trainers ON command.id_command = command_trainers.id_command
GROUP BY
    command.id_command,
    command.name,
    trainer_fio
ORDER BY
    COUNT(match.id_match) DESC;

/*47.Выбрать тренеров, которые работали с командами из более чем двух стран.*/

SELECT
    first_name,
    last_name,
    patronymic,
    birth_date,
    salary
FROM
    worker
    JOIN commandworker ON worker.id_worker = commandworker.id_worker
    JOIN command ON commandworker.id_command = command.id_command
    JOIN club ON command.id_club = club.id_club
    JOIN country ON club.id_country = country.id_country
GROUP BY
    first_name,
    last_name,
    patronymic,
    birth_date,
    salary
HAVING
    COUNT(DISTINCT country.id_country) > 1;

/*48.Выбрать дату матча, стадион, название команд участниц, фамилию и инициалы тренера, баллы для всех матчей, 
общее количество матчей сыгранных до текущего матча каждой из команд участниц, какого-то конкретного турнира 
(конкретное значение подставьте сами).*/

WITH full_info_table AS (
    SELECT
        match.id_match,
        match.id_competition,
        match.event_date,
        location.stadium_name,
        command1.name   AS command1_name,
        command2.name   AS command2_name,
        worker1.last_name
        || ' '
        || substr(worker1.first_name, 1, 1)
        || '. '
        || substr(worker1.patronymic, 1, 1)
        || '.' AS command1_trainer,
        worker2.last_name
        || ' '
        || substr(worker2.first_name, 1, 1)
        || '. '
        || substr(worker2.patronymic, 1, 1)
        || '.' AS command2_trainer,
        match.score1,
        match.score2
    FROM
        match
        JOIN location ON match.id_location = location.id_location
        JOIN command         command1 ON match.id_command1 = command1.id_command
        JOIN command         command2 ON match.id_command2 = command2.id_command
        JOIN commandworker   commandworker1 ON command1.id_command = commandworker1.id_command
        JOIN commandworker   commandworker2 ON command2.id_command = commandworker2.id_command
        JOIN worker          worker1 ON commandworker1.id_worker = worker1.id_worker
        JOIN worker          worker2 ON commandworker2.id_worker = worker2.id_worker
        JOIN position        position1 ON position1.id_position = worker1.id_position
        JOIN position        position2 ON position2.id_position = worker2.id_position
    WHERE
        position1.name = 'Тренер'
        AND position2.name = 'Тренер'
        AND commandworker1.date_end IS NULL
        AND commandworker2.date_end IS NULL
    ORDER BY
        match.event_date
)
SELECT
    full_info_table.id_match,
    full_info_table.id_competition,
    full_info_table.event_date,
    full_info_table.stadium_name,
    full_info_table.command1_name,
    full_info_table.command2_name,
    full_info_table.command1_trainer,
    full_info_table.command2_trainer,
    full_info_table.score1,
    full_info_table.score2,
    SUM(played_matches) AS sum_played_matches,
    SUM(competition_played_matches) AS sum_competition_played_matches
FROM
    full_info_table
    JOIN (
        SELECT
            id_match,
            RANK() OVER(
                PARTITION BY command_name
                ORDER BY
                    event_date
            ) - 1 AS played_matches,
            RANK() OVER(
                PARTITION BY id_competition, command_name
                ORDER BY
                    event_date
            ) - 1 AS competition_played_matches
        FROM
            (
                SELECT
                    id_match,
                    id_competition,
                    event_date,
                    command1_name AS command_name
                FROM
                    full_info_table
                UNION
                SELECT
                    id_match,
                    id_competition,
                    event_date,
                    command2_name AS command_name
                FROM
                    full_info_table
            )
    ) tmp ON full_info_table.id_match = tmp.id_match
GROUP BY
    full_info_table.id_match,
    full_info_table.id_competition,
    full_info_table.event_date,
    full_info_table.stadium_name,
    full_info_table.command1_name,
    full_info_table.command2_name,
    full_info_table.command1_trainer,
    full_info_table.command2_trainer,
    full_info_table.score1,
    full_info_table.score2
ORDER BY
    full_info_table.event_date;

/*49.Выбрать названия всех стран и количество команд в стране. Если страна не имеет команды, то вывести ноль.*/

SELECT
    country.name,
    COUNT(command.id_command) AS commands_count
FROM
    country
    LEFT JOIN club ON club.id_country = country.id_country
    LEFT JOIN command ON command.id_club = club.id_club
GROUP BY
    country.name;

/*Another version of 49*/

SELECT
    country.name,
    SUM(
        CASE
            WHEN command.id_command IS NOT NULL THEN
                1
            ELSE
                0
        END
    ) AS commands_count
FROM
    country
    LEFT JOIN club ON club.id_country = country.id_country
    LEFT JOIN command ON command.id_club = club.id_club
GROUP BY
    country.name;

/*Another version of 49*/

SELECT
    country.name,
    coalesce(commands, 0) AS commands_count
FROM
    country
    LEFT JOIN (
        SELECT
            id_country,
            COUNT(*) commands
        FROM
            club
            JOIN command ON command.id_club = club.id_club
        GROUP BY
            id_country
    ) country_commands ON country.id_country = country_commands.id_country;

/*51.Выбрать ФИО владельцев клубов, имеющих две команды.*/

SELECT
    first_name,
    last_name,
    patronymic
FROM
    owner
    JOIN clubowner ON owner.id_owner = clubowner.id_owner
    JOIN club ON clubowner.id_club = club.id_club
    JOIN command ON club.id_club = command.id_club
GROUP BY
    first_name,
    last_name,
    patronymic
HAVING
    COUNT(command.id_command) = 2;

/*Another version*/

SELECT DISTINCT
    first_name,
    last_name,
    patronymic
FROM
    owner
    JOIN clubowner ON owner.id_owner = clubowner.id_owner
    JOIN club ON clubowner.id_club = club.id_club
    JOIN command ON club.id_club = command.id_club
GROUP BY
    first_name,
    last_name,
    patronymic,
    club.id_club
HAVING
    COUNT(command.id_command) = 2;

/*52.Выбрать название чемпионата, в котором приняли участие как минимум по две команды от каждой страны участниц.*/

WITH competition_commands AS (
    SELECT
        competition.name,
        country.id_country,
        COUNT(command.id_command) AS commands_count
    FROM
        competition
        JOIN match ON match.id_competition = competition.id_competition
        JOIN command ON command.id_command = match.id_command1
                        OR command.id_command = match.id_command2
        JOIN club ON command.id_club = club.id_club
        JOIN country ON club.id_country = country.id_country
    GROUP BY
        competition.id_competition,
        competition.name,
        country.id_country
)
SELECT DISTINCT
    name
FROM
    competition_commands
WHERE
    name NOT IN (
        SELECT
            name
        FROM
            competition_commands
        WHERE
            commands_count < 2
    );

/*53.Выбрать месяца, в которых нет дней рождений футболистов*/

WITH month_list AS (
    SELECT
        to_char(to_date(level, 'mm'), 'MONTH') AS month
    FROM
        dual
    CONNECT BY
        level <= 12
)
SELECT
    month
FROM
    month_list
WHERE
    month NOT IN (
        SELECT DISTINCT
            to_char(to_date(EXTRACT(MONTH FROM birth_date), 'mm'), 'MONTH')
        FROM
            player
    );