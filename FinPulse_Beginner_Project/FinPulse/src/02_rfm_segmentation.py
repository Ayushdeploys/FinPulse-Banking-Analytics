"""FinPulse lesson 2: create customer RFM features from transactions."""
from pathlib import Path
import pandas as pd
import numpy as np

ROOT = Path(__file__).resolve().parents[1]
customers = pd.read_csv(ROOT / "data/raw/customers.csv", parse_dates=["customer_since"])
accounts = pd.read_csv(ROOT / "data/raw/accounts.csv")
tx = pd.read_csv(ROOT / "data/raw/transactions.csv", parse_dates=["transaction_datetime"])

tx = tx[tx["status"].eq("SUCCESS")].copy()
tx["date"] = tx["transaction_datetime"].dt.date
snapshot = tx["transaction_datetime"].max() + pd.Timedelta(days=1)

customer_tx = tx.merge(accounts[["account_id", "customer_id"]], on="account_id", how="left")

rfm = customer_tx.groupby("customer_id").agg(
    recency_days=("transaction_datetime", lambda x: (snapshot - x.max()).days),
    frequency=("transaction_id", "count"),
    monetary=("amount", "sum")
).reset_index()

# Simple quantile scoring: 1 = weaker, 4 = stronger.
rfm["R"] = pd.qcut(rfm["recency_days"].rank(method="first"), 4, labels=[4,3,2,1]).astype(int)
rfm["F"] = pd.qcut(rfm["frequency"].rank(method="first"), 4, labels=[1,2,3,4]).astype(int)
rfm["M"] = pd.qcut(rfm["monetary"].rank(method="first"), 4, labels=[1,2,3,4]).astype(int)
rfm["rfm_score"] = rfm[["R","F","M"]].sum(axis=1)

rfm["segment"] = np.select(
    [
        rfm["rfm_score"] >= 10,
        rfm["rfm_score"] >= 7,
        rfm["rfm_score"] >= 5
    ],
    ["Champions", "Loyal/Active", "Needs Attention"],
    default="At Risk"
)

out = rfm.merge(customers[["customer_id","first_name","last_name"]], on="customer_id", how="left")
out.to_csv(ROOT / "data/processed/customer_rfm.csv", index=False)
print(out.head(10).to_string(index=False))
print("\nSegments:")
print(out["segment"].value_counts())
