CREATE DATABASE sem5_train;

USE sem5_train;

CREATE TABLE Trains (
	train_id INT,
	station VARCHAR(20),
	station_time TIME
);

INSERT INTO Trains(train_id, station, station_time)
VALUES
(110, 'San Francisco', '10:00:00'),
(110, 'Redwood City', '10:54:00'),
(110, 'Palo Alto', '11:02:00'),
(110, 'San Jose', '12:35:00'),
(120, 'San Francisco', '11:00:00'),
(120, 'Palo Alto', '12:49:00'),
(120, 'San Jose',  '13:30:00');

SELECT *,
SUBTIME(LEAD(station_time, 1) OVER(PARTITION BY train_id ORDER BY train_id), station_time)
AS 'time to next station'
FROM Trains;





