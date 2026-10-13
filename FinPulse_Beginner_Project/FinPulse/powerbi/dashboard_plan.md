# Power BI Dashboard Plan

Connect Power BI Desktop to PostgreSQL database `finpulse`.

## Page 1 — Executive Overview
Cards:
- Total customers
- Successful transaction value
- Transaction count
- Active loans
- Loan principal

Charts:
- Monthly transaction value
- Transaction value by channel
- Loan principal by loan type

## Page 2 — Customer Analytics
- Customer segment distribution
- Top customers by transaction value
- Recency vs monetary scatter
- Customer transaction trend

## Page 3 — Risk & Churn
- At-risk customer count
- RFM segment table
- Churn-risk model output (after model is built)
- Model precision / recall / F1 / ROC-AUC

## Important modelling rule
Before building visuals, understand the grain of each table and avoid accidentally double-counting values through many-to-many relationships.
