from flask import Blueprint, render_template

auth = Blueprint('auth', __name__)


@auth.route('/login')
def login():
    return render_template("login.html", text="Testing", user="Tim", boolean=False)    # Params

@auth.route('/logout')
def logout():
    return "<p>Logout</p>"

@auth.route("/signup")
def signup():
    return render_template("signup.html")

