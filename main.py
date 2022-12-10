from website import get_flask_instance

app_instance = get_flask_instance()

if __name__ == "__main__":
    app_instance.run(debug=True)

