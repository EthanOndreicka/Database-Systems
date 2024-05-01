----------------------------------------------------------------------------------------
-- MLB-DB
-- by Ethan Ondreicka
----------------------------------------------------------------------------------------

DROP TABLE IF EXISTS People;
DROP TABLE IF EXISTS Players;
DROP TABLE IF EXISTS Coaches;
DROP TABLE IF EXISTS Umpires;
DROP TABLE IF EXISTS Broadcasters;
DROP TABLE IF EXISTS FreeAgents;
DROP TABLE IF EXISTS Teams;
DROP TABLE IF EXISTS Stadiums;
DROP TABLE IF EXISTS Broadcasters;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS BroadcastNetworks;
DROP TABLE IF EXISTS Awards;
DROP TABLE IF EXISTS HallOfFame;
DROP TABLE IF EXISTS PlayerStats;
DROP TABLE IF EXISTS PlaysFor;
DROP TABLE IF EXISTS CoachesFor;
DROP TABLE IF EXISTS BroadcastsFor;

DROP TYPE IF EXISTS division;
DROP TYPE IF EXISTS oritentation;
DROP TYPE IF EXISTS weather;

-- Type Creation Statements

CREATE TYPE division AS ENUM ('NL East', 'NL Central', 'NL West', 'AL East', 'AL Central', 'AL West');

CREATE TYPE orientation AS ENUM ('lefty', 'righty', 'ambidextrous');

CREATE TYPE weather AS ENUM ('rainy', 'cloudy', 'sunny', 'snowy', 'windy');

-- Table Creation Statements

-- Awards --
CREATE TABLE Awards(
    AwardID         int not null,
    Award_Name      text not null,
  primary key(AwardID)
);

-- Award Won --
CREATE TABLE AwardsWon (
	WonID int not null,
    AwardsID int not null references Awards(AwardID),
	dateWon date not null,
  primary key(WonID)
);


-- People --
CREATE TABLE People (
   PeopleID    int not null,
   fName       text,
   lName       text,
   birthday    date,
   debutDate   date,
   WonID       int references AwardsWon(WonID),
 primary key(PeopleID)
);

-- Players --
CREATE TABLE Players (
    PeopleID               int not null references People(PeopleID),
    height_cm              decimal(8,3) not null,
    weight_kg              decimal(7,3) not null, 
    position               text not null,
    hittingOrientation     orientation not null,
    throwingArm            orientation not null,
  primary key(PeopleID)
);

-- Coaches --
CREATE TABLE Coaches (
    PeopleID        int not null references People(PeopleID),
    gamesCoached    int,
  primary key(PeopleID)
);

-- Umpires --
CREATE TABLE Umpires (
    PeopleID        int not null references People(PeopleID),
    gamesUmpired    int,
  primary key(PeopleID)
);

-- Broadcasters --
CREATE TABLE Broadcasters (
    PeopleID        int not null references People(PeopleID),
    gamesBroadcasted int,
  primary key(PeopleID)
);

-- Stadiums --
CREATE TABLE Stadiums (
    StadiumID           int not null,
    location            text not null,
    seatingCapacity     int not null,
    stadiumName         text not null,
  primary key(StadiumID)
);

-- Team --
CREATE TABLE Team (
    TeamID                 int not null,
    StadiumID              int not null references Stadiums(StadiumID),
    teamName               text not null,
    primaryColor           text not null,
    secondaryColor         text not null,
    mascotName             text,
    tripleA_Affiliate      text not null,
    doubleA_Affiliate      text not null,
    singleA_Affiliate      text not null,
    highA_Affiliate        text not null,
	division			   division not null,
  primary key(TeamID)
);

-- Free Agents --
CREATE TABLE FreeAgents (
    PeopleID        int not null references People(PeopleID),
    desiredSalary   int,
    lastTeamID      int not null references Team(TeamID),
  primary key(PeopleID)
);

-- Broadcast Networks --
CREATE TABLE BroadcastNetworks(
    NetworkID       int not null,
    channelNumber   int not null,
    networkName     text not null,
  primary key(NetworkID)
);

-- Game --
CREATE TABLE Game (
    GameDate            date not null,
    weather             weather not null,
    NetworkID           int not null references BroadcastNetworks(NetworkID),
    Team1ID             int not null references Team(TeamID),
    Team2ID             int not null references Team(TeamID),
  primary key(GameDate)
);

-- Hall of Fame --
CREATE TABLE HallOfFame(
    HallID          int not null,
    dateInducted    date not null,
    PeopleID        int not null references People(PeopleID),
  primary key(HallID, PeopleID)
);

-- Player Stats --
CREATE TABLE PlayerStats (
    PeopleID        int not null references People(PeopleID),
    atBats          int,
    hits            int,
    strikeouts      int,
    battingAverage  decimal(5,3),
    singles         int,
    doubles         int,
    triples         int,
    homeruns        int,
    walks           int,
    onBasePercentage decimal (5,3),
    pitchingStrikeouts   int,
    inningsPitched       int,
    strikeoutsPerNine    decimal(5,2),
    earnedRuns           int,
    earnedRunAverage     decimal(5,2),
    pitchingWins         int,
    pitchingLosses       int,
  primary key(PeopleID)
);

-- Plays For --
CREATE TABLE PlaysFor (
    PeopleID        int not null references People(PeopleID),
    TeamID          int not null references Team(TeamID),
    start_date      date not null,
    end_date        date,
  primary key(PeopleID, TeamID)
);

-- Coaches For --
CREATE TABLE CoachesFor (
    PeopleID        int not null references People(PeopleID),
    TeamID          int not null references Team(TeamID),
    start_date      date not null,
    end_date        date,
  primary key(PeopleID, TeamID)
);

-- Broadcasts For --
CREATE TABLE BroadcastsFor (
    PeopleID        int not null references People(PeopleID),
    NetworkID       int not null references BroadcastNetworks(NetworkID),
    start_date      date not null,
    end_date        date,
  primary key(PeopleID, NetworkID)
);


-- Loading Example Data 

INSERT INTO Awards (AwardID, Award_Name)
VALUES             (1, 'Silver Slugger'),
                   (2, 'Cy Young'),
                   (3, 'MVP'),
                   (4, 'Coach of the Year'),
                   (5, 'Broadcaster of the Year');

INSERT INTO AwardsWon (WonID, AwardsID, dateWon)
VALUES             (1, 3, '2010-10-30'),
                   (2, 5, '2003-10-18'),
                   (3,4, '1999-10-02'),
                   (4, 2, '2024-01-01'),
                   (5, 1, '2019-10-03');
				   
INSERT INTO People (PeopleID, fName, lName, birthday, debutDate, WonID)
VALUES             (1, 'John', 'Lobster', '1995-07-22', '2018-04-12', NULL),
                   (2, 'Richard', 'Octo', '1992-01-12', '2012-08-18', NULL),
                   (3, 'Jim', 'Krill', '2000-12-25', '2022-09-01', NULL),
                   (4, 'Drew', 'Shark', '1997-06-20', '2016-08-30', 5),
                   (5, 'Alan', 'Labouseur', '1985-02-14', '2006-03-30', 1),
                   (6, 'Paul', 'Boats', '1981-03-17', '2002-06-22', NULL),
                   (7, 'Michael', 'Coral', '1989-10-10', '2002-04-12', NULL),
                   (8, 'Josh', 'Fish', '2003-02-17', '2024-03-29', 4),
                   (9, 'Randy', 'Flounder', '1995-07-26', '2017-10-01', NULL),
                   (10, 'Carlos', 'Hook', '1988-01-19', '2012-06-05', NULL),
                   (11, 'Tim', 'Sea', '2001-03-13', '2023-07-12', NULL),
                   (12, 'Frank', 'Kelp', '1973-11-24', '1998-05-23', 2),
                   (13, 'Kyle', 'Dolphin', '1983-12-02', '2006-08-17', NULL),
                   (14, 'Dominick', 'Osyter', '1968-05-01', '1993-02-12', 3),
                   (15, 'Kevin', 'Shell', '1990-08-12', '2012-06-18', NULL);

INSERT INTO Players (PeopleID, height_cm, weight_kg, position, hittingOrientation, throwingArm)
VALUES             (1, 190.500, 80.000, 'Second Base', 'lefty', 'righty'),
                   (2, 165.100, 65.317, 'Center Field', 'righty', 'righty'),
                   (4, 183.439, 95.467, 'Shortstop', 'righty', 'ambidextrous'),
                   (5, 808.808, 808.808, 'Pitcher', 'righty', 'righty'),
                   (8, 199.691, 101.803, 'Pitcher', 'lefty', 'lefty'),
                   (9, 120.700, 72.991, 'Right Field', 'righty', 'lefty'),
                   (11, 166.388, 59.140, 'Catcher', 'righty', 'righty');


INSERT INTO Coaches (PeopleID, gamesCoached)
VALUES             (6, 1378),
                   (10, 322),
                   (14, 2001);

INSERT INTO Broadcasters (PeopleID, gamesBroadcasted)
VALUES             (3, 183),
                   (12, 2001),
                   (13, 971);

INSERT INTO Umpires (PeopleID, gamesUmpired)
VALUES             (7, 287),
                   (15, 677);

INSERT INTO Stadiums (StadiumID, location, seatingCapacity, stadiumName)
VALUES             (1, 'New York', 53000, 'Liberty Park'),
                   (2, 'Colorado', 49000, 'Mountain Field'),
                   (3, 'Florida', 55000, 'Blue Ocean Stadium'),
                   (4, 'Wyoming', 38000, 'The Buffalo Dome');

INSERT INTO Team (TeamID, StadiumID, teamName, primaryColor, secondaryColor, mascotName, tripleA_Affiliate, doubleA_Affiliate, singleA_Affiliate, highA_Affiliate, division)
VALUES             (1, 1, 'Liberty', 'Green', 'White', 'Lady Liberty', 'Vermont Trees', 'Alaska Yetis', 'Buffalo Rivers', 'Miami Sunsets', 'NL East'),
                   (2, 3, 'Retirees', 'Light Blue', 'Navy Blue', 'Grandpa Joe', 'Texas Chainsaws', 'Arizona Nothingness', 'Utah Mormons', 'Maine Mutants', 'AL East'),
                   (3, 2, 'Climbers', 'Olive Green', 'Brown', 'Rocky the Rock', 'Seattle Squares', 'Denver Dawgs', 'Kansas Nados',  'North Carolina Borings', 'NL West'),
                   (4, 4, 'Water Buffalos', 'Yellow', 'Black', 'Buddy the Buffalo', 'Minnesota Hogs', 'Georgia Peaches', 'Iowa Goats', 'Oregon Petals', 'AL Central');


INSERT INTO PlaysFor (PeopleID, TeamID, start_date, end_date)
VALUES             (1, 1, '2019-05-22', NULL),
                   (2, 3, '2016-08-12', NULL),
                   (4, 3, '2016-08-30', NULL),
                   (5, 4, '2020-06-17', NULL),
                   (8, 4, '2024-03-29', NULL),
                   (9, 2, '2017-10-01', '2023-09-15'),
                   (11, 1, '2023-07-12', NULL);
				   
INSERT INTO CoachesFor (PeopleID, TeamID, start_date, end_date)
VALUES             (6, 2, '2008-07-19', '2022-09-18'),
                   (10, 1, '2014-04-01', NULL),
                   (14, 4, '2000-05-22', NULL);
				   
INSERT INTO FreeAgents (PeopleID, desiredSalary, lastTeamID)
VALUES             (8, 2500000, 3),
                   (1, 1375000, 1);

INSERT INTO BroadcastNetworks (NetworkID, channelNumber, networkName)
VALUES             (1, 225, 'Sports Central'),
                   (2, 585, 'Bingus Sportus'),
                   (3, 75, 'Big Baseball Broadcasts');
				   
INSERT INTO BroadcastsFor (PeopleID, NetworkID, start_date, end_date)
VALUES             (3, 3, '2023-01-19', NULL),
                   (12, 1, '2000-10-02', NULL),
                   (13, 2, '2015-03-27', '2021-09-12');

INSERT INTO HallOfFame (HallID, dateInducted, PeopleID)
VALUES             (1, '2016-04-20', 5),
                   (2, '2000-08-17', 14),
                   (3, '2008-08-19', 12);

INSERT INTO Game (GameDate, weather, NetworkID, Team1ID, Team2ID)
VALUES             ('2024-05-12', 'sunny', 3, 1, 4),
                   ('2024-05-13', 'rainy', 2, 2, 4),
                   ('2024-05-14', 'snowy', 2, 1, 4),
                   ('2024-05-15', 'sunny', 1, 3, 4),
                   ('2024-05-17', 'cloudy', 3, 4, 1),
                   ('2024-05-18', 'sunny', 1, 4, 3);

INSERT INTO PlayerStats (PeopleID, atBats, hits, strikeouts, singles, doubles, triples, homeruns, walks, pitchingStrikeouts, inningsPitched, earnedRuns, pitchingWins, pitchingLosses)
VALUES             (1, 891, 212, 189, 184, 20, 3, 5, 102, NULL, NULL, NULL, NULL, NULL),
                   (2, 2082, 550, 289, 300, 74, 42, 134, 200, NULL, NULL, NULL, NULL, NULL),
                   (4, 999, 333, 44, 222, 56, 18, 37, 66, NULL, NULL, NULL, NULL, NULL),
                   (5, 1000, 1000, 0, 0, 0, 0, 1000, 0, 2700, 900, 0, 100, 0),
                   (8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 72, 62, 13, 7, 2),
                   (9, 3038, 891, 388, 588, 120, 51, 132, 204, NULL, NULL, NULL, NULL, NULL),
                   (11, 512, 220, 61, 78, 40, 9, 93, 36, NULL, NULL, NULL, NULL, NULL);
