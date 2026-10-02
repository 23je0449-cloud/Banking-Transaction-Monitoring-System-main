USE banking_analytics;

-- 1. Overall transaction KPIs
SELECT COUNT(*) AS total_transactions,
       SUM(amount) AS total_transaction_value,
       AVG(amount) AS average_transaction_value
FROM transactions;

-- 2. Successful transaction KPIs
SELECT COUNT(*) AS successful_transactions,
       SUM(amount) AS successful_transaction_value
FROM transactions
WHERE status = 'Success';

-- 3. Monthly transaction trend
SELECT DATE_FORMAT(transaction_date, '%Y-%m') AS month,
       COUNT(*) AS transaction_count,
       SUM(amount) AS transaction_value
FROM transactions
WHERE status = 'Success'
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY month;

-- 4. Channel performance
SELECT channel, COUNT(*) AS transaction_count,
       SUM(amount) AS transaction_value,
       AVG(amount) AS average_amount
FROM transactions
WHERE status = 'Success'
GROUP BY channel
ORDER BY transaction_value DESC;

-- 5. Flagged transactions for review (rule-based sample)
SELECT transaction_id, customer_id, transaction_date, channel,
       transaction_type, amount, risk_flag
FROM transactions
WHERE risk_flag = 1
ORDER BY amount DESC;

-- 6. Transaction status distribution
SELECT status, COUNT(*) AS transaction_count
FROM transactions
GROUP BY status
ORDER BY transaction_count DESC;

-- 7. Top 10 customers by successful transaction value
SELECT c.customer_id, c.customer_name,
       COUNT(t.transaction_id) AS transaction_count,
       SUM(t.amount) AS total_value
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
WHERE t.status = 'Success'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_value DESC
LIMIT 10;

-- 8. Merchant category analysis
SELECT merchant_category, COUNT(*) AS transaction_count,
       SUM(amount) AS transaction_value
FROM transactions
WHERE status = 'Success'
GROUP BY merchant_category
ORDER BY transaction_value DESC;

-- 9. Failed transaction rate
SELECT ROUND(100.0 * SUM(status = 'Failed') / COUNT(*), 2) AS failed_rate_pct
FROM transactions;

-- 10. City-level transaction value
SELECT c.city, SUM(t.amount) AS transaction_value,
       COUNT(*) AS transaction_count
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
WHERE t.status = 'Success'
GROUP BY c.city
ORDER BY transaction_value DESC;
