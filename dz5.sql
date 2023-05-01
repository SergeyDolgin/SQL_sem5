CREATE DATABASE sem5_windows;

USE sem5_windows;

CREATE TABLE Cars (
	Id INT auto_increment primary key,
    Name VARCHAR(20) NOT NULL,
    Cost DECIMAL (6, 0)
);

INSERT INTO Cars (Name, Cost) VALUES
	('Audi', 52642), ('Mercedes', 57127),
    ('Skoda', 9000), ('Volvo', 29000),
	('Bentley', 350000), ('Citroen', 21000),
    ('Hummer', 41400), ('Votkswagen', 21600);
    
# Задание 1.
CREATE VIEW Cars_cheap AS
	SELECT * FROM Cars WHERE Cost < 25000;
SELECT * FROM Cars_cheap;

# Задание 2.
ALTER VIEW Cars_cheap AS
	SELECT * FROM Cars WHERE Cost < 30000;
SELECT * FROM Cars_cheap;

# Задание 3.
CREATE VIEW Cars_two AS
	SELECT * FROM Cars WHERE Name = 'Skoda' OR Name = 'Audi';
SELECT * FROM Cars_two;

CREATE TABLE Analysis
(       
  an_id VARCHAR(2) PRIMARY KEY, 
  an_name VARCHAR(10), 
  an_cost INT,
  an_price INT, 
  an_group VARCHAR(10)
);

INSERT INTO Analysis values
(1 , 'second', 10, 12, 'common'),
(2 , 'first', 11, 12, 'common'),
(3 , 'first', 11, 12, 'common'),
(4 , 'third', 20, 25, 'spec'),
(5 , 'second', 10, 12, 'common'),
(6 , 'first', 11, 12, 'common'),
(7 , 'third', 20, 25, 'spec');

CREATE TABLE Grouups
(       
  gr_id VARCHAR(2) PRIMARY KEY, 
  gr_name VARCHAR(10), 
  gr_temp_cost INT
);

INSERT INTO Grouups VALUES
(1 , 'common', 10),
(2 , 'spec', 2);


CREATE TABLE Orders
(       
  ord_id VARCHAR(2) PRIMARY KEY, 
  ord_datetime datetime, 
  ord_an INT
);
INSERT INTO Orders values
(1 , '2020-02-05 00:00:00', 1),
(2 , '2020-02-06 00:00:00', 2),
(3 , '2020-02-07 00:00:00', 3),
(4 , '2020-02-08 00:00:00', 4),
(5 , '2020-02-10 00:00:00', 5),
(6 , '2020-02-13 00:00:00', 6),
(7 , '2020-02-15 00:00:00', 7);

SELECT sc.ord_datetime, sc.an_name, SUM(an_price) 
	OVER (PARTITION BY sc.ord_datetime ORDER BY sc.ord_datetime) AS Summary
FROM (SELECT Analysis.an_name, Analysis.an_price, Orders.ord_datetime
    FROM sem5_windows.Analysis, sem5_windows.Orders  WHERE Analysis.an_id = Orders.ord_an 
    AND ord_datetime BETWEEN '2020-02-05' AND '2020-02-11') AS sc;
