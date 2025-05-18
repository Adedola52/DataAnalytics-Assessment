-- Assessment_Q1: Write a query to find customers with at least one funded savings plan AND 
-- one funded investment plan, sorted by total deposits.

-- SQL query that answers the question -- 
SELECT 
    sa.owner_id, 
    concat(cu.first_name, ' ', cu.last_name) AS name,
    count(CASE WHEN pp.is_regular_savings = 1 THEN 1 END) AS savings_count,
    count(CASE WHEN pp.is_a_fund = 1 THEN 1 END) AS investment_count,
    sum(sa.confirmed_amount) AS total_deposits
FROM savings_savingsaccount sa 
JOIN plans_plan pp ON sa.plan_id = pp.id
JOIN users_customuser cu ON cu.id = sa.owner_id
and cu.id = pp.owner_id
WHERE sa.transaction_status = 'success'
GROUP BY sa.owner_id
having savings_count>= 1 and investment_count >=1;




