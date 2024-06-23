import uuid

class Diatary:
    def __init__(self, allergies: str, diatary_preference: str  ):
        self.allergies= allergies,
        self.diatary_preference= diatary_preference, #(e.g., vegetarian, vegan, gluten-free) or has preferences regarding organic or non-GMO products.

class Activity:
    def __init__(self, physical_activity: str, goal: str , lifestyle_choice: str):
        self.physical_activity= physical_activity, # Level of physical activity or exercise routine, which influences caloric and nutritional needs.
        self.goal =goal,
        self.lifestyle_choice= lifestyle_choice, #Such as whether the user is trying to gain or lose weight, maintain a balanced diet, or improve overall health.

class PersonGoal:
    def __init__(self, health_goal: str, target_weight: float, target_calories: float):
        self.health_goal= health_goal, # (e.g., weight loss, muscle gain, maintenance) that may impact dietary choices and caloric needs.
        self.target_weight= target_weight,
        self.target_calories= target_calories

class PreviousExp:
    def __init__(self, nutrition_knowledge: str):
        self.nutrition_knowledge:nutrition_knowledge # Previous experience with diets or meal plans, including successes or challenges.

class Shopping_Pref:
    def __init__(self, budget: float, availablity: str):
        self.budget= budget,
        self.availability=availablity, #Budget constraints or preferences for certain types of products.,

class User:
    def __init__(self, age: int, gender: str, weight: float, height: float, medical_condition: str, diatary: Diatary,activity:Activity, person_goal: PersonGoal ,previous_exp: PreviousExp, shopping_pref: Shopping_Pref):
        self.id = uuid.uuid4()
        self.age = age #Certain products may be more suitable based on age-related dietary needs or restrictions.
        self.gender = gender  #Nutritional needs can vary between genders.
        self.weight = weight # Relevant for assessing appropriate portion sizes and nutritional requirements.
        self.height = height # Relevant for assessing appropriate portion sizes and nutritional requirements.
        self.medical_condition = medical_condition #  Allergies, intolerances, chronic conditions (e.g., diabetes, hypertension) that may impact dietary choices.
        self.diatary = diatary
        self.activity = activity
        self.person_goal = person_goal
        self.previous_exp = previous_exp
        self.shopping_pref = shopping_pref
            

user =User(age=2,gender='male', weight= 2, height= 2, medical_condition='none')
print(user.age)