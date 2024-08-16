import sys
import os
import jwt
import datetime
from functools import wraps
from flask import Flask, request, jsonify, abort

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), os.pardir)))

from image_to_text.image_text import process_image
from mongo import validate_user  # Import the validate_user function

app = Flask(__name__)

app.config['SECRET_KEY'] = 'your-secret-key'

def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = request.headers.get('Authorization')
        if not token:
            return jsonify({'message': 'Token is missing!'}), 403

        try:
            # Strip the "Bearer " prefix
            token = token.replace("Bearer ", "")
            data = jwt.decode(token, app.config['SECRET_KEY'], algorithms=["HS256"])
            current_user = data['user']
        except jwt.ExpiredSignatureError:
            return jsonify({'message': 'Token has expired!'}), 403
        except jwt.InvalidTokenError:
            return jsonify({'message': 'Token is invalid!'}), 403

        return f(current_user, *args, **kwargs)
    
    return decorated

@app.route('/login', methods=['POST'])
def login():
    auth = request.json
    if not auth or not auth.get('username') or not auth.get('password'):
        return jsonify({'message': 'Could not verify', 'WWW-Authenticate': 'Basic auth="Login required"'}), 401

    username = auth.get('username')
    password = auth.get('password')
    print(validate_user(username, password))
    if validate_user(username, password):
        token = jwt.encode({
            'user': username,
            'exp': datetime.datetime.utcnow() + datetime.timedelta(minutes=30)
        }, app.config['SECRET_KEY'], algorithm="HS256")
        return jsonify({'token': token})
    
    return jsonify({'message': 'Invalid credentials'}), 401

@app.route('/')
def hello():
    return 'Hello, World!'

@app.route('/checkServerRunning', methods=['GET'])
def onLoad():
    return 'Server is working perfectly!'

@app.route('/initialPrompt', methods=['POST'])
@token_required
def upload_initial_image(current_user):
    try:
        data = request.json
        image_to_text_data = process_image(data['data']['imageUrl'], "initial_data_text")
        return jsonify(image_to_text_data)
    except Exception as e:
        return jsonify({'error': str(e)})

@app.route('/ratioPrompt', methods=['POST'])
@token_required
def upload_ratio_image(current_user):
    try:
        data = request.json
        image_to_text_data = process_image(data['data']['imageUrl'], "ratio_specified_text")
        return jsonify(image_to_text_data)
    except Exception as e:
        return jsonify({'error': str(e)})

@app.route('/healthPrompt', methods=['POST'])
@token_required
def upload_health_image(current_user):
    try:
        data = request.json
        image_to_text_data = process_image(data['data']['imageUrl'], "health_consideration_text")
        return jsonify(image_to_text_data)
    except Exception as e:
        return jsonify({'error': str(e)})

@app.route('/conclusionPrompt', methods=['POST'])
@token_required
def upload_conclusion_image(current_user):
    try:
        data = request.json
        image_to_text_data = process_image(data['data']['imageUrl'], "conclusion_text")
        return jsonify(image_to_text_data)
    except Exception as e:
        return jsonify({'error': str(e)}) 

if __name__ == '__main__':
    app.run()
