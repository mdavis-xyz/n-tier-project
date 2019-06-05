from flask import Flask
from flask import jsonify
app = Flask(__name__)

@app.route("/dynamic")
def {{ handler_function }}():
    data = [
      {'firstName':'Matthew',
       'lastName': 'Davis'
      },
      {'firstName':'John',
       'lastName': 'Smith'
      },
            ]
    return(jsonify(data))

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)
