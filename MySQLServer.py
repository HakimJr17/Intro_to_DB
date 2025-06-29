import mysql.connector
from mysql.connector import Error

# --- Configuration ---
DB_HOST = "localhost"
DB_USER = "root" 
DB_PASSWORD = "1234" 
NEW_DATABASE_NAME = "alx_book_store"

# --- Database Connection and Creation ---
mydb = None
mycursor = None

try:
    # Attempt to connect to the MySQL server (not a specific database initially)
    # This is necessary to execute CREATE DATABASE
    print(f"Attempting to connect to MySQL server at {DB_HOST}...")
    mydb = mysql.connector.connect(
        host=DB_HOST,
        user=DB_USER,
        password=DB_PASSWORD
    )

    if mydb.is_connected():
        print("Successfully connected to MySQL server.")
        mycursor = mydb.cursor()

        # SQL statement to create the database if it doesn't exist
        # This adheres to the "not fail if database already exists" and
        # "no SELECT or SHOW statements" requirements.
        create_db_query = f"CREATE DATABASE IF NOT EXISTS {NEW_DATABASE_NAME}"

        print(f"Executing query: {create_db_query}")
        mycursor.execute(create_db_query)

        # Commit changes to ensure the database creation is saved
        mydb.commit()

        # Print success message as required
        print(f"Database '{NEW_DATABASE_NAME}' created successfully!")
    else:
        print("Failed to establish a connection to MySQL server.")

except Error as e:
    # Handle connection and other database-related errors
    print(f"Error: Failed to connect to the database or execute query: {e}")
    # You can add more specific error handling based on e.errno if needed
    if e.errno == mysql.connector.errorcode.ER_ACCESS_DENIED_ERROR:
        print("Please check your username and password. Access denied.")
    elif e.errno == mysql.connector.errorcode.CR_CONN_HOST_ERROR:
        print(f"Cannot connect to MySQL server at {DB_HOST}. Is the server running?")
    else:
        print(f"An unexpected database error occurred: {e}")

finally:
    # Ensure the cursor and connection are closed, regardless of success or failure
    if mycursor:
        mycursor.close()
        print("Cursor closed.")
    if mydb:
        mydb.close()
        print("Database connection closed.")