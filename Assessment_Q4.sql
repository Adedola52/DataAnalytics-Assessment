-- Assessment_Q4: For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, 
-- calculate:
-- Account tenure (months since signup)
-- Total transactions
-- Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
-- Order by estimated CLV from highest to lowest

-- SQL query that answers the question -- 
WITH cl_value AS (
	SELECT cu.id AS customer_id, CONCAT (cu.first_name, ' ', cu.last_name) AS name, 
    timestampdiff(Month, cu.date_joined, CURRENT_DATE ()) AS tenure_month, 
    sum(sa.confirmed_amount/100) AS total_transactions /* converted to naira */  ,
    avg((sa.confirmed_amount /100) * 0.001) avg_profit_per_transaction /* converted to naira */ 
	FROM users_customuser cu
	JOIN savings_savingsaccount sa ON sa.owner_id = cu.id
    WHERE transaction_status = 'success'
	GROUP BY cu.id, name 
)
SELECT customer_id, 
name, 
tenure_month, 
total_transactions, 
(total_transactions / tenure_month) * 12 * avg_profit_per_transaction AS estimated_clv
FROM cl_value
ORDER BY estimated_clv DESC; 