# Data Lineage

```text
data/raw/customers.csv ------data/raw/accounts.csv --------> PostgreSQL finpulse schema
data/raw/transactions.csv ----/             |
data/raw/loans.csv ------------------------>|
data/raw/branches.csv --------------------->|
                                             v
                                  SQL quality checks
                                             |
                    +------------------------+-------------------+
                    |                                            |
                    v                                            v
             SQL business KPIs                         Python RFM/modeling
                    |                                            |
                    +------------------------+-------------------+
                                             v
                                      Power BI dashboard
```

## Why lineage matters
It tells another analyst where a dashboard number came from and what transformations happened before it was reported.
