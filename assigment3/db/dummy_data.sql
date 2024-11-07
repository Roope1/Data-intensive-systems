
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
