CREATE DATABASE KAYS_TRANSPORT;

SHOW DATABASES;

USE KAYS_TRANSPORT;

CREATE TABLE IF NOT EXISTS BUSES (
    BUS_ID INT PRIMARY KEY AUTO_INCREMENT,
    BUS_NAME VARCHAR(255) DEFAULT 'KOROPE',
    FUEL_TYPE ENUM('PMS', 'CNG'),
    PURCHASE_DATE DATE,
    CAPACITY INT DEFAULT 7,
    STATUS ENUM('ACTIVE', 'MAINTENANCE'),
    LICENSE_PLATE VARCHAR(255) DEFAULT 'Unknown'
);

CREATE TABLE ROUTE(
    ROUTE_ID INT PRIMARY KEY AUTO_INCREMENT,
    ROUTE_NAME ENUM ('LASU_ISHERI_ROAD', 'MILE2_IYANA-IBA'),
    START_LOCATION VARCHAR (255) DEFAULT 'IYANA-IBA',
    END_LOCATION ENUM ('EGBEDA', 'MILE2')
);


CREATE TABLE DRIVER(
    DRIVER_ID INT PRIMARY KEY AUTO_INCREMENT,
    FULL_NAME VARCHAR (255),
    PHONE_NUMBER VARCHAR (50),
    HIRE_DATE DATE,
    DAILY_PAYMENT INT,
    PAYMENT_VERIFICATION ENUM ('PAID', 'YET_TO_PAY')
);

DROP TABLE SCHEDULE;
SHOW TABLES;

INSERT INTO BUSES (BUS_ID, FUEL_TYPE, PURCHASE_DATE, LICENSE_PLATE)
VALUES (100, 'PMS', '2024-10-01', 'ACTIVE','EKY786GJ');

-- Set the AUTO_INCREMENT value to start at 100
ALTER TABLE BUSES AUTO_INCREMENT = 100;
-- Insert 15 bus records
INSERT INTO BUSES (BUS_NAME, FUEL_TYPE, PURCHASE_DATE, CAPACITY, STATUS, LICENSE_PLATE)
VALUES
('KOROPE', 'PMS', '2022-01-01', 7, 'ACTIVE', 'ABC123'),
('KOROPE', 'CNG', '2022-02-01', 7, 'ACTIVE', 'DEF456'),
('KOROPE', 'PMS', '2022-03-01', 7, 'MAINTENANCE', 'GHI789'),
('KOROPE', 'CNG', '2022-04-01', 7, 'ACTIVE', 'JKL012'),
('KOROPE', 'PMS', '2022-05-01', 7, 'ACTIVE', 'MNO345'),
('KOROPE', 'CNG', '2022-06-01', 7, 'MAINTENANCE', 'PQR678'),
('KOROPE', 'PMS', '2022-07-01', 7, 'ACTIVE', 'STU901'),
('KOROPE', 'CNG', '2022-08-01', 7, 'ACTIVE', 'VWX234'),
('KOROPE', 'PMS', '2022-09-01', 7, 'MAINTENANCE', 'YZA567'),
('KOROPE', 'CNG', '2022-10-01', 7, 'ACTIVE', 'BCD890'),
('KOROPE', 'PMS', '2022-11-01', 7, 'ACTIVE', 'EFG123'),
('KOROPE', 'CNG', '2022-12-01', 7, 'MAINTENANCE', 'HIJ456'),
('KOROPE', 'PMS', '2023-01-01', 7, 'ACTIVE', 'KLM789'),
('KOROPE', 'CNG', '2023-02-01', 7, 'ACTIVE', 'NOP012'),
('KOROPE', 'PMS', '2023-03-01', 7, 'MAINTENANCE', 'QRS345');


ALTER TABLE ROUTE AUTO_INCREMENT = 200;

-- Insert data into the ROUTE table
INSERT INTO ROUTE (ROUTE_NAME, START_LOCATION, END_LOCATION)
VALUES
('LASU_ISHERI_ROAD', 'IYANA-IBA', 'EGBEDA'),
('MILE2_IYANA-IBA', 'IYANA-IBA', 'MILE2');



INSERT INTO DRIVER (FULL_NAME, PHONE_NUMBER, HIRE_DATE, DAILY_PAYMENT, PAYMENT_VERIFICATION)
VALUES
('John Doe', '123-456-7890', '2022-01-01', 5000, 'PAID'),
('Jane Smith', '234-567-8901', '2022-02-01', 5000, 'PAID'),
('Michael Johnson', '345-678-9012', '2022-03-01', 5000, 'PAID'),
('Emily Davis', '456-789-0123', '2022-04-01', 5000, 'YET_TO_PAY'),
('James Brown', '567-890-1234', '2022-05-01', 5000, 'YET_TO_PAY'),
('Patricia Wilson', '678-901-2345', '2022-06-01', 5000, 'YET_TO_PAY'),
('Robert Miller', '789-012-3456', '2022-07-01', 5000, 'PAID'),
('Linda Moore', '890-123-4567', '2022-08-01', 5000, 'PAID'),
('William Taylor', '901-234-5678', '2022-09-01', 5000, 'PAID'),
('Elizabeth Anderson', '012-345-6789', '2022-10-01', 5000, 'YET_TO_PAY'),
('David Thomas', '123-456-7890', '2022-11-01', 5000, 'PAID'),
('Susan Jackson', '234-567-8901', '2022-12-01', 5000, 'PAID'),
('Charles White', '345-678-9012', '2023-01-01', 5000, 'PAID'),
('Jessica Harris', '456-789-0123', '2023-02-01', 5000, 'YET_TO_PAY'),
('George Martin', '567-890-1234', '2023-03-01', 5000, 'PAID'),
('Mary Thompson', '678-901-2345', '2023-04-01', 5000, 'PAID'),
('Joseph Garcia', '789-012-3456', '2023-05-01', 5000, 'PAID'),
('Sarah Martinez', '890-123-4567', '2023-06-01', 5000, 'YET_TO_PAY'),
('Thomas Robinson', '901-234-5678', '2023-07-01', 5000, 'PAID'),
('Margaret Clark', '012-345-6789', '2023-08-01', 5000, 'PAID'),
('Christopher Lewis', '123-456-7890', '2023-09-01', 5000, 'PAID'),
('Nancy Walker', '234-567-8901', '2023-10-01', 5000, 'YET_TO_PAY'),
('Daniel Hall', '345-678-9012', '2023-11-01', 5000, 'PAID'),
('Karen Allen', '456-789-0123', '2023-12-01', 5000, 'PAID');



CREATE TABLE SCHEDULE (
    SCHEDULE_ID INT PRIMARY KEY AUTO_INCREMENT,
    BUS_ID INT,
    ROUTE_ID INT,
    DRIVER_ID INT,
    OFFICER_ID INT,
    BATCH ENUM('BATCH A', 'BATCH B'),
    DEPARTURE_TIME TIME,
    ARRIVAL_TIME TIME,
    FOREIGN KEY (BUS_ID) REFERENCES BUSES (BUS_ID),
    FOREIGN KEY (ROUTE_ID) REFERENCES ROUTE (ROUTE_ID),
    FOREIGN KEY (DRIVER_ID) REFERENCES DRIVER (DRIVER_ID),
    FOREIGN KEY (OFFICER_ID) REFERENCES TRANSPORT_OFFICERS (OFFICER_ID)
);

CREATE TRIGGER set_times_based_on_batch
BEFORE INSERT ON SCHEDULE
FOR EACH ROW
BEGIN
    IF NEW.BATCH = 'BATCH A' THEN
        SET NEW.DEPARTURE_TIME = '06:00:00';
        SET NEW.ARRIVAL_TIME = '12:00:00';
    ELSEIF NEW.BATCH = 'BATCH B' THEN
        SET NEW.DEPARTURE_TIME = '13:00:00';
        SET NEW.ARRIVAL_TIME = '21:00:00';
    END IF;
END;

CREATE TABLE TRANSPORT_OFFICERS (
    OFFICER_ID INT PRIMARY KEY AUTO_INCREMENT,
    FULL_NAME ENUM ('JAMES PAUL', 'SYDNEY ANDERSON', 'JOHN JONES', 'MAURICE BOND'),
    HIRE_DATE DATE
);

INSERT INTO TRANSPORT_OFFICERS (OFFICER_ID, FULL_NAME, HIRE_DATE)
VALUES (1001, 'JAMES PAUL', '2023-09-22'),
(1002, 'SYDNEY ANDERSON', '2023-09-22'),
(1003, 'JOHN JONES', '2023-09-23'),
(1004, 'MAURICE BOND', '2023-09-24');

SELECT * FROM SCHEDULE;
USE KAYS_TRANSPORT;

INSERT INTO SCHEDULE (BUS_ID, ROUTE_ID, DRIVER_ID, OFFICER_ID, BATCH)
VALUES
(100, 200, 500, 1001, 'BATCH A'),
(101, 201, 501, 1002, 'BATCH B'),
(102, 200, 502, 1003, 'BATCH A'),
(103, 201, 503, 1004, 'BATCH B'),
(104, 200, 504, 1001, 'BATCH A'),
(105, 201, 505, 1002, 'BATCH B'),
(106, 200, 506, 1003, 'BATCH A'),
(107, 201, 507, 1004, 'BATCH B'),
(108, 200, 508, 1001, 'BATCH A'),
(109, 201, 509, 1002, 'BATCH B'),
(110, 200, 510, 1003, 'BATCH A'),
(111, 201, 511, 1004, 'BATCH B'),
(112, 200, 512, 1001, 'BATCH A'),
(113, 201, 513, 1002, 'BATCH B'),
(114, 200, 514, 1003, 'BATCH A'),
(100, 201, 515, 1004, 'BATCH B'),
(101, 200, 516, 1001, 'BATCH A'),
(102, 201, 517, 1002, 'BATCH B'),
(103, 200, 518, 1003, 'BATCH A'),
(104, 201, 519, 1004, 'BATCH B'),
(105, 200, 520, 1001, 'BATCH A'),
(106, 201, 521, 1002, 'BATCH B'),
(107, 200, 522, 1003, 'BATCH A'),
(108, 201, 523, 1004, 'BATCH B');

INSERT INTO SCHEDULE (BUS_ID, ROUTE_ID, DRIVER_ID, OFFICER_ID, BATCH)
VALUES
(100, 200, 500, 1001, 'BATCH A'),
(101, 201, 501, 1002, 'BATCH B'),
(102, 200, 502, 1003, 'BATCH A'),
(103, 201, 503, 1004, 'BATCH B'),
(104, 200, 504, 1001, 'BATCH A'),
(105, 201, 505, 1002, 'BATCH B'),
(106, 200, 506, 1003, 'BATCH A'),
(107, 201, 507, 1004, 'BATCH B'),
(108, 200, 508, 1001, 'BATCH A'),
(109, 201, 509, 1002, 'BATCH B'),
(110, 200, 510, 1003, 'BATCH A'),
(111, 201, 511, 1004, 'BATCH B'),
(112, 200, 512, 1001, 'BATCH A'),
(113, 201, 513, 1002, 'BATCH B'),
(114, 200, 514, 1003, 'BATCH A'),
(100, 201, 515, 1004, 'BATCH B'),
(101, 200, 516, 1001, 'BATCH A'),
(102, 201, 517, 1002, 'BATCH B'),
(103, 200, 518, 1003, 'BATCH A'),
(104, 201, 519, 1004, 'BATCH B'),
(105, 200, 520, 1001, 'BATCH A'),
(106, 201, 521, 1002, 'BATCH B'),
(107, 200, 522, 1003, 'BATCH A'),
(108, 201, 523, 1004, 'BATCH B'),
(109, 200, 500, 1001, 'BATCH A'),
(110, 201, 501, 1002, 'BATCH B'),
(111, 200, 502, 1003, 'BATCH A'),
(112, 201, 503, 1004, 'BATCH B');

INSERT INTO SCHEDULE (BUS_ID, ROUTE_ID, DRIVER_ID, OFFICER_ID, BATCH)
VALUES
(100, 200, 504, 1002, 'BATCH A'),
(101, 201, 505, 1003, 'BATCH B'),
(102, 200, 506, 1004, 'BATCH A'),
(103, 201, 507, 1001, 'BATCH B'),
(104, 200, 508, 1002, 'BATCH A'),
(105, 201, 509, 1003, 'BATCH B'),
(106, 200, 510, 1004, 'BATCH A'),
(107, 201, 511, 1001, 'BATCH B'),
(108, 200, 512, 1002, 'BATCH A'),
(109, 201, 513, 1003, 'BATCH B'),
(110, 200, 514, 1004, 'BATCH A'),
(111, 201, 515, 1001, 'BATCH B'),
(112, 200, 516, 1002, 'BATCH A'),
(113, 201, 517, 1003, 'BATCH B'),
(114, 200, 518, 1004, 'BATCH A'),
(100, 201, 519, 1001, 'BATCH B'),
(101, 200, 520, 1002, 'BATCH A'),
(102, 201, 521, 1003, 'BATCH B'),
(103, 200, 522, 1004, 'BATCH A'),
(104, 201, 523, 1001, 'BATCH B'),
(105, 200, 500, 1002, 'BATCH A'),
(106, 201, 501, 1003, 'BATCH B'),
(107, 200, 502, 1004, 'BATCH A'),
(108, 201, 503, 1001, 'BATCH B'),
(109, 200, 504, 1002, 'BATCH A'),
(110, 201, 505, 1003, 'BATCH B'),
(111, 200, 506, 1004, 'BATCH A'),
(112, 201, 507, 1001, 'BATCH B'),
(113, 200, 508, 1002, 'BATCH A');

INSERT INTO SCHEDULE (BUS_ID, ROUTE_ID, DRIVER_ID, OFFICER_ID, BATCH)
VALUES
(114, 201, 509, 1003, 'BATCH B'),
(100, 200, 510, 1004, 'BATCH A'),
(101, 201, 511, 1001, 'BATCH B'),
(102, 200, 512, 1002, 'BATCH A'),
(103, 201, 513, 1003, 'BATCH B'),
(104, 200, 514, 1004, 'BATCH A'),
(105, 201, 515, 1001, 'BATCH B'),
(106, 200, 516, 1002, 'BATCH A'),
(107, 201, 517, 1003, 'BATCH B'),
(108, 200, 518, 1004, 'BATCH A'),
(109, 201, 519, 1001, 'BATCH B'),
(110, 200, 520, 1002, 'BATCH A'),
(111, 201, 521, 1003, 'BATCH B'),
(112, 200, 522, 1004, 'BATCH A'),
(113, 201, 523, 1001, 'BATCH B'),
(114, 200, 500, 1002, 'BATCH A'),
(100, 201, 501, 1003, 'BATCH B'),
(101, 200, 502, 1004, 'BATCH A'),
(102, 201, 503, 1001, 'BATCH B'),
(103, 200, 504, 1002, 'BATCH A'),
(104, 201, 505, 1003, 'BATCH B'),
(105, 200, 506, 1004, 'BATCH A'),
(106, 201, 507, 1001, 'BATCH B'),
(107, 200, 508, 1002, 'BATCH A'),
(108, 201, 509, 1003, 'BATCH B'),
(109, 200, 510, 1004, 'BATCH A'),
(110, 201, 511, 1001, 'BATCH B');

SELECT * FROM SCHEDULE;

-- FIND ALL ACTIVE BUSES
SELECT * FROM BUSES WHERE STATUS = 'ACTIVE';

-- LIST OF BUSES WITH MAINTENANCE DUE
SELECT BUS_NAME, LICENSE_PLATE, PURCHASE_DATE 
FROM BUSES 
WHERE STATUS = 'MAINTENANCE';

-- DRIVERS ASSIGNED TO ROUTE 200
SELECT D.DRIVER_ID, D.FULL_NAME
FROM DRIVER D
JOIN SCHEDULE S ON D.DRIVER_ID = S.DRIVER_ID
WHERE ROUTE_ID = 200;

-- DRIVERS THAT ARE YET TO MAKE THERE DAILY PAYMENTS
SELECT FULL_NAME, PHONE_NUMBER 
FROM DRIVER 
WHERE PAYMENT_VERIFICATION = 'YET_TO_PAY';

-- COUNT OF BUSES PER ROUTE
SELECT ROUTE_ID, COUNT(DISTINCT BUS_ID) AS BUS_COUNT
FROM SCHEDULE
GROUP BY ROUTE_ID;

-- COUNT OF DRIVERS PER ROUTE
SELECT ROUTE_ID, COUNT(DISTINCT DRIVER_ID) AS DRIVER_COUNT
FROM SCHEDULE
GROUP BY ROUTE_ID;

-- DRIVERS WORKING ON BATCH A
SELECT D.FULL_NAME, S.ROUTE_ID, R.ROUTE_NAME 
FROM DRIVER D
JOIN SCHEDULE S ON D.DRIVER_ID = S.DRIVER_ID
JOIN ROUTE R ON R.ROUTE_ID = S.ROUTE_ID
WHERE S.BATCH = 'BATCH A';

-- LIST OF BUSES WITH FUEL TYPE 'PMS'
SELECT STATUS, COUNT (STATUS)
FROM BUSES
WHERE FUEL_TYPE = 'PMS'
GROUP BY STATUS;

-- LIST OF BUSES WITH FUEL TYPE 'CNG'
SELECT STATUS, COUNT (STATUS)
FROM BUSES
WHERE FUEL_TYPE = 'CNG'
GROUP BY STATUS;

-- Drivers with More Than One Route Assignment
SELECT S.DRIVER_ID, D.FULL_NAME, R.ROUTE_ID, R.ROUTE_NAME
FROM DRIVER D
JOIN SCHEDULE S ON D.DRIVER_ID = S.DRIVER_ID
JOIN ROUTE R ON R.ROUTE_ID = S.ROUTE_ID
HAVING ROUTE_ID > 1;

-- Find Drivers Assigned to Multiple Routes
SELECT DRIVER_ID, COUNT(ROUTE_ID) AS ROUTE_COUNT
FROM SCHEDULE
GROUP BY DRIVER_ID
HAVING ROUTE_COUNT > 1;

SELECT BUS_ID, COUNT (ROUTE_ID) AS ROUTE_COUNT
FROM SCHEDULE
GROUP BY BUS_ID
HAVING ROUTE_COUNT > 1;

--Average Daily Payment of Drivers
SELECT AVG(DAILY_PAYMENT) AS AVG_DAILY_PAYMENT 
FROM DRIVER;

-- Find Buses Purchased in 2023
SELECT BUS_ID, BUS_NAME, PURCHASE_DATE
FROM BUSES
WHERE YEAR(PURCHASE_DATE) = 2023;

-- List All Buses in Maintenance
SELECT BUS_ID, LICENSE_PLATE
FROM BUSES
WHERE STATUS = 'MAINTENANCE';

-- Count the Number of Buses per Fuel Type
SELECT FUEL_TYPE, COUNT(BUS_ID) AS NUMBER_OF_BUSES
FROM BUSES
GROUP BY FUEL_TYPE;

-- Find Drivers Hired After 2022
SELECT DRIVER_ID, FULL_NAME, HIRE_DATE
FROM DRIVER
WHERE HIRE_DATE > '2022-01-01';

-- Determine the Route with the Most Buses Assigned
SELECT BUS_ID, COUNT (ROUTE_ID) AS ROUTE_COUNT
FROM SCHEDULE
GROUP BY BUS_ID
ORDER BY ROUTE_COUNT DESC
LIMIT 10;

-- Find Buses Assigned to Driver John Doe
SELECT S.DRIVER_ID, D.FULL_NAME, S.BUS_ID
FROM DRIVER D
JOIN SCHEDULE S ON D.DRIVER_ID = S.DRIVER_ID
WHERE FULL_NAME = 'JOHN DOE';

-- List All Transport Officers
SELECT FULL_NAME, HIRE_DATE
FROM TRANSPORT_OFFICERS;

-- Calculate the Total Daily Payments for All Drivers
SELECT SUM (DAILY_PAYMENT) AS DAILY_EARNINGS
FROM DRIVER;

-- Find the Schedule for Buses on BATCH B
SELECT DISTINCT S.BUS_ID, D.FULL_NAME, S.BATCH, R.ROUTE_NAME
FROM DRIVER D
JOIN SCHEDULE S ON D.DRIVER_ID = S.DRIVER_ID
JOIN ROUTE R ON S.ROUTE_ID = R.ROUTE_ID
WHERE BATCH = 'BATCH B'
ORDER BY BUS_ID;

-- List Buses Purchased Before 2023
SELECT BUS_ID, PURCHASE_DATE AS BUS_PURCHASE_PRE_2023
FROM BUSES
WHERE PURCHASE_DATE < '2023-01-01';

-- Identify Routes with Drivers Assigned to Both Batch A and Batch B
SELECT DISTINCT D.FULL_NAME, R.ROUTE_NAME, S.BATCH
FROM DRIVER D
JOIN SCHEDULE S ON D.DRIVER_ID = S.DRIVER_ID
JOIN ROUTE R ON S.ROUTE_ID = R.ROUTE_ID
WHERE BATCH IN ('BATCH A', 'BATCH B')
ORDER BY FULL_NAME;

-- List All Active Buses
SELECT BUS_ID, STATUS
FROM BUSES
WHERE STATUS = 'ACTIVE';

