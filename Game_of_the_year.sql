drop database if exists game_of_the_year;
create database game_of_the_year;
use game_of_the_year;

CREATE TABLE game (
    id INT NOT NULL AUTO_INCREMENT,
    game_name VARCHAR(50) NOT NULL,
    year_of_release INT,
    Score TINYINT,
    Sales INT,
    developer_id SMALLINT,
    genre_id SMALLINT,
    platforms_id SMALLINT,
    PRIMARY KEY (id),
    FOREIGN KEY (developer_id)
        REFERENCES developer (id),
    FOREIGN KEY (genre_id)
        REFERENCES genre (id),
    FOREIGN KEY (platforms_id)
        REFERENCES consoles (id)
);

alter table game
modify column year_of_release year;

alter table game
modify column sales numeric (12);

alter table game
rename column platforms_id to console_id;

CREATE TABLE developer (
    id SMALLINT NOT NULL AUTO_INCREMENT,
    developer VARCHAR(100),
    PRIMARY KEY (id),
    UNIQUE KEY (developer)
);

CREATE TABLE genre (
    id SMALLINT NOT NULL AUTO_INCREMENT,
    genre VARCHAR(100),
    PRIMARY KEY (id),
    UNIQUE KEY (genre)
);

CREATE TABLE consoles (
    id SMALLINT NOT NULL AUTO_INCREMENT,
    console_name VARCHAR(100),
    PRIMARY KEY (id),
    UNIQUE KEY (console_name)
);
 
select * from game;
select * from genre order by id asc;
select * from developer order by id asc;
select * from consoles order by id asc;


insert into developer (developer)
values ('rare'), ('Nintento'), ('maxis'), ('Blizzard Entertainment'), ('Bungie'), ('Digital Illusions CE'), 
       ('Infinity Ward'), ('Valve'), ('Santa Monica Studio'), ('Epic Games'), ('Media Molecule'), 
       ('Naughty Dog'), ('BioWare'), ('Bethesda Game Studios'), ('Thatgamecompany'),
       ('House House'), ('Supergiant Games'), ('Hazelight Studios'), ('FromSoftware');

insert into genre (genre)
values ('First-Person Shooter'), ('Action-Adventure'), ('Life Simulation'), ('Action Role-Playing'),
       ('Third-Person Shooter'), ('Puzzle-Platformer'), ('Adventure'), ('Puzzle–Stealth');
       
insert into consoles (console_name)
values ('Nintendo 64'), ('PC'), ('PlayStation 1'), ('PlayStation 2'), 
        ('Xbox'), ('GameCube'), ('PlayStation 3'), ('Xbox 360'),
        ('Nintendo WII'), ('PSP'), ('Nintendo DS'), ('PlayStation 4'),
        ('Nintendo 3DS'), ('Xbox One'), ('WII U'), ('Nintendo Switch'), 
        ('PlayStation 5'), ('Xbox Series X/S');
        
insert into game (game_name, year_of_release, score, sales, developer_id, genre_id, console_id)
values ('GoldenEye 007', 1998, 96, 8090000, 1, 1, 1), ('The Legend of Zelda: Ocarina of Time', 1999, 99, 7600000, 2, 2, 1),
       ('The Sims', 2000, 92, 16000000, 3, 3, 2), ('Diablo II', 2000, 88, 4000000, 4, 4, 2), 
       ('Halo: Combat Evolved', 2001, 97, 5000000, 5, 1, 5), ('Battlefield 1942', 2002, 89, 3000000, 6, 1, 2), 
       ('Call of Duty', 2003, 91, 4500000, 7, 1, 2), ('Half-Life 2', 2004, 96, 12000000, 8, 1, 2),
       ('God of War', 2005, 92, 4617350, 9, 2, 4), ('Gears of War', 2006, 94, 5000000, 10, 5, 8), 
       ('Call of Duty 4: Modern Warfare', 2007, 94, 9410000, 7, 1, 8), ('LittleBigPlanet', 2008, 94, 4500000 , 11, 6, 7),
       ('Uncharted 2: Among Thieves', 2009, 96, 6740000, 12, 2, 7), ('Mass Effect 2', 2010, 94, 3100000, 13, 4, 8), 
       ('The Elder Scrolls V: Skyrim', 2011, 94, 30000000 , 14, 4, 2), ('Journey', 2012, 92, 170000, 15, 7, 7), 
       ('The Last of Us', 2013, 95, 8150000, 12, 2, 7), ('Dragon Age: Inquisition', 2014, 89, 6000000, 13, 4, 12),
       ('Fallout 4', 2015, 87, 20000000, 14, 4, 12), ('Overwatch', 2016, 90, 4540000, 4, 1, 12), 
       ('The Legend of Zelda: Breath of the Wild', 2017, 97, 29000000, 2, 2, 16), ('God of War', 2018, 94, 19500000, 9, 2, 12), 
       ('Untitled Goose Game', 2019, 79, 1000000, 16, 8, 2), ('Hades', 2020, 93, 1000000, 17, 4, 2),
       ('It Takes Two', 2021, 88 , 10000000 , 18, 2, 12), ('Elden Ring', 2022, 94, 17500000, 19, 4, 2);


                          #here is some practice with the data#


#to see the joins of the 4 tables#
SELECT 
    ga.id,
    ga.game_name AS 'game name',
    ga.year_of_release AS 'year of release',
    ga.score,
    ga.sales,
    d.developer AS 'developer name',
    g.genre,
    c.console_name AS 'console name'
FROM
    game ga
        JOIN
    developer d ON ga.developer_id = d.id
        JOIN
    genre g ON ga.genre_id = g.id
        JOIN
    consoles c ON ga.console_id = c.id
ORDER BY ga.id ASC;

#to see the games with a score > 95#
SELECT 
    id,
    game_name AS 'Game Name',
    year_of_release AS 'Year of release',
    score
FROM
    game
WHERE
    score >= 95
ORDER BY score DESC;

#to see a average of the score per developer#
SELECT 
    d.developer AS 'Developer Name',
    AVG(ga.score) AS 'Average Note per Developer'
FROM
    game ga
        JOIN
    developer d ON ga.developer_id = d.id
GROUP BY d.developer
ORDER BY AVG(ga.score) DESC;

#to count the number of games each developer had in the list#
SELECT 
    d.developer AS 'Developer Name',
    COUNT(ga.id) AS 'Number of games per Developer'
FROM
    developer d
        JOIN
    game ga ON d.id = ga.developer_id
GROUP BY d.developer
ORDER BY COUNT(ga.id) DESC;

#to see the top 5 games with the highest sales amount#
SELECT 
    ga.id,
    ga.game_name AS 'Game name',
    ga.sales AS 'Total Sales'
FROM
    game ga
ORDER BY ga.sales DESC
LIMIT 5;

#to count the games that were > 3 by console#
SELECT 
    c.console_name AS 'Console name',
    COUNT(ga.id) AS 'Games per console'
FROM
    consoles c
        JOIN
    game ga ON c.id = ga.console_id
GROUP BY c.console_name
HAVING COUNT(ga.id) > 3
ORDER BY COUNT(ga.id) DESC;

#to sum the amount of sales for every console with the games that won an award#
SELECT 
    c.console_name AS 'Console Name',
    SUM(ga.sales) AS 'total sales per console'
FROM
    consoles c
        JOIN
    game ga ON c.id = ga.console_id
GROUP BY c.console_name
ORDER BY SUM(ga.sales) DESC;




