import os
from PIL import Image
from dotenv import load_dotenv
import requests  # Import requests library here

# api setup an
import google.generativeai as gai
import time
from io import BytesIO

def image_to_text(image_path):
  
    # Load the environment variables from .env file
    load_dotenv()

    # Get the API key from the environment variables
    api_key = os.getenv("API_KEY")

    # Configure the API with the obtained key
    gai.configure(api_key=api_key)

  

    # Download the image from the URL
    response = requests.get(image_path)
    img = Image.open(BytesIO(response.content))

    model = gai.GenerativeModel('gemini-pro-vision')
   
    prompt = input("Enter the prompt: ")
    # prompt = "collect all data available in image regarding to the how product is made up of and its quantity, give all data in json format and add one more field as key \"productType\" e.g food and name and expire data.take time and  pull maximum data. look for twice"
    if prompt.lower() in ['exit', 'quit', 'bye']:
        print("AI: Goodbye!")
        time.sleep(2)
        print("AI: See you soon!")
     
        
    response = model.generate_content([prompt, img])
    print(' ')
    print(f"AI: {response.text}")
    return response
    print('=' * 100)


image_to_text('https://i.pinimg.com/736x/1b/34/dd/1b34ddbed4fe56767fae40b3444c605b.jpg')