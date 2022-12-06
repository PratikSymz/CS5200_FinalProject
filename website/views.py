from flask import Blueprint

views = Blueprint('views', __name__)


@views.route('/')
def home_page() -> str:
    return "<h1>Test</h1>"
