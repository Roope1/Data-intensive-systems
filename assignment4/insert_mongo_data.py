import pymongo
from dotenv import load_dotenv
import os

def main():
    # connect to mongodb
    client = pymongo.MongoClient(os.getenv("MONGO_URI"))
    db = client["store"]
    sellers = db["sellers"]
    products = db["products"]

    # insert dummy sellers
    sellers.insert_many([
        {"name": "Amazon"},
        {"name": "eBay"},
        {"name": "Walmart"}
    ])

    # insert dummy products
    products.insert_many([
        {"name": "Echo Dot", "price": 39.99, "seller_id": sellers.find_one({"name": "Amazon"})["_id"]},
        {"name": "iPhone 13", "price": 699.99, "seller_id": sellers.find_one({"name": "eBay"})["_id"]},
        {"name": "PlayStation 5", "price": 499.99, "seller_id": sellers.find_one({"name": "Walmart"})["_id"]},
        {"name": "Gaming Chair", "price": 199.99, "seller_id": sellers.find_one({"name": "Amazon"})["_id"]},
        {"name": "MacBook Pro", "price": 1299.99, "seller_id": sellers.find_one({"name": "eBay"})["_id"]},
        {"name": "Nintendo Switch", "price": 299.99, "seller_id": sellers.find_one({"name": "Walmart"})["_id"]}
    ])

    

if __name__ == "__main__":
    load_dotenv(override=True)
    main()