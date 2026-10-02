"""Banking Transaction Monitoring System - reproducible analysis.
Run from project root: python python/analysis.py
Dataset is synthetic; risk_flag is a simple rule-based demonstration, not a fraud model.
"""
from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "raw"
OUT = ROOT / "data" / "processed"
CHARTS = ROOT / "reports" / "charts"
OUT.mkdir(parents=True, exist_ok=True)
CHARTS.mkdir(parents=True, exist_ok=True)

customers = pd.read_csv(DATA / "customers.csv")
tx = pd.read_csv(DATA / "transactions.csv", parse_dates=["transaction_date"])

# Basic data quality checks
tx = tx.drop_duplicates(subset=["transaction_id"])
tx["amount"] = pd.to_numeric(tx["amount"], errors="coerce")
tx = tx.dropna(subset=["transaction_id", "customer_id", "amount", "transaction_date"])
tx["month"] = tx["transaction_date"].dt.to_period("M").astype(str)

success = tx[tx["status"].eq("Success")].copy()
monthly = success.groupby("month", as_index=False).agg(
    transaction_count=("transaction_id", "count"),
    transaction_value=("amount", "sum"),
    average_transaction_value=("amount", "mean")
)
monthly.to_csv(OUT / "monthly_transaction_summary.csv", index=False)

channel = success.groupby("channel", as_index=False).agg(
    transaction_count=("transaction_id", "count"),
    transaction_value=("amount", "sum"),
    average_transaction_value=("amount", "mean")
).sort_values("transaction_value", ascending=False)
channel.to_csv(OUT / "channel_summary.csv", index=False)

risk = tx.groupby("risk_flag", as_index=False).agg(
    transaction_count=("transaction_id", "count"), total_amount=("amount", "sum")
)
risk.to_csv(OUT / "risk_flag_summary.csv", index=False)

customer = success.groupby("customer_id", as_index=False).agg(
    transaction_count=("transaction_id", "count"),
    total_transaction_value=("amount", "sum"),
    average_transaction_value=("amount", "mean")
)
customer.to_csv(OUT / "customer_summary.csv", index=False)

plt.figure(figsize=(10, 5))
plt.plot(monthly["month"], monthly["transaction_value"], marker="o")
plt.title("Monthly Successful Transaction Value")
plt.xlabel("Month"); plt.ylabel("Transaction value")
plt.xticks(rotation=45); plt.tight_layout()
plt.savefig(CHARTS / "monthly_transaction_trend.png", dpi=160); plt.close()

plt.figure(figsize=(8, 5))
plt.bar(channel["channel"], channel["transaction_value"])
plt.title("Successful Transaction Value by Channel")
plt.xlabel("Channel"); plt.ylabel("Transaction value")
plt.xticks(rotation=20); plt.tight_layout()
plt.savefig(CHARTS / "channel_transaction_value.png", dpi=160); plt.close()

print(f"Customers: {len(customers):,}")
print(f"Transactions after cleaning: {len(tx):,}")
print(f"Successful transactions: {len(success):,}")
print(f"Rule-flagged transactions: {int(tx['risk_flag'].sum()):,}")
print("Processed CSVs and charts saved.")
