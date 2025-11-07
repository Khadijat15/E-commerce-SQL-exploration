------------- SALES PERFORMANCE

SELECT*
FROM customers;

SELECT*
FROM orders;

SELECT*
FROM order_items;

-- GENERAL AVERAGE PRICE 

SELECT
      AVG(price) AS average_price
FROM order_items;



-- AVERAGE PRICE AND FREIGHT VALUE BASED ON CITIES

SELECT
      cus.customer_city,
      AVG(oi.price) AS average_price,
	  AVG(oi.freight_value) AS avg_freigt_value
FROM 
    customers AS cus
JOIN 
    orders AS ord
	ON 
	cus.customer_id = ord.customer_id
JOIN
    order_items AS oi
	ON 
	ord.order_id = oi.order_id
GROUP BY 
       customer_city 
ORDER BY 
       average_price DESC;
	   


--- ORDERS BASED ON STATE

SELECT
      cus.customer_state,
	  COUNT(ord.order_id) AS total_orders
FROM 
    customers AS cus
JOIN 
    orders AS ord
	ON 
	cus.customer_id = ord.customer_id
GROUP BY 
       customer_state
ORDER BY 
       total_orders DESC;
	   


-- TOP TEN STATES BASED ON ORDERS

SELECT
      cus.customer_state,
	  COUNT(ord.order_id) AS total_orders
FROM 
    customers AS cus
JOIN 
    orders AS ord
	ON 
	cus.customer_id = ord.customer_id
GROUP BY 
       customer_state
ORDER BY 
       total_orders DESC
LIMIT 10;



---- TOP TWENTY CITIES BASED ON ORDERS

SELECT
      cus.customer_city,
	  COUNT(ord.order_id) AS total_orders
FROM 
    customers AS cus
JOIN 
    orders AS ord
	ON 
	cus.customer_id = ord.customer_id
GROUP BY 
       customer_city
ORDER BY 
       total_orders DESC
LIMIT 20;



--- REVENUE GENERATED BASED ON STATE

SELECT
      cus.customer_state,
	  COUNT(ord.order_id) AS total_orders,
	  SUM(oi.price) AS revenue
FROM 
    customers AS cus
JOIN 
    orders AS ord
	ON 
	cus.customer_id = ord.customer_id
JOIN 
    order_items AS oi
    ON ord.order_id = oi.order_id
GROUP BY 
       customer_state
ORDER BY 
       revenue DESC;

	   

--- REVENUE GENERATED BASED ON CITIES/STATE
SELECT
      cus.customer_state,
	  cus.customer_city,
	  COUNT(ord.order_id) AS total_orders,
	  SUM(oi.price) AS revenue
FROM 
    customers AS cus
JOIN 
    orders AS ord
	ON 
	cus.customer_id = ord.customer_id
JOIN 
    order_items AS oi
    ON ord.order_id = oi.order_id
GROUP BY 
       cus.customer_state,
	   cus.customer_city
ORDER BY 
       cus.customer_state,
	   cus.customer_city,
       revenue DESC;

	   

--- Sellers by city

SELECT
     customer_state,
	 Customer_city,
	 COUNT(sel.seller_id) AS num_of_sellers,
	 COUNT(ord.order_id) AS num_of_orders
FROM 
    customers AS cus
JOIN 
    orders AS ord
    ON cus.customer_id = ord.customer_id
JOIN 
    order_items AS oi
    ON ord.order_id = oi.order_id
JOIN 
    sellers AS sel
	ON oi.seller_id = sel.seller_id
GROUP BY 
       cus.customer_state,
	   cus.customer_city
ORDER BY
        cus.customer_state,
		cus.customer_city,
        num_of_sellers,
		num_of_orders;



---- PAYMENT TYPE

SELECT
      cus.customer_city,
	  pay.payment_type,
	  COUNT(pay.payment_type) AS counts
FROM 
    customers AS cus
JOIN 
    orders AS ord
	ON 
	cus.customer_id = ord.customer_id
JOIN 
    payment AS pay
    ON ord.order_id = pay.order_id
GROUP BY 
       customer_city,
	   payment_type
ORDER BY 
       customer_city,
	   payment_type DESC;

