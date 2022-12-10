from flask import Flask, session
from flaskext.mysql import MySQL
from flask_login import LoginManager

KEY_SECRET = 'c6TKdxlo793pjEsYIPv0Ds4IAw7hDltg'
DB_NAME = "ecommerce"
USERNAME = "root"
PASSWORD = "carrot28"
HOSTNAME = "localhost"

global mysql_db
mysql_db = None


def get_flask_instance():
    app = Flask(__name__)
    # Create the "secret session key"
    # app.config['KEY_SECRET'] = 'c6TKdxlo793pjEsYIPv0Ds4IAw7hDltg'
    app.secret_key = KEY_SECRET
    app.config['SQLALCHEMY_DATABASE_URI'] = f'mysql+pymysql://{USERNAME}:{PASSWORD}@{HOSTNAME}/{DB_NAME}'

    global mysql_db
    mysql_db = connect_database(app)
    mysql_db.init_app(app)

    from .views import views
    from .auth import auth
    from .models import User

    login_manager = LoginManager()
    login_manager.login_view = 'auth.login'     #type: ignore
    login_manager.init_app(app)

    @login_manager.user_loader
    def load_user(user_id: str):
        assert mysql_db is not None
        cursor = mysql_db.connect().cursor()
        cursor.execute(f''' SELECT * FROM users WHERE user_id = {int(user_id)} ''')
        
        user_details = cursor.fetchone()
        if (user_details is None or len(user_details) == 0): 
             # Invalidate the session
            session.pop('logged_in', None)
            session.pop('user_id', None)
            session.pop('email', None)
            session.modified = True
            return None

        # Extract user info
        user = User(user_details[0], user_details[1], user_details[2], user_details[3])
        # Update the session
        session['logged_in'] = True
        session['user_id'] = user.user_id
        session['email'] = user.email
        session.modified = True
        cursor.close()

        return user

    # Register blueprints
    # app.register_blueprint(views, url_prefix='/')  # Prefix: root prefix
    app.register_blueprint(auth, url_prefix='/')  # Prefix: root prefix

    return app


def connect_database(app) -> MySQL:
    return MySQL(
        app, host="localhost", user="root", password="carrot28", db="ecommerce", autocommit=True
    )

def terminate_connection():
    global mysql_db
    if mysql_db is not None:
        mysql_db.connect().close()
