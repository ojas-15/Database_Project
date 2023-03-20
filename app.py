from flask import Flask, render_template, request, redirect, url_for, session
from flask_mysqldb import MySQL
from sql_tools import *
from html_tools import *

import flask
import yaml
import MySQLdb.cursors
import re

app = Flask(__name__)
app.debug = True

app.secret_key = 'your_secret_key'

# Enter your mysql connection details here
app.config['MYSQL_HOST'] = '127.0.0.1'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'justanother_msd'
app.config['MYSQL_DB'] = 'dms'

# Intialize MySQL

mysql = MySQL(app)

# first
@app.route('/', methods=['GET', 'POST'])
def login():
    msg = ''
    if request.method == 'POST' and 'useremail' in request.form and 'password' in request.form and 'authority' in request.form:
        useremail = request.form['useremail']
        password = request.form['password']
        authority = request.form['authority']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        if (authority == "patient"): 
            cursor.execute('SELECT * FROM users WHERE email = % s AND password = % s AND role=%s', (useremail, password,"patient",))
            account = cursor.fetchone()
            if account:
                session['bool'] = True
                session['email'] = account['email'] # here, match emails
                msg = 'Logged in successfully!'
                flask.flash(msg)
                return redirect(url_for('index'))
                # return redirect(url_for("patientdashboard")) # redirect to customer dashboard
            else:
                msg = 'Incorrect username / password !'
        elif (authority == "doctor"):
            cursor.execute('SELECT * FROM users WHERE email = % s AND password = % s AND role=%s', (useremail, password, "doctor",))
            account = cursor.fetchone()
            if account:
                session['bool'] = True
                session['email'] = account['email']
                msg = 'Logged in successfully!'
                flask.flash(msg)
                return redirect(url_for('index'))
                # return redirect(url_for("doctordashboard")) # redirect to doctor dashboard
            else:
                msg = 'Incorrect username/password!'
                flask.flash(msg)
        elif (authority == "admin"):
            cursor.execute('SELECT * FROM users WHERE email = % s AND password = % s AND role=%s', (useremail, password, "admin", ))
            account = cursor.fetchone()
            if account:
                session['bool'] = True
                session['email'] = account['email']
                msg = 'Logged in successfully!'
                flask.flash(msg)
                return redirect(url_for('index'))
                #return redirect(url_for("admindashboard")) # redirect to admin dashboard
            else:
                msg = 'Incorrect username/password!'
                flask.flash(msg)
        else:
            msg = 'Incorrect username/password!'
            flask.flash(msg)
    return render_template('login.html', msg = msg)

# about us url

# second

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))

@app.route('/register', methods =['GET', 'POST'])
def register():
    msg = ''
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form and 'email' in request.form and 'role' in request.form :
        username = request.form['username']
        password = request.form['password']
        email = request.form['email']
        role = request.form['role']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM users WHERE email = % s', (username, ))
        account = cursor.fetchone() # fetches the first row
        if account:
            msg = 'Account already exists !'
        elif not re.match(r'[^@]+@[^@]+\.[^@]+', email):
            msg = 'Invalid email address !'
        elif not re.match(r'[A-Za-z0-9]+', username):
            msg = 'Username must contain only characters and numbers !'
        elif not username or not password or not email:
            msg = 'Please fill out the form !'
        else:
            cursor.execute('INSERT INTO users VALUES (NULL, %s, % s, % s, % s)', (username, email, password, role))
            mysql.connection.commit()
            msg = 'You have successfully registered!'
    elif request.method == 'POST':
        msg = 'Please fill out the form!'
    return render_template('register.html', msg = msg)

# third

@app.route('/about_us')
def about():
    return render_template('about_us.html')

# fourth
@app.route('/index')
def index():
    return render_template('index.html')

# fifth
@app.route('/index', methods=['POST'])
def choose():
    if request.form.get("start"):
        return redirect(url_for('pick_table'))
    else:
        return render_template('index.html')

# sixth

@app.route('/pick_table', methods=['POST', 'GET'])
def pick_table():
    table_name = ''
    if session.get('table_name'):
        session.pop('table_name', None)
    options = nested_list_to_html_select(show_tables(mysql))
    if request.method == 'POST' and 'table' in request.form:
    
        if 'pick' in request.form:
            session['table_name'] = request.form['table']
            return redirect(url_for('edit'))

    table = nested_list_to_html_table(show_tables(mysql))
    return render_template('pick_table.html', table=table, table_name=table_name, options=options)

# seventh

@app.route('/edit', methods=['POST', 'GET'])
def edit():
    table_name = session['table_name']
    operation = None
    form_html = ''
    if request.method == 'POST' and 'insert_form' in request.form:
        operation = 'insert'
        table = nested_list_to_html_table(select_with_headers(mysql, table_name), buttons=True)
        form_html = get_insert_form(select_with_headers(mysql, table_name)[0])
        return render_template('edit.html', table=table, table_name=table_name, operation=operation, form_html=form_html)
    elif request.method == 'POST' and 'insert_execute' in request.form:
        columns = select_with_headers(mysql, table_name)[0]
        values = []
        for col in columns:
            val = request.form[col]
            if val.isnumeric():
                values.append(val)
            else:
                values.append("\'" + val + "\'")
        try:
            tables = insert_to_table(mysql, table_name, columns, values)
        except Exception as e:
            return render_template('invalid.html', e=str(e))
        tables = [nested_list_to_html_table(t) for t in tables]
        return render_template('insert_results.html', tables=tables, table_name=table_name)
    elif request.method == 'POST' and 'delete_button' in request.form:
        values = request.form['delete_button'].split(',')
        values = [val if val.isnumeric() else "\'" + val + "\'" for val in values]
        columns = select_with_headers(mysql, table_name)[0]
        where = []
        for col, val in zip(columns, values):
            where.append(col + " = " + val)
        where = " AND ".join(where)
        try:
            tables = delete_from_table(mysql, table_name, where)
        except Exception as e:
            return render_template('invalid.html', e=str(e))
        tables = [nested_list_to_html_table(t) for t in tables]
        return render_template('delete_results.html', tables=tables, table_name=table_name)
    elif request.method == 'POST' and 'update_button' in request.form:
        operation = 'update'
        table = nested_list_to_html_table(select_with_headers(mysql, table_name), buttons=True)
        values = request.form['update_button'].split(',')
        form_html = get_update_form(select_with_headers(mysql, table_name)[0], values)
        values = [val if val.isnumeric() else "\'" + val + "\'" for val in values]
        columns = select_with_headers(mysql, table_name)[0]
        where = []
        for col, val in zip(columns, values):
            where.append(col + " = " + val)
        where = " AND ".join(where)
        session['update_where'] = where
        return render_template('edit.html', table=table, table_name=table_name, operation=operation, form_html=form_html)
    elif request.method == 'POST' and 'update_execute' in request.form:
        columns = select_with_headers(mysql, table_name)[0]
        values = []
        for col in columns:
            val = request.form[col]
            if val.isnumeric():
                values.append(val)
            else:
                values.append("\'" + val + "\'")
        
        set_statement = []
        for col, val in zip(columns, values):
            set_statement.append(col + " = " + val)
        set_statement = ", ".join(set_statement)

        try:
            tables = update_table(mysql, table_name, set_statement, session['update_where'])
        except Exception as e:
            return render_template('invalid.html', e=str(e))
        tables = [nested_list_to_html_table(t) for t in tables]
        if session.get('update_where'):
            session.pop('update_where', None)
        return render_template('update_results.html', tables=tables, table_name=table_name)


    table = nested_list_to_html_table(select_with_headers(mysql, table_name), buttons=True)
    return render_template('edit.html', table=table, table_name=table_name, operation=operation, form_html=form_html)

# app run 

if __name__ == '__main__':
    app.run()