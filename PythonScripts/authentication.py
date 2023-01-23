from flask import Flask, request, jsonify
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)

# A list to store user credentials (username and hashed password)
users = [{"username": "user1", "password": generate_password_hash("password1")}]

@app.route("/login", methods=["POST"])
def login():
    # Get the user's input
    username = request.json.get("username")
    password = request.json.get("password")

    # Check if the user exists in the list of users
    for user in users:
        if user["username"] == username:
            # Check if the provided password matches the stored hash
            if check_password_hash(user["password"], password):
                return jsonify({"message": "Successfully logged in."}), 200
            else:
                return jsonify({"message": "Incorrect password."}), 401

    # If the user is not found in the list
    return jsonify({"message": "User not found."}), 404

if __name__ == '__main__':
    app.run(debug=True)