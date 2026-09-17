# Analysis Notes

## Dataset Overview

### Accounts
- Total accounts: 10,000
- Fraud-labelled accounts: 1,685
- Non-fraud accounts: 8,315
- Fraud-labelled account rate: 16.85%
- Only one account type exists in the dataset.

### Transactions
- Total transactions: approximately 1 million
- Overall fraud-labelled transaction rate: approximately 0.13%
- Only one transaction type exists in the dataset.

### AML Alerts
- Total alert transaction records: approximately 1.72K
- Unique AML alerts: 391
- Main AML alert types:
  - Cycle
  - Fan-in



## Main Findings

### AML Alert Activity

Cycle generated the highest number of alert transaction records.

Fan-in generated slightly more unique AML alerts.

Cycle alerts also had a higher average number of transactions per alert.



### Transaction Value

Fraud-labelled transactions were concentrated almost entirely in the lowest
transaction-value band.

Average fraud-labelled transaction value:
- Approximately $9.76

Average non-fraud transaction value:
- Approximately $116.14K

This suggests that fraud-labelled activity in this synthetic dataset is not
associated with higher transaction values.



### Fraud Activity Over Time

Fraud-labelled transaction activity varied across transaction periods.

Several noticeable spikes were present, rather than fraud-labelled transactions
being evenly distributed over time.



## Hypothesis Review

### 1. Higher-value transactions are more likely to be associated with fraud

Not supported by this dataset.

Fraud-labelled transactions were concentrated in the lowest-value transaction
band and had a substantially lower average value than non-fraud transactions.

### 2. Certain transaction behaviours may be associated with fraud

Partially investigated.

The dataset includes transaction behaviour identifiers but deeper behavioural
modelling was outside the scope of this project.

### 3. Certain AML alert scenarios may show different activity patterns

Supported.

Cycle and Fan-in alerts differed in total volume, unique alert counts, average
transactions per alert and average transaction value.


## Data Quality / Limitations

- All AML alert records were fraud-labelled.
- False-positive analysis could therefore not be performed.
- ACCOUNT_TYPE contained only one value.
- TX_TYPE contained only one value.
- The dataset is synthetic.
