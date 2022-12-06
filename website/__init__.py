from flask import Flask

def get_flask_instance():
    app = Flask(__name__)
    # Create the "secret session key"
    app.config['KEY_SECRET'] = 'c6TKdxlo793pjEsYIPv0Ds4IAw7hDltl'

    from .views import views
    from .auth import auth

    # Register blueprints
    app.register_blueprint(views, url_prefix = '/') # Prefix: root prefix
    app.register_blueprint(auth, url_prefix = '/')  # Prefix: root prefix
    
    return app
