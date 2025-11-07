--- CUSTOMER's EXPERIENCE


--- REVIEWS BASED ON ORDERS

SELECT
      cus.customer_id,
	  ord.order_id,
	  rev.review_score,
	  rev.review_comment_message
FROM
    customers AS cus
JOIN 
    orders AS ord
	ON cus.customer_id = ord.customer_id
JOIN
    reviews AS rev
	ON ord.order_id = rev.order_id
WHERE 
     rev.review_score >=4
ORDER BY
       rev.review_score DESC;




--- TOTAL NUMBER OF CUSTOMERS BASED ON REVIEWS

SELECT
	  rev.review_score,
	  COUNT(cus.customer_id) AS total_customers
FROM
    customers AS cus
JOIN 
    orders AS ord
	ON cus.customer_id = ord.customer_id
JOIN
    reviews AS rev
	ON ord.order_id = rev.order_id
GROUP BY 
       rev.review_score
ORDER BY
       total_customers DESC;