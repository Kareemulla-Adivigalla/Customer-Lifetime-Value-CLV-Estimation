CREATE DATABASE BANK;
USE BANK;

SHOW TABLES;

SELECT * FROM Customers;
SELECT * FROM Accounts;
SELECT * FROM Transactions;
SELECT * FROM CustomerFeedback;
SELECT * FROM Loans;
SELECT * FROM Credit_Card_Usage;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Age INT,
    Gender NVARCHAR(10),
    MaritalStatus NVARCHAR(20),
    Occupation NVARCHAR(50),
    Income DECIMAL(10, 2),
    City NVARCHAR(50),
    State NVARCHAR(50),
    Country NVARCHAR(50)
);

CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    AccountType NVARCHAR(20),  -- e.g., Checking, Savings, Credit
    Balance DECIMAL(15, 2),
    AccountStatus NVARCHAR(20),  -- e.g., Active, Dormant, Closed
    CONSTRAINT FK_Customer FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    AccountID INT,
    TransactionDate DATE,
    TransactionType NVARCHAR(20), -- e.g., Deposit, Withdrawal, Transfer, Payment
    Amount DECIMAL(10, 2),
    BalanceAfter DECIMAL(10, 2),
    Description NVARCHAR(100),
    CONSTRAINT FK_Account FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE CustomerFeedback (
    FeedbackID INT PRIMARY KEY,
    CustomerID INT,
    FeedbackDate DATE,
    FeedbackCategory NVARCHAR(50), -- e.g., Service Quality, Online Banking, Customer Support, Product Satisfaction
    FeedbackText NVARCHAR(255),
    Rating INT, -- Rating on a scale of 1 to 5
    Sentiment NVARCHAR(10), -- e.g., Positive, Neutral, Negative
    CONSTRAINT FK_CustomerFeedback FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    CustomerID INT,
    LoanType NVARCHAR(30), -- e.g., Personal, Mortgage, Auto, Student
    LoanAmount DECIMAL(12, 2),
    InterestRate DECIMAL(4, 2), -- Interest rate as a percentage
    LoanTerm INT, -- Loan term in months
    StartDate DATE,
    EndDate DATE,
    LoanStatus NVARCHAR(15), -- e.g., Active, Closed, Defaulted
    CONSTRAINT FK_LoanCustomer FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Credit_Card_Usage (
    UsageID INT PRIMARY KEY,
    CustomerID INT,
    TransactionDate DATE,
    Merchant NVARCHAR(50),
    TransactionAmount DECIMAL(10, 2),
    Category NVARCHAR(30), -- e.g., Groceries, Travel, Dining, Shopping, Entertainment
    CardType NVARCHAR(20), -- e.g., Visa, MasterCard, Amex
    CONSTRAINT FK_CreditCardCustomer FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);





INSERT INTO Customers (CustomerID, FirstName, LastName, Age, Gender, MaritalStatus, Occupation, Income, City, State, Country) VALUES
(1, 'Alice', 'Johnson', 28, 'Female', 'Single', 'Teacher', 55000.00, 'New York', 'NY', 'USA'),
(2, 'Bob', 'Smith', 34, 'Male', 'Married', 'Engineer', 85000.00, 'San Francisco', 'CA', 'USA'),
(3, 'Carol', 'Williams', 45, 'Female', 'Married', 'Accountant', 78000.00, 'Chicago', 'IL', 'USA'),
(4, 'David', 'Brown', 23, 'Male', 'Single', 'Software Developer', 62000.00, 'Austin', 'TX', 'USA'),
(5, 'Eve', 'Davis', 52, 'Female', 'Divorced', 'Sales Manager', 91000.00, 'Seattle', 'WA', 'USA'),
(6, 'Frank', 'Miller', 41, 'Male', 'Married', 'Doctor', 120000.00, 'Boston', 'MA', 'USA'),
(7, 'Grace', 'Wilson', 29, 'Female', 'Single', 'Marketing Specialist', 65000.00, 'Denver', 'CO', 'USA'),
(8, 'Henry', 'Moore', 36, 'Male', 'Married', 'Banker', 87000.00, 'Miami', 'FL', 'USA'),
(9, 'Ivy', 'Taylor', 47, 'Female', 'Widowed', 'Nurse', 63000.00, 'Phoenix', 'AZ', 'USA'),
(10, 'Jack', 'Anderson', 31, 'Male', 'Single', 'Consultant', 95000.00, 'Dallas', 'TX', 'USA'),
(11, 'Kim', 'Thomas', 26, 'Female', 'Single', 'Data Analyst', 58000.00, 'New York', 'NY', 'USA'),
(12, 'Leo', 'Jackson', 55, 'Male', 'Married', 'Architect', 105000.00, 'Los Angeles', 'CA', 'USA'),
(13, 'Mona', 'White', 42, 'Female', 'Married', 'Lawyer', 115000.00, 'Chicago', 'IL', 'USA'),
(14, 'Nathan', 'Harris', 33, 'Male', 'Single', 'Engineer', 81000.00, 'Houston', 'TX', 'USA'),
(15, 'Olivia', 'Martin', 39, 'Female', 'Married', 'Professor', 88000.00, 'Philadelphia', 'PA', 'USA'),
(16, 'Paul', 'Garcia', 24, 'Male', 'Single', 'Researcher', 50000.00, 'Seattle', 'WA', 'USA'),
(17, 'Quinn', 'Martinez', 50, 'Male', 'Divorced', 'Business Owner', 130000.00, 'San Diego', 'CA', 'USA'),
(18, 'Rachel', 'Robinson', 38, 'Female', 'Married', 'HR Manager', 72000.00, 'San Jose', 'CA', 'USA'),
(19, 'Sam', 'Clark', 44, 'Male', 'Married', 'Chef', 69000.00, 'Las Vegas', 'NV', 'USA'),
(20, 'Tina', 'Rodriguez', 30, 'Female', 'Single', 'Financial Analyst', 76000.00, 'Boston', 'MA', 'USA'),
(21, 'Uma', 'Lewis', 48, 'Female', 'Widowed', 'Teacher', 57000.00, 'Portland', 'OR', 'USA'),
(22, 'Victor', 'Lee', 27, 'Male', 'Single', 'Software Developer', 64000.00, 'Austin', 'TX', 'USA'),
(23, 'Wendy', 'Walker', 54, 'Female', 'Married', 'Real Estate Agent', 91000.00, 'Orlando', 'FL', 'USA'),
(24, 'Xander', 'Hall', 40, 'Male', 'Married', 'Pilot', 105000.00, 'Miami', 'FL', 'USA'),
(25, 'Yara', 'Allen', 32, 'Female', 'Single', 'Product Manager', 87000.00, 'Atlanta', 'GA', 'USA'),
(26, 'Zack', 'Young', 60, 'Male', 'Married', 'Retired', 70000.00, 'Detroit', 'MI', 'USA'),
(27, 'Amy', 'Hernandez', 37, 'Female', 'Divorced', 'Psychologist', 95000.00, 'Denver', 'CO', 'USA'),
(28, 'Ben', 'King', 29, 'Male', 'Single', 'Graphic Designer', 61000.00, 'Chicago', 'IL', 'USA'),
(29, 'Cathy', 'Wright', 43, 'Female', 'Married', 'Account Manager', 92000.00, 'Houston', 'TX', 'USA'),
(30, 'Don', 'Lopez', 46, 'Male', 'Married', 'Electrician', 55000.00, 'Dallas', 'TX', 'USA'),
(31, 'Elena', 'Hill', 51, 'Female', 'Divorced', 'Pharmacist', 99000.00, 'Miami', 'FL', 'USA'),
(32, 'Fred', 'Scott', 33, 'Male', 'Single', 'Journalist', 68000.00, 'New York', 'NY', 'USA'),
(33, 'Gina', 'Green', 25, 'Female', 'Single', 'Interior Designer', 53000.00, 'Los Angeles', 'CA', 'USA'),
(34, 'Hank', 'Adams', 56, 'Male', 'Married', 'Mechanic', 60000.00, 'San Diego', 'CA', 'USA'),
(35, 'Irene', 'Baker', 41, 'Female', 'Married', 'Consultant', 94000.00, 'San Francisco', 'CA', 'USA'),
(36, 'Jake', 'Gonzalez', 30, 'Male', 'Single', 'Marketing Analyst', 67000.00, 'Chicago', 'IL', 'USA'),
(37, 'Karen', 'Nelson', 49, 'Female', 'Widowed', 'Nurse', 73000.00, 'Phoenix', 'AZ', 'USA'),
(38, 'Leo', 'Carter', 35, 'Male', 'Married', 'Teacher', 62000.00, 'Philadelphia', 'PA', 'USA'),
(39, 'Maya', 'Mitchell', 27, 'Female', 'Single', 'Software Engineer', 87000.00, 'Austin', 'TX', 'USA'),
(40, 'Nick', 'Perez', 57, 'Male', 'Married', 'Veterinarian', 98000.00, 'Portland', 'OR', 'USA'),
(41, 'Opal', 'Roberts', 31, 'Female', 'Single', 'Digital Marketer', 65000.00, 'Seattle', 'WA', 'USA'),
(42, 'Peter', 'Turner', 36, 'Male', 'Married', 'Finance Manager', 89000.00, 'Denver', 'CO', 'USA'),
(43, 'Quincy', 'Phillips', 52, 'Male', 'Married', 'CEO', 150000.00, 'San Francisco', 'CA', 'USA'),
(44, 'Rita', 'Campbell', 28, 'Female', 'Single', 'Content Writer', 56000.00, 'New York', 'NY', 'USA'),
(45, 'Steve', 'Parker', 33, 'Male', 'Single', 'Analyst', 72000.00, 'Los Angeles', 'CA', 'USA'),
(46, 'Tracy', 'Evans', 47, 'Female', 'Married', 'HR Director', 93000.00, 'Boston', 'MA', 'USA'),
(47, 'Umar', 'Edwards', 22, 'Male', 'Single', 'Software Engineer', 62000.00, 'San Diego', 'CA', 'USA'),
(48, 'Vera', 'Collins', 40, 'Female', 'Married', 'Financial Consultant', 87000.00, 'Miami', 'FL', 'USA'),
(49, 'Will', 'Stewart', 55, 'Male', 'Married', 'Retired', 70000.00, 'Orlando', 'FL', 'USA'),
(50, 'Yvonne', 'Sanders', 34, 'Female', 'Single', 'Project Manager', 91000.00, 'Atlanta', 'GA', 'USA');



INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, AccountStatus) VALUES
(101, 1, 'Savings', 12000.00, 'Active'),
(102, 1, 'Checking', 3000.00, 'Active'),
(103, 2, 'Credit', 500.00, 'Active'),
(104, 2, 'Savings', 14000.00, 'Active'),
(105, 3, 'Savings', 18000.00, 'Dormant'),
(106, 4, 'Checking', 2500.00, 'Active'),
(107, 5, 'Savings', 20000.00, 'Active'),
(108, 5, 'Credit', 1500.00, 'Closed'),
(109, 6, 'Checking', 7500.00, 'Active'),
(110, 7, 'Credit', 800.00, 'Active'),
(111, 8, 'Savings', 16000.00, 'Active'),
(112, 9, 'Checking', 3200.00, 'Active'),
(113, 10, 'Savings', 9000.00, 'Dormant'),
(114, 11, 'Savings', 5000.00, 'Active'),
(115, 12, 'Credit', 1000.00, 'Active'),
(116, 12, 'Checking', 8000.00, 'Active'),
(117, 13, 'Savings', 30000.00, 'Active'),
(118, 14, 'Credit', 200.00, 'Active'),
(119, 15, 'Checking', 4500.00, 'Active'),
(120, 16, 'Savings', 22000.00, 'Active'),
(121, 17, 'Credit', 700.00, 'Active'),
(122, 18, 'Savings', 12500.00, 'Dormant'),
(123, 19, 'Checking', 3800.00, 'Active'),
(124, 20, 'Savings', 17000.00, 'Closed'),
(125, 21, 'Savings', 14000.00, 'Active'),
(126, 22, 'Credit', 1200.00, 'Active'),
(127, 23, 'Checking', 5200.00, 'Dormant'),
(128, 24, 'Savings', 19000.00, 'Active'),
(129, 25, 'Credit', 400.00, 'Closed'),
(130, 26, 'Checking', 2400.00, 'Active'),
(131, 27, 'Savings', 13000.00, 'Active'),
(132, 28, 'Credit', 1000.00, 'Active'),
(133, 29, 'Checking', 3100.00, 'Dormant'),
(134, 30, 'Savings', 21000.00, 'Active'),
(135, 31, 'Credit', 1500.00, 'Active'),
(136, 32, 'Checking', 5400.00, 'Active'),
(137, 33, 'Savings', 18500.00, 'Active'),
(138, 34, 'Credit', 2500.00, 'Active'),
(139, 35, 'Checking', 7000.00, 'Closed'),
(140, 36, 'Savings', 25000.00, 'Active'),
(141, 37, 'Credit', 400.00, 'Dormant'),
(142, 38, 'Checking', 2700.00, 'Active'),
(143, 39, 'Savings', 23000.00, 'Active'),
(144, 40, 'Credit', 1800.00, 'Active'),
(145, 41, 'Checking', 6200.00, 'Active'),
(146, 42, 'Savings', 19000.00, 'Active'),
(147, 43, 'Credit', 3000.00, 'Closed'),
(148, 44, 'Checking', 2800.00, 'Dormant'),
(149, 45, 'Savings', 15000.00, 'Active'),
(150, 46, 'Credit', 1200.00, 'Active'),
(151, 47, 'Checking', 3800.00, 'Closed'),
(152, 48, 'Savings', 21000.00, 'Active'),
(153, 49, 'Credit', 1400.00, 'Dormant'),
(154, 50, 'Checking', 3300.00, 'Active');


-- Sample records for Transactions table
INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, TransactionType, Amount, BalanceAfter, Description) VALUES
(1, 101, '2023-01-05', 'Deposit', 2000.00, 14000.00, 'Salary Deposit'),
(2, 101, '2023-01-15', 'Withdrawal', 500.00, 13500.00, 'ATM Withdrawal'),
(3, 102, '2023-01-18', 'Transfer', 200.00, 2800.00, 'Transfer to Credit Card'),
(4, 103, '2023-01-22', 'Payment', 100.00, 400.00, 'Credit Card Payment'),
(5, 104, '2023-02-01', 'Deposit', 3000.00, 17000.00, 'Bonus Payment'),
(6, 105, '2023-02-10', 'Withdrawal', 1500.00, 16500.00, 'ATM Withdrawal'),
(7, 106, '2023-02-15', 'Deposit', 800.00, 3300.00, 'Transfer from Savings'),
(8, 107, '2023-02-20', 'Withdrawal', 200.00, 19800.00, 'POS Purchase'),
(9, 108, '2023-02-22', 'Payment', 500.00, 1000.00, 'Credit Card Payment'),
(10, 109, '2023-03-01', 'Deposit', 5000.00, 12500.00, 'Salary Deposit'),
(11, 110, '2023-03-04', 'Payment', 300.00, 500.00, 'Credit Card Payment'),
(12, 111, '2023-03-10', 'Deposit', 1500.00, 17500.00, 'Online Transfer'),
(13, 112, '2023-03-15', 'Withdrawal', 400.00, 2800.00, 'ATM Withdrawal'),
(14, 113, '2023-03-22', 'Deposit', 1000.00, 10000.00, 'Gift Deposit'),
(15, 114, '2023-04-01', 'Withdrawal', 600.00, 4400.00, 'POS Purchase'),
(16, 115, '2023-04-05', 'Payment', 200.00, 800.00, 'Credit Card Payment'),
(17, 116, '2023-04-10', 'Deposit', 3000.00, 11000.00, 'Bonus Payment'),
(18, 117, '2023-04-15', 'Withdrawal', 700.00, 29300.00, 'ATM Withdrawal'),
(19, 118, '2023-04-20', 'Payment', 50.00, 150.00, 'Credit Card Payment'),
(20, 119, '2023-05-01', 'Deposit', 2500.00, 7000.00, 'Salary Deposit'),
(21, 120, '2023-05-05', 'Withdrawal', 800.00, 21200.00, 'ATM Withdrawal'),
(22, 121, '2023-05-10', 'Deposit', 1000.00, 1700.00, 'Gift Deposit'),
(23, 122, '2023-05-15', 'Withdrawal', 200.00, 12300.00, 'POS Purchase'),
(24, 123, '2023-05-20', 'Deposit', 1500.00, 5300.00, 'Transfer from Savings'),
(25, 124, '2023-06-01', 'Withdrawal', 300.00, 16700.00, 'ATM Withdrawal'),
(26, 125, '2023-06-05', 'Payment', 500.00, 13500.00, 'Credit Card Payment'),
(27, 126, '2023-06-10', 'Deposit', 2000.00, 3200.00, 'Salary Deposit'),
(28, 127, '2023-06-15', 'Withdrawal', 600.00, 1900.00, 'POS Purchase'),
(29, 128, '2023-06-20', 'Deposit', 1000.00, 20000.00, 'Online Transfer'),
(30, 129, '2023-07-01', 'Payment', 100.00, 300.00, 'Credit Card Payment'),
(31, 130, '2023-07-05', 'Deposit', 3000.00, 5400.00, 'Bonus Payment'),
(32, 131, '2023-07-10', 'Withdrawal', 400.00, 12600.00, 'ATM Withdrawal'),
(33, 132, '2023-07-15', 'Deposit', 2500.00, 29000.00, 'Salary Deposit'),
(34, 133, '2023-07-20', 'Payment', 150.00, 450.00, 'Credit Card Payment'),
(35, 134, '2023-08-01', 'Withdrawal', 300.00, 6500.00, 'ATM Withdrawal'),
(36, 135, '2023-08-05', 'Deposit', 500.00, 10500.00, 'Gift Deposit'),
(37, 136, '2023-08-10', 'Deposit', 2000.00, 11000.00, 'Salary Deposit'),
(38, 137, '2023-08-15', 'Withdrawal', 800.00, 2600.00, 'POS Purchase'),
(39, 138, '2023-08-20', 'Payment', 100.00, 1200.00, 'Credit Card Payment'),
(40, 139, '2023-09-01', 'Deposit', 2500.00, 5700.00, 'Salary Deposit'),
(41, 140, '2023-09-05', 'Withdrawal', 300.00, 20700.00, 'ATM Withdrawal'),
(42, 141, '2023-09-10', 'Deposit', 1000.00, 1900.00, 'Gift Deposit'),
(43, 142, '2023-09-15', 'Withdrawal', 500.00, 12700.00, 'POS Purchase'),
(44, 143, '2023-09-20', 'Deposit', 2000.00, 6200.00, 'Transfer from Savings'),
(45, 144, '2023-10-01', 'Payment', 100.00, 15900.00, 'Credit Card Payment'),
(46, 145, '2023-10-05', 'Deposit', 3000.00, 2500.00, 'Bonus Payment'),
(47, 146, '2023-10-10', 'Withdrawal', 500.00, 12300.00, 'ATM Withdrawal'),
(48, 147, '2023-10-15', 'Deposit', 2000.00, 27000.00, 'Online Transfer'),
(49, 148, '2023-10-20', 'Payment', 200.00, 800.00, 'Credit Card Payment'),
(50, 149, '2023-11-01', 'Deposit', 2500.00, 6700.00, 'Salary Deposit');

-- Sample records for CustomerFeedback table
INSERT INTO CustomerFeedback (FeedbackID, CustomerID, FeedbackDate, FeedbackCategory, FeedbackText, Rating, Sentiment) VALUES
(1, 1, '2023-01-05', 'Service Quality', 'The service at the branch was excellent.', 5, 'Positive'),
(2, 2, '2023-01-10', 'Online Banking', 'Online banking is easy to use but a bit slow.', 4, 'Neutral'),
(3, 3, '2023-01-12', 'Customer Support', 'Customer support was very helpful.', 5, 'Positive'),
(4, 4, '2023-01-15', 'Product Satisfaction', 'The new credit card offers great rewards.', 5, 'Positive'),
(5, 5, '2023-01-20', 'Service Quality', 'Wait times at the branch are too long.', 2, 'Negative'),
(6, 6, '2023-01-22', 'Online Banking', 'Website downtime is frustrating.', 2, 'Negative'),
(7, 7, '2023-01-25', 'Customer Support', 'Support team was slow to respond.', 3, 'Neutral'),
(8, 8, '2023-01-28', 'Product Satisfaction', 'Not satisfied with the savings account interest rates.', 2, 'Negative'),
(9, 9, '2023-02-01', 'Service Quality', 'Friendly staff and quick service.', 5, 'Positive'),
(10, 10, '2023-02-05', 'Online Banking', 'The app is user-friendly and convenient.', 5, 'Positive'),
(11, 11, '2023-02-08', 'Customer Support', 'Customer service was excellent.', 5, 'Positive'),
(12, 12, '2023-02-10', 'Product Satisfaction', 'Happy with the mortgage rates.', 4, 'Positive'),
(13, 13, '2023-02-12', 'Service Quality', 'The staff was rude.', 1, 'Negative'),
(14, 14, '2023-02-15', 'Online Banking', 'Mobile app needs more features.', 3, 'Neutral'),
(15, 15, '2023-02-18', 'Customer Support', 'Good assistance provided.', 4, 'Positive'),
(16, 16, '2023-02-20', 'Product Satisfaction', 'Satisfied with the insurance plan.', 4, 'Positive'),
(17, 17, '2023-02-22', 'Service Quality', 'Wait times need improvement.', 3, 'Neutral'),
(18, 18, '2023-02-25', 'Online Banking', 'Excellent app with great features.', 5, 'Positive'),
(19, 19, '2023-02-28', 'Customer Support', 'Support team was helpful and responsive.', 4, 'Positive'),
(20, 20, '2023-03-01', 'Product Satisfaction', 'Credit card offers are competitive.', 4, 'Positive'),
(21, 21, '2023-03-05', 'Service Quality', 'Very welcoming branch staff.', 5, 'Positive'),
(22, 22, '2023-03-08', 'Online Banking', 'Issues with account login.', 2, 'Negative'),
(23, 23, '2023-03-10', 'Customer Support', 'Customer service could be more polite.', 3, 'Neutral'),
(24, 24, '2023-03-12', 'Product Satisfaction', 'Satisfied with the loan terms.', 4, 'Positive'),
(25, 25, '2023-03-15', 'Service Quality', 'Long lines at the branch.', 2, 'Negative'),
(26, 26, '2023-03-18', 'Online Banking', 'Online banking experience is smooth.', 5, 'Positive'),
(27, 27, '2023-03-20', 'Customer Support', 'Received quick help for account issues.', 5, 'Positive'),
(28, 28, '2023-03-22', 'Product Satisfaction', 'Low satisfaction with the new investment product.', 2, 'Negative'),
(29, 29, '2023-03-25', 'Service Quality', 'Friendly and efficient staff.', 5, 'Positive'),
(30, 30, '2023-03-28', 'Online Banking', 'App is very slow during peak hours.', 2, 'Negative'),
(31, 31, '2023-04-01', 'Customer Support', 'Support team resolved my issue promptly.', 5, 'Positive'),
(32, 32, '2023-04-05', 'Product Satisfaction', 'Credit card cashback options are good.', 4, 'Positive'),
(33, 33, '2023-04-08', 'Service Quality', 'Staff is professional and friendly.', 4, 'Positive'),
(34, 34, '2023-04-10', 'Online Banking', 'Need improvements in security.', 3, 'Neutral'),
(35, 35, '2023-04-12', 'Customer Support', 'Slow response time from support.', 2, 'Negative'),
(36, 36, '2023-04-15', 'Product Satisfaction', 'Interest rates could be higher.', 3, 'Neutral'),
(37, 37, '2023-04-18', 'Service Quality', 'Very accommodating staff.', 5, 'Positive'),
(38, 38, '2023-04-20', 'Online Banking', 'Overall satisfied with the online service.', 4, 'Positive'),
(39, 39, '2023-04-22', 'Customer Support', 'Support team was very courteous.', 5, 'Positive'),
(40, 40, '2023-04-25', 'Product Satisfaction', 'Good value in the savings account.', 4, 'Positive'),
(41, 41, '2023-04-28', 'Service Quality', 'Slow service during peak hours.', 3, 'Neutral'),
(42, 42, '2023-05-01', 'Online Banking', 'App interface is intuitive.', 5, 'Positive'),
(43, 43, '2023-05-05', 'Customer Support', 'Support team was not very helpful.', 2, 'Negative'),
(44, 44, '2023-05-08', 'Product Satisfaction', 'Very happy with the credit card benefits.', 5, 'Positive'),
(45, 45, '2023-05-10', 'Service Quality', 'Service has improved a lot recently.', 4, 'Positive'),
(46, 46, '2023-05-12', 'Online Banking', 'Frequent issues with online transfers.', 2, 'Negative'),
(47, 47, '2023-05-15', 'Customer Support', 'Helpful but long wait times.', 3, 'Neutral'),
(48, 48, '2023-05-18', 'Product Satisfaction', 'Great mortgage rates.', 5, 'Positive'),
(49, 49, '2023-05-20', 'Service Quality', 'Professional staff and quick service.', 5, 'Positive'),
(50, 50, '2023-05-22', 'Online Banking', 'App sometimes crashes.', 2, 'Negative');


-- Sample records for Loans table
INSERT INTO Loans (LoanID, CustomerID, LoanType, LoanAmount, InterestRate, LoanTerm, StartDate, EndDate, LoanStatus) VALUES
(1, 1, 'Personal', 15000.00, 5.50, 36, '2021-01-15', '2024-01-15', 'Active'),
(2, 2, 'Mortgage', 250000.00, 3.75, 240, '2020-05-01', '2040-05-01', 'Active'),
(3, 3, 'Auto', 20000.00, 4.25, 60, '2022-06-10', '2027-06-10', 'Active'),
(4, 4, 'Student', 18000.00, 5.00, 120, '2018-09-01', '2028-09-01', 'Active'),
(5, 5, 'Personal', 12000.00, 6.00, 24, '2022-02-20', '2024-02-20', 'Closed'),
(6, 6, 'Mortgage', 300000.00, 3.50, 360, '2015-10-01', '2045-10-01', 'Active'),
(7, 7, 'Auto', 15000.00, 4.00, 48, '2023-03-15', '2027-03-15', 'Active'),
(8, 8, 'Personal', 10000.00, 5.75, 36, '2021-08-01', '2024-08-01', 'Closed'),
(9, 9, 'Student', 22000.00, 4.75, 120, '2019-01-10', '2029-01-10', 'Active'),
(10, 10, 'Mortgage', 275000.00, 3.85, 240, '2020-11-15', '2040-11-15', 'Active'),
(11, 11, 'Auto', 18000.00, 4.50, 60, '2022-05-05', '2027-05-05', 'Active'),
(12, 12, 'Personal', 8000.00, 6.25, 24, '2021-03-20', '2023-03-20', 'Closed'),
(13, 13, 'Mortgage', 200000.00, 3.65, 180, '2019-07-30', '2034-07-30', 'Active'),
(14, 14, 'Auto', 25000.00, 4.10, 72, '2020-09-12', '2026-09-12', 'Active'),
(15, 15, 'Student', 15000.00, 5.25, 120, '2017-06-15', '2027-06-15', 'Active'),
(16, 16, 'Personal', 10000.00, 6.50, 36, '2021-10-01', '2024-10-01', 'Active'),
(17, 17, 'Mortgage', 220000.00, 3.95, 240, '2018-12-20', '2038-12-20', 'Active'),
(18, 18, 'Auto', 12000.00, 4.75, 48, '2022-11-08', '2026-11-08', 'Active'),
(19, 19, 'Personal', 7000.00, 6.75, 24, '2023-02-14', '2025-02-14', 'Active'),
(20, 20, 'Student', 20000.00, 5.10, 120, '2019-04-25', '2029-04-25', 'Active'),
(21, 21, 'Mortgage', 280000.00, 3.45, 360, '2022-01-05', '2052-01-05', 'Active'),
(22, 22, 'Auto', 22000.00, 4.20, 60, '2021-06-30', '2026-06-30', 'Closed'),
(23, 23, 'Personal', 15000.00, 5.80, 36, '2021-02-25', '2024-02-25', 'Active'),
(24, 24, 'Mortgage', 325000.00, 3.25, 300, '2017-08-14', '2042-08-14', 'Active'),
(25, 25, 'Auto', 16000.00, 4.30, 60, '2023-05-10', '2028-05-10', 'Active'),
(26, 26, 'Personal', 9000.00, 6.10, 24, '2022-09-01', '2024-09-01', 'Closed'),
(27, 27, 'Mortgage', 225000.00, 3.55, 240, '2021-03-22', '2041-03-22', 'Active'),
(28, 28, 'Student', 17000.00, 5.35, 120, '2018-05-17', '2028-05-17', 'Active'),
(29, 29, 'Personal', 11000.00, 5.95, 36, '2020-07-03', '2023-07-03', 'Closed'),
(30, 30, 'Mortgage', 250000.00, 3.60, 180, '2021-04-15', '2036-04-15', 'Active'),
(31, 31, 'Auto', 24000.00, 4.15, 60, '2022-02-28', '2027-02-28', 'Active'),
(32, 32, 'Personal', 7500.00, 6.35, 24, '2023-06-09', '2025-06-09', 'Active'),
(33, 33, 'Student', 21000.00, 4.85, 120, '2017-10-01', '2027-10-01', 'Active'),
(34, 34, 'Mortgage', 290000.00, 3.30, 360, '2019-09-20', '2049-09-20', 'Active'),
(35, 35, 'Auto', 14000.00, 4.25, 48, '2020-11-14', '2024-11-14', 'Closed'),
(36, 36, 'Personal', 12000.00, 5.70, 36, '2022-03-10', '2025-03-10', 'Active'),
(37, 37, 'Student', 19000.00, 5.00, 120, '2021-12-30', '2031-12-30', 'Active'),
(38, 38, 'Mortgage', 275000.00, 3.40, 240, '2023-04-05', '2043-04-05', 'Active'),
(39, 39, 'Auto', 17000.00, 4.60, 60, '2018-08-15', '2023-08-15', 'Closed'),
(40, 40, 'Personal', 13000.00, 6.20, 36, '2022-01-01', '2025-01-01', 'Active'),
(41, 41, 'Mortgage', 310000.00, 3.50, 300, '2020-10-10', '2045-10-10', 'Active'),
(42, 42, 'Student', 16000.00, 5.40, 120, '2018-06-12', '2028-06-12', 'Active'),
(43, 43, 'Personal', 10000.00, 6.30, 24, '2023-02-18', '2025-02-18', 'Active'),
(44, 44, 'Auto', 19000.00, 4.35, 72, '2022-12-30', '2028-12-30', 'Active');

-- Sample records for Credit_Card_Usage table
INSERT INTO Credit_Card_Usage (UsageID, CustomerID, TransactionDate, Merchant, TransactionAmount, Category, CardType) VALUES
(1, 1, '2023-01-05', 'Walmart', 120.50, 'Groceries', 'Visa'),
(2, 1, '2023-01-12', 'Amazon', 75.99, 'Shopping', 'Visa'),
(3, 2, '2023-01-15', 'Delta Airlines', 350.00, 'Travel', 'MasterCard'),
(4, 3, '2023-01-18', 'Starbucks', 12.50, 'Dining', 'Amex'),
(5, 4, '2023-01-20', 'Netflix', 15.99, 'Entertainment', 'Visa'),
(6, 5, '2023-01-25', 'Target', 80.25, 'Groceries', 'MasterCard'),
(7, 6, '2023-01-28', 'Uber', 20.00, 'Travel', 'Visa'),
(8, 7, '2023-02-01', 'McDonalds', 9.75, 'Dining', 'Visa'),
(9, 8, '2023-02-05', 'Best Buy', 199.99, 'Shopping', 'Amex'),
(10, 9, '2023-02-10', 'Spotify', 9.99, 'Entertainment', 'MasterCard'),
(11, 10, '2023-02-14', 'Whole Foods', 150.00, 'Groceries', 'Visa'),
(12, 11, '2023-02-18', 'Expedia', 600.00, 'Travel', 'MasterCard'),
(13, 12, '2023-02-21', 'Chipotle', 15.50, 'Dining', 'Amex'),
(14, 13, '2023-02-25', 'Apple Store', 299.99, 'Shopping', 'Visa'),
(15, 14, '2023-03-01', 'Disney+', 7.99, 'Entertainment', 'MasterCard'),
(16, 15, '2023-03-03', 'Safeway', 45.60, 'Groceries', 'Visa'),
(17, 16, '2023-03-06', 'Lyft', 18.00, 'Travel', 'Visa'),
(18, 17, '2023-03-09', 'Olive Garden', 32.00, 'Dining', 'Amex'),
(19, 18, '2023-03-12', 'Amazon', 25.99, 'Shopping', 'MasterCard'),
(20, 19, '2023-03-15', 'Hulu', 12.99, 'Entertainment', 'Visa'),
(21, 20, '2023-03-20', 'Kroger', 60.30, 'Groceries', 'MasterCard'),
(22, 21, '2023-03-22', 'JetBlue', 250.00, 'Travel', 'Visa'),
(23, 22, '2023-03-25', 'Panera Bread', 20.50, 'Dining', 'Amex'),
(24, 23, '2023-03-28', 'Walmart', 85.20, 'Shopping', 'Visa'),
(25, 24, '2023-04-01', 'Spotify', 9.99, 'Entertainment', 'MasterCard'),
(26, 25, '2023-04-05', 'Trader Joes', 72.40, 'Groceries', 'Visa'),
(27, 26, '2023-04-08', 'Lyft', 22.00, 'Travel', 'Visa'),
(28, 27, '2023-04-10', 'Pizza Hut', 18.99, 'Dining', 'Amex'),
(29, 28, '2023-04-12', 'Macys', 150.00, 'Shopping', 'MasterCard'),
(30, 29, '2023-04-15', 'Netflix', 15.99, 'Entertainment', 'Visa'),
(31, 30, '2023-04-18', 'Whole Foods', 130.00, 'Groceries', 'MasterCard'),
(32, 31, '2023-04-20', 'American Airlines', 500.00, 'Travel', 'Visa'),
(33, 32, '2023-04-25', 'Chipotle', 11.25, 'Dining', 'Amex'),
(34, 33, '2023-04-28', 'Target', 89.50, 'Shopping', 'Visa'),
(35, 34, '2023-05-01', 'Hulu', 8.99, 'Entertainment', 'MasterCard'),
(36, 35, '2023-05-05', 'Costco', 145.90, 'Groceries', 'Visa'),
(37, 36, '2023-05-10', 'Amtrak', 75.00, 'Travel', 'Visa'),
(38, 37, '2023-05-15', 'TGI Fridays', 27.80, 'Dining', 'Amex'),
(39, 38, '2023-05-20', 'Amazon', 56.70, 'Shopping', 'MasterCard'),
(40, 39, '2023-05-25', 'Disney+', 7.99, 'Entertainment', 'Visa'),
(41, 40, '2023-06-01', 'Walmart', 65.30, 'Groceries', 'MasterCard'),
(42, 41, '2023-06-08', 'Southwest Airlines', 325.00, 'Travel', 'Visa'),
(43, 42, '2023-06-15', 'Starbucks', 10.50, 'Dining', 'Amex'),
(44, 43, '2023-06-20', 'Nordstrom', 210.00, 'Shopping', 'Visa'),
(45, 44, '2023-06-25', 'Spotify', 9.99, 'Entertainment', 'MasterCard'),
(46, 45, '2023-07-01', 'Safeway', 89.25, 'Groceries', 'Visa'),
(47, 46, '2023-07-10', 'Uber', 30.00, 'Travel', 'Visa'),
(48, 47, '2023-07-15', 'Olive Garden', 24.50, 'Dining', 'Amex'),
(49, 48, '2023-07-18', 'Best Buy', 249.99, 'Shopping', 'MasterCard'),
(50, 49, '2023-07-20', 'Netflix', 15.99, 'Entertainment', 'Visa');


SELECT * FROM Customers;
SELECT * FROM Accounts;
SELECT * FROM Transactions;
SELECT * FROM CustomerFeedback;
SELECT * FROM Loans;
SELECT * FROM Credit_Card_Usage;




