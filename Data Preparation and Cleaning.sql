USE BANK;

SHOW TABLES;

SELECT * FROM Transactions;
SELECT * FROM Loans;
SELECT * FROM Accounts;

--- Data Preparation and Cleaning

-- Remove duplicate records from the Transactions table
DELETE t1 FROM Transactions t1
JOIN Transactions t2 
ON t1.TransactionID = t2.TransactionID
AND t1.AccountID = t2.AccountID
AND t1.TransactionDate = t2.TransactionDate
AND t1.Amount = t2.Amount
AND t1.BalanceAfter = t2.BalanceAfter
AND t1.Description = t2.Description
AND t1.TransactionID > t2.TransactionID;

-- Remove duplicate records from the Loans table
DELETE l1 FROM Loans l1
JOIN Loans l2 
ON l1.LoanID = l2.LoanID
AND l1.CustomerID = l2.CustomerID
AND l1.LoanAMOUNT = l2.LoanAMOUNT
AND l1.INTERESTrATE = l2.INTERESTrATE
AND l1.LOANTERM = l2.LOANTERM
AND l1.StartDate = l2.StartDate
AND l1.EndDate = l2.EndDate
AND l1.LoanStatus = l2.LoanStatus
AND l1.LoanID > l2.LoanID;

-- Remove duplicate records from the Accounts table
DELETE a1 FROM Accounts a1
JOIN Accounts a2 
ON a1.AccountID = a2.AccountID
AND a1.CustomerID = a2.CustomerID
AND a1.AccountType = a2.AccountType
AND a1.Balance = a2.Balance
AND a1.AccountStatus = a2.AccountStatus
AND a1.AccountID > a2.AccountID;


---- Handle Missing Data

-- Set missing Account Balances to 0
UPDATE Accounts 
SET Balance = 0 
WHERE Balance IS NULL;

-- Set missing Transaction Amounts to 0
UPDATE Transactions 
SET Amount = 0 
WHERE Amount IS NULL;



