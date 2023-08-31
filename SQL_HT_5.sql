CREATE DATABASE IF NOT EXISTS seminar_5;

USE seminar_5;
DROP TABLE IF EXISTS cars;

CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT *
FROM cars;

-- Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов
CREATE VIEW below_25
AS 
SELECT *
FROM cars c
WHERE c.cost < 25000;

-- Изменить в существующем представлении порог для стоимости: 
-- пусть цена будет до 30 000 долларов (используя оператор OR REPLACE)
CREATE OR REPLACE VIEW below_25
AS 
SELECT *
FROM cars c
WHERE c.cost < 30000;

-- Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”
CREATE OR REPLACE VIEW Sk_Audi
AS 
SELECT *
FROM cars c
WHERE c.name IN ('Skoda', 'Audi');

DROP TABLE IF EXISTS tr_schedule;

CREATE TABLE tr_schedule
(
	id INT NOT NULL PRIMARY KEY,
    train_id INT,
    station VARCHAR(45),
    station_time TIME
);

INSERT tr_schedule
VALUES
	(1, 110, 'San Francisco', '10:00:00'),
    (2, 110, 'Redwood City', '10:54:00'),
    (3, 110, 'Palo Alto', '11:02:00' ),
	(4, 120, 'San Francisco', '11:00:00'),
    (5, 120, 'Redwood City', '11:54:00');
    
-- Добавьте новый столбец под названием «время до следующей станции».    
SELECT 
	id,
    train_id,
    station,
    station_time,
    TIMEDIFF(LEAD(station_time) OVER w, station_time) AS 'time to next station'
FROM tr_schedule 
WINDOW w AS (PARTITION BY train_id);

    