from typing import Dict, List
import json

class RatioSpecified:

    def __init__(self,
                 ingredient_analysis: List[Dict[str, str]] = [],
                 nutritional_content: Dict[str, float] = {},
                 health_considerations: List[Dict[str, str]] = [],
                ):
        self.ingredient_analysis = ingredient_analysis
        self.nutritional_content = nutritional_content
        self.health_considerations = health_considerations
   
    
    def to_json(self) -> str:
        """
        Convert object attributes to a JSON string.
        """
        return json.dumps({
            "ingredient_analysis": self.ingredient_analysis,
            "nutritional_content": self.nutritional_content,
            "health_considerations": self.health_considerations,
        })

    @classmethod
    def from_json(cls, json_str: str) -> 'RatioSpecified':
        """
        Create an instance of RatioSpecified from a JSON string.
        """
        json_data = json.loads(json_str)
        return cls(
            ingredient_analysis=json_data.get("ingredientAnalysis", []),
            nutritional_content=json_data.get("nutritionalAnalysis", {}),
            health_considerations=json_data.get("healthConsiderations", []),
           
        )
    

class ConclusionData:
    def __init__(self,
                 conclusion: str = "",
                 overall_health_rating: int = 0,
                 recommendations: str = "",
                 serving_size: str = "",
                 allergen_information: List[str] = []
                 ):
        self.conclusion = conclusion
        self.overall_health_rating = overall_health_rating
        self.recommendations = recommendations
        self.serving_size = serving_size
        self.allergen_information = allergen_information

    def to_json(self) -> str:

        return json.dumps({
            "positive_impacts": self.positive_impacts,
            "negative_impacts": self.negative_impacts,
            "conclusion": self.conclusion,
            "overall_health_rating": self.overall_health_rating,
            "recommendations": self.recommendations,
            "serving_size": self.serving_size,
            "allergen_information": self.allergen_information
        })
    
    @classmethod
    def from_json(cls, json_str: str) -> 'RatioSpecified':
        json_data = json.loads(json_str)
        return cls(
            ingredient_analysis=json_data.get("ingredientAnalysis", []),
            nutritional_content=json_data.get("nutritionalAnalysis", {}),
            health_considerations=json_data.get("healthConsiderations", []),
            positive_impacts=json_data.get("positive", ""),
            negative_impacts=json_data.get("negative", ""),
            conclusion=json_data.get("conclusion", ""),
            overall_health_rating=json_data.get("overallHealthRating", 0),
            recommendations=json_data.get("recommendations", ""),
            serving_size=json_data.get("servingSize", ""),
            allergen_information=json_data.get("allergenInformation", [])
        )

    