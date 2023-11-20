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
