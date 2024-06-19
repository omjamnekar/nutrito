import os
from PIL import Image
from dotenv import load_dotenv
import requests

# api setup an
import google.generativeai as gai
import time
from io import BytesIO
model = gai.GenerativeModel('gemini-pro-vision')
   

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

    # prompt = input("Enter the prompt: ")
    prompt = """
    Collect all data available in the image regarding the product composition and its quantities. Provide the data in JSON format with the following consistent keys:
    - "productType": (e.g., food)
    - "isAddictive": a ratio of 1 to 10
    - "name": the name of the product
    - "expiryDate": the expiry date of the product
    - "ingredients": a list of ingredients and their quantities
    - "nutritionalInformation": a dictionary with keys as nutritional components and values as the quantity of each component
    - "manufacturer": details about the company or brand that produced the product
    - "allergenInformation": any potential allergens contained in the product
    - "dietaryInformation": information relevant to specific diets (e.g., vegan, gluten-free, keto)
    - "servingSize": the recommended serving size for the product
    - "storageInstructions": instructions on how to properly store the product
    - "usageInstructions": how to use or prepare the product
    - "countryOfOrigin": the country where the product was manufactured
    - "certifications": any certifications or labels (e.g., organic, non-GMO)
    - "barcode": the product's barcode or Universal Product Code
    Take the time to pull the maximum amount of data. Ensure that the keys remain consistent in subsequent runs to prevent inconsistencies.
    """


    if prompt.lower() in ['exit', 'quit', 'bye']:
        print("AI: Goodbye!")
        time.sleep(2)
        print("AI: See you soon!")
     
        
    response = model.generate_content([prompt, img])
    # print(' ')
    # return response
    # print('=' * 100)

    # prompt = 'i have data of product,what if i give you this data make Nutritional Analysis and tell you to analys this data and tell me if is it healthy to eat. i need your response in json format where keys like "Ingredient Analysis","Health Considerations" of all ingredients is positive and negative for only in Health Considerations, "Nutritional Analysis","Conclusion" etc' + response.text
    prompt = '''
    I have data for a product, and I need a nutritional analysis of this data to determine if it is healthy to eat. Please analyze this data and provide a detailed response in JSON format. The JSON structure should include the following keys:
    - Ingredient Analysis: Provide an analysis of each ingredient used in the product.
    - Nutritional Analysis: Summarize the nutritional content of the product, For each nutrient, include a feedback ratio from 1 to 10 indicating how good the nutrient content is.
    - Health Considerations: List the positive and negative health considerations for each ingredient.
    - Positive: Benefits or positive health impacts of the ingredient.
    - Negative: Potential risks or negative health impacts of the ingredient.
    - Conclusion: Based on the analysis, provide a conclusion on whether the product is healthy to eat, including any recommendations or considerations.
    - overallHealthRating: Provide an overall health rating for the product based on the analysis.
    - recommendations: Any recommendations for consuming the product or alternatives.
    - servingSize: The recommended serving size for the product.
    - allergenInformation: Any allergens present in the product.
             '''

    response = model.generate_content([prompt, img])
    # print(' ')
    # print(f"DETAIL: {response.text}")
    # print(response.text)
    # print('=' * 100)



image_to_text('https://i.pinimg.com/736x/1b/34/dd/1b34ddbed4fe56767fae40b3444c605b.jpg')
#image_to_text('https://m.media-amazon.com/images/I/81iTeA3lETL._AC_UF1000,1000_QL80_.jpg')