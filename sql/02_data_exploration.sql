-- Accounts

-- Quick look at the data
SELECT *
FROM accounts
LIMIT 10;

-- Total accounts
SELECT COUNT(*) AS total_accounts
FROM accounts;

-- Account types available
SELECT DISTINCT account_type
FROM accounts;

-- Countries in the dataset
SELECT DISTINCT country
FROM accounts;

-- Fraud label split
SELECT
    is_fraud,
    COUNT(*) AS account_count
FROM accounts
GROUP BY is_fraud
ORDER BY is_fraud;

-- Behaviour profile counts
SELECT
    tx_behavior_id,
    COUNT(*) AS account_count
FROM accounts
GROUP BY tx_behavior_id
ORDER BY tx_behavior_id;



-- Transactions

-- Quick look at the transaction data
SELECT *
FROM transactions
LIMIT 10;

-- Total transactions
SELECT COUNT(*) AS total_transactions
FROM transactions;

-- Fraud vs non-fraud transactions
SELECT
    is_fraud,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY is_fraud
ORDER BY is_fraud;

-- Check transaction types
-- Only one TX_TYPE exists, so this field is not useful for comparison
SELECT
    tx_type,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY tx_type
ORDER BY transaction_count DESC;



-- AML alerts

-- Quick look at alert records
SELECT *
FROM alerts
LIMIT 10;

-- Total alert records
SELECT COUNT(*) AS total_alert_records
FROM alerts;

-- Count unique AML alerts
SELECT COUNT(DISTINCT alert_id) AS unique_alerts
FROM alerts;

-- Alert type volumes
SELECT
    alert_type,
    COUNT(*) AS alert_record_count
FROM alerts
GROUP BY alert_type
ORDER BY alert_record_count DESC;

-- Check fraud labels in the alerts data
SELECT
    is_fraud,
    COUNT(*) AS alert_record_count
FROM alerts
GROUP BY is_fraud
ORDER BY is_fraud;

-- Overall fraud-labelled rate in alert records
SELECT
    COUNT(*) AS total_alert_records,
    SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) AS fraud_alert_records,
    ROUND(
        100.0 * SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS fraud_rate_percent
FROM alerts;

-- Alert volume by type
SELECT
    alert_type,
    COUNT(*) AS transaction_records
FROM alerts
GROUP BY alert_type
ORDER BY transaction_records DESC;

-- Unique alerts by type
SELECT
    alert_type,
    COUNT(DISTINCT alert_id) AS unique_alerts
FROM alerts
GROUP BY alert_type
ORDER BY unique_alerts DESC;

-- Average transactions within each alert
SELECT
    alert_type,
    COUNT(*) AS transaction_records,
    COUNT(DISTINCT alert_id) AS unique_alerts,
    ROUND(
        COUNT(*)::NUMERIC / COUNT(DISTINCT alert_id),
        2
    ) AS avg_transactions_per_alert
FROM alerts
GROUP BY alert_type
ORDER BY avg_transactions_per_alert DESC;

-- Compare transaction values across alert types
SELECT
    alert_type,
    COUNT(*) AS transaction_records,
    ROUND(AVG(tx_amount), 2) AS avg_transaction_amount,
    ROUND(SUM(tx_amount), 2) AS total_transaction_amount,
    ROUND(MIN(tx_amount), 2) AS min_transaction_amount,
    ROUND(MAX(tx_amount), 2) AS max_transaction_amount
FROM alerts
GROUP BY alert_type
ORDER BY total_transaction_amount DESC;



-- Relationship checks

-- Make sure alert transaction IDs exist in transactions
SELECT
    COUNT(*) AS matched_alert_transactions
FROM alerts a
JOIN transactions t
    ON a.tx_id = t.tx_id;

-- Check for alert transaction IDs that are missing
SELECT
    COUNT(*) AS unmatched_alert_transactions
FROM alerts a
LEFT JOIN transactions t
    ON a.tx_id = t.tx_id
WHERE t.tx_id IS NULL;

-- Check for sender accounts missing from the accounts table
SELECT
    COUNT(*) AS missing_sender_accounts
FROM transactions t
LEFT JOIN accounts a
    ON t.sender_account_id = a.account_id
WHERE a.account_id IS NULL;

-- Check for receiver accounts missing from the accounts table
SELECT
    COUNT(*) AS missing_receiver_accounts
FROM transactions t
LEFT JOIN accounts a
    ON t.receiver_account_id = a.account_id
WHERE a.account_id IS NULL;



-- Overall transaction fraud rate

SELECT
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) AS fraud_transactions,
    ROUND(
        100.0 * SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS fraud_rate_percent
FROM transactions;