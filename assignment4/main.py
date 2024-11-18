import psycopg
import pymongo
import os
from dotenv import load_dotenv
import enum

class Status(enum.Enum):
    UNCHANGED = 0
    CHANGED = 1
    DELETED = 2
    INSERTED = 3

class Seller:
    def __init__(self, name, id, origin) -> None:
        self.name = name
        self.id = id
        self.origin = origin
        self.status = Status.UNCHANGED

class Product:
    def __init__(self, id, name, price, seller_id, seller, origin) -> None:
        self.id = id
        self.name = name
        self.price = price
        self.seller_id = seller_id
        self.seller = seller
        self.origin = origin
        self.status = Status.UNCHANGED


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
        product_obj = Product(product["_id"], product["name"], product["price"], product["seller_id"], seller_obj, "mongo")
        products.append(product_obj)

    client.close()
    return (sellers, products)

def print_menu():
    print("1. View all sellers")
    print("2. View all products")
    print("3. View all products by seller")
    print("4. Insert new seller")
    print("5. Insert new product")
    print("6. Update product price")
    print("7. Delete product")
    print("8. Delete seller")
    print("0. Exit")
    action = input("Select an action: ")

    # check if the input is a digit and in range of the menu
    if not action.isdigit() or int(action) < 0 or int(action) > 8:
        print("Invalid input. Please enter a number from 0 to 8.")
        return print_menu() # recursively call the function until a valid input is given

    return action

def print_sellers():
    print("Sellers:")
    for seller in [seller for seller in sellers if seller.status != Status.DELETED]:
        print(f"{seller.name}")

def print_products():
    print("Products:")
    for product in [product for product in products if product.status != Status.DELETED]:
        print(f"{product.name} - ${product.price} - {product.seller.name}")

def print_products_by_seller():
    print_sellers()
    seller_name = input("Enter the name of the seller: ")
    products_by_seller = [product for product in products if product.seller.name.lower() == seller_name.lower()]
    print(f"Products by {seller_name}:")
    for product in products_by_seller:
        print(f"{product.name} - ${product.price}")

def insert_seller():
    location = input("Enter the database you want to add a seller to (1. postgres, 2. mongodb): ")
    if location == "1":
        db = "postgres"
    elif location == "2":
        db = "mongo"
    else:
        print("Invalid input. Please enter 1 or 2.")
        return insert_seller()

    name = input("Enter the name of the seller: ")
    seller = Seller(name, None, db)
    sellers.append(seller)
    seller.status = Status.INSERTED

def insert_product():
    name = input("Enter the name of the product: ")
    price = float(input("Enter the price of the product: "))
    seller_name = input("Enter the name of the seller: ")
    seller = [seller for seller in sellers if seller.name.lower() == seller_name.lower()][0]
    product = Product(None, name, price, seller.id, seller, seller.origin)
    products.append(product)
    product.status = Status.INSERTED

def update_product_price():
    name = input("Enter the name of the product: ")
    new_price = float(input("Enter the new price of the product: "))
    product = [product for product in products if product.name.lower() == name.lower()][0]
    product.price = new_price
    product.status = Status.CHANGED

def delete_product():
    name = input("Enter the name of the product: ")
    product = [product for product in products if product.name.lower() == name.lower()][0]
    product.status = Status.DELETED

def delete_seller():
    name = input("Enter the name of the seller: ")
    seller = [seller for seller in sellers if seller.name.lower() == name.lower()][0]

    # delete all products associated with the seller
    for product in products:
        if product.seller == seller:
            product.status = Status.DELETED

    seller.status = Status.DELETED

def commit_changes():

    for product in products:
        if product.status != Status.UNCHANGED:
            # Added product
            if product.status == Status.INSERTED:

                if product.origin == "postgres":
                    with psycopg.connect(os.getenv("POSTGRES_URI")) as conn:
                        with conn.cursor() as cursor:
                            cursor.execute("INSERT INTO Product (name, price, seller) VALUES (%s, %s, %s)", (product.name, product.price, product.seller.id))

                elif product.origin == "mongo":
                    client = pymongo.MongoClient(os.getenv("MONGO_URI"))
                    db = client["store"]
                    mongo_products = db["products"]
                    mongo_products.insert_one({"name": product.name, "price": product.price, "seller_id": product.seller.id})
                    client.close()

            # Changed product
            elif product.status == Status.CHANGED:

                if product.origin == "postgres":
                    with psycopg.connect(os.getenv("POSTGRES_URI")) as conn:
                        with conn.cursor() as cursor:
                            cursor.execute("UPDATE Product SET price = %s WHERE id = %s", (product.price, product.id))

                elif product.origin == "mongo":
                    client = pymongo.MongoClient(os.getenv("MONGO_URI"))
                    db = client["store"]
                    mongo_products = db["products"]
                    mongo_products.update_one({"_id": product.id}, {"$set": {"price": product.price}})
                    client.close()

            # Deleted product
            elif product.status == Status.DELETED:

                if product.origin == "postgres":
                    with psycopg.connect(os.getenv("POSTGRES_URI")) as conn:
                        with conn.cursor() as cursor:
                            cursor.execute("DELETE FROM Product WHERE id = %s", (product.id,))

                elif product.origin == "mongo":
                    client = pymongo.MongoClient(os.getenv("MONGO_URI"))
                    db = client["store"]
                    mongo_products = db["products"]
                    mongo_products.delete_one({"_id": product.id})
                    client.close()

    for seller in sellers:
        if seller.status != Status.UNCHANGED:
            # Added seller
            if seller.status == Status.INSERTED:

                if seller.origin == "postgres":
                    with psycopg.connect(os.getenv("POSTGRES_URI")) as conn:
                        with conn.cursor() as cursor:
                            cursor.execute("INSERT INTO Seller (name) VALUES (%s)", (seller.name,))

                elif seller.origin == "mongo":
                    client = pymongo.MongoClient(os.getenv("MONGO_URI"))
                    db = client["store"]
                    mongo_sellers = db["sellers"]
                    mongo_sellers.insert_one({"name": seller.name})
                    client.close()

            # Deleted seller        
            elif seller.status == Status.DELETED:

                if seller.origin == "postgres":
                    with psycopg.connect(os.getenv("POSTGRES_URI")) as conn:
                        with conn.cursor() as cursor:
                            cursor.execute("DELETE FROM Seller WHERE id = %s", (seller.id,))

                elif seller.origin == "mongo":
                    client = pymongo.MongoClient(os.getenv("MONGO_URI"))
                    db = client["store"]
                    mongo_sellers = db["sellers"]
                    mongo_sellers.delete_one({"_id": seller.id})
                    client.close()

    
def main():
    postgres_sellers, postgres_products = read_postgres_data()
    mongo_sellers, mongo_products = read_mongo_data()

    # combine the data
    global sellers, products
    sellers = postgres_sellers + mongo_sellers
    products = postgres_products + mongo_products
    while True:
        action = print_menu() 
        if action == "0":
            commit_changes() 
            return
        elif action == "1":
            print_sellers()
        elif action == "2":
            print_products()
        elif action == "3":
            print_products_by_seller()
        elif action == "4":
            insert_seller()
        elif action == "5":
            insert_product()
        elif action == "6":
            update_product_price()
        elif action == "7":
            delete_product()
        elif action == "8":
            delete_seller()


if __name__ == "__main__":
    load_dotenv(override=True) 
    main()