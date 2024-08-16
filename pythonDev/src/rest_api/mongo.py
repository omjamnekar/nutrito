from pymongo import MongoClient

# Initialize MongoDB client
client = MongoClient("mongodb://localhost:27017/")
db = client["nutrito"]  # Replace with your database name
collection = db["sample_collection"]  # Replace with your collection name

def get_user(username):
    """Fetch user from MongoDB by username."""
    
    return collection.find_one({"username": username})

def validate_user(username, password):
    """Validate user credentials."""
    user = get_user(username)
    if user and user['password'] == password:
        return True
    return False
