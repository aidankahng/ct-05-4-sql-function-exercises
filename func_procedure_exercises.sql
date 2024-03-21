-- SQL function and procedure practice exercises

-- 1. Create a Stored Procedure that will insert a new film into the film table with the
-- following arguments: title, description, release_year, language_id, rental_duration,
-- rental_rate, length, replace_cost, rating
SELECT *
FROM film
LIMIT 2;

-- First lets just create a procedure that inserts a new film
INSERT INTO film (title, description, release_year, language_id, rental_duration, rental_rate, "length", replacement_cost, rating, last_update)
VALUES ('t', 'd', 2024, 1, 2, 4.44, 10, 44.44, 'PG', NOW());

-- checking to see if it inserted correctly:
SELECT * FROM film ORDER BY film_id DESC LIMIT 1;

-- okay it seems to work. Now to make it a procedure
CREATE OR REPLACE PROCEDURE add_film(
	title VARCHAR, 
	description VARCHAR, 
	release_year INTEGER, 
	language_id INTEGER, 
	rental_duration INTEGER, 
	rental_rate NUMERIC(4,2), 
	movie_length INTEGER, 
	replacement_cost NUMERIC(5,2), 
	rating mpaa_rating)
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO film (
		title, 
		description, 
		release_year, 
		language_id, 
		rental_duration, 
		rental_rate, 
		"length", 
		replacement_cost, 
		rating, 
		last_update)
	VALUES (
		title, 
		description, 
		release_year, 
		language_id, 
		rental_duration, 
		rental_rate, 
		movie_length, 
		replacement_cost, 
		rating, 
		NOW()
	);
END;
$$;

-- Now to call procedure and check if it worked
CALL add_film(
	'ct_film',
	'A daring tale of elephants killing mice',
	2024,
	1,
	1,
	1.1,
	2,
	1.1,
	'R'
);

SELECT * FROM film ORDER BY film_id DESC;
-- And it seems to work!



-- 2. Create a Stored Function that will take in a category_id and return the number of
-- films in that category

-- First lets try to do this task manually for one category_id
-- We will count using the film_category table

SELECT COUNT(*)
FROM film_category 
WHERE category_id = 1
GROUP BY category_id; -- RETURN 64

CREATE OR REPLACE FUNCTION num_films_in_category ( 
	category_id_input INTEGER
)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
	DECLARE num_films INTEGER;
BEGIN
	SELECT COUNT(*) INTO num_films
	FROM film_category fc
	WHERE fc.category_id = category_id_input
	GROUP BY fc.category_id;
	RETURN num_films;
END;
$$;

-- Test our function
SELECT num_films_in_category(1); -- RETURN 64
-- Seems to work! Took me many tries. I'll need more practice!











