SPOOL project.out 
SET ECHO ON 
/* 
CIS 353
 - Database Design Project 
    <Ryan Gole> 
    <Nathan Anderle>
    <Nicholas Spruit>
    <Edward Johnson>
*/ 

/*
< The SQL/DDL code that creates your schema > 
In the DDL, every IC must have a unique name; e.g. IC5, IC10, IC15, etc. 
*/
CREATE TABLE Teams
(
    teamID      INTEGER,
    name        CHAR(15)    NOT NULL,
    mascot      CHAR(15)    NOT NULL,
    wins        INTEGER     NOT NULL,
    losses      INTEGER     NOT NULL,
    seed        INTEGER     NOT NULL,
    region      CHAR(15)    NOT NULL,

    --needs integrity constraints yet
    CONSTRAINT teamIC1 CHECK (wins >= 0),
    CONSTRAINT teamIC2 CHECK (losses >= 0), 
    CONSTRAINT teamIC3 UNIQUE (seed, region), 
    CONSTRAINT teamIC4 CHECK(seed >= 1 AND seed <= 16),
    CONSTRAINT teamIC5 CHECK (region IN ('West', 'South', 'Midwest', 'East'))
);
-- ------------------------------------------------------
CREATE TABLE Player
(
    playerID    INTEGER,
    num         INTEGER     NOT NULL,
    firstName   char(15)    NOT NULL,
    lastName    char(15)    NOT NULL,
    height      INTEGER     NOT NULL,
    year        char(15)    NOT NULL,
    teamID      INTEGER,     --not sure on nullness

    --needs integrity constraints yet
        CONSTRAINT playerIC1 FOREIGN KEY (teamID) REFERENCES Teams(teamID)
                         ON DELETE CASCADE,
        CONSTRAINT playerIC2 CHECK (year IN ('Fr', 'Sr', 'Jr', 'Sr'))
        
);
--  -------------------------------------------------------
CREATE TABLE Game
(
    gameID      INTEGER,
    region      CHAR(15)   NOT NULL,
    gDate       DATE       NOT NULL,
    winScore    INTEGER    NOT NULL,
    loseScore   INTEGER    NOT NULL,
    winner      INTEGER    NOT NULL,
    teamOne     INTEGER    NOT NULL,
    teamTwo     INTEGER    NOT NULL,
    nextGID     INTEGER 

    --needs integrity constraints yet
    CONSTRAINT gameIC1 CHECK (region IN('South', 'West', 'Midwest', 'East','Final Four')),
    CONSTRAINT gameIC2 CHECK(winScore >=0 AND loseScore >= 0),
    CONSTRAINT gameIC3 FOREIGN KEY (teamOne) REFERENCES Teams(teamID),
    CONSTRAINT gameIC4 FOREIGN KEY (teamTwo) REFERENCES Teams(teamID),
    CONSTRAINT gameIC5 CHECK (winner = teamOne OR winner = teamTwo),
    CONSTRAINT gameIC6 FOREIGN KEY nextGID REFERENCES Game(gameID)
);
--  -------------------------------------------------------
CREATE TABLE Coach
(
    coachID     INTEGER,
    firstName   CHAR(15)     NOT NULL,
    lastName    CHAR(15)     NOT NULL,
    wins        INTEGER      NOT NULL,
    losses      INTEGER      NOT NULL,
    team        INTEGER      NOT NULL,
    startYear   DECIMAL(4,0) NOT NULL,

    --needs integrity constraints yet
    CONSTRAINT coachIC1 CHECK(wins >= 0),
    CONSTRAINT coachIC2 CHECK(losses >= 0),
    CONSTRAINT coachIC3 FOREIGN KEY (team) REFERENCES Teams(teamID)
);
--  -------------------------------------------------------
CREATE TABLE Performance
(
    playerID    INTEGER,
    gameID      INTEGER
    points      INTEGER    NOT NULL,
    rebounds    INTEGER    NOT NULL,
    assists     INTEGER    NOT NULL,

    --needs integrity constraints yet
    CONSTRAINT perIC1 CHECK(points >= 0),
    CONSTRAINT perIC2 CHECK(rebounds >= 0),
    CONSTRAINT perIC3 CHECK(assists >= 0),
    CONSTRAINT perIC4 FOREIGN KEY (playerID) REFERENCES Player(playerID),
    CONSTRAINT perIC5 FOREIGN KEY (gameID) REFERENCES Game(gameID),
    CONSTRAINT perIC6 PRIMARY KEY (playerID, gameID) 
    
);
---------------------------------------------------------
CREATE TABLE PreviouslyCoached
(



-- 
SET FEEDBACK OFF 
/*< The INSERT statements that populate the tables> 
    Important: Keep the number of rows in each
    table small enough so that the results of 
    your queries can be verified by hand. 
    See the Sailors database as an example.
*/
    playerID    INTEGER,
    num         INTEGER     NOT NULL,
    firstName   char(15)    NOT NULL,
    lastName    char(15)    NOT NULL,
    height      INTEGER     NOT NULL,
    year        char(15)    NOT NULL,
    teamID      INTEGER,     --not sure on nullness


INSERT INTO Players (1,0 ,'Henry' ,'Lowe' ,71 ,'Sr' , );
INSERT INTO Players (2,1 ,'Jalen' ,'Brunson' ,75 ,'Fr' , );
INSERT INTO Players (3,2 ,'Kris' ,'Jenkins' ,78 ,'Jr' , );
INSERT INTO Players (4,3 ,'Josh' ,'Hart' ,77 ,'Jr' , );
INSERT INTO Players (5,4 ,'Eric' ,'Paschall' ,79 ,'Fr' , );
INSERT INTO Players (6,5 ,'Phil' ,'Booth' ,75 ,'So' , );
INSERT INTO Players (7,10 ,'Donte' ,'DiVencenzo' ,77 ,'Fr' , );
INSERT INTO Players (8,15 ,'Ryan' ,'Arcidiacono' ,75 ,'Sr' , );
INSERT INTO Players (9,20 ,'Patrick' ,'Farrel' ,77 ,'Sr' , );
INSERT INTO Players (10,23 ,'Daniel' ,'Ochefu' ,83 ,'Sr' , );
INSERT INTO Players (11,25 ,'Mikal' ,'Bridges' ,79 ,'Fr' , );
INSERT INTO Players (12,34 ,'Tim','Delaney' ,81 ,'Fr' , );
INSERT INTO Players (13,45 ,'Darryl','Reynolds' ,80 ,'Jr' , );
INSERT INTO Players (14,52 ,'Kevin','Rafferty' ,80 ,'Sr' , );

INSERT INTO Players (15,0,'Michael','Gbinije',79,'Sr', );
INSERT INTO Players (16,1,'Franklin','Howard',76,'Fr', );
INSERT INTO Players (17,3,'Shaun','Belby',70,'Fr', );
INSERT INTO Players (18,4,'Mike','Sutton',74,'So', );
INSERT INTO Players (19,10,'Trevor','Cooney',76,'Sr', );
INSERT INTO Players (20,11,'Adrian','Autry',72,'Fr', );
INSERT INTO Players (21,13,'Paschal','Chukwu',86,'So', );
INSERT INTO Players (22,14,'Kaleb','Joseph',75,'So', );
INSERT INTO Players (23,20'Tyler','Lydon',80,'Fr', );
INSERT INTO Players (24,21,'Tyler','Roberson',80,'Jr', );
INSERT INTO Players (25,23,'Malachi','Richardson',78,'Fr', );
INSERT INTO Players (26,25,'Evan','Dourdas',72,'Fr', );
INSERT INTO Players (27,32,'DaJuan','Coleman',81,'Sr', );
INSERT INTO Players (28,33,'Jonathon','Radner',70,'Fr', );
INSERT INTO Players (29,34,'Doyin','Akintobi-Adeyeye',78,'So', );
INSERT INTO Players (30,35,'Chinonso','Obokoh',81,'So', );
INSERT INTO Players (31,54,'Ky','Feldman',70, 'Fr', );
INSERT INTO Players (32,55,'Christian','White',70,'Sr',);






INSERT INTO Game (1,'Final Four','2016-04-02',95,51,'Villanova','Oklahoma','Villanova',2);
INSERT INTO Game (2,'Final Four','2016-04-02',83,66,'UNC','Syracuse','UNC',3);
INSERT INTO Game (3,'Final Four', '2016-04-02',77,74,'Villanova','UNC','Villanova',);

INSERT INTO Coach (1,'Jay','Wright',441,237,'Villanova',2001);
INSERT INTO Coach (2,'Jim','Boeheim',988,346,'Syracuse',1976);
INSERT INTO Coach (3,'Roy','Williams',783,209,'UNC',2003);
INSERT INTO Coach (4,'Lon','Kruger',590,361,'Oklahoma',2011);


SET FEEDBACK ON 
COMMIT 
-- 
/*
< One query (per table) of the form: SELECT * FROM table; in order to print out your database > 
*/
-- 
/*
< The SQL queries>. Include the following for each query: 
1.A comment line stating the query number and the feature(s) it demonstrates (e.g. – Q25 – correlated subquery). 
2.A comment line stating the query in English. 
3.The SQL code for the query. 
*/
-- 
/*
< The insert/delete/update statements  to test the enforcement of ICs> 
Include the following items for every IC that you test
    -A comment line stating: Testing: < IC name> 
    -A SQL INSERT, DELETE, or UPDATE that will test the IC.
*/
    COMMIT 
-- 
SPOOL OF
