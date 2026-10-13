SET search_path TO finpulse;

-- 1. Duplicate primary keys
SELECT customer_id, COUNT(*) FROM customers GROUP BY customer_id HAVING COUNT(*) > 1;
SELECT account_id, COUNT(*) FROM accounts GROUP BY account_id HAVING COUNT(*) > 1;
SELECT transaction_id, COUNT(*) FROM transactions GROUP BY transaction_id HAVING COUNT(*) > 1;
SELECT loan_id, COUNT(*) FROM loans GROUP BY loan_id HAVING COUNT(*) > 1;

-- 2. Required nulls
SELECT COUNT(*) AS customers_missing_email FROM customers WHERE email IS NULL;
SELECT COUNT(*) AS accounts_missing_customer FROM accounts WHERE customer_id IS NULL;

-- 3. Invalid numeric values
SELECT COUNT(*) AS negative_balances FROM accounts WHERE current_balance < 0;
SELECT COUNT(*) AS non_positive_transactions FROM transactions WHERE amount <= 0;
SELECT COUNT(*) AS invalid_interest_rate FROM loans WHERE interest_rate <= 0;

-- 4. Invalid categories
SELECT DISTINCT status FROM transactions ORDER BY status;
SELECT DISTINCT account_type FROM accounts ORDER BY account_type;

-- 5. Orphan foreign keys
SELECT a.account_id
FROM accounts a
LEFT JOIN customers c ON a.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT t.transaction_id
FROM transactions t
LEFT JOIN accounts a ON t.account_id = a.account_id
WHERE a.account_id IS NULL;

-- 6. Basic date sanity
SELECT COUNT(*) AS future_customer_dates
FROM customers
WHERE customer_since > CURRENT_DATE;
