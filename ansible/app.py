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
        host="localhost",
        user="root",
        passwd="tuesdayVibratoLesson3Bar", # TODO: figure out a better way to handle secrets
        database="web_data"
    )

    
    mycursor = mydb.cursor()

    # must spell out keys this way
    # not select *, because the return value is a string with no
    # column names
    keys = ('first_name','last_name','job_title')
    mycursor.execute("SELECT %s FROM staff_info" % ", ".join(keys))

    myresult = mycursor.fetchall()
    data = []
    for row in myresult:
        data.append({key:val for (key,val) in zip(keys,row)})

    return(data) 

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)
