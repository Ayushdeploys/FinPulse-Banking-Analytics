-- FinPulse: Monthly Transaction Analysis

SELECT
    DATE_TRUNC('month', transaction_datetime)::date AS month,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_transaction_value,
    COUNT(*) FILTER (WHERE status = 'SUCCESS') AS successful_transactions,
    COUNT(*) FILTER (WHERE status = 'FAILED') AS failed_transactions
FROM finpulse.transactions
GROUP BY DATE_TRUNC('month', transaction_datetime)
ORDER BY month;
-- FinPulse: Customer Transaction Analysis

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(t.transaction_id) AS successful_transactions,
    SUM(t.amount) AS total_transaction_value
FROM finpulse.customers c
JOIN finpulse.accounts a
    ON c.customer_id = a.customer_id
JOIN finpulse.transactions t
    ON a.account_id = t.account_id
WHERE t.status = 'SUCCESS'
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_transaction_value DESC
LIMIT 20;