USE banking_analytics;

CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    age INT,
    city VARCHAR(50),
    customer_segment VARCHAR(30),
    account_open_date DATE
);

CREATE TABLE IF NOT EXISTS transactions (
    transaction_id VARCHAR(20) PRIMARY KEY,
    customer_id INT NOT NULL,
    transaction_date DATETIME NOT NULL,
    transaction_type VARCHAR(30),
    channel VARCHAR(30),
    amount DECIMAL(12,2) NOT NULL,
    status VARCHAR(20),
    merchant_category VARCHAR(40),
    risk_flag TINYINT DEFAULT 0,
    CONSTRAINT fk_transactions_customer
      FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE INDEX idx_transaction_date ON transactions(transaction_date);
CREATE INDEX idx_transaction_customer ON transactions(customer_id);
CREATE INDEX idx_transaction_status ON transactions(status);
