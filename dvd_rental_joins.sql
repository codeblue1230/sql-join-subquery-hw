SELECT *
FROM staff;

SELECT *
FROM rental;

-- Which staff member sold the most rentals?
SELECT first_name, last_name, staff.staff_id, COUNT(staff.staff_id)
FROM staff
FULL JOIN rental
ON staff.staff_id = rental.staff_id
-- WHERE staff.staff_id IS NOT NULL
GROUP BY staff.staff_id;

-- Which actors are showing up in what films
SELECT *
from actor;

SELECT *
FROM film;

SELECT *
FROM film_actor
ORDER BY film_id;

SELECT actor.actor_id, first_name, last_name, film_id
FROM film_actor
INNER JOIN actor
ON actor.actor_id = film_actor.actor_id;

-- Adding another join to get into the film table
SELECT actor.actor_id, first_name, last_name, film.film_id, title
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id

-- LEFT JOIN with Actor and Film Actor table
SELECT actor.actor_id, first_name, last_name, film_id
FROM film_actor
LEFT JOIN actor
ON actor.actor_id = film_actor.actor_id
WHERE first_name IS NULL and last_name IS NULL;

-- FULL JOIN to check if any actors werent in any movies
SELECT actor.actor_id, first_name, last_name, film_id
FROM actor
FULL JOIN film_actor
ON actor.actor_id = film_actor.actor_id
WHERE film_id IS NULL

-- Use a join to find all or any customers that live in Angola (join 3 tables maybe 4)
SELECT *
FROM customer;

SELECT *
FROM address;

SELECT *
FROM city;

SELECT *
FROM country;

SELECT first_name, last_name, country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Angola';

-- customer id who has more than 175 in total payments
-- HAVING is a conditional AFTER we group our data vs WHERE is a conditional BEFORE we group our data
SELECT *
FROM payment;

SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175.00
ORDER BY SUM(amount) DESC;

SELECT *
FROM CUSTOMER;

SELECT store_id, first_name, last_name, customer_id
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
)
GROUP BY store_id, first_name, last_name, customer_id;


SELECT store_id, first_name, last_name, address
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'United States' AND customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);

SELECT first_name, last_name, country, SUM(amount)
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
GROUP BY first_name, last_name, country
HAVING SUM(amount) > 175.00
ORDER BY SUM(amount) DESC;

SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id = 341;

SELECT customer_id, payment_id, amount
FROM payment;

SELECT customer_id
FROM customer;
 
SELECT first_name, last_name, payment.customer_id, amount, payment_id
FROM customer
INNER JOIN payment
on customer.customer_id = payment.customer_id;



