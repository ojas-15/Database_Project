# Database_Project

# Dispensary Management System

The given problem statement required team to develop a web application using Flask and MySQL to manage a dispensary. The team is divided into two groups, G1 and G2, with G1 responsible for the front-end and G2 for the back-end. The application should support the dynamic execution of database functions, such as insert, rename, update, delete, (CRUD) and where clause. Additionally, the application should have a login page with user and stakeholder authentication.
To develop this application, the team was first needed to design and implement the database schema. We identified the tables and fields required to store information related to the dispensary, such as products, suppliers, employees, customers, and transactions.
Once the database schema is in place, G2 began working on the back-end development. We have used Flask to create the API endpoints that interact with the database. These endpoints should implement the required functions, such as inserting new records, updating existing records, deleting records, and executing where clause queries.
Meanwhile, G1 worked on the front-end development. They used Bootstrap, HTML, and CSS to create a user-friendly interface for the web application. The interface allows users to interact with the database by providing forms and buttons to add, update, and delete records. The interface displays the data stored in the database in a clear and organized manner.
As a part of the project, the team implemented user authentication to ensure that only authorized users can access the application. The login page should prompt users to enter their credentials, and upon successful authentication, the user should be redirected to the main page of the application.
Finally, the team tested the application to ensure that all functions are working correctly, and the changes made through the application are correctly reflected in the main database and web page. Once the application is ready, it was pushed to GitHub.
In summary, this project required the team to develop a web application using Flask and MySQL to manage a dispensary. The application supports the database functions such as insert, update, delete, rename, and where clause, and should have a login page with user authentication. The team also designed the database schema, develop the back-end using Flask, and created a user-friendly front-end using Bootstrap, HTML, and CSS. Finally, the application was be tested and pushed to GitHub for submission.




## Installation

Installation requirements:

```bash
  python3 -m venv env_flask
```
```bash
  pip3 install flask
```
```bash
  pip3 install flask-mysqldb
```
```bash
  pip3 install pyyaml
```

    
## Modules used

To run this project, you will need to add the following modules

`from flask import Flask, render_template, request, redirect, url_for, session`

`from flask_mysqldb import MySQL
`

`from sql_tools import *   `

`from html_tools import *`

`import flask`

`import yaml`

`import MySQLdb.cursors`

`import re`

Note: MySQL Server(workbench) should be installed on the PC. Dump the “dispensary.sql” in the same directory.



#### These are the major steps to launch the website:


- Move all the files in one folder. Open folder as code in VS Code.
- Create virtual environment using command “python -m venv venv”
- Activate environment using command “./venv/Scripts\activate.ps1”
- Install required libraries (mentioned above)
- Run the “app.py” file using command “python ./app.py”



#### Now after running the server you will get a login page:
![image](https://user-images.githubusercontent.com/105475941/226404419-984a5c0a-ee78-4b7d-950d-77a21bd77187.png)



