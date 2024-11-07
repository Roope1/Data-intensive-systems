from dotenv import load_dotenv
import os
import psycopg
from enum import Enum

class DB(Enum):
    EUROPE = 1
    ASIA = 2
    US = 3

def switch_db() -> DB:
    input_db = input('Enter the database you want to connect to (1: europe, 2: asia, 3: us): ')
    if input_db == '1':
        return DB.EUROPE
    elif input_db == '2':
        return DB.ASIA
    elif input_db == '3':
        return DB.US
    else:
        print('Invalid input. Please try again.')
        return switch_db()

def print_action_menu() -> int:
    print('1. Switch database')
    print('2. List all users')
    print('3. Get all posts by a user')
    print('4. Get all comments of a post')
    print('5. Get all members of an organization')
    print('6. Get all posts of an organization')
    print('0. Exit')

    # print current database in front of the prompt to indicate which database is currently connected
    action = input(f'{CURRENT_DB.name} | Enter the action you want to perform: ')

    # check if the input is a valid number
    if not action.isdigit():
        print('Invalid input. Please try again.')
        return print_action_menu()
    # check if input is within the range of the menu
    elif int(action) < 0 or int(action) > 6:
        print('Invalid input. Please try again.')
        return print_action_menu()
    else:
        return int(action)

def connect_to_db() -> psycopg.connection:
    try:
        conn = psycopg.connect(os.getenv(f'CONN_STR_{CURRENT_DB.value}'))
        return conn
    except psycopg.Error as e:
        print(f"Could not connect to database {CURRENT_DB}: {e}")
        exit(1)
        


def main():
    global CURRENT_DB
    CURRENT_DB = switch_db()

    while True:
        # Connect to the database
        conn = connect_to_db()
        while True:
            action = print_action_menu()
            if action == 0: # exit
                conn.close()
                break
            elif action == 1:
                CURRENT_DB = switch_db()
                conn = connect_to_db()
            elif action >= 2:
                pass

           # with conn.cursor() as cur:
                ## Do something with the database
                #cur.execute('SELECT * FROM "User"')
                #users = cur.fetchall()
                #print(users)
        break
        

if __name__ == '__main__':
    load_dotenv(override=True)
    main()