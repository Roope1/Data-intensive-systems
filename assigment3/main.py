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
    print('\nMenu:')
    print('\t1. Switch database')
    print('\t2. List all users')
    print('\t3. Get all posts by a user')
    print('\t4. Get all comments of a post')
    print('\t5. Get all members of an organization')
    print('\t6. Get all posts of an organization')
    print('\t0. Exit')
    print()

    # print current database in front of the prompt to indicate which database is the user currently connected to
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
    """
        Connects to a database based on the value of CURRENT_DB
    """
    try:
        conn = psycopg.connect(os.getenv(f'CONN_STR_{CURRENT_DB.value}'))
        return conn
    except psycopg.Error as e:
        print(f"Could not connect to database {CURRENT_DB}: {e}")
        exit(1)
        
def list_all_users(conn: psycopg.connection) -> None:
    """
        List all users in the selected database
    """

    cur = conn.cursor()
    cur.execute('SELECT id, name FROM "User";')
    users = cur.fetchall()
    cur.close()
    print("\nUSERS:\n\tID   | NAME")
    for user in users:
        print(f"\t{user[0]:<4} | {user[1]:<20}")
    print()

def get_posts_by_user(conn: psycopg.connection) -> None :
    """
        Get all posts by a user
    """
    user_id = input('Enter the user ID: ')

    # check if the input is a valid number
    if not user_id.isdigit():
        print('Invalid input. Please try again.')
        return get_posts_by_user(conn)

    cur = conn.cursor()
    cur.execute('SELECT id, title, content FROM Post WHERE user_id = %s;', (int(user_id), ))
    posts = cur.fetchall()  
    cur.close()
    for post in posts:
        print(f"{post[0]:<4} | {post[1]:<35} | {post[2]:<100}")
    return None
    

def get_comments_of_post(conn: psycopg.connection) -> None:
    """
        Get all comments of a post by post ID
    """
    post_id = input('Enter the post ID: ')

    # check if the input is a valid number
    if not post_id.isdigit():
        print('Invalid input. Please try again.')
        return get_comments_of_post(conn)

    cur = conn.cursor()
    cur.execute('SELECT u.name, c.content FROM Comment c JOIN "User" u ON u.id = c.user_id WHERE c.post_id = %s;', (int(post_id), ))
    comments = cur.fetchall()
    cur.close()
    print("\nUSER            | COMMENT")
    for comment in comments:
        print(f"{comment[0]:<15} | {comment[1]:<100}")
    return None


def get_org_members(conn: psycopg.connection) -> None:
    """
        Get all members of an organization by organization ID
    """
    org_id = input('Enter the organization ID: ')

    # check if the input is a valid number
    if not org_id.isdigit():
        print('Invalid input. Please try again.')
        return get_org_members(conn)

    cur = conn.cursor()
    cur.execute('SELECT u.name, o.name FROM "User" u JOIN organization o ON o.id = %s WHERE u.org_id = %s;', (int(org_id), int(org_id), ))
    members = cur.fetchall()
    cur.close()
    print(f"\nMembers of {members[0][1]}:")
    for member in members:
        print(member[0])
    return None

def get_org_announcements(conn: psycopg.connection) -> None:
    """
        Get all announcements of an organization by organization ID
    """
    org_id = input('Enter the organization ID: ')

    # check if the input is a valid number
    if not org_id.isdigit():
        print('Invalid input. Please try again.')
        return get_org_announcements(conn)

    cur = conn.cursor()
    cur.execute('SELECT o.name, a.title, a.content FROM organization o JOIN announcement a ON a.org_id = %s WHERE o.id = %s;', (int(org_id), int(org_id), ))    
    announcements = cur.fetchall()
    cur.close()
    print(f"\nAnnouncements of {announcements[0][0]}:")
    for announcement in announcements:
        print(f"{announcement[1]:<40} | {announcement[2]}")
    return None


def main() -> None:
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
                conn.close()
                conn = connect_to_db()
            elif action == 2:   # list all users
                list_all_users(conn)                
            elif action == 3:   # get all posts by a user
                get_posts_by_user(conn)
            elif action == 4:   # get all comments of a post
                get_comments_of_post(conn) 
            elif action == 5:   # get all members of an organization
                get_org_members(conn)
            elif action == 6:   # get all posts of an organization
                get_org_announcements(conn)
            else:
                exit(1)
        break
    return None 


if __name__ == '__main__':
    load_dotenv(override=True)
    main()