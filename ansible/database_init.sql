CREATE DATABASE IF NOT EXISTS {{ database_name }};
USE {{ database_name }};
CREATE TABLE IF NOT EXISTS {{ table_name }} 
    (
     first_name VARCHAR(20), 
     last_name VARCHAR(30), 
     job_title VARCHAR(50),
     UNIQUE(first_name,last_name)
    );

{% for person in staff_data %}
INSERT IGNORE INTO {{ table_name }} (first_name, last_name, job_title) VALUES 
   ("{{ person.first_name }}", "{{ person.last_name }}", "{{ person.job_title }}");
{% endfor %}

