class Prompts:
    _initialJSONdataFramePrompt ="""
        Collect all data available in the image regarding the product composition and its quantities. Provide the data in JSON format with the following consistent keys but dont write anything other then format not even ```JSON ```:
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
    
    _ratioSpecifiedPrompt = '''
    I have data for a product, and I need a nutritional analysis of this data to determine if it is healthy to eat. Provide the data in JSON format with the following consistent keys and dont write anything other then format not even ```JSON ```:
    - ingredient Analysis: Provide an analysis of each ingredient used in the product.
    - nutritional Analysis: Summarize the nutritional content of the product, For each nutrient, include a feedback ratio from 1 to 10 indicating how good the nutrient content is.
             '''
    _otherPrompt = '''
    Collect all data available in the image regarding the product composition and its quantities. Provide the data in JSON format with the following consistent keys: dont write anything other then format not even ```JSON ```
    - overallHealthRating: Provide an overall health rating for the product based on the analysis in number from 1 to 10.
    - recommendations: Any recommendations for consuming the product or alternatives.
    - servingSize: The recommended serving size for the product.
    - allergenInformation: Any allergens present in the product.
    - conclusion: Based on the analysis, provide a conclusion on whether the product is healthy to eat, including any recommendations or considerations.
    '''

    _healthPrompt = '''
     Collect all data available in the image regarding the product composition and its quantities. Provide the data in JSON format with the following consistent keys: but dont write anything other then format not even ```JSON ```
    - health Considerations: List the positive and negative health considerations for each ingredient.
    - positive: Benefits or positive health impacts of the ingredient.
    - negative: Potential risks or negative health impacts of the ingredient.
    '''
    @property
    def initialJSONdataFramePrompt(self):
        return self._initialJSONdataFramePrompt
    @property
    def ratioSpecifiedPrompt(self):
        return self._ratioSpecifiedPrompt
    @property
    def otherPrompt(self):
        return self._otherPrompt
    @property
    def healthPrompt(self):
        return self._healthPrompt
