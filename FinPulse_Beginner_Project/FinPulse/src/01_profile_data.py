"""FinPulse lesson 1: profile the raw CSVs before modelling."""
from pathlib import Path
import pandas as pd

RAW = Path(__file__).resolve().parents[1] / "data" / "raw"

for path in sorted(RAW.glob("*.csv")):
    df = pd.read_csv(path)
    print("\n" + "=" * 70)
    print(path.name)
    print("=" * 70)
    print("Rows:", len(df))
    print("Columns:", len(df.columns))
    print("\nData types:")
    print(df.dtypes)
    print("\nMissing values:")
    print(df.isna().sum())
    print("\nDuplicate rows:", df.duplicated().sum())
    print("\nNumeric summary:")
    print(df.describe(include="number").round(2).to_string())
