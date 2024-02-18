CREATE TABLE IF NOT EXISTS departments (
  	id SERIAL PRIMARY KEY,
	title VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS positions (
  	id SERIAL PRIMARY KEY,
	title VARCHAR NOT NULL,
        department_id int,
        FOREIGN KEY (department_id) REFERENCES departments(id)
);

CREATE TABLE IF NOT EXISTS workers (
  	id SERIAL PRIMARY KEY,
	"name" VARCHAR NOT NULL,
  	age INT,
        is_married BOOLEAN DEFAULT FALSE,
        position_id int,
        FOREIGN KEY (position_id) REFERENCES positions(id)
);

CREATE TABLE IF NOT EXISTS new_workers (
  	id SERIAL PRIMARY KEY,
	"name" VARCHAR NOT NULL,
  	age INT,
    is_married BOOLEAN DEFAULT FALSE,
    position_id int,
    FOREIGN KEY (position_id) REFERENCES positions(id)
);

CREATE TABLE IF NOT EXISTS workers (
   id SERIAL PRIMARY KEY,
   "name" VARCHAR NOT NULL,
    age INT,
    is_married BOOLEAN DEFAULT FALSE,
    start_work_at DATE NOT NULL,
    "info" TEXT,
    email TEXT UNIQUE
);

CREATE INDEX age_idx
ON workers(age);

DROP INDEX age_idx

DROP TABLE IF EXISTS workers;
DROP TABLE IF EXISTS positions;
DROP TABLE IF EXISTS departments;

INSERT INTO workers ("name", age) VALUES ('Boris', 20);

INSERT INTO workers ("name", age, start_work_at, email) VALUES ('Ivan', 20, '2022-01-01', '11@mail.ru');

INSERT INTO workers ("name", age, start_work_at, email, "info") VALUES 

('John', 20, '2022-01-01', '111@mail.ru', '{"name":"John"}');

INSERT INTO workers (start_work_at) VALUES ('2022-02-02')

INSERT INTO workers ("name", age, is_married) VALUES 
('Boris', 20, false),
('John', 24, true),
('Kate', 18, false),
('Rafael', 25, true),
('Antonio', 22, false)

INSERT INTO workers ("name", age, is_married) VALUES 
('Leo', 24, false),
('Lena', 20, false)

INSERT INTO positions (title) VALUES
('manager'),
('designer'),
('developer');

INSERT INTO workers ("name", age, is_married, position_id) VALUES
('Boris', 24, true, 1),
('Kate', 18, false, 2),
('Ivan', 23, false, 2),
('John', 26, true, 3),
('Antonio', 23, false, 3),
('Elena', 18, false, 2),
('Franhesko', 19, true, 3);

INSERT INTO departments (title) VALUES
('marketing'),
('ecommerce');

INSERT INTO positions (title, department_id) VALUES
('manager', 1),
('manager', 2),
('designer', 2),
('developer', 2);
('boss', 2);

INSERT INTO workers ("name", age, is_married, position_id) VALUES
('Boris', 24, true, 1),
('Kate', 18, false, 3),
('Ivan', 23, false, 2),
('John', 26, true, 4),
('Antonio', 23, false, 4),
('Elena', 18, false, 3),
('Franhesko', 19, true, 3),
('Pavel', 25, false, null),
('Otto', 19,false, null);

SELECT * FROM workers;
SELECT * FROM positions;
SELECT * FROM departments;
SELECT * FROM new_workers

ALTER TABLE workers
ADD COLUMN "some_attr" VARCHAR

ALTER TABLE workers
DROP COLUMN "some_attr"

ALTER TABLE workers
RENAME COLUMN "info" TO some_data

ALTER TABLE workers
ALTER COLUMN "name" DROP NOT NULL

ALTER TABLE workers
ALTER COLUMN "name" SET NOT NULL

ALTER TABLE workers
ALTER COLUMN is_married SET DEFAULT TRUE

ALTER TABLE workers
ALTER COLUMN "name" TYPE TEXT

DELETE FROM workers
WHERE "name" = 'Boris'

DELETE FROM workers
WHERE id = 4

UPDATE workers
SET "name" = 'Boris'
WHERE "name" = 'Ivan'

UPDATE workers
SET "name" = 'Ivan', age = 21
WHERE "name" = 'Boris'

UPDATE workers
set "position" = 'manager'
WHERE id = 1

UPDATE workers
set "position" = 'designer'
WHERE id = 3

UPDATE workers
set "position" = 'developer'
WHERE id > 3

UPDATE workers
set age = 23
where is_married <> false


SELECT "name", title FROM workers 
JOIN positions 
ON workers.position_id = positions.id;

SELECT * FROM workers 
LEFT JOIN positions 
ON workers.position_id = positions.id;

SELECT * FROM workers 
RIGHT JOIN positions 
ON workers.position_id = positions.id;

SELECT * FROM workers 
FULL JOIN positions 
ON workers.position_id = positions.id;

SELECT * FROM workers
LEFT JOIN positions 
ON workers.position_id = positions.id
UNION
SELECT * FROM workers 
RIGHT JOIN positions 
ON workers.position_id = positions.id

SELECT p.title, d.title FROM positions as p
JOIN departments as d 
ON p.department_id = d.id;

SELECT DISTINCT age FROM workers

SELECT * FROM workers
where age >  20 AND is_married = true

SELECT * FROM workers
where age < 22 OR age > 25

SELECT * FROM workers
where NOT age = 26

SELECT * FROM workers
where  age <> 26

SELECT * FROM workers
ORDER BY age ASC

SELECT * FROM workers
ORDER BY age DESC

SELECT * FROM workers
ORDER BY age DESC LIMIT 1

SELECT * FROM workers
ORDER BY age ASC LIMIT 1

SELECT MIN(age) FROM workers

SELECT MAX(age) FROM workers

SELECT COUNT(id) FROM workers

SELECT SUM(age) FROM workers

SELECT * FROM workers
where position_id = 3

SELECT AVG(age) FROM workers

SELECT * FROM workers
WHERE name LIKE 'Boris'

SELECT * FROM workers
WHERE name LIKE '%or%'

SELECT * FROM workers
WHERE name LIKE '%ate%'

SELECT * FROM workers
WHERE name ILIKE 'b%'

SELECT * FROM workers
WHERE name ILIKE '%e'

SELECT * FROM workers
WHERE age in (22,25,26)

SELECT * FROM workers
WHERE id in (1,3,5)

SELECT * FROM workers
WHERE age BETWEEN 20 AND 30

SELECT COUNT(id), is_married FROM workers
GROUP BY is_married

SELECT COUNT(id), age FROM workers
GROUP BY age

SELECT * FROM workers
WHERE EXISTS 
(SELECT department_id FROM positions
 where workers.position_id = positions.id and positions.department_id = 1);

SELECT * FROM workers
WHERE position_id = any 
(SELECT id from positions
 WHERE department_id = 1)

SELECT * FROM workers
WHERE position_id = SOME 
(SELECT id from positions
 WHERE department_id = 1)

INSERT INTO new_workers
SELECT * FROM workers
WHERE age > 24;

