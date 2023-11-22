# Financial-Management-Portfolio-System

## Introduction
Financial Management Portfolio System (FMPS) is a database-driven application designed to help users manage their financial portfolios. With FMPS, users can maintain their user profiles, manage financial instruments, track investments, and perform complex financial queries to inform their investment decisions.

## Features
- **User Management:** Register and maintain user profiles within the system.
- **Financial Instrument Tracking:** Keep a record of various financial instruments such as stocks(future work will be to include more financial instruments).
- **Market Data Integration:** Automatically fetch and store live market data.
- **Investment Analysis:** Perform SQL-based queries for investment analysis.

## Prerequisites
- Python 3.x
- MySQL Server
- Python libraries: `yfinance`, `mysql-connector-python`

## Setup
1. Install the required Python packages.
2. Execute the `fmps_setup.sql` script on your MySQL server to set up the FMPS database and tables.
3. Configure the `market_data.py` script with your database connection details and run it to fetch and populate the market data.
4. Utilize the `queries.sql` to perform initial data queries and set up your initial state or to perform regular analytical operations.

## Usage
- **Database Management:** Use MySQL Workbench or a similar tool to manage the FMPS database.
- **Market Data Collection:** Schedule the `market_data.py` script to run at your desired frequency to keep market data up-to-date.
- **Financial Analysis:** Use the provided SQL queries in `queries.sql` as a starting point for financial analysis and reporting.

## Future Work
The roadmap for the Financial Management Portfolio System includes several exciting enhancements to extend its functionality and provide users with a more powerful tool for managing their investments:

- **Advanced Analytics Dashboard:** We are planning to develop a cutting-edge analytics dashboard that will offer users deeper insights into their investments with real-time data visualization and performance tracking features.

- **Comprehensive Market Coverage:** In the upcoming versions, we aim to broaden our market coverage to include the entire S&P 500, giving users access to a more extensive selection of stocks for analysis and investment. This expansion will allow for a more diversified portfolio and the ability to tap into a wider range of market opportunities.

- **Multi-Currency Support & Expanded Financial Instruments:** The system will be enhanced to support transactions and valuations in multiple currencies, making it an ideal tool for international investors. Moreover, we will integrate a variety of financial instruments into our platform, including bonds, ETFs, various derivatives, and cryptocurrencies, to meet the needs of advanced investors looking for a comprehensive portfolio management solution.

These developments are geared towards making FMPS a versatile and indispensable asset for investors of all levels, providing them with the tools they need to navigate the complexities of the financial markets confidently.



