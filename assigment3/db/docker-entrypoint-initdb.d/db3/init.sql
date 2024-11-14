CREATE TABLE IF NOT EXISTS "User" (
    id SERIAL PRIMARY KEY,          
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    org_id INTEGER,                 
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    --FOREIGN KEY (org_id) REFERENCES Organization(id) ON DELETE SET NULL
) PARTITION BY HASH (id);

CREATE TABLE IF NOT EXISTS UserPart1 PARTITION OF "User"
    FOR VALUES WITH (MODULUS 2, REMAINDER 0); 

CREATE TABLE IF NOT EXISTS UserPart2 PARTITION OF "User"
    FOR VALUES WITH (MODULUS 2, REMAINDER 1); 

CREATE TABLE IF NOT EXISTS Organization (
    id SERIAL PRIMARY KEY,         
    name VARCHAR(255) NOT NULL,
    description VARCHAR(1024) NOT NULL,
    location VARCHAR(255) NOT NULL,
    owner_id INTEGER,               
    FOREIGN KEY (owner_id) REFERENCES "User"(id) ON DELETE SET NULL
) PARTITION BY HASH(id);

CREATE TABLE IF NOT EXISTS OrganizationPart1 PARTITION OF Organization
    FOR VALUES WITH (MODULUS 2, REMAINDER 0);

CREATE TABLE IF NOT EXISTS OrganizationPart2 PARTITION OF Organization
    FOR VALUES WITH (MODULUS 2, REMAINDER 1);

CREATE TABLE IF NOT EXISTS Post (
    id SERIAL PRIMARY KEY,          
    user_id INTEGER NOT NULL,       
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    likes INTEGER DEFAULT 0,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES "User"(id) ON DELETE CASCADE
) PARTITION BY HASH(id);

CREATE TABLE IF NOT EXISTS PostPart1 PARTITION OF Post
    FOR VALUES WITH (MODULUS 2, REMAINDER 0);

CREATE TABLE IF NOT EXISTS PostPart2 PARTITION OF Post
    FOR VALUES WITH (MODULUS 2, REMAINDER 1);

CREATE TABLE IF NOT EXISTS Comment (
    id SERIAL PRIMARY KEY,          
    post_id INTEGER NOT NULL,       
    user_id INTEGER NOT NULL,       
    content TEXT NOT NULL,
    likes INTEGER DEFAULT 0,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES Post(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES "User"(id) ON DELETE CASCADE
) PARTITION BY HASH(id);

CREATE TABLE IF NOT EXISTS CommentPart1 PARTITION OF Comment
    FOR VALUES WITH (MODULUS 2, REMAINDER 0);

CREATE TABLE IF NOT EXISTS CommentPart2 PARTITION OF Comment
    FOR VALUES WITH (MODULUS 2, REMAINDER 1);


CREATE TABLE IF NOT EXISTS Announcement (
    id SERIAL PRIMARY KEY,          
    org_id INTEGER NOT NULL,        
    title VARCHAR(255) NOT NULL,
    content VARCHAR(1024) NOT NULL,
    likes INTEGER DEFAULT 0,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (org_id) REFERENCES Organization(id) ON DELETE CASCADE  
) PARTITION BY HASH(id);

CREATE TABLE IF NOT EXISTS AnnouncementPart1 PARTITION OF Announcement
    FOR VALUES WITH (MODULUS 2, REMAINDER 0);

CREATE TABLE IF NOT EXISTS AnnouncementPart2 PARTITION OF Announcement
    FOR VALUES WITH (MODULUS 2, REMAINDER 1);


-- Set all serials to start at 1 to allow for easier dummy data insertion
ALTER SEQUENCE "User_id_seq" RESTART WITH 1;
ALTER SEQUENCE Organization_id_seq RESTART WITH 1;
ALTER SEQUENCE Post_id_seq RESTART WITH 1;
ALTER SEQUENCE Comment_id_seq RESTART WITH 1;
ALTER SEQUENCE Announcement_id_seq RESTART WITH 1;

/** DATA FOR DB-3 **/
-- Insert additional dummy data for "User" (IDs starting from 1 again)
INSERT INTO "User" (name, location, org_id) VALUES
('Liam Foster', 'San Diego', 1),
('Maya Johnson', 'Houston', 2),
('Noah Clark', 'Orlando', 3),
('Olivia Walker', 'Chicago', 4),
('Parker Lewis', 'Charlotte', 1),
('Quinn Davis', 'Nashville', 2),
('Riley Robinson', 'Las Vegas', 3),
('Sophia Evans', 'Portland', 4),
('Tyler Scott', 'Dallas', 1),
('Uma Harris', 'Detroit', 2);

-- Insert additional dummy data for organizations (IDs starting from 1 again)
INSERT INTO Organization (name, description, location, owner_id) VALUES
('GreenSolutions', 'A company focused on providing sustainable solutions to reduce environmental impact', 'San Diego', 1),
('TechHub', 'A tech startup incubator helping entrepreneurs turn ideas into reality', 'Houston', 2),
('HealthGen', 'A health tech company focused on genetic research for personalized medicine', 'Orlando', 3),
('WorldLearn', 'An educational technology company providing digital tools for schools', 'Chicago', 4);

-- Insert additional dummy data for posts (IDs starting from 1 again)
INSERT INTO Post (user_id, title, content, likes) VALUES
(1, 'Clean Energy for a Sustainable Future', 'GreenSolutions is pushing the envelope in renewable energy technology to power the future sustainably.', 40),
(2, 'Tech Startup Challenges', 'Starting a business in the tech world is challenging, but the rewards are worth it. Here’s how we do it.', 30),
(3, 'The Future of Genetic Medicine', 'HealthGen is leading the way in genetic research to create personalized treatments for common diseases.', 50),
(4, 'Building the Future of Education', 'WorldLearn is creating a new wave of digital tools that will empower students and teachers alike.', 60),
(5, 'Solar Panels for Urban Environments', 'How we are bringing solar panel technology to the urban landscape for a cleaner tomorrow.', 35),
(6, 'Tech Innovations in Education', 'Technology is revolutionizing the education sector. Here’s how we’re contributing to this shift.', 28),
(7, 'Genomic Medicine and Its Potential', 'Genetic research holds the key to developing personalized medicine that could change healthcare forever.', 45),
(8, 'Digital Tools for Schooling in Remote Areas', 'WorldLearn is focused on bringing digital education tools to underserved and remote areas.', 33),
(9, 'The Role of Solar in Green Building Design', 'GreenSolutions is integrating solar technology into green building design to create energy-efficient homes.', 22),
(10, 'TechHub’s Role in Scaling Startups', 'TechHub has helped launch hundreds of startups. Learn about our process and how we support entrepreneurs.', 18);

-- Insert additional dummy data for comments (IDs starting from 1 again)
INSERT INTO Comment (post_id, user_id, content, likes) VALUES
(1, 2, 'This is exactly what the world needs. Clean energy will help preserve the planet for future generations.', 12),
(2, 3, 'I agree. Starting a tech company is tough, but the potential to change the world is worth it.', 8),
(3, 4, 'This is fascinating! Personalized genetic medicine could eliminate so many healthcare issues.', 20),
(4, 5, 'I love the focus on digital tools for education. Its great that technology is being leveraged for learning.', 15),
(5, 6, 'Solar technology can definitely revolutionize urban environments. Exciting stuff!', 10),
(6, 7, 'Education tech is booming, and Im excited to see how it will continue to innovate.', 9),
(7, 8, 'Genomic medicine will change healthcare forever. This is one of the most exciting breakthroughs of our time.', 18),
(8, 9, 'Digital education tools in remote areas is such a great initiative. It can really change lives.', 13),
(9, 10, 'Solar energy is key to green buildings. Its amazing how it can make homes more energy-efficient.', 6),
(10, 1, 'Tech startups need more support. What TechHub is doing is really inspiring for aspiring entrepreneurs.', 7);

-- Insert additional dummy data for announcements (IDs starting from 1 again)
INSERT INTO Announcement (org_id, title, content, likes) VALUES
(1, 'GreenSolutions Expansion', 'GreenSolutions is expanding its operations into new cities, bringing sustainable energy solutions nationwide.', 55),
(2, 'TechHub Launches New Incubator Program', 'We are excited to launch a new incubator program for budding tech startups in Houston.', 60),
(3, 'HealthGen Breakthrough in Genetic Research', 'HealthGen has made a major breakthrough in genetic research that could change personalized medicine forever.', 65),
(4, 'WorldLearn Launches New Tools for Remote Classrooms', 'WorldLearn has launched new digital tools that will help remote classrooms stay connected and engaged with the curriculum.', 50),
(1, 'GreenSolutions Wins Sustainability Award', 'We are proud to announce that GreenSolutions has won a prestigious sustainability award for our efforts in clean energy.', 60),
(2, 'TechHub Collaborates with Global Investors', 'TechHub has formed new partnerships with global investors to help scale our startup programs.', 45),
(3, 'HealthGen Opens New Genomic Research Center', 'HealthGen is proud to announce the opening of a new center dedicated to advancing genomic medicine.', 70),
(4, 'WorldLearn Hosts Education Conference', 'Join us for the WorldLearn annual conference where we discuss the future of education and technology.', 55),
(1, 'GreenSolutions Partners with EcoTech', 'GreenSolutions is partnering with EcoTech to integrate new green technology solutions into our renewable energy offerings.', 45),
(2, 'TechHub Hosts Startup Pitch Day', 'TechHub will be hosting a pitch day where entrepreneurs will present their ideas to a panel of investors.', 40);
