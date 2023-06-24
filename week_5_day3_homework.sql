-- 1. List all customers who live in Texas (use JOINs) $

SELECT first_name, last_name, district , address.address_id
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name $

SELECT first_name, last_name, payment.customer_id, amount
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;
ORDER BY

-- 3. Show all customers names who have made payments over $175(use subqueries) total amount $

SELECT customer_id, SUM(amount)	-- This way doesn't show names and doesn't subquery
FROM payment			
GROUP BY customer_id
HAVING SUM(amount) > 175
ORDER BY SUM(amount) DESC;

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

-- 4. List all customers that live in Nepal $

SELECT first_name, last_name, country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
FULL JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';


-- 5. Which staff member had the most transactions? $


SELECT staff_id, first_name, last_name -- Remember you can only grab one column with a subquery
FROM staff 
WHERE staff_id IN (
	SELECT staff_id
	FROM payment
	GROUP BY staff_id
	ORDER BY COUNT(staff_id) DESC
	LIMIT 1
)
GROUP BY staff_id;

-- 6. How many movies of each rating are there? $

SELECT rating, COUNT(rating)
FROM film
GROUP BY rating
ORDER BY COUNT(rating) DESC;

-- 7. Show all customers who have made a single payment above $6.99 (Use Subqueries) $

SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	WHERE amount > 6.99
	GROUP BY customer_id
	HAVING COUNT(amount) = 1
);

-- 8. How many free rentals did our stores give away? $

SELECT amount, COUNT(payment_id)
FROM payment
WHERE amount = 0
GROUP BY amount;





