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

-- People --
CREATE TABLE People (
   PeopleID         int not null,
   fName       text,
   lName       text,
   birthday    date,
   debutDate   date,
   AwardsID    int references Awards(AwardsID),
 primary key(PeopleID)
 foreign key(AwardsID)
);

-- Players --
CREATE TABLE Players (
    PeopleID               int not null references People(PeopleID),
    height_cm              decimal(8,3) not null,
    weight_kg              decimal(7,3) not null, 
    TeamID                 int references Teams(TeamID),
    position               text not null,
    hittingOrientation     orientation not null,
    throwingArm            orientation not null,
  primary key(PeopleID)
  foreign key(TeamID)
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
    NetworkID       int not null references BroadcastNetworks(NetworkID),
  primary key(PeopleID)
  foreign key(NetworkID)
);

-- Free Agents --
CREATE TABLE FreeAgents (
    PeopleID        int not null references People(PeopleID),
    desiredSalary   int,
    lastTeam        text,
  primary key(PeopleID)
);

-- Team --
CREATE TABLE Team (
    TeamID                 int not null
    PeopleID               int not null references People(PeopleID),
    StadiumID              int not null references Stadiums(StadiumID),
    primaryColor           text not null,
    secondaryColor         text not null,
    mascotName             text,
    tripleA_Affiliate      text not null,
    doubleA_Affiliate      text not null,
    singleA_Affiliate      text not null,
    highA_Affiliate        text not null,
  primary key(TeamID, PeopleID)
  foreign key(StadiumID)
);

-- Stadiums --
CREATE TABLE Stadiums (
    StadiumID           int not null,
    location            text not null,
    seatingCapacity     int not null,
    stadiumName         text not null,
  primary key(StadiumID)
);

-- Game --
CREATE TABLE Game (
    GameDate            date not null,
    PeopleID            int not null references People(PeopleID),
    weather             weather not null,
    NetworkID           int not null references BroadcastNetworks(NetworkID),
    Team1ID             int not null references Team(TeamID),
    Team2ID             int not null references Team(TeamID),
  primary key(GameDate, PeopleID)
  foreign key(NetworkID, Team1ID, Team2ID)
);

-- Broadcast Networks --
CREATE TABLE BroadcastNetworks(
    NetworkID       int not null,
    channelNumber   int not null,
    networkName     text not null,
  primary key(NetworkID)
);

-- Awards --
CREATE TABLE Awards(
    AwardID         int not null,
    Award_Name      text not null,
    Award_Winner    text not null,
  primary key(AwardID)
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
    battingAverage  int, -- Calculate 
    singles         int,
    doubles         int,
    triples         int,
    homeruns        int,
    walks           int,
    onBasePercentage int, -- Calculate 
    pitchingStrikeouts   int,
    inningsPitched       int,
    strikeoutsPerNine    int, -- Calculate
    earnedRunAverage     int, -- Calculate
    pitchingWins         int,
    pitchingLosses       int,
  primary key(PeopleID)
);