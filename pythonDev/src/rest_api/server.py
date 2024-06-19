import sys
import os

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), os.pardir)))

from image_to_text.image_text import image_to_text
from flask import Flask, request, jsonify

# string to object
import json

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello, World!'

@app.route('/imageTodata', methods=['POST'])
def upload_image():
    # get data from post request in json format
    data = request.json
    image_to_text_data =image_to_text(data['data']['imageUrl'])   
    # print(data["imageUrl"])
    # image_to_text_data =image_to_text('https://i.pinimg.com/736x/1b/34/dd/1b34ddbed4fe56767fae40b3444c605b.jpg')   
    text_to_dict = json.loads(image_to_text_data.text[9:-4])
    # print(image_to_text_data)
    # Process the file here
    # You can access the file data using file.read() or save it to the UPLOAD_FOLDER
    # print(data['data']['imageUrl'])
    return jsonify({"data":text_to_dict})

if __name__ == '__main__':
    app.run()








# 
# //////////////////////////////////


# import os
# from PIL import Image
# from dotenv import load_dotenv
# import requests  # Import requests library here

# # api setup an
# import google.generativeai as gai
# import time
# from io import BytesIO

# def image_to_text(image_path):
  
#     # Load the environment variables from .env file
#     load_dotenv()

#     # Get the API key from the environment variables
#     api_key = os.getenv("API_KEY")

#     # Configure the API with the obtained key
#     gai.configure(api_key=api_key)

  

#     # Download the image from the URL
#     response = requests.get(image_path)
#     img = Image.open(BytesIO(response.content))

#     model = gai.GenerativeModel('gemini-pro-vision')
#     while True:
#         # prompt = input("Enter the prompt: ")
#         prompt = "collect all data available in image regarding to the how product is made up of and its quantity, give all data in json format and add one more field as key \"productType\" e.g food and name and expire data.take time and  pull maximum data. look for twice"
#         if prompt.lower() in ['exit', 'quit', 'bye']:
#             print("AI: Goodbye!")
#             time.sleep(2)
#             print("AI: See you soon!")
#             break
        
#         response = model.generate_content([prompt, img])
#         print(' ')
#         print(f"AI: {response.text}")
#         time.sleep(2)
#         print('=' * 100)


# # image_to_text('https://i.pinimg.com/736x/1b/34/dd/1b34ddbed4fe56767fae40b3444c605b.jpg')