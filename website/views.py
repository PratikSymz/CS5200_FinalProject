from flask import Blueprint, render_template, request, session
from flask_login import login_required
from . import mysql_db

views = Blueprint('views', __name__)


@views.route('/', methods=['GET', 'POST'])
def products_page() -> str:
    cursor = mysql_db.connect().cursor()
    lines = cursor.execute(''' SELECT * FROM product ''')

    product_list = []
    if (lines > 0):
        for line in cursor:
            product_list.append(line)

    return render_template("products.html", session=session, product_list=product_list)


@views.route('/orders', methods=['GET', 'POST'])
def orders_page() -> str:
    cursor = mysql_db.connect().cursor()
    lines = cursor.execute(f''' SELECT * FROM orders WHERE email = "{session['email']} ''')

    orders_list = []
    if (lines > 0):
        for line in cursor:
            orders_list.append(line)
    
    return render_template("orders.html", session=session, orders_list=orders_list)