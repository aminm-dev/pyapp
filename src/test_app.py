import pytest
from app import app

@pytest.fixture
def client():
    """Fixture to create a test client for the Flask app."""
    app.config['TESTING'] = True  # Enable testing mode
    with app.test_client() as client:
        yield client

def test_index_route(client):
    """Test the root route of the application."""
    response = client.get('/')
    assert response.status_code == 200
    assert b'<html>' in response.data  # Assuming `index.html` has HTML content

def test_health_route(client):
    """Test the health check route."""
    response = client.get('/health')
    assert response.status_code == 200
    assert response.json == {'status': 'Up'}
