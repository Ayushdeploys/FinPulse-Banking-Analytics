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
