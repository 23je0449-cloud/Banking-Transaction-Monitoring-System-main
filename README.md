# 🏦 Banking Transaction Monitoring System

<p align="center">
  <strong>SQL · Python · Power BI</strong><br/>
  Transaction trends • Channel performance • Status monitoring • Rule-based risk review
</p>

## 📊 Power BI Dashboard
The interactive dashboard is built in Power BI Desktop. GitHub README pages cannot render a `.pbix` file directly; this section will show the **actual dashboard screenshot** once an image exported from Power BI is added to `assets/`.

**Dashboard file:** `Banking_Transaction_Monitoring_Dashboard.pbix`  
**Dashboard pages planned:** Executive Overview, Risk Review, and Customer & Merchant Insights.

> To display the real dashboard here, export a screenshot from Power BI Desktop (or use a screenshot of the report canvas) and save it as `assets/dashboard-screenshot.png`. Do not use the conceptual preview as if it were the real report.

## ✨ Project Overview
A portfolio project using SQL, Python, and Power BI to analyze **synthetic** banking transaction activity, monitor transaction channels and statuses, and review rule-flagged transactions.

## 📌 Project Highlights
- Dataset: 500 synthetic customer records and 10,000 synthetic transaction records.
- MySQL database setup, table schema, indexes, and analytical SQL queries.
- Python data-quality checks, KPI summaries, and charts.
- Jupyter notebook for exploratory analysis.
- Power BI dashboard build guide and DAX measures.
- Processed monthly, channel, and risk-flag summary CSVs.

## 🗂️ Repository Structure
```text
assets/
  dashboard-preview.svg       # Conceptual illustration only; not the actual report
data/
  processed/
    channel_summary.csv
    monthly_transaction_summary.csv
    risk_flag_summary.csv
notebooks/
  banking_transaction_analysis.ipynb
powerbi/
  dashboard_build_guide.md
  dax_measures.txt
python/
  analysis.py
sql/
  01_create_database.sql
  02_create_tables.sql
  03_analysis_queries.sql
```

## ⚙️ Run the Python Analysis
Install dependencies:
```bash
pip install pandas matplotlib
```
Then run from the project root after placing `customers.csv` and `transactions.csv` under `data/raw/`:
```bash
python python/analysis.py
```

## 🛢️ SQL Setup
1. Run `sql/01_create_database.sql` in MySQL Workbench.
2. Run `sql/02_create_tables.sql`.
3. Import the raw customer and transaction CSV files into their corresponding tables.
4. Run `sql/03_analysis_queries.sql`.

## ⚠️ Data & Limitations
The intended dataset is synthetic. The `risk_flag` field uses simple illustrative rules; it is **not a trained or validated fraud-detection model**. Do not describe this as real bank experience or production fraud detection.

## 💼 Resume Bullet
> Built a banking transaction analytics portfolio project using SQL, Python (Pandas), and Power BI to analyze synthetic transactions, track channel and monthly KPIs, and review rule-based risk flags.

## Author
**Yash Kamble**
