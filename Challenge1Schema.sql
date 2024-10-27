DROP DATABASE IF EXISTS P102_01_challange1_nba;
CREATE DATABASE P102_01_challange1_nba; -- !40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */
USE P102_01_challange1_nba;

-- TODO: check that all names coincide

-- PURPLE **********************************************

DROP TABLE IF EXISTS People;
CREATE TABLE People (
    ID int(4) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    brithdate DATE
);

DROP TABLE IF EXISTS Team_staff;
CREATE TABLE Team_staff (
    team_staff_ID INT(4) NOT NULL PRIMARY KEY,
    firname VARCHAR(50),
    surname VARCHAR(50),
    nationality VARCHAR(50),    -- TODO
    gender BOOLEAN  -- male=0, female=1
);

DROP TABLE IF EXISTS Assistant_coaches;
CREATE TABLE Assistant_coaches (
    a_coach_ID INT(4) NOT NULL PRIMARY KEY,
    specialty VARCHAR(50),  -- TODO
    boss INT(4),
    franchise_name VARCHAR(50)
);

DROP TABLE IF EXISTS Workers;
CREATE TABLE Workers (
    worker_ID INT(4) NOT NULL PRIMARY KEY,
    city VARCHAR(50),
    bank_account INT(8) NOT NULL, -- ASSUMPTION
    has_full_time_contract BOOLEAN
);

DROP TABLE IF EXISTS Mascots;
CREATE TABLE Mascots (
    mascot_ID INT(4) NOT NULL PRIMARY KEY,
    animal VARCHAR(50)
);

DROP TABLE IF EXISTS Bartenders;
CREATE TABLE Bartenders (
    bartender_ID INT(4) NOT NULL PRIMARY KEY,
    drunk_record BOOLEAN
);

DROP TABLE IF EXISTS Cleaners;
CREATE TABLE Cleaners (
    cleaner_ID INT(4) NOT NULL PRIMARY KEY,
    speed FLOAT(10,10)
);

DROP TABLE IF EXISTS Ticket_sellers;
CREATE TABLE Ticket_sellers (
    seller_ID INT(4) NOT NULL PRIMARY KEY,
    gambling BOOLEAN
);

DROP TABLE IF EXISTS Security_guards;
CREATE TABLE Scurity_guards (
    security_ID INT(4) NOT NULL PRIMARY KEY,
    gun_license BOOLEAN,
    arena_city VARCHAR(50)  -- TODO
);


DROP TABLE IF EXISTS Players;
CREATE TABLE Players (
    player_ID INT(4) NOT NULL PRIMARY KEY,
    pro_year INT(4),
    university VARCHAR(50), -- TO DO
    national_team VARCHAR(50)
);

DROP TABLE IF EXISTS Head_coaches;
CREATE TABLE Head_coaches(
    h_coach_ID INT(4) NOT NULL PRIMARY KEY,
    win_rate FLOAT(10,10),
    salary FLOAT(10,10)
);



-- GREEN **********************************************

DROP TABLE IF EXISTS National_teams;
CREATE TABLE National_teams (
    country VARCHAR(50) NOT NULL, -- TO DO
    head_coach INT(4) NOT NULL,
    CONSTRAINT national_team_PK PRIMARY KEY (country, head_coach)
);

DROP TABLE IF EXISTS Draftlists;
CREATE TABLE Draftlists (
    draft_year INT(4) NOT NULL PRIMARY KEY
);

DROP TABLE IF EXISTS Franchises;
CREATE TABLE Franchises (
    franchise_name VARCHAR(50) NOT NULL PRIMARY KEY, -- TO DO
    city VARCHAR(50), -- TO DO
    anual_budget FLOAT(10,10),
    head_coach INT(4),
    conference VARCHAR(50),
    mascot INT(4)
);

DROP TABLE IF EXISTS Conferences;
CREATE TABLE Conferencences (
    conference_name VARCHAR(50) NOT NULL PRIMARY KEY,
    conference_location VARCHAR(50)
);

DROP TABLE IF EXISTS Seasons;
CREATE TABLE Seasons (
    season_year INT(4) NOT NULL PRIMARY KEY,
    start_day DATE,
    end_date DATE,
    winner VARCHAR(50)
);

-- YELLOW **********************************************

DROP TABLE IF EXISTS Tickets;
CREATE TABLE Tickets (
    ID INT(4) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    price FLOAT(10,10),
    purchase_date DATE,
    seller_ID INT(4),
    seat_number INT(4)
);

DROP TABLE IF EXISTS Seats;
CREATE TABLE Seats (
    seat_number INT(4) NOT NULL,
    zone_code INT(4),
    colour VARCHAR(50), -- TODO
    CONSTRAINT seat_PK PRIMARY KEY (seat_number, zone_code)
);

DROP TABLE IF EXISTS Zones;
CREATE TABLE Zones (
    zone_code INT(4) NOT NULL,
    arena_city VARCHAR(50) NOT NULL,
    is_VIP BOOLEAN,
    CONSTRAINT zone_PK PRIMARY KEY (zone_code, arena_city)
);

DROP TABLE IF EXISTS Arenas;
CREATE TABLE Arenas (
    city VARCHAR(50) NOT NULL PRIMARY KEY, -- TODO
    arena_name VARCHAR(50),
    capacity INT(8)
);

-- BLUE **********************************************

DROP TABLE IF EXISTS Selects;
CREATE TABLE Selects (
    player_ID INT(4) NOT NULL,
    country VARCHAR(50) NOT NULL,
    year_selection INT(4) NOT NULL,
    CONSTRAINT selects_PK PRIMARY KEY (player_ID, country, year_selection)
);

DROP TABLE IF EXISTS Drafts;
CREATE TABLE Drafts (
    player_ID INT(4) NOT NULL,
    draftlist INT(4) NOT NULL,
    franchise_name INT(4) NOT NULL,
    player_rank INT(4),
    CONSTRAINT drafts_PK PRIMARY KEY (player_ID, draftlist, franchise_name)
);

DROP TABLE IF EXISTS Matches;
CREATE TABLE Matches (
    match_ID INT(4) NOT NULL,
    franchise_name VARCHAR(50) NOT NULL, -- TO DO 
    season_year INT(4) NOT NULL,
    arean_city VARCHAR(50), -- TO DO
    score_local INT(4),
    score_visitant INT(4),
    match_day DATETIME,
    CONSTRAINT match_PK PRIMARY KEY (match_ID, franchise_name, season_year)
);

DROP TABLE IF EXISTS Signs;
CREATE TABLE Signs (
    player_ID INT(4) NOT NULL,
    franchise_name VARCHAR(50) NOT NULL,
    shirt_number INT(4) NOT NULL,
    salary FLOAT(10,10),
    sign_in_date DATETIME NOT NULL,
    sign_out_date DATETIME,
    CONSTRAINT signs_PK PRIMARY KEY (player_ID, franchise_name, shirt_number)
);

DROP TABLE IF EXISTS Works;
CREATE TABLE Works (
    worker_ID INT(4) NOT NULL,
    franchise_name VARCHAR(50) NOT NULL,
    CONSTRAINT works_PK PRIMARY KEY (worker_ID,franchise_name)
);