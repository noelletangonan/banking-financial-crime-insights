-- AML / transaction monitoring analysis

-- The dataset uses is_fraud as the outcome label.
-- All alert records are fraud-labelled, so false positives
-- cannot be measured from the alerts table.


-- Alert type split
SELECT
    alert_type,
    COUNT(*) AS alert_count,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS percent_of_alerts
FROM alerts
GROUP BY alert_type
ORDER BY alert_count DESC;


-- Overall fraud-labelled transaction rate
SELECT
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END)
        AS fraud_labelled_transactions,
    ROUND(
        100.0 * SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) / COUNT(*),
        3
    ) AS fraud_rate_percent
FROM transactions;


-- Compare transaction amounts for fraud vs non-fraud
SELECT
    is_fraud,
    COUNT(*) AS transaction_count,
    ROUND(AVG(tx_amount), 2) AS avg_transaction_amount,
    ROUND(MIN(tx_amount), 2) AS min_transaction_amount,
    ROUND(MAX(tx_amount), 2) AS max_transaction_amount
FROM transactions
GROUP BY is_fraud;


-- Median transaction amount
-- Useful here because large transaction values can skew the average
SELECT
    is_fraud,
    ROUND(
        PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY tx_amount)::numeric,
        2
    ) AS median_transaction_amount
FROM transactions
GROUP BY is_fraud;


-- Compare transaction values across AML alert types
SELECT
    alert_type,
    COUNT(*) AS alert_count,
    ROUND(AVG(tx_amount), 2) AS avg_transaction_amount,
    ROUND(MIN(tx_amount), 2) AS min_transaction_amount,
    ROUND(MAX(tx_amount), 2) AS max_transaction_amount
FROM alerts
GROUP BY alert_type
ORDER BY alert_count DESC;


-- Sender accounts with the most fraud-labelled transactions
SELECT
    sender_account_id,
    COUNT(*) AS fraud_transaction_count,
    ROUND(SUM(tx_amount), 2) AS total_transaction_amount,
    ROUND(AVG(tx_amount), 2) AS avg_transaction_amount
FROM transactions
WHERE is_fraud = TRUE
GROUP BY sender_account_id
ORDER BY fraud_transaction_count DESC
LIMIT 10;


-- Fraud rate by account behaviour profile
SELECT
    a.tx_behavior_id,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN t.is_fraud THEN 1 ELSE 0 END)
        AS fraud_labelled_transactions,
    ROUND(
        100.0 * SUM(CASE WHEN t.is_fraud THEN 1 ELSE 0 END)
        / COUNT(*),
        3
    ) AS fraud_rate_percent
FROM transactions t
JOIN accounts a
    ON t.sender_account_id = a.account_id
GROUP BY a.tx_behavior_id
ORDER BY fraud_rate_percent DESC;