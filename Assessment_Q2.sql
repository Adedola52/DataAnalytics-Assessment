-- Assessment_Q2: Calculate the average number of transactions per customer per month and categorize them:
-- "High Frequency" (≥10 transactions/month)
-- "Medium Frequency" (3-9 transactions/month)
-- "Low Frequency" (≤2 transactions/month)

-- SQL query that answers the question -- 
WITH Frequency_analysis AS (
	SELECT cu.id, date_format(sa.transaction_date, '%Y-%m')  AS transaction_date, 
    count(date_format(sa.transaction_date, '%Y-%m') ) AS no_of_transactions
	FROM users_customuser cu
	JOIN savings_savingsaccount sa ON sa.owner_id = cu.id
	WHERE transaction_status = 'success'
	GROUP BY cu.id, date_format(sa.transaction_date, '%Y-%m') 
),
Tf_analysis AS (
	SELECT id, avg(no_of_transactions) AS no_of_transactions
	FROM Frequency_analysis
    GROUP BY id
),
categorized_analysis as (
    SELECT id, no_of_transactions, 
    CASE WHEN no_of_transactions <= 2
	THEN "Low Frequency"
	WHEN no_of_transactions BETWEEN 3 AND 9
	THEN "Medium Frequency"
	ELSE "High Frequency"
	END AS frequency_category
    FROM Tf_analysis)
SELECT frequency_category, 
count(frequency_category) AS customer_count, 
avg(no_of_transactions) AS avg_transactions_per_month
FROM categorized_analysis
GROUP BY frequency_category
ORDER BY avg_transactions_per_month DESC;