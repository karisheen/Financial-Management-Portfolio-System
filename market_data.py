import yfinance as yf
import mysql.connector
from mysql.connector import Error
import datetime

# Replace the values below with your MySQL database connection info
host_name = '127.0.0.1'
db_name = 'FMPS'
user_name = 'root'
user_password = 'football25'

# Function to insert data into the database
def insert_market_data(ticker_symbol, data_frame):
    try:
        connection = mysql.connector.connect(
            host='127.0.0.1',
            database='FMPS',
            user='root',
            password='football25'
        )
        if connection.is_connected():
            cursor = connection.cursor()
            
            # Get the InstrumentID that corresponds to the ticker_symbol
            instrument_id = get_instrument_id(cursor, ticker_symbol)
            
            for row in data_frame.itertuples():
                insert_query = """
                    INSERT INTO `MARKET_DATA` (InstrumentID, Date, OpenPrice, ClosePrice, High, Low, Volume)
                    VALUES (%s, %s, %s, %s, %s, %s, %s)
                """
                cursor.execute(insert_query, (instrument_id, row.Index, row.Open, row.Close, row.High, row.Low, row.Volume))
            
            # Fetch the latest price
            latest_price = data_frame.iloc[-1]['Close']
            
            # Update the CurrentMarketPrice in the FINANCIAL_INSTRUMENT table
            update_query = """
                UPDATE `FINANCIAL_INSTRUMENT`
                SET `CurrentMarketPrice` = %s
                WHERE `InstrumentID` = %s
            """
            cursor.execute(update_query, (latest_price, instrument_id))
            
            connection.commit()
    except Error as e:
        print(f"Error: {e}")
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

def get_instrument_id(cursor, ticker_symbol):
    cursor.execute("SELECT InstrumentID FROM FINANCIAL_INSTRUMENT WHERE TickerSymbol = %s", (ticker_symbol,))
    result = cursor.fetchone()
    return result[0] if result else None

# List of top 25 stocks from the S&P 500
stocks = ['AAPL', 'MSFT', 'AMZN', 'NVDA', 'GOOGL', 'TSLA', 'GOOG',
          'BRK-B', 'META', 'UNH', 'XOM', 'LLY', 'JPM', 'JNJ', 'V',
          'PG', 'MA', 'AVGO', 'HD', 'CVX', 'MRK', 'ABBV', 'COST',
          'PEP', 'ADBE']

# Loop over the list of stocks
for stock in stocks:
    # Fetch market data up to today
    data_frame = yf.download(stock, start='2023-01-01', end=datetime.date.today().isoformat())

    # Insert market data into the database
    insert_market_data(stock, data_frame)