import mysql.connector
from mysql.connector import Error

# --- Configuration ---
DB_HOST = "localhost"
DB_USER = "root"     
DB_PASSWORD = "####" 
DATABASE_NAME = "alx_book_store" # The database where your Customers table is

# --- Data to Insert ---
customer_data = (2, "Blessing Malik", "bmalik@sandtech.com", "124 Happiness  Ave."),
                (3, "Obed Ehoneah", "eobed@sandtech.com", "125 Happiness  Ave."),
                (4, "Nehemial Kamolu", "nkamolu@sandtech.com", "126 Happiness  Ave.");

# --- Database Connection and Data Insertion Logic ---
mydb = None
mycursor = None

try:
    # 1. Establish a connection to the database
    print(f"Attempting to connect to database '{DATABASE_NAME}' on {DB_HOST}...")
    mydb = mysql.connector.connect(
        host=DB_HOST,
        user=DB_USER,
        password=DB_PASSWORD,
        database=DATABASE_NAME
    )

    if mydb.is_connected():
        print(f"Successfully connected to database '{DATABASE_NAME}'.")
        mycursor = mydb.cursor()

        # 2. SQL INSERT statement with placeholders
        sql = "INSERT INTO customer (customer_id, customer_name, email, address) VALUES (%s, %s, %s, %s)"

        # 3. Execute the SQL statement with the data
        print(f"Inserting customer data: {customer_data}...")
        mycursor.execute(sql, customer_data)

        # 4. Commit the changes to the database
        mydb.commit()

        # 5. Print success message and number of rows affected
        print(f"{mycursor.rowcount} record inserted successfully into 'Customers' table.")

    else:
        print("Failed to establish a connection to MySQL server.")

except Error as e:
    # Handle potential errors
    print(f"Error: Failed to connect to the database or insert data: {e}")
    if e.errno == mysql.connector.errorcode.ER_ACCESS_DENIED_ERROR:
        print("Please check your username and password. Access denied.")
    elif e.connector_errno == mysql.connector.errorcode.CR_UNKNOWN_DATABASE:
        print(f"Database '{DATABASE_NAME}' does not exist. Ensure it is created.")
    elif e.errno == mysql.connector.errorcode.ER_DUP_ENTRY:
        print(f"Duplicate entry for primary key (customer_id: {customer_data[0]}). This customer might already exist.")
    else:
        print(f"An unexpected database error occurred: {e}")

finally:
    # Ensure the cursor and connection are closed
    if mycursor:
        mycursor.close()
        print("Cursor closed.")
    if mydb:
        mydb.close()
        print("Database connection closed.")