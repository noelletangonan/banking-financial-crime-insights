# Banking AML & Financial Crime Insights Analysis

## Project Overview

This project analyses a synthetic banking dataset containing approximately
1 million transactions, customer account information and AML alert records.

The objective was to explore fraud-labelled transaction behaviour, understand
how AML alerts were distributed across monitoring scenarios and identify
patterns that could support transaction monitoring analysis.

The project was built using PostgreSQL, SQL and Power BI.


## Business Questions

The analysis focused on the following questions:

1. What transaction patterns are associated with fraud-labelled activity?
2. How does fraud-labelled activity vary across transaction value ranges?
3. How does fraud-labelled activity vary over time?
4. What types of AML alerts are generated most frequently?
5. How do AML alert scenarios differ in transaction volume and transaction value?



## Dataset

The project uses a synthetic banking transaction dataset containing:

- Accounts
- Transactions
- AML Alerts

Key fields include:

- Account identifiers
- Sender and receiver accounts
- Transaction amounts
- Transaction timestamps
- Fraud labels
- AML alert identifiers
- AML alert types
- Transaction behaviour identifiers

The dataset is synthetic and is used only for analytical and portfolio purposes.



## Tools Used

- PostgreSQL
- SQL
- pgAdmin
- Power BI
- Power Query
- DAX
- VS Code



## SQL Analysis

SQL was used to:

- Validate table row counts
- Explore account and transaction distributions
- Check relationships between accounts, transactions and alerts
- Analyse fraud-labelled transaction rates
- Compare transaction values
- Analyse AML alert volumes
- Compare AML alert types
- Investigate fraud-labelled activity over time



## Power BI Report

The Power BI report contains three pages:

### 1. Executive Overview

Provides a view of:

- Total transactions
- Total AML alert records
- Unique AML alerts
- Fraud-labelled transaction rate
- Fraud activity over time
- AML alert volume by type
- Average alerted transaction value

### 2. AML Alert Analysis

Explores:

- Unique AML alerts by type
- Average transactions per alert
- Alert activity over time

### 3. Transaction Insights

Explores:

- Fraud rate by transaction amount band
- Average fraud-labelled transaction value
- Average non-fraud transaction value
- Fraud-labelled transaction activity over time



## Key Findings

- The dataset contained approximately 1 million transactions.

- The overall fraud-labelled transaction rate was approximately 0.13%.

- The AML alerts dataset contained approximately 1.72K alert transaction records
  across 391 unique alerts.

- Cycle alerts generated more alert transaction records, while Fan-in alerts
  generated slightly more unique alerts.

- Fraud-labelled transactions were concentrated in the lowest transaction-value
  band.

- The average fraud-labelled transaction value was substantially lower than
  the average non-fraud transaction value.

- Fraud-labelled activity varied across transaction periods, with several
  noticeable spikes.



## Data Limitations

- All records supplied in the AML alerts dataset were associated with
  fraud-labelled transactions.

- Because there were no non-fraud alert records, false-positive rates and
  meaningful alert-effectiveness comparisons could not be calculated.

- The dataset contained only one transaction type and one account type, which
  limited analysis across those dimensions.

- The dataset is synthetic, so findings should not be interpreted as
  representative of real-world banking customers or real financial-crime
  behaviour.



## Recommendations


- Review the transaction patterns behind Cycle and Fan-in alerts.

- Focus on transaction amounts and time periods where fraud-labelled activity is higher.

- In a real bank, include investigator outcomes and non-fraud alerts so the team can measure false positives and see which AML alerts are actually effective.


## Dashboard

Screenshots of the Power BI report are available in the `screenshots` folder.

The full Power BI report is available in the `powerbi` folder.