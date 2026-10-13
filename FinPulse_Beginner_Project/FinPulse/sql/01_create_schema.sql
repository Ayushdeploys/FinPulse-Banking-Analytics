-- FinPulse PostgreSQL schema
-- Lesson: PK = uniquely identifies a row; FK = links related tables.

DROP SCHEMA IF EXISTS finpulse CASCADE;
CREATE SCHEMA finpulse;
SET search_path TO finpulse;

CREATE TABLE branches (
    branch_id VARCHAR(10) PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL
);

CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150),
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    customer_since DATE NOT NULL
);

CREATE TABLE accounts (
    account_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL REFERENCES customers(customer_id),
    branch_id VARCHAR(10) NOT NULL REFERENCES branches(branch_id),
    account_type VARCHAR(30) NOT NULL,
    opened_date DATE NOT NULL,
    current_balance NUMERIC(14,2) NOT NULL,
    status VARCHAR(20) NOT NULL
);

CREATE TABLE transactions (
    transaction_id VARCHAR(12) PRIMARY KEY,
    account_id VARCHAR(10) NOT NULL REFERENCES accounts(account_id),
    transaction_datetime TIMESTAMP NOT NULL,
    transaction_type VARCHAR(30) NOT NULL,
    channel VARCHAR(30) NOT NULL,
    amount NUMERIC(14,2) NOT NULL,
    status VARCHAR(20) NOT NULL
);

CREATE TABLE loans (
    loan_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL REFERENCES customers(customer_id),
    loan_type VARCHAR(30) NOT NULL,
    principal_amount NUMERIC(16,2) NOT NULL,
    interest_rate NUMERIC(5,2) NOT NULL,
    start_date DATE NOT NULL,
    term_months INTEGER NOT NULL,
    status VARCHAR(20) NOT NULL
);

CREATE INDEX idx_accounts_customer ON accounts(customer_id);
CREATE INDEX idx_transactions_account ON transactions(account_id);
CREATE INDEX idx_transactions_datetime ON transactions(transaction_datetime);
CREATE INDEX idx_loans_customer ON loans(customer_id);
