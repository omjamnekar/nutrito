import json
from typing import List, Dict

class InitialData:
    def __init__(self,
                 product_type: str,
                 is_addictive: float,
                 name: str,
                 expiry_date: str,
                 ingredients: List[Dict[str, str]],
                 nutritional_information: Dict[str, float],
                 manufacturer: str,
                 allergen_information: List[str],
                 dietary_information: List[str],
                 serving_size: str,
                 storage_instructions: str,
                 usage_instructions: str,
                 country_of_origin: str,
                 certifications: List[str],
                 barcode: str):
        self.product_type = product_type
        self.is_addictive = is_addictive
        self.name = name
        self.expiry_date = expiry_date
        self.ingredients = ingredients
        self.nutritional_information = nutritional_information
        self.manufacturer = manufacturer
        self.allergen_information = allergen_information
        self.dietary_information = dietary_information
        self.serving_size = serving_size
        self.storage_instructions = storage_instructions
        self.usage_instructions = usage_instructions
        self.country_of_origin = country_of_origin
        self.certifications = certifications
        self.barcode = barcode


    def to_json(self) -> str:
        """
        Convert object attributes to a JSON string.
        """
        return json.dumps({
            "product_type": self.product_type,
            "is_addictive": self.is_addictive,
            "name": self.name,
            "expiry_date": self.expiry_date,
            "ingredients": self.ingredients,
            "nutritional_information": self.nutritional_information,
            "manufacturer": self.manufacturer,
            "allergen_information": self.allergen_information,
            "dietary_information": self.dietary_information,
            "serving_size": self.serving_size,
            "storage_instructions": self.storage_instructions,
            "usage_instructions": self.usage_instructions,
            "country_of_origin": self.country_of_origin,
            "certifications": self.certifications,
            "barcode": self.barcode
        })

    @classmethod
    def from_json(cls, json_str: str) -> 'InitialData':
        """
        Create an instance of InitialData from a JSON string.
        """
        json_data = json.loads(json_str)
        return cls(
            product_type=json_data["productType"],
            is_addictive=json_data["isAddictive"],
            name=json_data["name"],
            expiry_date=json_data["expiryDate"],
            ingredients=json_data["ingredients"],
            nutritional_information=json_data["nutritionalInformation"],
            manufacturer=json_data["manufacturer"],
            allergen_information=json_data["allergenInformation"],
            dietary_information=json_data["dietaryInformation"],
            serving_size=json_data["servingSize"],
            storage_instructions=json_data["storageInstructions"],
            usage_instructions=json_data["usageInstructions"],
            country_of_origin=json_data["countryOfOrigin"],
            certifications=json_data["certifications"],
            barcode=json_data["barcode"]
        )
