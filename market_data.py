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
            host=host_name,
            database=db_name,
            user=user_name,
            password=user_password
        )
        if connection.is_connected():
            cursor = connection.cursor()
            
            # Get the InstrumentID that corresponds to the ticker_symbol
            instrument_id = get_instrument_id(cursor, ticker_symbol)
            
            for row in data_frame.itertuples():
                # Convert the Timestamp to a string in 'YYYY-MM-DD' format
                date_str = row.Index.strftime('%Y-%m-%d')
                
                # Convert numpy float64 to native Python types
                open_price = float(row.Open)
                close_price = float(row.Close)
                high = float(row.High)
                low = float(row.Low)
                volume = int(row.Volume)
                
                insert_query = """
                    INSERT INTO `MARKET_DATA` (InstrumentID, Date, OpenPrice, ClosePrice, High, Low, Volume)
                    VALUES (%s, %s, %s, %s, %s, %s, %s)
                """
                cursor.execute(insert_query, (instrument_id, date_str, open_price, close_price, high, low, volume))
            
            # Fetch the latest price and ensure it's a native Python float
            latest_price = float(data_frame.iloc[-1]['Close'])
            
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
    data_frame = yf.download(stock, start='2023-11-01', end=datetime.date.today().isoformat())

    # Insert market data into the database
    insert_market_data(stock, data_frame)
