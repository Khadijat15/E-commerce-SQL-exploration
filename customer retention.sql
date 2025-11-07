---- Customer's retention


SELECT 
      cus.customer_state,
	  cus.customer_city,
	  cus.customer_id,
	  COUNT (ord.order_id) AS numbers_of_orders,
	  CASE
           WHEN COUNT(ord.order_id) >= 2 
		   THEN 'returned'
		   ELSE 'not_returned'
		END AS returned_customers
FROM
    customers AS cus
	JOIN 
	    orders AS ord
	ON
	  cus.customer_id = ord.customer_id
GROUP BY
        cus.customer_state,cus.customer_city,cus.customer_id
ORDER BY
        cus.customer_state,
		cus.customer_city,
		cus.customer_id