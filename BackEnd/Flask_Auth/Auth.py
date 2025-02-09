from flask import Flask, request, jsonify
from werkzeug.security import generate_password_hash, check_password_hash
import jwt
import datetime

app = Flask(__name__)
app.config['SECRET8KEY'] = 'create_cv_secret_key'

users = {}

@app.route('/register', methods = ['POST'])
def register():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')

    if username in users:
        return jsonify({'message': 'User already exist!'}), 400

    hashed_password = generate_password_hash(password, method='sha256')
    users[username] = hashed_password
    return jsonify({'message' : 'User registered successfully :)!'})

@app.route('/login', methods = ['POST'])
def login():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')

    if username not in users:
        return jsonify({'message': 'User not found'}), 400
    if not check_password_hash(users[username], password):
        return jsonify({'message': 'Incorrect password'}), 400

    token = jwt.encode({
        'username' : username,
        'exp': datetime.datetime.utcnow() + datetime.timedelta(hours = 2)
    }, app.config['SECRET8KEY'], algorithm='HS256')
    return jsonify({'token' : token})


@app.route('/protected', methods = ['GET'])
def protected():
    token = request.headers.get('x-access-token')

    if not token:
        return jsonify({'message': 'Token is missing!'}), 400
    try:
        data = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
        current_user = data['username']
    except:
        return jsonify({'message': 'Token is valid !'}), 401

    return jsonify({'message' : f'Hello, {current_user}!'})

if __name__ == '__main__':
    app.run(debug=True)
