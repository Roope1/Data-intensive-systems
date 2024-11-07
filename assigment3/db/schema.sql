
/* DATABASE SCHEMA FOR ALL DATABASES */


CREATE TABLE IF NOT EXISTS "User" (
    id SERIAL PRIMARY KEY,          
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    org_id INTEGER,                 
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    --FOREIGN KEY (org_id) REFERENCES Organization(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS Organization (
    id SERIAL PRIMARY KEY,         
    name VARCHAR(255) NOT NULL,
    description VARCHAR(1024) NOT NULL,
    location VARCHAR(255) NOT NULL,
    owner_id INTEGER,               
    FOREIGN KEY (owner_id) REFERENCES "User"(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS Post (
    id SERIAL PRIMARY KEY,          
    user_id INTEGER NOT NULL,       
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    likes INTEGER DEFAULT 0,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES "User"(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Comment (
    id SERIAL PRIMARY KEY,          
    post_id INTEGER NOT NULL,       
    user_id INTEGER NOT NULL,       
    content TEXT NOT NULL,
    likes INTEGER DEFAULT 0,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES Post(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES "User"(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Announcement (
    id SERIAL PRIMARY KEY,          
    org_id INTEGER NOT NULL,        
    title VARCHAR(255) NOT NULL,
    content VARCHAR(1024) NOT NULL,
    likes INTEGER DEFAULT 0,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (org_id) REFERENCES Organization(id) ON DELETE CASCADE  
);


-- Set all serials to start at 1 to allow for easier dummy data insertion
ALTER SEQUENCE "User_id_seq" RESTART WITH 1;
ALTER SEQUENCE Organization_id_seq RESTART WITH 1;
ALTER SEQUENCE Post_id_seq RESTART WITH 1;
ALTER SEQUENCE Comment_id_seq RESTART WITH 1;
ALTER SEQUENCE Announcement_id_seq RESTART WITH 1;

