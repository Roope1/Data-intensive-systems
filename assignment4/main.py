import psycopg
import pymongo
import os
from dotenv import load_dotenv

class Seller:
    def __init__(self, name, id, origin) -> None:
        self.name = name
        self.id = id
        self.origin = origin

class Product:
    def __init__(self, id, name, price, seller_id, seller, origin) -> None:
        self.id = id
        self.name = name
        self.price = price
        self.seller_id = seller_id
        self.seller = seller
        self.origin = origin


def read_postgres_data():
    # connect to postgresdb
    with psycopg.connect(os.getenv("POSTGRES_URI")) as conn:
        with conn.cursor() as cursor:
            cursor.execute("SELECT name, id FROM Seller")
            raw_sellers = cursor.fetchall()
        with conn.cursor() as cursor:
            cursor.execute("SELECT id, name, price, seller FROM Product")
            raw_products = cursor.fetchall()

    sellers = []
    products = []

    # parse data into Seller objects
    for row in raw_sellers:
        seller = Seller(row[0], row[1], "postgres")
        sellers.append(seller)

    # parse data into Product objects
    for row in raw_products:
        # find the seller object that corresponds to the seller_id
        seller = [seller for seller in sellers if seller.id == row[3]][0]
        product = Product(row[0], row[1], row[2], row[3], seller, "postgres")
        products.append(product)

    return (sellers, products) 

def read_mongo_data():
    # connect to mongodb
    client = pymongo.MongoClient(os.getenv("MONGO_URI"))
    db = client["store"]
    mongo_sellers = db["sellers"]
    mongo_products = db["products"]

    # parse data into Seller objects
    sellers = []
    for seller in mongo_sellers.find():
        seller_obj = Seller(seller["name"], seller["_id"], "mongo")
        sellers.append(seller_obj)

    # parse data into Product objects
    products = []
    for product in mongo_products.find():
        # find the seller object that corresponds to the seller_id
        seller_obj = [seller for seller in sellers if seller.id == product["seller_id"]][0]
        product_obj = Product(product["_id"], product["name"], product["price"], product["seller_id"], seller, "mongo")
        products.append(product_obj)

    return (sellers, products)

def main():
    postgres_sellers, postgres_products = read_postgres_data()
    mongo_sellers, mongo_products = read_mongo_data()

    # combine the data
    sellers = postgres_sellers + mongo_sellers
    products = postgres_products + mongo_products

  


if __name__ == "__main__":
    load_dotenv(override=True) 
    main()