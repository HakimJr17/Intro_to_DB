import mysql.connector
from mysql.connector import Error

# --- Configuration ---
DB_HOST = "localhost"
DB_USER = "root"    
DB_PASSWORD = "####" 
DATABASE_NAME = "alx_book_store"  # The database you want to list tables from

# --- Main Script ---
mydb = None
mycursor = None

try:
    # 1. Establish a connection to the specific database
    print(f"Attempting to connect to database '{DATABASE_NAME}' on {DB_HOST}...")
    mydb = mysql.connector.connect(
        host=DB_HOST,
        user=DB_USER,
        password=DB_PASSWORD,
        database=DATABASE_NAME # Connect directly to the database
    )

    if mydb.is_connected():
        print(f"Successfully connected to database '{DATABASE_NAME}'.")
        mycursor = mydb.cursor()

        print(f"Executing USE {DATABASE_NAME};")
        mycursor.execute(f"USE {DATABASE_NAME};")


        # 2. Define the SQL query to show tables
        sql_query = "SHOW TABLES;"

        print(f"\nExecuting query: {sql_query}")
        mycursor.execute(sql_query)

        # 3. Fetch all the results
        # fetchall() returns a list of tuples, where each tuple is a row.
        # For SHOW TABLES, each row will typically have one element: the table name.
        tables = mycursor.fetchall()

        # 4. Print the tables
        if tables:
            print(f"\nTables in database '{DATABASE_NAME}':")
            for table in tables:
                print(f"- {table[0]}")
        else:
            print(f"No tables found in database '{DATABASE_NAME}'.")

    else:
        print("Failed to establish a connection to MySQL server.")

except Error as e:
    # 5. Handle potential errors
    print(f"Error: Failed to connect to the database or list tables: {e}")
    if e.errno == mysql.connector.errorcode.ER_ACCESS_DENIED_ERROR:
        print("Please check your username and password. Access denied.")
    elif e.connector_errno == mysql.connector.errorcode.CR_UNKNOWN_DATABASE:
        print(f"Database '{DATABASE_NAME}' does not exist. Please check the database name.")
    elif e.connector_errno == mysql.connector.errorcode.CR_CONN_HOST_ERROR:
        print(f"Cannot connect to MySQL server at {DB_HOST}. Is the server running?")
    else:
        print(f"An unexpected database error occurred: {e}")

finally:
    # 6. Close the cursor and connection
    if mycursor:
        mycursor.close()
        print("\nCursor closed.")
    if mydb:
        mydb.close()
        print("Database connection closed.")