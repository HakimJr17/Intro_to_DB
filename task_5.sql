sql = "INSERT INTO Customer (customer_id, customer_name, email, address) VALUES (%s, %s, %s, %s)"
val = (1, "Cole Baidoo", "cbaidoo@sandtech.com", "123 Happiness Ave.")

mycursor.execute(sql,val)
mydb.commit()