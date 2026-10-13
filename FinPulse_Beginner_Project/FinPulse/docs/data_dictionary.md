# FinPulse Data Dictionary

| Table | Column | Meaning | Type | Key |
|---|---|---|---|---|
| customers | customer_id | Unique customer identifier | VARCHAR | PK |
| customers | customer_since | Date customer joined | DATE | |
| accounts | account_id | Unique bank account | VARCHAR | PK |
| accounts | customer_id | Customer owning account | VARCHAR | FK |
| accounts | branch_id | Branch servicing account | VARCHAR | FK |
| transactions | transaction_id | Unique transaction | VARCHAR | PK |
| transactions | account_id | Account involved in transaction | VARCHAR | FK |
| transactions | transaction_datetime | Timestamp of transaction | TIMESTAMP | |
| transactions | amount | Transaction monetary value | NUMERIC | |
| loans | loan_id | Unique loan | VARCHAR | PK |
| loans | customer_id | Borrowing customer | VARCHAR | FK |
| loans | principal_amount | Original loan principal | NUMERIC | |
| loans | interest_rate | Annual interest rate | NUMERIC | |

## Grain
- `transactions`: one row = one transaction.
- `accounts`: one row = one bank account.
- `loans`: one row = one loan.
- `customers`: one row = one customer.
- `branches`: one row = one branch.
