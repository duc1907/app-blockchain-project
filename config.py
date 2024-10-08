import os
from dotenv import load_dotenv

# Load variables from .env file
load_dotenv()

class Config:
    # MySQL database connection
    SQLALCHEMY_DATABASE_URI = os.getenv('DATABASE_URL')
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    # Web3 provider
    WEB3_PROVIDER = os.getenv('WEB3_PROVIDER')
