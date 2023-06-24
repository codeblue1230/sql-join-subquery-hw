SELECT *
FROM payment
WHERE payment_id = 17504;

DROP 

CREATE OR REPLACE PROCEDURE late_fee(
	customer INTEGER, -- customer id
	payment_choice INTEGER, -- payment
	late_fee_amount DECIMAL -- amount for late fee
)

LANGUAGE plpgsql -- get stored and lets other users know what language your procedure is written in
AS $$
BEGIN 
	--Add late fee to customer payment amount
	UPDATE payment
	SET amount = amount + late_fee_amount
	WHERE customer_id = customer AND payment_id = payment_choice;
	
	--Commit the above statement inside of a transaction
	COMMIT;
END;
$$

-- stored under procedures in the Schemas/public drop down

-- Calling a stored procedure
CALL late_fee(341, 17504, 2.00);

DROP PROCEDURE late_Fee

-- Using the rental table and the payment table, right a query that will add a 2.00 late fee
-- to any rental returned after 7 days

SELECT *
FROM rental;

SELECT *
FROM payment

CREATE OR REPLACE PROCEDURE super_late_fee (
 rental INTEGER,
 date1 DATE,
 date2 DATE
)

LANGUAGE plpgsql
AS $$
BEGIN
 UPDATE amount
 SET amount = amount + 2.00
 WHERE date2 > date1 + INTERVAL '7 days';
 COMMIT;
END;
$$

super_late_fee()


CREATE OR REPLACE PROCEDURE add_late_fee(
	fee_amount NUMERIC(5,2)
)
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE payment
  SET amount = amount + fee_amount
  WHERE rental_id IN (
    SELECT rental_id
    FROM rental
    WHERE return_date > (rental_date + INTERVAL '7 days')
  );
  
  COMMIT;
END;
$$;

CALL add_late_fee(3.00)

SELECT *
FROM payment
WHERE rental_id IN (
	SELECT rental_id
	FROM rental
	WHERE rental_date > (rental_date + INTERVAL '7 days')
);

-- Stored Functions
CREATE OR REPLACE FUNCTION add_actor(_actor_id INTEGER, _first_name VARCHAR, _last_name VARCHAR, _last_update TIMESTAMP WITHOUT TIME ZONE)
RETURNS void -- can return data type but in this case we're just inserting into a table
AS $MAIN$
BEGIN
	INSERT INTO actor
	VALUES(_actor_id, _first_name, _last_name, _last_update);
END;
$MAIN$
LANGUAGE plpgsql;
	
-- DO NOT CALL function -- SELECT it
-- BAD function call
-- CALL add_actor(500, 'Orlando', 'Bloom', NOW():timestamp);

-- GOOD nice way of SELECTING a function
SELECT add_actor(500, 'ORLANDO', 'BLOOM', NOW()::timestamp)

-- Verify that the actor was added
SELECT *
FROM actor
WHERE actor_id = 500;


-- Calling a function inside of a procedure
-- take a value that a function returns and then pass that into a procedure

CREATE OR REPLACE FUNCTION get_discount(price NUMERIC, percentage INTEGER)
RETURNS INTEGER
AS $$
BEGIN
RETURN (price * percentage/100);
END;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE apply_discount(
	percentage INTEGER,
	_payment_id INTEGER
)
LANGUAGE plpgsql
AS
$$
BEGIN
	UPDATE payment
	SET amount = get_discount(payment.amount, percentage)
	WHERE payment_id = _payment_id;
	COMMIT;
END;
$$

SELECT *
FROM payment
WHERE payment_id = 17507

CALL apply_discount(50, 17507)

