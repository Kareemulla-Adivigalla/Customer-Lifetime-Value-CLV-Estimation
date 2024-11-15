# Customer Lifetime Value (CLV) Estimation

## Objective
The goal of this project is to calculate the Customer Lifetime Value (CLV) to estimate the long-term revenue generated by each customer. CLV is a critical metric for understanding customer behavior and forecasting future revenue, helping businesses optimize marketing and retention strategies.

## Key Data
The CLV estimation is based on three primary data sources:

- **Transactions Table**: Contains information about the total transaction amounts for each customer.
- **Loans Table**: Contains data on loan amounts and interest payments associated with each customer.
- **Accounts Table**: Contains information on customer account balances.

These data points will be combined and analyzed to estimate the total revenue a customer will generate over their relationship with the bank.

## Purpose
By calculating CLV, the project aims to:
1. Estimate the total revenue generated by each customer over their relationship with the bank.
2. Identify high-value customers who contribute the most revenue over time.
3. Provide insights for prioritizing marketing efforts, customer retention strategies, and resource allocation for high-value customers.
4. Help the bank make data-driven decisions on customer segmentation and lifecycle management.

## Methodology
The project uses the following steps for CLV estimation:

1. **Data Cleaning**: Data from the `Transactions`, `Loans`, and `Accounts` tables are cleaned and preprocessed to handle missing values, duplicates, and inconsistencies.
2. **Data Integration**: The data is integrated into a single customer profile based on customer IDs, combining information on transactions, loan activity, and account balances.
3. **CLV Calculation**: The CLV is calculated based on historical transaction data, loan repayment patterns, and account balances, taking into account the interest earned and other factors.
4. **Segmentation**: Customers are segmented based on their CLV to identify high-value, medium-value, and low-value customers.

## Tools and Technologies
The following tools and technologies were used to implement the CLV estimation:

- **SQL**: Used to query and join the `Transactions`, `Loans`, and `Accounts` tables.
- **Python (Pandas, NumPy)**: Used for data preprocessing, analysis, and CLV calculation.
- **Power BI/Excel**: Data visualization and reporting.

