import os
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    tenant_name = os.environ.get('TENANT_NAME', 'DefaultTenant')
    return f"Kubernetes Multitenancy for {tenant_name}!\n"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=int(os.environ.get('PORT', 5000)))
