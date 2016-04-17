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
CREATE TABLE Championships
(
    teamID      INTEGER,
    yearWon     INTEGER,
    
        CONSTRAINT champIC1 FORIEGN KEY (teamID) REFERENCES Teams(teamID) 
                        ON DELETE CASCADE,
        CONSTRAINT champIC2 PRIMARY KEY(teamID, yearWon)
);
-- -------------------------------------------------------
CREATE TABLE Players
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
    gameID      INTEGER,
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
coachID       INTEGER,
teamID        INTEGER,
startYear     INTEGER,
endYear       INTEGER,

CONSTRAINT pcIC1 FOREIGN KEY (coachID) REFERENCES Coach(coachID),
CONSTRAINT pcIC2 FOREIGN KEY (teamID) REFERENCES Teams(teamID),
CONSTRAINT pcIC3 PRIMARY KEY (coachID, teamID)

);
-- 
SET FEEDBACK OFF 
/*< The INSERT statements that populate the tables> 
    Important: Keep the number of rows in each
    table small enough so that the results of 
    your queries can be verified by hand. 
    See the Sailors database as an example.
*/
   

--Villanova Players
INSERT INTO Players (1,0 ,'Henry' ,'Lowe' ,71 ,'Sr' ,1);
INSERT INTO Players (2,1 ,'Jalen' ,'Brunson' ,75 ,'Fr' ,1);
INSERT INTO Players (3,2 ,'Kris' ,'Jenkins' ,78 ,'Jr' ,1);
INSERT INTO Players (4,3 ,'Josh' ,'Hart' ,77 ,'Jr' ,1);
INSERT INTO Players (5,4 ,'Eric' ,'Paschall' ,79 ,'Fr' ,1);
INSERT INTO Players (6,5 ,'Phil' ,'Booth' ,75 ,'So' ,1);
INSERT INTO Players (7,10 ,'Donte' ,'DiVencenzo' ,77 ,'Fr' ,1);
INSERT INTO Players (8,15 ,'Ryan' ,'Arcidiacono' ,75 ,'Sr' ,1);
INSERT INTO Players (9,20 ,'Patrick' ,'Farrel' ,77 ,'Sr' ,1);
INSERT INTO Players (10,23 ,'Daniel' ,'Ochefu' ,83 ,'Sr' ,1);
INSERT INTO Players (11,25 ,'Mikal' ,'Bridges' ,79 ,'Fr' ,1);
INSERT INTO Players (12,34 ,'Tim','Delaney' ,81 ,'Fr' ,1);
INSERT INTO Players (13,45 ,'Darryl','Reynolds' ,80 ,'Jr' ,1);
INSERT INTO Players (14,52 ,'Kevin','Rafferty' ,80 ,'Sr' ,1);
--Syracuse Players
INSERT INTO Players (15,0,'Michael','Gbinije',79,'Sr',2);
INSERT INTO Players (16,1,'Franklin','Howard',76,'Fr',2);
INSERT INTO Players (17,3,'Shaun','Belby',70,'Fr',2);
INSERT INTO Players (18,4,'Mike','Sutton',74,'So',2);
INSERT INTO Players (19,10,'Trevor','Cooney',76,'Sr',2);
INSERT INTO Players (20,11,'Adrian','Autry',72,'Fr',2);
INSERT INTO Players (21,13,'Paschal','Chukwu',86,'So',2);
INSERT INTO Players (22,14,'Kaleb','Joseph',75,'So',2);
INSERT INTO Players (23,20'Tyler','Lydon',80,'Fr',2);
INSERT INTO Players (24,21,'Tyler','Roberson',80,'Jr',2);
INSERT INTO Players (25,23,'Malachi','Richardson',78,'Fr',2);
INSERT INTO Players (26,25,'Evan','Dourdas',72,'Fr',2);
INSERT INTO Players (27,32,'DaJuan','Coleman',81,'Sr',2);
INSERT INTO Players (28,33,'Jonathon','Radner',70,'Fr',2);
INSERT INTO Players (29,34,'Doyin','Akintobi-Adeyeye',78,'So',2);
INSERT INTO Players (30,35,'Chinonso','Obokoh',81,'So',2);
INSERT INTO Players (31,54,'Ky','Feldman',70, 'Fr',2);
INSERT INTO Players (32,55,'Christian','White',70,'Sr',2);
--Oklahoma Players
INSERT INTO Players (33,14,'Bola','Alade',76,'Fr',3);
INSERT INTO Players (34,21,'Dante','Buford',79,'Fr',3);
INSERT INTO Players (35,25,'C.J.','Cole',79,'Jr',3);
INSERT INTO Players (36,11,'Isaiah','Cousins',76,'Sr',3);
INSERT INTO Players (37,5,'Matt','Freeman',82,'Fr',3);
INSERT INTO Players (38,45,'Austin','Grandstaff',77,'Fr',3);
INSERT INTO Players (39,22,'Daniel','Harper',73,'Jr',3);
INSERT INTO Players (40,24,'Buddy','Hield',76,'Sr',3);
INSERT INTO Players (41,3,'Christian','James',76,'Fr',3);
INSERT INTO Players (42,12,'Khadeem','Lattin',81,'So',3);
INSERT INTO Players (43,41,'Austin','Mankin',79,'Sr',3);
INSERT INTO Players (44,30,'Akolda','Manyang',84,'Jr',3);
INSERT INTO Players (45,4,'Jamuni','McNeace',82,'Fr',3);
INSERT INTO Players (46,1,'Rashard','Odomes',78,'Fr',3);
INSERT INTO Players (47,0,'Ryan','Spangler',80,'Sr',3);
INSERT INTO Players (48,2,'Dinjiyl','Walker',73,'Sr',3);
INSERT INTO Players (49,10,'Jordan','Woodard',72,'Jr',3);
--North Carolina Players
INSERT INTO Players (50,0,'Nate','Britt',73,'Jr',4);
INSERT INTO Players (51,1,'Theo','Pinson',78,'So',4);
INSERT INTO Players (52,2,'Joel','Berry',72,'So',4);
INSERT INTO Players (53,3,'Kennedy','Meeks',82,'Jr',4);
INSERT INTO Players (54,4,'Isaiah','Hicks',81,'Jr',4);
INSERT INTO Players (55,5,'Marcus','Paige',74,'Sr',4);
INSERT INTO Players (56,11,'Brice','Johnson',82,'Sr',4);
INSERT INTO Players (57,13,'Kanler','Coker',76,'Jr',4);
INSERT INTO Players (58,24,'Kenny','Williams',76,'Fr',4);
INSERT INTO Players (59,30,'Stilman','White',73,'Jr',4);
INSERT INTO Players (60,31,'Justin','Coleman',73,'Sr',4);
INSERT INTO Players (61,32,'Luke','Maye',80,'Fr',4);
INSERT INTO Players (62,34,'Toby','Egbuna',76,'Sr',4);
INSERT INTO Players (63,42,'Joel','James',83,'Sr',4);
INSERT INTO Players (64,43,'Spenser','Dalton',75,'Sr',4);
INSERT INTO Players (65,44,'Justin','Jackson',80,'So',4);
--Teams
INSERT INTO Teams (1,'Villanova','Will D. Cat',35,5,2,'East');
INSERT INTO Teams (2,'Syracuse','Otto the Orange',23,14,10,'Midwest');
INSERT INTO Teams (3,'Oklahoma','Boomer and Sooner',29,8,2,'West');
INSERT INTO Teams (4,'UNC','Rameses'33,7,1,'East');
INSERT INTO Teams (5,'Kansas','Big Jay',33,5,1,'Midwest');
INSERT INTO Teams (6,'Texas A&M','Reveille IX',33,5,5,'South');
--Chamionships
INSERT INTO Chamionships(1,2016);
INSERT INTO Chamionships(1,1985);
INSERT INTO Chamionships(2,2003);
INSERT INTO Chamionships(4,2009);
INSERT INTO Chamionships(4,2005);
INSERT INTO Chamionships(4,1993);
INSERT INTO Chamionships(4,1982);
INSERT INTO Chamionships(4,1957);
--Games
INSERT INTO Game (1,'Final Four','2016-04-02',95,51,'Villanova','Oklahoma','Villanova',2);
INSERT INTO Game (2,'Final Four','2016-04-02',83,66,'UNC','Syracuse','UNC',3);
INSERT INTO Game (3,'Final Four', '2016-04-02',77,74,'Villanova','UNC','Villanova',);
--Coaches
INSERT INTO Coach (1,'Jay','Wright',441,237,'Villanova',2001);
INSERT INTO Coach (2,'Jim','Boeheim',988,346,'Syracuse',1976);
INSERT INTO Coach (3,'Roy','Williams',783,209,'UNC',2003);
INSERT INTO Coach (4,'Lon','Kruger',590,361,'Oklahoma',2011);

INSERT INTO PreviouslyCoached(3,5,1988,2004); 
INSERT INTO PreviouslyCoached,4,6,1982,1986); 
-- Performances for Villanova in game 1
INSERT INTO Performance(10,1,10,6,3);		
INSERT INTO Performance(3,1,18,8,1);		
INSERT INTO Performance(9,1,0,0,0);	
INSERT INTO Performance(14,1,0,0,0);		
INSERT INTO Performance(13,1,,0,2,1);		
INSERT INTO Performance(6,1,10,2,0);		
INSERT INTO Performance(8,1,15,3,3);		
INSERT INTO Performance(2,1,8,2);		
INSERT INTO Performance(1,1,0,0,0);		
INSERT INTO Performance(4,1,23,8,4);		
INSERT INTO Performance(11,1,11,20);		
--Performances for Oklahoma in game 1 							
INSERT INTO Performance,45,1,4,0,0);		
INSERT INTO Performance(35,1,0,0,0);		
INSERT INTO Performance(38,1,0,1,0);		
INSERT INTO Performance(42,1,2,5,0);		
INSERT INTO Performance(47,1,6,4,1);		
INSERT INTO Performance(34,1,0,1,1);		
INSERT INTO Performance(48,1,1,2,0);	
INSERT INTO Performance(32,1,5,0,1);		
INSERT INTO Performance(36,1,8,1,1);		
INSERT INTO Performance(49,1,12,4,2);		
INSERT INTO Performance(46,1,4,1,0);	
INSERT INTO Performance(33,1,0,0,0);		
INSERT INTO Performance(39,1,0,0,0);	
INSERT INTO Performance(40,1,9,7,2);		




SET FEEDBACK ON 
COMMIT 
-- 
/*
< One query (per table) of the form: SELECT * FROM table; in order to print out your database > 
*/
SELECT * 
FROM Coach;

SELECT * 
FROM Players;

SELECT * 
FROM Teams;

SELECT * 
FROM Performance;

SELECT * 
FROM Game;
/*
SELECT *
FROM PreviouslyCoached
*/
------------------------------------------------------
/*
< The SQL queries>. Include the following for each query: 
1.A comment line stating the query number and the feature(s) it demonstrates (e.g. – Q25 – correlated subquery). 
2.A comment line stating the query in English. 
3.The SQL code for the query. 
*/
-- I think this might be a four relation join. It's definitely three.
SELECT P.firstName, P.lastName, R.points
FROM P.Players, T.Teams, G.Game, R.Performance
WHERE P.teamID = T.teamID AND P.playerID = R.playerID AND R.gameID = G.gameID
      AND T.teamID = 1;
-------------------------------------------------------
/*
< The insert/delete/update statements  to test the enforcement of ICs> 
Include the following items for every IC that you test
    -A comment line stating: Testing: < IC name> 
    -A SQL INSERT, DELETE, or UPDATE that will test the IC.
*/
    COMMIT 
-- 
SPOOL OF
