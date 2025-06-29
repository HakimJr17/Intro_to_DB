import mysql.connector
from mysql.connector import Error

# --- Configuration ---
DB_HOST = "localhost"
DB_USER = "root"     
DB_PASSWORD = "####" 
DATABASE_NAME = "alx_book_store"    # The database where all tables will be created

# --- SQL Queries for Table Creation ---

# Authors table 
create_authors_table_query = """
CREATE TABLE IF NOT EXISTS Authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL
);
"""

# Customers table 
create_customers_table_query = """
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT PRIMARY KEY NOT NULL,
    customer_name VARCHAR(215) NOT NULL,
    email VARCHAR(215) NOT NULL,
    address TEXT
);
"""

# Books table (it references the Authors)
create_books_table_query = """
CREATE TABLE IF NOT EXISTS Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(130) NOT NULL,
    author_id INT NOT NULL,
    price DOUBLE, 
    publication_date DATE,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);
"""

# Orders table (references Customers)
create_orders_table_query = """
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY NOT NULL,
    customer_id INT NOT NULL,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
"""

# Order_Details table (it references Orders and Books)
create_order_details_table_query = """
CREATE TABLE IF NOT EXISTS Order_Details (
    orderdetailid INT PRIMARY KEY,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity DOUBLE NOT NULL, 
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);
"""

TABLE_CREATION_QUERIES = [
    ("Authors", create_authors_table_query),
    ("Customers", create_customers_table_query),
    ("Books", create_books_table_query),
    ("Orders", create_orders_table_query),
    ("Order_Details", create_order_details_table_query)
]

# --- Database Connection and Table Creation Logic ---
mydb = None
mycursor = None

try:
    # 1. Establish a connection to the specific database ('alx_book_store')
    print(f"Attempting to connect to database '{DATABASE_NAME}' on {DB_HOST}...")
    mydb = mysql.connector.connect(
        host=DB_HOST,
        user=DB_USER,
        password=DB_PASSWORD,
        database=DATABASE_NAME # Connect directly to the 'alx_book_store' database
    )

    if mydb.is_connected():
        print(f"Successfully connected to database '{DATABASE_NAME}'.")
        mycursor = mydb.cursor()

        # 2. Iterate through and execute each table creation query
        for table_name, query in TABLE_CREATION_QUERIES:
            try:
                print(f"\nExecuting table creation query for '{table_name}'...")
                mycursor.execute(query)
                mydb.commit() # Commit after each table creation
                print(f"Table '{table_name}' created successfully or already exists.")
            except Error as e:
                # Specific error handling for table creation
                print(f"Error creating table '{table_name}': {e}")

    else:
        print("Failed to establish a connection to MySQL server.")

except Error as e:
    # Handle connection errors
    print(f"Error: Failed to connect to the database: {e}")
    if e.errno == mysql.connector.errorcode.ER_ACCESS_DENIED_ERROR:
        print("Please check your username and password. Access denied.")
    elif e.connector_errno == mysql.connector.errorcode.CR_UNKNOWN_DATABASE:
        print(f"Database '{DATABASE_NAME}' does not exist. Ensure it is created before running this script.")
    elif e.connector_errno == mysql.connector.errorcode.CR_CONN_HOST_ERROR:
        print(f"Cannot connect to MySQL server at {DB_HOST}. Is the server running?")
    else:
        print(f"An unexpected error occurred during connection: {e}")

finally:
    # 3. Ensure the cursor and connection are closed
    if mycursor:
        mycursor.close()
        print("\nCursor closed.")
    if mydb:
        mydb.close()
        print("Database connection closed.")