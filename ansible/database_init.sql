CREATE DATABASE IF NOT EXISTS {{ database_name }};
USE {{ database_name }};
CREATE TABLE IF NOT EXISTS {{ table_name }} 
    (
     first_name VARCHAR(20), 
     last_name VARCHAR(30), 
     UNIQUE(first_name,last_name)
    );
INSERT IGNORE INTO staff_info (first_name, last_name) VALUES 
    ('Matt','Davis'), 
    ('Molly','Rowe'),
    ('Ben','Ashby');

