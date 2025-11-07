-- OPERATION PERFORMANCE


----- TIME TAKEN FOR APPROVAL BASED ON ORDERS
 SELECT 
       order_id,
	   (order_approved_at - order_purchase_timestamp) AS time_taken_for_approval
FROM 
    orders
WHERE
     order_approved_at IS NOT NULL 
	 AND
	 order_purchase_timestamp IS NOT NULL
	 AND
	 order_approved_at >= order_purchase_timestamp
ORDER BY
        time_taken_for_approval DESC;



---- AVERAGE TIME TAKEN FOR DELIVERY AND APPROVAL
SELECT 
       cus.customer_state,
	   cus.customer_city,
	   AVG(ord.order_approved_at - ord.order_purchase_timestamp) AS time_taken_for_approval,
	   AVG(ord.order_delivered_carrier_date - ord.order_approved_at) AS time_taken_for_carrier_delivery,
	   AVG(ord.order_estimated_delivery_date - ord.order_approved_at) AS estimated_delivery_time,
	   AVG(ord.order_delivered_customer_date - ord.order_approved_at) AS time_taken_to_deliver_to_customer
FROM 
    customers AS cus
JOIN
    orders AS ord
ON
   cus.customer_id = ord.customer_id
WHERE
     ord.order_approved_at IS NOT NULL  AND ord.order_purchase_timestamp IS NOT NULL
	 AND ord.order_delivered_carrier_date IS NOT NULL AND ord.order_estimated_delivery_date IS NOT NULL
	 AND ord.order_delivered_customer_date IS NOT NULL AND ord.order_approved_at >= ord.order_purchase_timestamp
	 AND ord.order_delivered_carrier_date >= ord.order_approved_at
	 AND ord.order_estimated_delivery_date >= ord.order_approved_at
	 AND ord.order_delivered_customer_date >= ord.order_approved_at 
GROUP BY
       cus.customer_state, cus.customer_city
ORDER BY
        time_taken_for_approval, time_taken_for_carrier_delivery,
		estimated_delivery_time, time_taken_to_deliver_to_customer DESC;

		

--- PERCENTAGE DELIVERY PERFORMANCE
SELECT
     cus.customer_state,
	 cus.customer_city,
	 SUM(
	     CASE
		     WHEN ord.order_delivered_customer_date <= ord.order_estimated_delivery_date 
			 THEN 1
			 ELSE 0
		END
		) AS time_orders,
	  COUNT(*) AS total_orders,
	 (SUM(
	     CASE
		     WHEN ord.order_delivered_customer_date <= ord.order_estimated_delivery_date 
			 THEN 1
			 ELSE 0
			 END) / COUNT(*)
			 ) * 100 AS percentage_time_orders
FROM 
    customers AS cus
JOIN
    orders AS ord
	ON cus.customer_id = ord.customer_id
GROUP BY
       cus.customer_state, cus.customer_city
ORDER BY
       total_orders, percentage_time_orders DESC;
