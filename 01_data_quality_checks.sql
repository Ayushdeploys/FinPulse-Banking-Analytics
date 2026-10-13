-- FinPulse: Data Quality Checks

-- 1. Customers missing email addresses
SELECT *
FROM finpulse.customers
WHERE email IS NULL OR TRIM(email) = '';

-- 2. Accounts with negative balances
SELECT *
FROM finpulse.accounts
WHERE balance < 0;

-- 3. Transactions with invalid amounts
SELECT *
FROM finpulse.transactions
WHERE amount <= 0;

-- 4. Transactions with unexpected statuses
SELECT *
FROM finpulse.transactions
WHERE status NOT IN ('SUCCESS', 'FAILED', 'PENDING');

-- 5. Loans with invalid interest rates
SELECT *
FROM finpulse.loans
WHERE interest_rate <= 0;