from flask import Flask, jsonify, request
from werkzeug.security import generate_password_hash, check_password_hash
import jwt
import datetime

from backend.Classes import Person

app = Flask(__name__)
app.config['SECRET_KEY'] = 'create_cv_secret_key'

users_db = {}

@app.route('/signup', methods = ['POST'])
def SignUp():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')
    # print("hello world--------------------------------")

    if not email or not password:
        return jsonify({'message': 'missing email or password'}), 400

    if email in users:
        return jsonify({'message': 'User already exist!'}), 400

    hashed_password = generate_password_hash(password, method='pbkdf2:sha256')
    # Create a new Person instance
    new_person = Person(email, hashed_password)

    # Store the Person instance in the "database" (for this example, we use a dictionary)
    users_db[email] = new_person
    return jsonify({'message' : 'User registered successfully :)!'})

@app.route('/login', methods = ['POST'])
def login():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')

    if email not in users_db:
        return jsonify({'message': 'User not found'}), 400
    if not check_password_hash(users_db[email].getPassword(), password):
        return jsonify({'message': 'Incorrect password'}), 400

    token = jwt.encode({
        'email' : email,
        'exp': datetime.datetime.utcnow() + datetime.timedelta(hours = 2)
    }, app.config['SECRET_KEY'], algorithm='HS256')
    return jsonify({'token' : token})


@app.route('/protected', methods = ['GET'])
def protected():
    token = request.headers.get('x-access-token')

    if not token:
        return jsonify({'message': 'Token is missing!'}), 401
    try:
        data = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
        current_user = data['email']
    except jwt.ExpiredSignatureError:
        return jsonify({'message': 'Token has expired !'}), 401
    except jwt.InvalidTokenError:
        return jsonify({'message': 'Token is not valid'}), 401

    return jsonify({'message' : f'Hello, {current_user}!'})

if __name__ == '__main__':
    app.run(debug=True)
