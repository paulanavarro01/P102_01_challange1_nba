DROP DATABASE IF EXISTS P102_01_challange1_nba;
CREATE DATABASE IF NOT EXISTS P102_01_challange1_nba; -- !40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */
USE P102_01_challange1_nba;

-- TODO: check that all names coincide
-- ASSUMPTION: 'age', 'winrate', 'nba_championships', 'rookie_of_year'
-- ASSUMPTION: all values with NOT NULL are assumed to be needed to register an instance of the kind

-- PURPLE **********************************************

DROP TABLE IF EXISTS People;
CREATE TABLE IF NOT EXISTS People (
    ID INT(4) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    brithdate DATE
);

DROP TABLE IF EXISTS Team_staff;
CREATE TABLE IF NOT EXISTS Team_staff (
    team_staff_ID INT(4) NOT NULL PRIMARY KEY,
    firstname VARCHAR(50),
    surname VARCHAR(50),
    nationality VARCHAR(50),
    gender BOOLEAN,  -- male=0, female=1
    FOREIGN KEY (team_staff_ID) REFERENCES People (ID)
);

DROP TABLE IF EXISTS Players;
CREATE TABLE IF NOT EXISTS Players (
    player_ID INT(4) NOT NULL PRIMARY KEY,
    pro_year INT(4) NOT NULL,
    university VARCHAR(50),  -- ASSUMPTION: a player that is not drafted can not come from a university
    national_team VARCHAR(50),
    FOREIGN KEY (player_ID) REFERENCES Team_staff (team_staff_ID)
);

DROP TABLE IF EXISTS Head_coaches;
CREATE TABLE IF NOT EXISTS Head_coaches(
    h_coach_ID INT(4) NOT NULL PRIMARY KEY,
    salary FLOAT(10,2) NOT NULL, -- ASSUMPTION: we need to know the salary of a player to sign him/her
    FOREIGN KEY (h_coach_ID) REFERENCES Team_staff (team_staff_ID)
);

DROP TABLE IF EXISTS Assistant_coaches;
CREATE TABLE IF NOT EXISTS Assistant_coaches (
    a_coach_ID INT(4) NOT NULL PRIMARY KEY,
    specialty VARCHAR(50) DEFAULT 'Unspecified',
    boss INT(4),
    franchise_name VARCHAR(50) NOT NULL,
    FOREIGN KEY (a_coach_ID) REFERENCES Team_staff (team_staff_ID)
);

DROP TABLE IF EXISTS Workers;
CREATE TABLE IF NOT EXISTS Workers (
    worker_ID INT(4) NOT NULL PRIMARY KEY,
    city VARCHAR(50),   -- ASSUMPTION: we do not care that much about where the worker is from
    bank_account INT(8) NOT NULL, -- ASSUMPTION: we need to know the bank account to contract a worker
    has_full_time_contract BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (worker_ID) REFERENCES People (ID)
);

DROP TABLE IF EXISTS Mascots;
CREATE TABLE IF NOT EXISTS Mascots (
    mascot_ID INT(4) NOT NULL PRIMARY KEY,
    animal VARCHAR(50) NOT NULL,
    FOREIGN KEY (mascot_ID) REFERENCES Workers (worker_ID)
);

DROP TABLE IF EXISTS Bartenders;
CREATE TABLE IF NOT EXISTS Bartenders (
    bartender_ID INT(4) NOT NULL PRIMARY KEY,
    drunk_record BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (bartender_ID) REFERENCES Workers (worker_ID)
);

DROP TABLE IF EXISTS Cleaners;
CREATE TABLE IF NOT EXISTS Cleaners (
    cleaner_ID INT(4) NOT NULL PRIMARY KEY,
    speed FLOAT(10,3) NOT NULL,
    FOREIGN KEY (cleaner_ID) REFERENCES Workers (worker_ID)
);

DROP TABLE IF EXISTS Ticket_sellers;
CREATE TABLE IF NOT EXISTS Ticket_sellers (
    seller_ID INT(4) NOT NULL PRIMARY KEY,
    gambling BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (seller_ID) REFERENCES Workers (worker_ID)
);

DROP TABLE IF EXISTS Security_guards;
CREATE TABLE IF NOT EXISTS Security_guards (
    security_ID INT(4) NOT NULL PRIMARY KEY,
    gun_license BOOLEAN NOT NULL DEFAULT TRUE,
    arena_city VARCHAR(50) NOT NULL,
    FOREIGN KEY (security_ID) REFERENCES Workers (worker_ID)
);


-- GREEN **********************************************

DROP TABLE IF EXISTS National_teams;
CREATE TABLE IF NOT EXISTS National_teams (
    country VARCHAR(50) NOT NULL,
    head_coach INT(4) NOT NULL,
    CONSTRAINT national_team_PK PRIMARY KEY (country, head_coach),
    FOREIGN KEY (head_coach) REFERENCES Head_coaches (h_coach_ID)
);

DROP TABLE IF EXISTS Draftlists;
CREATE TABLE IF NOT EXISTS Draftlists (
    draft_year INT(4) NOT NULL PRIMARY KEY
);

DROP TABLE IF EXISTS Conferences;
CREATE TABLE IF NOT EXISTS Conferencences (
    conference_name VARCHAR(50) NOT NULL PRIMARY KEY,
    conference_location VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS Franchises;
CREATE TABLE IF NOT EXISTS Franchises (
    franchise_name VARCHAR(50) NOT NULL PRIMARY KEY,
    city VARCHAR(50) NOT NULL,
    anual_budget FLOAT(10,2) NOT NULL DEFAULT 0.0,
    head_coach INT(4) NOT NULL,
    conference VARCHAR(50) NOT NULL,
    mascot INT(4),
    FOREIGN KEY (head_coach) REFERENCES Head_coaches (h_coach_ID),
    FOREIGN KEY (conference) REFERENCES Conferencences (conference_name),
    FOREIGN KEY (mascot) REFERENCES Mascots (mascot_ID)
);

DROP TABLE IF EXISTS Seasons;
CREATE TABLE IF NOT EXISTS Seasons (
    season_year INT(4) NOT NULL PRIMARY KEY,
    start_day DATE NOT NULL,
    end_date DATE, -- ASSUMPTIONS: the finish date might not be known due to uncertainties
    winner VARCHAR(50), -- ASSUMPTIONS: the season can be in progress and not have a winner
    FOREIGN KEY (winner) REFERENCES Franchises (franchise_name)
);

-- YELLOW **********************************************

DROP TABLE IF EXISTS Arenas;
CREATE TABLE IF NOT EXISTS Arenas (
    city VARCHAR(50) NOT NULL PRIMARY KEY,
    arena_name VARCHAR(50) NOT NULL,
    capacity INT(8) NOT NULL DEFAULT 18000 -- ASSUMPTION: the minimum capacity required for an arena to hold an nba match
);

DROP TABLE IF EXISTS Zones;
CREATE TABLE IF NOT EXISTS Zones (
    zone_code INT(4) NOT NULL,
    arena_city VARCHAR(50) NOT NULL,
    is_VIP BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT zone_PK PRIMARY KEY (zone_code, arena_city),
    FOREIGN KEY (arena_city) REFERENCES Arenas (city)
);

DROP TABLE IF EXISTS Seats;
CREATE TABLE IF NOT EXISTS Seats (
    seat_number INT(4) NOT NULL,
    zone_code INT(4) NOT NULL,
    colour ENUM('blue','green','yellow','red','purple') NOT NULL, -- ASSUMPTIONS: we made up colors of zones and are fixed (cannot be more)
    CONSTRAINT seat_PK PRIMARY KEY (seat_number, zone_code),
    FOREIGN KEY (zone_code) REFERENCES Zones (zone_code)
);

DROP TABLE IF EXISTS Tickets;
CREATE TABLE IF NOT EXISTS Tickets (
    ticket_ID INT(4) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    price FLOAT(10,2) NOT NULL DEFAULT 70.00, -- ASSUMPTIONS: minimum nba ticket price, always known
    purchase_date DATE, -- ASSUMPTIONS: ticket can be not sold
    seller_ID INT(4), -- ASSUMPTIONS: ticket can be not sold
    seat_number INT(4) NOT NULL,
    FOREIGN KEY (seller_ID) REFERENCES Ticket_sellers (seller_ID),
    FOREIGN KEY (seat_number) REFERENCES Seats (seat_number)
);

-- BLUE **********************************************

DROP TABLE IF EXISTS Works;
CREATE TABLE IF NOT EXISTS Works (
    worker_ID INT(4) NOT NULL,
    franchise_name VARCHAR(50) NOT NULL,
    CONSTRAINT works_PK PRIMARY KEY (worker_ID,franchise_name),
    FOREIGN KEY (worker_ID) REFERENCES Workers (worker_ID),
    FOREIGN KEY (franchise_name) REFERENCES Franchises (franchise_name)
);

DROP TABLE IF EXISTS Selects;
CREATE TABLE IF NOT EXISTS Selects (
    player_ID INT(4) NOT NULL,
    country VARCHAR(50) NOT NULL,
    year_selection INT(4) NOT NULL,
    CONSTRAINT selects_PK PRIMARY KEY (player_ID, country, year_selection),
    FOREIGN KEY (player_ID) REFERENCES Players (player_ID),
    FOREIGN KEY (country) REFERENCES National_teams (country)
);

DROP TABLE IF EXISTS Drafts;
CREATE TABLE IF NOT EXISTS Drafts (
    player_ID INT(4) NOT NULL,
    draftlist INT(4) NOT NULL,
    franchise_name VARCHAR(50) NOT NULL,
    player_rank INT(4) NOT NULL,
    CONSTRAINT drafts_PK PRIMARY KEY (player_ID, draftlist, franchise_name),
    FOREIGN KEY (player_ID) REFERENCES Players (player_ID),
    FOREIGN KEY (draftlist) REFERENCES Draftlists (draft_year),
    FOREIGN KEY (franchise_name) REFERENCES Franchises (franchise_name)
);

-- ASSUMPTION: the data is always entered after the match has finished
DROP TABLE IF EXISTS Matches;
CREATE TABLE IF NOT EXISTS Matches (
    match_ID INT(4) NOT NULL AUTO_INCREMENT,
    franchise_name VARCHAR(50) NOT NULL,
    season_year INT(4) NOT NULL,
    arena_city VARCHAR(50) NOT NULL,
    score_local INT(4) NOT NULL DEFAULT 0,
    score_visitant INT(4) NOT NULL DEFAULT 0,
    match_day DATETIME NOT NULL,
    MVP INT(4) NOT NULL,
    CONSTRAINT match_PK PRIMARY KEY (match_ID, franchise_name, season_year),
    FOREIGN KEY (franchise_name) REFERENCES Franchises (franchise_name),
    FOREIGN KEY (season_year) REFERENCES Seasons (season_year),
    FOREIGN KEY (arena_city) REFERENCES Arenas (city),
    FOREIGN KEY (MVP) REFERENCES Players (player_ID)
);

DROP TABLE IF EXISTS Signs;
CREATE TABLE IF NOT EXISTS Signs (
    player_ID INT(4) NOT NULL,
    franchise_name VARCHAR(50) NOT NULL,
    shirt_number INT(4) NOT NULL,
    salary FLOAT(10,2) NOT NULL,
    sign_in_date DATETIME NOT NULL,
    sign_out_date DATETIME, -- ASSUMPTION: can not know when the player will sign out
    CONSTRAINT signs_PK PRIMARY KEY (player_ID, franchise_name, shirt_number),
    FOREIGN KEY (player_ID) REFERENCES Players (player_ID),
    FOREIGN KEY (franchise_name) REFERENCES Franchises (franchise_name)
);

-- FOREIGN KEYS ************************************************************************
ALTER TABLE Security_guards
ADD FOREIGN KEY (arena_city) REFERENCES Arenas (city);