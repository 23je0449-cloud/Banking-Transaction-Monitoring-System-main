# Power BI Dashboard Build Guide

## Data model
1. Import `data/raw/customers.csv` and `data/raw/transactions.csv`.
2. Confirm `customer_id` is a whole number in both tables.
3. Create a one-to-many relationship from `customers[customer_id]` to `transactions[customer_id]`.
4. Use the measures in `dax_measures.txt`.

## Page 1 — Executive Overview
- KPI cards: Total Transactions, Successful Transactions, Successful Transaction Value, Failed Transaction Rate.
- Line chart: transaction date by month on the axis; Successful Transaction Value as the value.
- Bar chart: channel on the axis; Successful Transaction Value as the value.
- Donut chart: status by transaction count.
- Slicers: transaction date, channel, city.

## Page 2 — Risk Review
- Table: transaction ID, customer ID, transaction date, channel, transaction type, amount, risk flag.
- Filter the table to risk_flag = 1.
- Bar chart: flagged transaction count by channel.
- Add date and channel slicers.

## Page 3 — Customer & Merchant Insights
- Bar chart: city by successful transaction value.
- Bar chart: merchant category by successful transaction value.
- Table: customer ID, transaction count, total transaction value.
- Add customer segment and date slicers where useful.

## Note
The risk flag is a simple illustrative rule, not a trained or validated fraud model. The dashboard is for portfolio/learning use and uses synthetic data.
