""" Importing modules needed """
from flask import Flask, render_template, jsonify
"""This is used to get env for the application"""
import os


app = Flask(__name__)

@app.route('/')
def index():
    """ Handles the root route of the application. """
    return render_template('index.html')

@app.route('/health')
def health():
    """ This will generate health check for the application"""
    return jsonify(status = "Up")

if __name__ == '__main__':
    environment = os.getenv('ENVIRONMENT', 'staging')
    flask_env = os.getenv('FLASK_ENV', 'development')  # Default to development if not set

    if environment == 'production' or flask_env == 'production':
        app.run(host='0.0.0.0', port=80)
    else:
        app.run(host='0.0.0.0', port=8080)
