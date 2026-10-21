# Final Project — Pandemic Data: Import, Normalization and Analysis

Importing infectious disease statistics into MySQL, normalizing the data to 3NF, analyzing rabies cases with aggregate functions, and calculating year differences with built-in and custom SQL functions.

## Files

* `fp_queries.sql` — all SQL code (tasks 1–5)
* `p1_1_create_schema.png` — Task 1: pandemic schema created and selected as default
* `p1_2_import_results.png` — Task 1: infectious_cases.csv imported via Import Wizard (10521 records)
* `p1_3_view_data.png` — Task 1: preview of the imported data with repeated Entity and Code
* `p2_1_entities_insert.png` — Task 2: unique Entity/Code pairs inserted into entities (245 rows)
* `p2_2_entities_table.png` — Task 2: entities table
* `p2_3_normalized_table_created.png` — Task 2: infectious_cases_normalized table created with a foreign key
* `p2_4_normalized_insert.png` — Task 2: data moved into the normalized table (10521 rows)
* `p2_5_normalized_data.png` — Task 2: normalized data with entity_id and NULL instead of empty values
* `p2_6_count.png` — Task 2: SELECT COUNT(*) FROM infectious_cases
* `p3_rabies_stats.png` — Task 3: AVG, MIN, MAX, SUM of number_rabies per entity, top 10 by average
* `p4_years_difference.png` — Task 4: January 1st date, current date and year difference with built-in functions
* `p5_1_create_function.png` — Task 5: custom function years_since created
* `p5_2_apply_function.png` — Task 5: years_since applied to the year column

## Database structure (pandemic)

* `infectious_cases` — original imported table (10521 rows)
* `entities` (id, entity, code)
* `infectious_cases_normalized` (id, entity_id, year, number_yaws, polio_cases, cases_guinea_worm, number_rabies, number_malaria, number_hiv, number_tuberculosis, number_smallpox, number_cholera_cases)

## Function

* `years_since(input_year INT) RETURNS INT` — returns the number of full years between January 1st of the given year and the current date
