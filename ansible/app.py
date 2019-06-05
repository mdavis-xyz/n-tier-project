from flask import Flask
from flask import jsonify
app = Flask(__name__)

@app.route("/dynamic")
def {{ handler_function }}():
    data = [
      {'first_name':'Matthew',
       'last_name': 'Davis'
      },
      {'first_name':'John',
       'last_name': 'Smith'
      },
            ]
    return(jsonify(data))

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)
