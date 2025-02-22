from flask import Flask, json, jsonify, request
from werkzeug.security import generate_password_hash, check_password_hash
import jwt
import datetime

from .Classes.Person import Person
from .Classes.Cv import BasicTemplateForStem as Stem

app = Flask(__name__)
app.json.sort_keys = False
app.config['SECRET_KEY'] = 'create_cv_secret_key'


#TODO: this is a mockup of the data that would be in the database
person = Person('lazar-wissal@outlook.com', generate_password_hash('123', method='pbkdf2:sha256'))
users_db = {
    'lazar-wissal@outlook.com': person
}

templates_db = {
    'template1': "BasicTemplateForStem",
    'template2': "BasicTemplateForBusiness",
    'template3': "BasicTemplateForArt"
}

@app.route('/signup', methods = ['POST'])
def SignUp():
    # request
    data = request.get_json()
    # get email
    email = data.get('email')
    # get password
    password = data.get('password')

    # check if email or password are not empty :
    if not email or not password:
        return jsonify({'message': 'missing email or password'}), 400
    # check if user email in database :
    if email in users_db:
        return jsonify({'message': 'User already exist!'}), 400

    # hash password :
    hashed_password = generate_password_hash(password, method='pbkdf2:sha256')

    # Create a new Person instance and Store the Person in the "database"
    users_db[email] = Person(email, hashed_password)

    return jsonify({'message' : 'User registered successfully :)!'})

@app.route('/login', methods = ['POST'])
def login():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')


    if email not in users_db:
        return jsonify({'message': 'User not found'}), 400


    person = users_db[email]
    # print('login password : ', password)
    # print("stored hash : ", person.password)

    if not check_password_hash(person.password, password):
        return jsonify({'message': 'Incorrect password'}), 400

    token = jwt.encode({
        'email' : email,
        'exp': datetime.datetime.utcnow() + datetime.timedelta(hours = 2)
    }, app.config['SECRET_KEY'], algorithm='HS256')
    # print("token : ", token)

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


@app.route('/get_templates', methods=['GET'])
def get_template():
    return jsonify({'templates': templates_db})



@app.route('/get_questions', methods=['GET'])
def getQuestions():
    template = request.headers.get('template')

    # print(template)
    if template == 'template1':
        questions = Stem.questions()
        print(questions)
        return {'questions': questions}
    else:
        return jsonify({'message': 'Template not found'}), 404



if __name__ == '__main__':
    app.run(debug=True)
