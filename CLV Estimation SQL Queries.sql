USE BANK;

SHOW TABLES;

SELECT * FROM Transactions;
SELECT * FROM Loans;
SELECT * FROM Accounts;

--- Data Integration
--- Integrating relevant data from all three tables (Transactions, Loans, and Accounts) based on CustomerID to create a comprehensive customer profile for each customer.

SELECT 
    c.CustomerID,
    t.TransactionID,
    t.AccountID,
    t.TransactionDate,
    t.TransactionType,
    t.Amount AS TransactionAmount,
    t.BalanceAfter AS TransactionBalanceAfter,
    l.LoanID,
    l.LoanAMOUNT,
    l.INTERESTrATE,
    l.LOANTERM,
    l.StartDate AS LoanStartDate,
    l.EndDate AS LoanEndDate,
    l.LoanStatus,
    a.Balance AS AccountBalance,
    a.AccountType,
    a.AccountStatus
FROM 
    Customers c
JOIN 
    Transactions t ON c.CustomerID = t.TransactionID
INNER JOIN 
    Loans l ON c.CustomerID = l.CustomerID
INNER JOIN 
    Accounts a ON c.CustomerID = a.CustomerID
    WHERE
    a.AccountStatus = 'Active';

--- Calculate Transaction-Based CLV

SELECT 
    CustomerID,
    SUM(TransactionAmount) AS TransactionRevenue
FROM 
    (SELECT 
        ac.CustomerID,
        t.Amount AS TransactionAmount
     FROM 
        Accounts ac
     LEFT JOIN 
        Transactions t ON ac.AccountID = t.AccountID
     WHERE 
        ac.AccountStatus = 'Active') AS transactions_data
GROUP BY 
    CustomerID;


--- Calculate Loan-Based CLV

SELECT 
    CustomerID,
    SUM(LoanAmount * (INTERESTrATE / 100) * LOANTERM) AS LoanRevenue
FROM 
    Loans
WHERE
    LoanStatus = 'Active'
GROUP BY 
    CustomerID
ORDER BY
	LoanRevenue DESC;
    
--- Calculate Account Revenue

SELECT 
    CustomerID,
    SUM(Balance * 0.02) AS AccountRevenue -- Assuming a 2% fee or interest rate
FROM 
    Accounts
WHERE 
    AccountStatus = 'Active'
GROUP BY 
    CustomerID
ORDER BY
	AccountRevenue DESC;
    

---- Combine All Sources of Revenue

SELECT 
    a.CustomerID,
    COALESCE(t.TransactionRevenue, 0) + COALESCE(l.LoanRevenue, 0) + COALESCE(a.AccountRevenue, 0) AS TotalCLV
FROM 
    (SELECT 
        ac.CustomerID,
        SUM(tr.Amount) AS TransactionRevenue
     FROM 
        Transactions tr
     JOIN 
        Accounts ac ON tr.AccountID = ac.AccountID
     GROUP BY 
        ac.CustomerID) AS t
LEFT JOIN 
    (SELECT 
        CustomerID,
        SUM(LoanAmount * (INTERESTrATE / 100) * LOANTERM) AS LoanRevenue
     FROM 
        Loans
     WHERE
        LoanStatus = 'Active'
     GROUP BY 
        CustomerID) AS l ON t.CustomerID = l.CustomerID
LEFT JOIN 
    (SELECT 
        CustomerID,
        SUM(Balance * 0.02) AS AccountRevenue
     FROM 
        Accounts
     WHERE 
        AccountStatus = 'Active'
     GROUP BY 
        CustomerID) AS a ON t.CustomerID = a.CustomerID
ORDER BY 
    TotalCLV DESC;
    
    
--- Segmentation and Insights

WITH CLV_Calculation AS (
    SELECT 
        a.CustomerID,
        COALESCE(t.TransactionRevenue, 0) + COALESCE(l.LoanRevenue, 0) + COALESCE(a.AccountRevenue, 0) AS TotalCLV
    FROM 
        (SELECT 
            ac.CustomerID,
            SUM(tr.Amount) AS TransactionRevenue
         FROM 
            Transactions tr
         JOIN 
            Accounts ac ON tr.AccountID = ac.AccountID
         GROUP BY 
            ac.CustomerID) AS t
    LEFT JOIN 
        (SELECT 
            CustomerID,
            SUM(LoanAmount * (INTERESTrATE / 100) * LOANTERM) AS LoanRevenue
         FROM 
            Loans
         WHERE
            LoanStatus = 'Active'
         GROUP BY 
            CustomerID) AS l ON t.CustomerID = l.CustomerID
    LEFT JOIN 
        (SELECT 
            CustomerID,
            SUM(Balance * 0.02) AS AccountRevenue
         FROM 
            Accounts
         WHERE 
            AccountStatus = 'Active'
         GROUP BY 
            CustomerID) AS a ON t.CustomerID = a.CustomerID
),

RankedCLV AS (
    SELECT 
        CustomerID,
        TotalCLV,
        PERCENT_RANK() OVER (ORDER BY TotalCLV DESC) AS CLV_Rank
    FROM 
        CLV_Calculation
)

SELECT 
    CustomerID,
    TotalCLV,
    CASE 
        WHEN CLV_Rank <= 0.1 THEN 'High-Value'
        WHEN CLV_Rank > 0.1 AND CLV_Rank <= 0.6 THEN 'Medium-Value'
        ELSE 'Low-Value'
    END AS CLV_Segment
FROM 
    RankedCLV
ORDER BY 
    TotalCLV DESC;
    
    
---- Combined Table with all Revenues and Segmented groups

WITH TransactionRevenue AS (
    SELECT 
        ac.CustomerID,
        SUM(tr.Amount) AS TransactionRevenue
    FROM 
        Transactions tr
    JOIN 
        Accounts ac ON tr.AccountID = ac.AccountID
    GROUP BY 
        ac.CustomerID
),

LoanRevenue AS (
    SELECT 
        CustomerID,
        SUM(LoanAmount * (INTERESTrATE / 100) * LOANTERM) AS LoanRevenue
    FROM 
        Loans
    WHERE
        LoanStatus = 'Active'
    GROUP BY 
        CustomerID
),

AccountRevenue AS (
    SELECT 
        CustomerID,
        SUM(Balance * 0.02) AS AccountRevenue
    FROM 
        Accounts
    WHERE 
        AccountStatus = 'Active'
    GROUP BY 
        CustomerID
),

CombinedRevenue AS (
    SELECT 
        tr.CustomerID,
        COALESCE(tr.TransactionRevenue, 0) AS TransactionRevenue,
        COALESCE(lr.LoanRevenue, 0) AS LoanRevenue,
        COALESCE(ar.AccountRevenue, 0) AS AccountRevenue,
        COALESCE(tr.TransactionRevenue, 0) + COALESCE(lr.LoanRevenue, 0) + COALESCE(ar.AccountRevenue, 0) AS TotalCLV
    FROM 
        TransactionRevenue tr
    LEFT JOIN 
        LoanRevenue lr ON tr.CustomerID = lr.CustomerID
    LEFT JOIN 
        AccountRevenue ar ON tr.CustomerID = ar.CustomerID

    UNION

    SELECT 
        lr.CustomerID,
        COALESCE(tr.TransactionRevenue, 0) AS TransactionRevenue,
        COALESCE(lr.LoanRevenue, 0) AS LoanRevenue,
        COALESCE(ar.AccountRevenue, 0) AS AccountRevenue,
        COALESCE(tr.TransactionRevenue, 0) + COALESCE(lr.LoanRevenue, 0) + COALESCE(ar.AccountRevenue, 0) AS TotalCLV
    FROM 
        LoanRevenue lr
    LEFT JOIN 
        TransactionRevenue tr ON lr.CustomerID = tr.CustomerID
    LEFT JOIN 
        AccountRevenue ar ON lr.CustomerID = ar.CustomerID

    UNION

    SELECT 
        ar.CustomerID,
        COALESCE(tr.TransactionRevenue, 0) AS TransactionRevenue,
        COALESCE(lr.LoanRevenue, 0) AS LoanRevenue,
        COALESCE(ar.AccountRevenue, 0) AS AccountRevenue,
        COALESCE(tr.TransactionRevenue, 0) + COALESCE(lr.LoanRevenue, 0) + COALESCE(ar.AccountRevenue, 0) AS TotalCLV
    FROM 
        AccountRevenue ar
    LEFT JOIN 
        TransactionRevenue tr ON ar.CustomerID = tr.CustomerID
    LEFT JOIN 
        LoanRevenue lr ON ar.CustomerID = lr.CustomerID
),

RankedCLV AS (
    SELECT 
        CustomerID,
        TransactionRevenue,
        LoanRevenue,
        AccountRevenue,
        TotalCLV,
        PERCENT_RANK() OVER (ORDER BY TotalCLV DESC) AS CLV_Rank
    FROM 
        CombinedRevenue
)

SELECT 
    CustomerID,
    TransactionRevenue,
    LoanRevenue,
    AccountRevenue,
    TotalCLV,
    CASE 
        WHEN CLV_Rank <= 0.1 THEN 'High-Value'
        WHEN CLV_Rank > 0.1 AND CLV_Rank <= 0.6 THEN 'Medium-Value'
        ELSE 'Low-Value'
    END AS CLV_Segment
FROM 
    RankedCLV
ORDER BY 
    TotalCLV DESC;












