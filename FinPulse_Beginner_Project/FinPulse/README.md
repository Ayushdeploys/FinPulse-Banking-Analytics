# FinPulse — Banking Customer & Financial Analytics Platform

> Beginner-built, portfolio-ready project. The goal is to understand every layer rather than copy a black-box solution.

## Business goal
Analyze banking customers, accounts, transactions and loans to answer:
- Who are the most valuable customers?
- How does transaction activity change over time?
- Which customer segments are most active?
- Which customers show churn risk?
- How is the loan portfolio performing?

## Architecture
Raw CSV -> Data Profiling & Quality Checks -> PostgreSQL relational model -> SQL analytics -> Python modelling -> Power BI dashboard

## Stack
Python, Pandas, NumPy, PostgreSQL, SQL, Power BI, Scikit-learn, XGBoost, SHAP, Git/GitHub

## Folder structure
- `data/raw/` synthetic source CSVs
- `sql/` database schema, quality checks and analytics
- `src/` Python profiling and modelling
- `docs/` documentation and data dictionary
- `models/` ERD/star-schema diagrams
- `powerbi/` dashboard notes

## Build order
1. Install Python, PostgreSQL/pgAdmin, VS Code and Git.
2. Create a PostgreSQL database called `finpulse`.
3. Run `sql/01_create_schema.sql`.
4. Import the five CSVs from `data/raw/`.
5. Run `sql/02_quality_checks.sql`.
6. Run `sql/03_business_analytics.sql`.
7. Run `src/01_profile_data.py`.
8. Build RFM features and customer segments.
9. Train churn-risk model.
10. Connect Power BI to PostgreSQL and build the dashboard.
11. Document the project and publish only synthetic data/code to GitHub.

## Important
The data in this repository is synthetic. Do not upload private customer or financial information.
