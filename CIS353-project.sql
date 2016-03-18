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
);
--  -------------------------------------------------------
CREATE TABLE Game
(
    gameID      INTEGER,
    region      CHAR(15)    NOT NULL,
    gDate       DATE,       NOT NULL,
    winScore    INTEGER,    NOT NULL,
    loseScore   INTEGER,    NOT NULL,
    winner      INTEGER,    NOT NULL,
    teamOne     INTEGER,    NOT NULL,
    teamTwo     INTEGER,    NOT NULL,
    nextGID     INTEGER,    NOT NULL,

    --needs integrity constraints yet

);
--  -------------------------------------------------------
CREATE TABLE Coach
(
    coachID     INTEGER,
    firstName   CHAR(15),    NOT NULL,
    lastName    CHAR(15),    NOT NULL,
    wins        INTEGER,     NOT NULL,
    losses      INTEGER,     NOT NULL,
    team        INTEGER,     NOT NULL,
    startYear   DECIMAL(4,0) NOT NULL,

    --needs integrity constraints yet
);
--  -------------------------------------------------------
CREATE TABLE Performance
(
    playerID    INTEGER,
    gameID      INTEGER,
    points      INTEGER,    NOT NULL,
    rebounds    INTEGER,    NOT NULL,
    assists     INTEGER,    NOT NULL,

    --needs integrity constraints yet

);
--  -------------------------------------------------------
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
