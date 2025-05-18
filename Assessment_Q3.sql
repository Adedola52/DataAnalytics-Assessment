-- Assessment_Q3:  Find all active accounts (savings or investments) with 
-- no transactions in the last 1 year (365 days) .

-- SQL query that answers the question -- 
WITH no_transaction_table AS (
	SELECT pp.id as plan_id, 
    cu.id, 
    pp.is_regular_savings, 
    pp.is_a_fund, 
    sa.transaction_date
	FROM users_customuser cu
	JOIN savings_savingsaccount sa ON cu.id = sa.owner_id
	JOIN plans_plan pp ON pp.id = sa.plan_id
	WHERE cu.is_active = 1
    AND sa.transaction_status = 'success'
/* retrieved active ids who have made succesful transactions */),
account_activity AS (
	SELECT plan_id, id as owner_id, 
    CASE WHEN is_regular_savings = 1
	THEN 'Savings'
	END AS type, 
    transaction_date
	FROM no_transaction_table
	
	UNION
	
	SELECT plan_id, id as owner_id, 
    CASE WHEN is_a_fund = 1
	THEN 'Investment'
	END AS type, transaction_date
	FROM no_transaction_table
/* combined savings account result set and investment accounts result set */),
maximum_table AS (SELECT owner_id, max(transaction_date) AS max_dates FROM  account_activity
GROUP BY owner_id 
/* retrieved the maximum transaction date of users to a find out the last time each made a transaction */)
SELECT a.plan_id, 
m.owner_id, a.type, 
m.max_dates AS last_transaction_date,
datediff(CURRENT_DATE (), m.max_dates) AS inactivity_days
FROM account_activity a
JOIN maximum_table m ON m.owner_id = a.owner_id
AND m.max_dates = a.transaction_date
WHERE a.type IS NOT NULL
AND m.max_dates <= date_sub(CURRENT_DATE (), interval 1 year)
ORDER BY last_transaction_date DESC;
