import mysql.connector

# Informazioni di connessione al database
mydb = mysql.connector.connect(
  host="172.17.0.3",
  user="user",
  password="password",
  database="pandapower_db"
)

# Crea un cursore per eseguire le query
mycursor = mydb.cursor()

# Query UPDATE (adatta i nomi della tabella, del campo e il valore da aggiornare)
sql = "UPDATE line_cb SET value = '1' WHERE name = 'line_cb_10'"

# Esegui la query
mycursor.execute(sql)

# Conferma le modifiche al database
mydb.commit()

print(mycursor.rowcount, "record(s) affected")

# Chiudi la connessione
mydb.close()