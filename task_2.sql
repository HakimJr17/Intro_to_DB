import mysql.connector
from mysql.connector import Error

# --- Configuration ---
DB_HOST = "localhost"
DB_USER = "your_mysql_username"   
DB_PASSWORD = "1234" 
DATABASE_NAME = "alx_book_store" 

# --- Table Creation Logic ---
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

        # 2. Define the SQL query to create the 'Authors' table
        # IF NOT EXISTS is included to prevent errors if the table already exists.
        create_authors_table_query = """
        CREATE TABLE Authors (
        author_id INT PRIMARY KEY,
        author_name VARCHAR(255)
        );
        """

        print(f"Executing table creation query for 'Authors'...")
        mycursor.execute(create_authors_table_query)

        # 3. Commit the changes to save the new table
        mydb.commit()

        print(f"Table 'Authors' created successfully in '{DATABASE_NAME}' or already exists.")

except Error as e:
    # 4. Handle potential errors during connection or table creation
    print(f"Error: Failed to connect to the database or create table: {e}")
    if e.errno == mysql.connector.errorcode.ER_ACCESS_DENIED_ERROR:
        print("Please check your username and password. Access denied.")
    elif e.connector_errno == mysql.connector.errorcode.CR_UNKNOWN_DATABASE:
        print(f"Database '{DATABASE_NAME}' does not exist. Ensure it is created before running this script.")
    else:
        print(f"An unexpected database error occurred: {e}")

finally:
    # 5. Ensure the cursor and connection are closed
    if mycursor:
        mycursor.close()
        print("Cursor closed.")
    if mydb:
        mydb.close()
        print("Database connection closed.")