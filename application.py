from flask import Flask
import boto3
import json
import os

app = Flask(__name__)

@app.route('/')
def home():
    secret_name = os.getenv("SECRET_NAME", "MyAppSecrets")
    region_name = os.getenv("AWS_REGION", "us-east-1")

    session = boto3.session.Session()
    client = session.client(service_name='secretsmanager', region_name=region_name)

    try:
        get_secret_value_response = client.get_secret_value(SecretId=secret_name)
        secret = json.loads(get_secret_value_response['SecretString'])
        return f"Secrets loaded! DB_USER: {secret['DB_USER']}"
    except Exception as e:
        return str(e)

if __name__ == "__main__":
    app.run()
