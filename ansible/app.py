from flask import Flask
from flask import jsonify
import mysql.connector
import pprint as pp

app = Flask(__name__)

@app.route("/dynamic")
def serve():
    data = fetchFromDB()
    return(jsonify(data))


def fetchFromDB():

    mydb = mysql.connector.connect(
        host="{{ sql_host }}",
        user="{{ sql_user }}",
        passwd="{{ sql_pass }}", # TODO: figure out a better way to handle secrets
        database="{{ database_name }}"
    )

    
    mycursor = mydb.cursor()

    keys = ('first_name','last_name')
    mycursor.execute("SELECT %s FROM {{ table_name }}" % ", ".join(keys))

    myresult = mycursor.fetchall()
    data = []
    for row in myresult:
        data.append({key:val for (key,val) in zip(keys,row)})

    return(data) 

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)
