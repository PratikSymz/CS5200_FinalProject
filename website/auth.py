from flask import Blueprint, render_template, request, flash, redirect, url_for, session, jsonify
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import login_required
from .models import User
from . import mysql_db
import re
import json
from datetime import date

auth = Blueprint('auth', __name__)
email_regex = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'

global user
user = User()

global cart
cart = set()


@auth.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form.get('email')
        password = request.form.get('password')

        if email is None or password is None:
            flash('Please enter a valid email id and password!', category='error')
        else:
            # Load user's details from the database
            cursor = mysql_db.connect().cursor()
            cursor.execute(
                f''' SELECT * FROM users WHERE email = "{email}" ''')
            user_details = cursor.fetchone()

            if user_details is not None:
                user = User(user_details[0], user_details[1],
                            user_details[2], user_details[3])

                if check_password_hash(user.password, password):
                    flash('Logged in successfully!', category='success')
                    session['logged_in'] = True
                    session['user_id'] = user.user_id
                    session['email'] = user.email
                    # login_user(user, remember=True)

                    # Redirect url for the hompage
                    session.modified = True
                    return redirect(url_for('auth.products_page'))

                else:
                    flash('Incorrect password! Please try again.',
                          category='error')
            else:
                flash('No such user exists!', category='error')

            cursor.close()  # Close the cursor

    return render_template('login.html', session=None)


@auth.route('/logout')
@login_required
def logout():
    # logout_user()
    session.pop('logged_in', None)
    session.pop('user_id', None)
    session.pop('email', None)

    session.modified = True
    return redirect(url_for('auth.login'))


@auth.route('/signup', methods=['GET', 'POST'])
def signup():
    if (request.method == 'POST'):
        # Extract user input
        full_name = request.form.get('full_name')
        email = request.form.get('email')
        password1 = request.form.get('password1')
        password2 = request.form.get('password2')

        # Perform data validation
        if (full_name is not None and email is not None and password1 is not None and password2 is not None):
            # Query db to find a user with those credentials
            cursor = mysql_db.connect().cursor()
            cursor.execute(
                f''' SELECT * FROM users WHERE email = "{email}" ''')
            lines = cursor.fetchall()

            if len(lines) > 0:
                flash('Email already exists!', category='error')

            # Data validation
            elif (len(full_name) < 5 or not full_name.replace(' ', '').isalpha()):
                flash('Please enter a valid name longer than 5 characters!',
                      category='error')
            elif (re.fullmatch(email_regex, email) is None):
                flash('Please enter a valid email!', category='error')
            elif (len(password1) < 8):
                flash('Please enter a password with minimum 8 characters',
                      category='error')
            elif (password1 != password2):
                flash('Passwords dont\'t match! Please try again.', category='error')

            else:
                # Generate password hash
                password_hash = generate_password_hash(
                    password1, method='SHA256')

                # Add user to the database
                rows_affected = cursor.execute(
                    f''' INSERT INTO users (full_name, email, password) VALUES ("{full_name}", "{email}", "{password_hash}") ''')
                if rows_affected == 0:
                    flash('Error creating account! Please try again later.',
                          category='error')
                else:
                    # Retrieve the user id
                    cursor.execute(''' SELECT LAST_INSERT_ID() ''')
                    user_inserted = cursor.fetchone()
                    assert user_inserted is not None

                    # Create user reference
                    user = User(
                        user_id=user_inserted[0], full_name=full_name, password=password_hash, email=email)
                    session['logged_in'] = True
                    session['user_id'] = user.user_id
                    session['email'] = user.email
                    # login_user(user, remember=True)     # This user becomes the 'current_user'
                    flash('Account created', category='success')

                    # Commit changes to database
                    mysql_db.connect().commit()
                    cursor.close()

                    # Redirect url for the hompage
                    session.modified = True
                    return redirect(url_for('auth.products_page'))

            cursor.close()  # Close the cursor

    return render_template("signup.html", session=None)


@auth.route('/', methods=['GET', 'POST'])
def products_page():
    try:
        login_status = session['logged_in']
        cursor = mysql_db.connect().cursor()
        lines = cursor.execute(''' SELECT * FROM product ''')

        product_list = []
        if (lines > 0):
            for line in cursor:
                product_list.append(line)

    except KeyError:
        session.modified = True
        return redirect(url_for('auth.login'))

    return render_template("products.html", session=session['logged_in'], product_list=product_list)


@auth.route('/cart', methods=['GET', 'POST'])
def cart_page():
    try:
        login_status = session['logged_in']
        cursor = mysql_db.connect().cursor()

        product_list = []
        global cart
        for pid in cart:
            cursor.execute(
                f''' SELECT * FROM product WHERE product_id = {pid} ''')
            product_details = cursor.fetchone()
            product_list.append(product_details)

    except KeyError:
        session.modified = True
        return redirect(url_for('auth.login'))

    return render_template("cart.html", session=session['logged_in'], cart_items=product_list)


@auth.route('/orders', methods=['GET', 'POST'])
def orders_page():
    try:
        login_status = session['logged_in']
        cursor = mysql_db.connect().cursor()
        lines = cursor.execute(
            f''' SELECT * FROM orders WHERE user_id = {session['user_id']} ''')

        orders_list = []
        if (lines > 0):
            for line in cursor:
                orders_list.append(line)

    except KeyError:
        session.modified = True
        return redirect(url_for('auth.login'))

    return render_template("orders.html", session=session['logged_in'], orders_list=orders_list)


@auth.route('/edit_profile', methods=['GET', 'POST'])
def edit_profile_page():
    if (request.method == 'POST'):
        # Extract user input
        st_address1 = request.form.get('st_addr1')
        st_address2 = request.form.get('st_addr2')
        city = request.form.get('city')
        state = request.form.get('state')
        zip = request.form.get('zip')

        # Perform data validation
        if (st_address1 is not None and st_address2 is not None and city is not None
                and state is not None and zip is not None):

            # Data validation
            if (len(st_address1) < 5 or not st_address1.replace(' ', '').isalnum()):
                flash(
                    'Please enter a valid street address 1 longer than 5 characters!', category='error')
            elif (len(st_address2) < 5 or not st_address2.replace(' ', '').isalnum()):
                flash(
                    'Please enter a valid street address 2 longer than 5 characters!', category='error')
            elif (len(city) < 3):
                flash('Please enter a valid US city!', category='error')
            elif (len(state) < 2):
                flash('Please enter a valid 2 character US state!', category='error')
            elif (len(zip) < 3 or not zip.replace(' ', '').isnumeric()):
                flash('Please enter a valid US zip code!', category='error')

            else:
                # If the user does not have a current address, insert address record to the db.
                cursor = mysql_db.connect().cursor()
                cursor.execute(
                    f''' SELECT * FROM address WHERE user_id = {session['user_id']} ''')
                lines = cursor.fetchone()

                if (lines is None):
                    # Insert new address record
                    rows_affected = cursor.execute(
                        f'''
                        INSERT INTO address(street_address_1, street_address_2, city, state, zip, user_id)
                        VALUES ("{st_address1}", "{st_address2}", "{city}", "{state.capitalize()}", "{zip}", "{session['user_id']}")
                        '''
                    )

                    if rows_affected == 0:
                        flash(
                            'Error saving address! Please try again later.', category='error')
                    else:
                        flash('Address saved successfully!', category='success')

                else:
                    # Update the existing address
                    rows_affected = cursor.execute(
                        f''' 
                        UPDATE address 
                        SET street_address_1 = "{st_address1}", street_address_2 = "{st_address2}", city = "{city}", state = "{state.capitalize()}", zip = {zip}
                        WHERE user_id = {session['user_id']}
                        '''
                    )

                    if rows_affected == 0:
                        flash(
                            'Error saving address! Please try again later.', category='error')
                    else:
                        flash('Address saved successfully!', category='success')

                # Commit changes to database
                mysql_db.connect().commit()
                cursor.close()

                return redirect(url_for('auth.products_page'))

    return render_template("edit_profile.html", session=session['logged_in'])


@auth.route('/add_to_cart', methods=['POST'])
def add_to_cart():
    product = json.loads(request.data)  # to a dict
    product_id = product['product_id']
    # quantity = product['quantity']

    # Add product to cart
    global cart
    cart.add(int(product_id))

    return jsonify({})


@auth.route('/remove_from_cart', methods=['POST'])
def remove_from_cart():
    product = json.loads(request.data)  # to a dict
    product_id = product['product_id']

    # Remove product from cart
    global cart
    if int(product_id) in cart:
        cart.remove(int(product_id))

    return jsonify({})


@auth.route('/checkout_cart', methods=['POST'])
def checkout_cart():
    global cart
    cursor = mysql_db.connect().cursor()

    # Create an order with all the product id's in the cart
    total_price = 0.0
    today = date.today()

    # 1. Calculate the total price of all products in the cart
    for pid in cart:
        cursor.execute(
            f''' SELECT * FROM product WHERE product_id = {int(pid)} ''')
        product_details = cursor.fetchone()

        if product_details is not None:
            total_price += product_details[4]

    # 2. Create the order
    rows_affected = cursor.execute(
        f'''
        INSERT INTO orders(order_date, total_price, user_id)
        VALUES("{today.strftime("%Y-%m-%d")}", {total_price}, {session['user_id']})
        '''
    )

    # Retrieve the last created order id
    cursor.execute(''' SELECT LAST_INSERT_ID() ''')
    order_created = cursor.fetchone()
    assert order_created is not None

    # 3. Create order and product references in the "order_product_details" table.
    for pid in cart:
        rows_affected = cursor.execute(
            f'''
            INSERT INTO order_product_details(order_id, product_id, quantity)
            VALUES({order_created[0]}, {pid}, {1})
            '''
        )

    # Clear cart
    cart.clear()

    flash('Order successfully created!', category='success')

    # Commit changes to database
    mysql_db.connect().commit()
    cursor.close()

    return jsonify({})


@auth.route('/get_order_details', methods=['GET', 'POST'])
def get_order_details():
    order = json.loads(request.data)  # to a dict
    order_id = order['order_id']

    return redirect(url_for('auth.view_order_details', messages=order_id))


@auth.route('/view_order_details', methods=['GET'])
def view_order_details():
    order_id = request.args['messages']
    cursor = mysql_db.connect().cursor()

    order_details = []
    product_details = []

    # 1. Load the order details
    cursor.execute(
        f''' SELECT * FROM orders WHERE order_id = {int(order_id)} ''')
    order_details = cursor.fetchone()
    if order_details is not None:
        # 2. Fetch the product details from the "order_product_details" table.
        cursor.execute(
            f'''
            SELECT * FROM consolidated_view WHERE order_id = {int(order_id)}
            '''
        )

        lines = cursor.fetchall()
        for line in lines:
            product_details.append(line)

    # Commit changes to database
    mysql_db.connect().commit()
    cursor.close()

    return render_template("order_details.html", session=session['logged_in'], order_details=order_details, product_details=product_details)


@auth.route('/delete_order', methods=['POST'])
def delete_order():
    order = json.loads(request.data)  # to a dict
    order_id = order['order_id']

    cursor = mysql_db.connect().cursor()

    # 1. Remove order from the "orders" table.
    cursor.execute(
        f''' DELETE FROM orders WHERE order_id = {int(order_id)} ''')

    # 2. Remove mappings of this order and its products from the "order_product_details" table
    cursor.execute(
        f''' DELETE FROM order_product_details WHERE order_id = {int(order_id)} ''')

    flash('Order successfully deleted!', category='success')

    # Commit changes to database
    mysql_db.connect().commit()
    cursor.close()

    return jsonify({})

@auth.route('/delete_account', methods=['GET', 'POST'])
def delete_account():
    cursor = mysql_db.connect().cursor()
    # Delete the user's account
    # Cascading affect across all tables
    cursor.execute(f''' DELETE FROM users WHERE user_id = {session['user_id']} ''')
    
    session.pop('logged_in', None)
    session.pop('user_id', None)
    session.pop('email', None)
    session.clear()
    session.modified = True

    return render_template("login.html", session=None)
