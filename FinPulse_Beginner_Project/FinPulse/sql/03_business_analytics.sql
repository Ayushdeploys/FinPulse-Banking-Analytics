SET search_path TO finpulse;

-- A. Monthly transaction KPIs
WITH monthly AS (
    SELECT DATE_TRUNC('month', transaction_datetime)::date AS month,
           COUNT(*) AS transaction_count,
           SUM(amount) FILTER (WHERE status = 'SUCCESS') AS successful_amount,
           COUNT(*) FILTER (WHERE status = 'FAILED') AS failed_count
    FROM transactions
    GROUP BY 1
)
SELECT * FROM monthly ORDER BY month;

-- B. Top customers by successful transaction value
SELECT c.customer_id,
       c.first_name || ' ' || c.last_name AS customer_name,
       COUNT(t.transaction_id) AS successful_transactions,
       ROUND(SUM(t.amount),2) AS total_value
FROM customers c
JOIN accounts a ON a.customer_id = c.customer_id
JOIN transactions t ON t.account_id = a.account_id
WHERE t.status = 'SUCCESS'
GROUP BY c.customer_id, customer_name
ORDER BY total_value DESC
LIMIT 20;

-- C. Branch performance using a CTE
WITH branch_tx AS (
    SELECT b.branch_id, b.branch_name,
           COUNT(t.transaction_id) AS tx_count,
           SUM(t.amount) AS tx_value
    FROM branches b
    JOIN accounts a ON a.branch_id = b.branch_id
    JOIN transactions t ON t.account_id = a.account_id
    WHERE t.status = 'SUCCESS'
    GROUP BY b.branch_id, b.branch_name
)
SELECT *,
       RANK() OVER (ORDER BY tx_value DESC) AS branch_rank
FROM branch_tx
ORDER BY branch_rank;

-- D. Customer transaction ranking with a window function
WITH customer_value AS (
    SELECT c.customer_id,
           c.first_name || ' ' || c.last_name AS customer_name,
           SUM(t.amount) AS total_value
    FROM customers c
    JOIN accounts a ON a.customer_id = c.customer_id
    JOIN transactions t ON t.account_id = a.account_id
    WHERE t.status = 'SUCCESS'
    GROUP BY c.customer_id, customer_name
)
SELECT *,
       NTILE(4) OVER (ORDER BY total_value DESC) AS value_quartile
FROM customer_value
ORDER BY total_value DESC;

-- E. Loan portfolio
SELECT loan_type,
       COUNT(*) AS loan_count,
       ROUND(SUM(principal_amount),2) AS principal_value,
       ROUND(AVG(interest_rate),2) AS avg_interest_rate
FROM loans
GROUP BY loan_type
ORDER BY principal_value DESC;
