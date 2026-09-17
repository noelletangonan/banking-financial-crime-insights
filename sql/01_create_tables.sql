CREATE TABLE accounts (
    account_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    init_balance NUMERIC(18,2),
    country VARCHAR(100),
    account_type VARCHAR(50),
    is_fraud BOOLEAN,
    tx_behavior_id INTEGER
);
CREATE TABLE transactions (
    tx_id VARCHAR(50) PRIMARY KEY,
    sender_account_id VARCHAR(50),
    receiver_account_id VARCHAR(50),
    tx_type VARCHAR(50),
    tx_amount NUMERIC(18,2),
    timestamp TIMESTAMP,
    is_fraud BOOLEAN,
    alert_id VARCHAR(50)
);
CREATE TABLE alerts (
    alert_id VARCHAR(50),
    alert_type VARCHAR(100),
    is_fraud BOOLEAN,
    tx_id VARCHAR(50),
    sender_account_id VARCHAR(50),
    receiver_account_id VARCHAR(50),
    tx_type VARCHAR(50),
    tx_amount NUMERIC(18,2),
    timestamp TIMESTAMP
);