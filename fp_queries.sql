Завдання 1 Створення схеми та вибір її за замовчуванням

CREATE SCHEMA IF NOT EXISTS pandemic;

USE pandemic;

Імпорт infectious_cases.csv виконано через Table Data Import Wizard (усі колонки з типом text, імпортовано 10521 запис)

SELECT * FROM infectious_cases LIMIT 20;

Завдання 2 Нормалізація таблиці infectious_cases до 3НФ

CREATE TABLE entities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    entity VARCHAR(255) NOT NULL,
    code VARCHAR(20)
);

INSERT INTO entities (entity, code)
SELECT DISTINCT Entity, Code
FROM infectious_cases;

SELECT * FROM entities;

CREATE TABLE infectious_cases_normalized (
    id INT AUTO_INCREMENT PRIMARY KEY,
    entity_id INT NOT NULL,
    year INT NOT NULL,
    number_yaws DOUBLE,
    polio_cases DOUBLE,
    cases_guinea_worm DOUBLE,
    number_rabies DOUBLE,
    number_malaria DOUBLE,
    number_hiv DOUBLE,
    number_tuberculosis DOUBLE,
    number_smallpox DOUBLE,
    number_cholera_cases DOUBLE,
    FOREIGN KEY (entity_id) REFERENCES entities(id)
);

INSERT INTO infectious_cases_normalized (
    entity_id, year,
    number_yaws, polio_cases, cases_guinea_worm, number_rabies,
    number_malaria, number_hiv, number_tuberculosis,
    number_smallpox, number_cholera_cases
)
SELECT
    e.id,
    ic.Year,
    NULLIF(ic.Number_yaws, ''),
    NULLIF(ic.polio_cases, ''),
    NULLIF(ic.cases_guinea_worm, ''),
    NULLIF(ic.Number_rabies, ''),
    NULLIF(ic.Number_malaria, ''),
    NULLIF(ic.Number_hiv, ''),
    NULLIF(ic.Number_tuberculosis, ''),
    NULLIF(ic.Number_smallpox, ''),
    NULLIF(ic.Number_cholera_cases, '')
FROM infectious_cases AS ic
JOIN entities AS e
    ON e.entity = ic.Entity
   AND e.code = ic.Code;

SELECT * FROM infectious_cases_normalized LIMIT 20;

SELECT COUNT(*) FROM infectious_cases;

Завдання 3 Аналіз Number_rabies (AVG, MIN, MAX, SUM), топ-10 за середнім

SELECT
    e.id AS entity_id,
    e.entity,
    e.code,
    AVG(icn.number_rabies) AS avg_rabies,
    MIN(icn.number_rabies) AS min_rabies,
    MAX(icn.number_rabies) AS max_rabies,
    SUM(icn.number_rabies) AS sum_rabies
FROM infectious_cases_normalized AS icn
JOIN entities AS e ON e.id = icn.entity_id
WHERE icn.number_rabies IS NOT NULL
GROUP BY e.id, e.entity, e.code
ORDER BY avg_rabies DESC
LIMIT 10;

Завдання 4 Колонка різниці в роках (вбудовані функції)

SELECT
    id,
    year,
    MAKEDATE(year, 1) AS year_start_date,
    CURDATE() AS current_date_value,
    TIMESTAMPDIFF(YEAR, MAKEDATE(year, 1), CURDATE()) AS years_difference
FROM infectious_cases_normalized;

Завдання 5.1 Створення власної функції years_since

DROP FUNCTION IF EXISTS years_since;

DELIMITER //

CREATE FUNCTION years_since(input_year INT)
RETURNS INT
NOT DETERMINISTIC
NO SQL
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, MAKEDATE(input_year, 1), CURDATE());
END //

DELIMITER ;

Завдання 5.2 Застосування функції years_since

SELECT
    id,
    year,
    years_since(year) AS years_difference
FROM infectious_cases_normalized;