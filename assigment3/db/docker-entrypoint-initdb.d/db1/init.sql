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

/* DATA FOR DB-1*/

-- Insert dummy data for "User"
INSERT INTO "User" (name, location, org_id) VALUES
('Alice Johnson', 'New York', 1),
('Bob Smith', 'Los Angeles', 2),
('Charlie Brown', 'Chicago', 1),
('David White', 'Houston', 3),
('Eve Davis', 'San Francisco', 4),
('Frank Wilson', 'Austin', 2),
('Grace Lee', 'Seattle', 3),
('Hannah Clark', 'Boston', 4),
('Ivy Martinez', 'Miami', 1),
('Jackie Scott', 'Denver', 2);

-- Insert dummy data for organizations
INSERT INTO Organization (name, description, location, owner_id) VALUES
('TechCorp', 'Leading technology company specializing in AI solutions', 'New York', 1),
('GreenEnergy', 'A renewable energy company', 'Los Angeles', 2),
('HealthFirst', 'A health services organization', 'Chicago', 3),
('EduPro', 'An education technology startup', 'San Francisco', 4);

-- Insert dummy data for posts
INSERT INTO Post (user_id, title, content, likes) VALUES
(1, 'Exciting New AI Breakthrough', 'We just released a new AI algorithm that will revolutionize the industry!', 25),
(2, 'Green Energy Future', 'The future of renewable energy is bright. Our latest solar panel design is energy-efficient and cost-effective.', 15),
(3, 'HealthTech Innovations', 'Our latest health service platform helps clinics better manage patient records.', 10),
(4, 'EdTech Growth', 'We have developed a new online learning platform that makes education more accessible worldwide.', 18),
(5, 'AI for Good', 'We believe AI can solve some of the worlds most pressing challenges. Lets explore the potential together.', 30),
(6, 'Renewable Energy Solutions', 'Exploring the latest trends in wind and solar power.', 8),
(7, 'Revolutionizing Healthcare', 'Our platform is changing the way healthcare systems handle patient care.', 12),
(8, 'Education for All', 'Our goal is to make quality education accessible to everyone, anywhere.', 9),
(9, 'Sustainable AI Practices', 'How AI can help us build more sustainable cities and communities.', 14),
(10, 'Future of Energy Storage', 'Breakthrough in energy storage technology will make renewable energy more reliable.', 11);

-- Insert dummy data for comments
INSERT INTO Comment (post_id, user_id, content, likes) VALUES
(1, 2, 'This sounds amazing! Cant wait to see it in action.', 5),
(1, 3, 'AI is truly the future. Excited to see how it will impact industries.', 7),
(2, 4, 'This is exactly what we need to combat climate change.', 4),
(2, 5, 'Exciting stuff. Green energy is the way forward!', 3),
(3, 6, 'This platform is a game changer for health services.', 6),
(3, 7, 'Healthcare will never be the same with these innovations.', 5),
(4, 8, 'Online learning is growing at a rapid pace. Lets embrace it.', 8),
(4, 9, 'Access to quality education is key to a better future.', 10),
(5, 10, 'Great vision! Lets make AI work for humanity.', 13),
(6, 1, 'Wind power is the future. This is a step in the right direction.', 2);

-- Insert dummy data for announcements
INSERT INTO Announcement (org_id, title, content, likes) VALUES
(1, 'TechCorp Annual Conference', 'Join us for our annual conference where we will unveil our newest projects and AI advancements.', 20),
(2, 'GreenEnergy Partnership with SolarTech', 'GreenEnergy has partnered with SolarTech to further innovate in solar power technology.', 25),
(3, 'HealthFirst New Services Announcement', 'We are expanding our services to include remote patient monitoring.', 12),
(4, 'EduPro Funding Round', 'EduPro has raised a new round of funding to further expand our online learning platform.', 18),
(1, 'New AI Tool Launch', 'TechCorp is launching a new AI tool that will transform data analysis in real-time.', 40),
(2, 'GreenEnergy Expansion to Europe', 'GreenEnergy is expanding operations to Europe to bring clean energy to more people.', 22),
(3, 'HealthFirst Telemedicine Services', 'We are now offering telemedicine services to reach more patients in remote areas.', 19),
(4, 'EduPro New Learning Features', 'EduPro has added new interactive features to its online courses, enhancing the student experience.', 15),
(1, 'TechCorp CEO Interview', 'Our CEO shares insights on the future of technology and AI.', 33),
(2, 'SolarTech Technology Award', 'SolarTech has won a prestigious award for its new solar panel design.', 21);