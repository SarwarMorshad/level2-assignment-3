-- =========================================================================
-- SYSTEM: Football Ticket Booking System Database Setup Template
-- DESCRIPTION: Pseudo-DDL Template for Table Creation & Data Insertion
-- INSTRUCTIONS: Replace 'TYPE' and the constraint placeholders with your own
--               actual data types, relational keys, and check criteria.
-- =========================================================================

-- DROP TABLES IF THEY ALREADY EXIST TO PREVENT CONFLICTS
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Users;

-- =========================================================================
-- 1. CREATE USERS TABLE
-- =========================================================================
CREATE TABLE Users (
    user_id      INT          PRIMARY KEY,
    full_name    VARCHAR(100) NOT NULL,
    email        VARCHAR(150) NOT NULL UNIQUE,
    role         VARCHAR(20)  NOT NULL,
    phone_number VARCHAR(20),

    -- Restrict 'role' to only the two permitted access levels
    CONSTRAINT chk_users_role CHECK (role IN ('Ticket Manager', 'Football Fan'))
);

-- =========================================================================
-- 2. CREATE MATCHES TABLE
-- =========================================================================
CREATE TABLE Matches (
    match_id            INT           PRIMARY KEY,
    fixture             VARCHAR(150)  NOT NULL,
    tournament_category VARCHAR(50)   NOT NULL,
    base_ticket_price   NUMERIC(10,2) NOT NULL,
    match_status        VARCHAR(20)   NOT NULL,

    -- Ticket price can never be negative
    CONSTRAINT chk_matches_price CHECK (base_ticket_price >= 0),
    -- Restrict 'match_status' to the permitted availability states
    CONSTRAINT chk_matches_status CHECK (match_status IN ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
);

-- =========================================================================
-- 3. CREATE BOOKINGS TABLE
-- =========================================================================
CREATE TABLE Bookings (
    booking_id     INT           PRIMARY KEY,
    user_id        INT           NOT NULL,
    match_id       INT           NOT NULL,
    seat_number    VARCHAR(10),
    payment_status VARCHAR(20),
    total_cost     NUMERIC(10,2) NOT NULL,

    -- Link each booking to an existing user (One User -> Many Bookings)
    CONSTRAINT fk_bookings_user  FOREIGN KEY (user_id)  REFERENCES Users(user_id),
    -- Link each booking to an existing match (Many Bookings -> One Match)
    CONSTRAINT fk_bookings_match FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    -- Total cost can never be negative
    CONSTRAINT chk_bookings_total CHECK (total_cost >= 0),
    -- Restrict 'payment_status' to the permitted financial states (NULL allowed = not yet processed)
    CONSTRAINT chk_bookings_payment CHECK (payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded'))
);


-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO USERS
-- =========================================================================
INSERT INTO Users (user_id, full_name, email, role, phone_number) VALUES
(1,  'Tanvir Rahman',    'tanvir@mail.com',  'Football Fan',   '+8801711111111'),
(2,  'Asif Haque',       'asif@mail.com',    'Football Fan',   '+8801722222222'),
(3,  'Sajjad Rahman',    'sajjad@mail.com',  'Ticket Manager', '+8801733333333'),
(4,  'Jannat Ara',       'jannat@mail.com',  'Football Fan',   NULL),
(5,  'Mehedi Hasan',     'mehedi@mail.com',  'Football Fan',   '+8801744444444'),
(6,  'Nusrat Jahan',     'nusrat@mail.com',  'Football Fan',   '+8801755555555'),
(7,  'Rakib Hossain',    'rakib@mail.com',   'Ticket Manager', '+8801766666666'),
(8,  'Farhana Akter',    'farhana@mail.com', 'Football Fan',   NULL),
(9,  'Imran Khan',       'imran@mail.com',   'Football Fan',   '+8801788888888'),
(10, 'Sadia Islam',      'sadia@mail.com',   'Football Fan',   '+8801799999999'),
(11, 'Tofael Ahmed',     'tofael@mail.com',  'Ticket Manager', '+8801700000000'),
(12, 'Lamia Chowdhury',  'lamia@mail.com',   'Football Fan',   '+8801712121212');

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO MATCHES
-- =========================================================================
INSERT INTO Matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona',    'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool',       'Premier League',   120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG',        'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan',     'Serie A',           90.00, 'Sold Out'),
(105, 'Juventus vs Roma',            'Serie A',           80.00, 'Available'),
(106, 'Chelsea vs Arsenal',          'Premier League',   110.00, 'Available'),
(107, 'Dortmund vs Leipzig',         'Bundesliga',        95.00, 'Selling Fast'),
(108, 'Barcelona vs Atletico Madrid','La Liga',          140.00, 'Available'),
(109, 'Napoli vs Lazio',             'Serie A',           85.00, 'Postponed'),
(110, 'Tottenham vs Man United',     'Premier League',   115.00, 'Sold Out'),
(111, 'PSG vs Marseille',            'Ligue 1',          100.00, 'Available'),
(112, 'Real Madrid vs Man City',     'Champions League', 160.00, 'Selling Fast');

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO BOOKINGS
-- Users 4, 11, 12 intentionally have no bookings (for the LEFT JOIN query).
-- =========================================================================
INSERT INTO Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1,  101, 'A-12', 'Confirmed', 150.00),
(502, 1,  102, 'B-04', 'Confirmed', 120.00),
(503, 2,  101, 'A-13', 'Confirmed', 150.00),
(504, 2,  101, NULL,   NULL,        150.00),
(505, 3,  102, 'C-20', 'Pending',   120.00),
(506, 5,  103, 'D-01', 'Confirmed', 130.00),
(507, 5,  106, 'E-15', 'Pending',   110.00),
(508, 6,  108, 'A-22', 'Confirmed', 140.00),
(509, 7,  112, 'B-09', 'Refunded',  160.00),
(510, 8,  105, NULL,   'Cancelled',  80.00),
(511, 9,  107, 'C-11', 'Confirmed',  95.00),
(512, 10, 111, 'F-03', 'Pending',   100.00);


-- =========================================================================
-- PART 2: SQL QUERIES
-- =========================================================================
