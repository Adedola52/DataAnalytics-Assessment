# Query Explanations

# Assessment_Q1: 
**Scenario:** The business wants to identify customers who have both a savings and an investment plan (cross-selling opportunity)

**Task:** Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits

**Code Explanation:**
To answer this, I retrieved the required information such as customer_id and concatenated the first and last names from three tables using joins. I applied aggregate functions like COUNT to calculate the number of savings accounts, the number of investment accounts, and sum to calculate the total deposits. I used a WHERE clause to filter transactions with a status of 'success', which indicates a successful funding. Additionally, I applied a HAVING clause to filter the aggregated results to include only customers who have at least one funded savings account **AND** at least one investment account then sorted by total deposits.

# Assessment_Q2: 
**Scenario:** The finance team wants to analyze how often customers transact to segment them (e.g., frequent vs. occasional users)

**Task:** Calculate the average number of transactions per customer per month and categorize them:
- "High Frequency" (≥10 transactions/month)
- "Medium Frequency" (3-9 transactions/month)
- "Low Frequency" (≤2 transactions/month)

**Code Explanation:**


# Assessment_Q3: 
**Scenario:** The ops team wants to flag accounts with no inflow transactions for over one year

**Task:** Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days)

**Code Explanation:**
To answer this, I used a Common Table Expression (CTE). First, I retrieved all active users who have made successful transactions, a successful transaction indicates an inflow. From this result, I identified users with either a savings account and users who have investment account then combined the result sets using **UNION**. Finally, I retrieved the maximum transaction date for each user to determine the last time they made a transaction and then identified active users whose last succesfull transaction was a year or over a year ago, without redundancies.

# Assessment_Q4: 
**Scenario:** Marketing wants to estimate CLV based on account tenure and transaction volume (simplified model)

**Task:** For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
- Account tenure (months since signup)
- Total transactions
- Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
- Order by estimated CLV from highest to lowest

**Code Explanation:**
To answer this, I used a Common Table Expression (CTE). First, I retrieved the customer_id, concatenated their first and last names, and calculated the account tenure in months. I then converted the amount columns from kobo to naira, performed aggregations such as sum and average to derive total_transactions and avg_profit_per_transaction.
The necessary tables were joined and filtered to include only successful transactions, as those are the only valid ones. Including failed transactions could distort calculations like the average profit per transaction.
From the resulting dataset, I retrieved the following:
- customer_id
- name
- tenure_month
- total_transactions
- estimated_clv calculated using the formula:
**CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction**

