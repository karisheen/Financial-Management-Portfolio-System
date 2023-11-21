-- Active: 1700455865595@@127.0.0.1@3306
-- Create the FMPS database
CREATE DATABASE IF NOT EXISTS FMPS;

-- Use the FMPS database
USE FMPS;

-- Create the USER table
CREATE TABLE IF NOT EXISTS USER (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(255) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    DateRegistered DATE NOT NULL
);

-- Create the FINANCIAL_INSTRUMENT table
CREATE TABLE IF NOT EXISTS FINANCIAL_INSTRUMENT (
    InstrumentID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Type VARCHAR(50),
    TickerSymbol VARCHAR(10) NOT NULL,
    CurrentMarketPrice DECIMAL(19, 4)
);

-- Create the USER_INVESTMENT table
CREATE TABLE IF NOT EXISTS USER_INVESTMENT (
    InvestmentID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    InstrumentID INT NOT NULL,
    Quantity DECIMAL(19, 4) NOT NULL,
    PurchaseDate DATE NOT NULL,
    PurchasePrice DECIMAL(19, 4) NOT NULL,
    FOREIGN KEY (UserID) REFERENCES USER(UserID),
    FOREIGN KEY (InstrumentID) REFERENCES FINANCIAL_INSTRUMENT(InstrumentID)
);

-- Create the REPORT table
CREATE TABLE IF NOT EXISTS REPORT (
    ReportID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    DateGenerated DATE NOT NULL,
    ReportType VARCHAR(255),
    Content TEXT,
    FOREIGN KEY (UserID) REFERENCES USER(UserID)
);

-- Create the MARKET_DATA table
CREATE TABLE IF NOT EXISTS MARKET_DATA (
    DataID INT AUTO_INCREMENT PRIMARY KEY,
    InstrumentID INT NOT NULL,
    Date DATE NOT NULL,
    OpenPrice DECIMAL(19, 4) NOT NULL,
    ClosePrice DECIMAL(19, 4) NOT NULL,
    High DECIMAL(19, 4) NOT NULL,
    Low DECIMAL(19, 4) NOT NULL,
    Volume BIGINT NOT NULL,
    FOREIGN KEY (InstrumentID) REFERENCES FINANCIAL_INSTRUMENT(InstrumentID)
);

INSERT INTO FINANCIAL_INSTRUMENT (Name, Type, TickerSymbol, CurrentMarketPrice) VALUES
    ('Apple', 'Stock', 'AAPL', 0.00),
    ('Microsoft', 'Stock', 'MSFT', 0.00),
    ('Amazon', 'Stock', 'AMZN', 0.00),
    ('Nvidia', 'Stock', 'NVDA', 0.00),
    ('Google', 'Stock', 'GOOGL', 0.00),
    ('Tesla', 'Stock', 'TSLA', 0.00),
    ('Google', 'Stock', 'GOOG', 0.00),
    ('Berkshire Hathaway', 'Stock', 'BRK-B', 0.00),
    ('Meta Platforms', 'Stock', 'META', 0.00),
    ('UnitedHealth Group', 'Stock', 'UNH', 0.00),
    ('Exxon Mobil', 'Stock', 'XOM', 0.00),
    ('Eli Lilly and Company', 'Stock', 'LLY', 0.00),
    ('JPMorgan Chase & Co.', 'Stock', 'JPM', 0.00),
    ('Johnson & Johnson', 'Stock', 'JNJ', 0.00),
    ('Visa', 'Stock', 'V', 0.00),
    ('Procter & Gamble', 'Stock', 'PG', 0.00),
    ('Mastercard', 'Stock', 'MA', 0.00),
    ('Broadcom', 'Stock', 'AVGO', 0.00),
    ('Home Depot', 'Stock', 'HD', 0.00),
    ('Chevron Corporation', 'Stock', 'CVX', 0.00),
    ('Merck & Co.', 'Stock', 'MRK', 0.00),
    ('AbbVie', 'Stock', 'ABBV', 0.00),
    ('Costco Wholesale Corporation', 'Stock', 'COST', 0.00),
    ('PepsiCo', 'Stock', 'PEP', 0.00),
    ('Adobe', 'Stock', 'ADBE', 0.00);

INSERT INTO USER (UserID, Username, Password, Email, DateRegistered) VALUES 
    (1, 'trader_john', '4bTg7hN12XyZ', 'trader_john@hedgefund.com', CURDATE()),
    (2, 'analyst_sam', '8pKm6jQ23WvX', 'analyst_sam@hedgefund.com', CURDATE()),
    (3, 'trader_emily', '1cRt5lP89SaE', 'trader_emily@hedgefund.com', CURDATE()),
    (4, 'analyst_alex', '2dQb4nU06LrF', 'analyst_alex@hedgefund.com', CURDATE()),
    (5, 'trader_max', '9zXs3vM71RfY', 'trader_max@hedgefund.com', CURDATE()),
    (6, 'analyst_sophia', '0kWv5gP24JnB', 'analyst_sophia@hedgefund.com', CURDATE()),
    (7, 'trader_jess', '6yHn2qT81LdC', 'trader_jess@hedgefund.com', CURDATE());


INSERT INTO USER_INVESTMENT (UserID, InstrumentID, PurchaseDate, PurchasePrice, Quantity) VALUES
    (1, 1, '2023-11-01', (SELECT OpenPrice FROM MARKET_DATA WHERE InstrumentID = 1 AND Date = '2023-11-01'), 2000)

INSERT INTO USER_INVESTMENT (UserID, InstrumentID, PurchaseDate, PurchasePrice, Quantity) VALUES
    (2, 9, '2023-11-02', (SELECT OpenPrice FROM MARKET_DATA WHERE InstrumentID = 9 AND Date = '2023-11-02'), 3000)

INSERT INTO USER_INVESTMENT (UserID, InstrumentID, PurchaseDate, PurchasePrice, Quantity) VALUES
    (3, 3, '2023-11-03', (SELECT OpenPrice FROM MARKET_DATA WHERE InstrumentID = 3 AND Date = '2023-11-03'), 1500)

INSERT INTO USER_INVESTMENT (UserID, InstrumentID, PurchaseDate, PurchasePrice, Quantity) VALUES
    (4, 4, '2023-11-06', (SELECT OpenPrice FROM MARKET_DATA WHERE InstrumentID = 4 AND Date = '2023-11-06'), 2500)

INSERT INTO USER_INVESTMENT (UserID, InstrumentID, PurchaseDate, PurchasePrice, Quantity) VALUES
    (5, 20, '2023-11-07', (SELECT OpenPrice FROM MARKET_DATA WHERE InstrumentID = 20 AND Date = '2023-11-07'), 3500)

INSERT INTO USER_INVESTMENT (UserID, InstrumentID, PurchaseDate, PurchasePrice, Quantity) VALUES
    (6, 2, '2023-11-08', (SELECT OpenPrice FROM MARKET_DATA WHERE InstrumentID = 2 AND Date = '2023-11-08'), 4000)

INSERT INTO USER_INVESTMENT (UserID, InstrumentID, PurchaseDate, PurchasePrice, Quantity) VALUES
    (7, 7, '2023-11-17', (SELECT OpenPrice FROM MARKET_DATA WHERE InstrumentID = 7 AND Date = '2023-11-17'), 1000)



