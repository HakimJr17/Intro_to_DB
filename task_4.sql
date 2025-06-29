-- This script prints the full description of the 'Books' table from the 'alx_book_store' database.

SELECT
    COLUMN_NAME,    -- The name of the column
    COLUMN_TYPE,    -- The data type of the column 
    IS_NULLABLE,    -- 'YES' if the column can contain NULL values, 'NO' otherwise
    COLUMN_KEY,     -- Indicates if the column is part of a key
    COLUMN_DEFAULT, -- The default value for the column, if any
    EXTRA           -- Additional information 
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_SCHEMA = 'alx_book_store' AND
    TABLE_NAME = 'Books';