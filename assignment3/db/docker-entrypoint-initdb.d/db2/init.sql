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

/** DATA FOR DB-2 **/
-- Insert additional dummy data for "User" (IDs starting from 1 again)
INSERT INTO "User" (name, location, org_id) VALUES
('Aiden Foster', 'Los Angeles', 1),
('Bianca Wallace', 'Dallas', 2),
('Chloe Hughes', 'Chicago', 3),
('Dylan Perez', 'New York', 4),
('Emma Wright', 'San Francisco', 1),
('Felix Bell', 'Miami', 2),
('Grace Simmons', 'Austin', 3),
('Hank Morris', 'Denver', 4),
('Iris Ross', 'Seattle', 1),
('Jack Harper', 'Boston', 2);

-- Insert additional dummy data for organizations (IDs starting from 1 again)
INSERT INTO Organization (name, description, location, owner_id) VALUES
('SolarTech Innovations', 'A solar power company focusing on affordable clean energy solutions', 'Los Angeles', 1),
('DataVision', 'A cutting-edge data visualization and business intelligence platform', 'Dallas', 2),
('BioHealth Solutions', 'A biotech company developing solutions for global health challenges', 'Chicago', 3),
('EduWorld', 'An educational non-profit providing resources to schools worldwide', 'New York', 4);

-- Insert additional dummy data for posts (IDs starting from 1 again)
INSERT INTO Post (user_id, title, content, likes) VALUES
(1, 'Solar Energy for All', 'We aim to make solar energy affordable and accessible to every household.', 30),
(2, 'The Future of Data Visualization', 'Data visualization is transforming how businesses make decisions. We are at the forefront of this revolution.', 25),
(3, 'Biotech Innovations in Medicine', 'Our new biotech innovation will help reduce the spread of infectious diseases globally.', 35),
(4, 'Digital Learning Resources', 'EduWorld has launched a platform offering free digital learning tools to students in underprivileged areas.', 40),
(5, 'Affordable Solar Panels', 'We have developed a new line of low-cost solar panels aimed at improving energy access.', 22),
(6, 'Empowering Businesses with Data', 'Our platform is helping businesses unlock insights from data with stunning visuals and dashboards.', 18),
(7, 'Biotech for Better Healthcare', 'We’re proud to announce a new breakthrough in biotechnology that will change healthcare for the better.', 28),
(8, 'Revolutionizing Education Access', 'EduWorld’s mission is to provide all students with equal access to educational resources.', 23),
(9, 'Clean Energy and Sustainability', 'Our goal is to revolutionize the clean energy market and help reduce the carbon footprint.', 31),
(10, 'The Power of Data Analytics', 'Data analytics is essential for business growth. We provide companies with actionable insights.', 19);

-- Insert additional dummy data for comments (IDs starting from 1 again)
INSERT INTO Comment (post_id, user_id, content, likes) VALUES
(1, 2, 'This is such an important initiative. Solar energy is the future!', 8),
(2, 3, 'Data visualization is key to making complex data accessible and actionable.', 7),
(3, 4, 'Biotech can truly change the world. This is a step in the right direction.', 10),
(4, 5, 'Free learning resources are critical to leveling the playing field in education.', 12),
(5, 6, 'Affordable solar energy could solve a lot of global energy problems.', 9),
(6, 7, 'Data insights are transforming businesses, and your platform is doing a fantastic job!', 6),
(7, 8, 'Biotech for better healthcare is always something worth supporting. Keep it up!', 11),
(8, 9, 'We need more platforms like this to ensure every student has access to quality education.', 15),
(9, 10, 'Clean energy is the only way forward. Let’s make it accessible to everyone.', 14),
(10, 1, 'Data analytics is a game-changer. It has huge potential for businesses.', 8);

-- Insert additional dummy data for announcements (IDs starting from 1 again)
INSERT INTO Announcement (org_id, title, content, likes) VALUES
(1, 'SolarTech New Product Launch', 'We are excited to announce the launch of our new, affordable solar panel line.', 50),
(2, 'DataVision Expands Product Suite', 'We have expanded our platform to include new data visualization tools for businesses of all sizes.', 40),
(3, 'BioHealth New Healthcare Solutions', 'BioHealth has developed a new solution to fight the spread of infectious diseases worldwide.', 60),
(4, 'EduWorld Partners with Schools', 'EduWorld has partnered with local schools to bring digital learning tools to underserved communities.', 45),
(1, 'SolarTech Community Outreach Program', 'We are launching a community program to install solar panels in underserved neighborhoods.', 35),
(2, 'DataVision Joins Industry Leaders', 'DataVision has partnered with leading companies to integrate our tools with industry-leading platforms.', 33),
(3, 'BioHealth Opens New Research Facility', 'We are opening a new research facility to advance our work in biotechnology and global health.', 48),
(4, 'EduWorld Wins Education Award', 'EduWorld has been awarded for our commitment to improving education worldwide.', 55),
(1, 'SolarTech Wins Sustainability Award', 'SolarTech is proud to announce that we have received a sustainability award for our contributions to clean energy.', 60),
(2, 'DataVision’s Annual Data Conference', 'Join us for the DataVision annual conference where we’ll discuss the future of data visualization and analytics.', 38);