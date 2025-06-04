WILCO_ID="`cat .wilco`"
export ENGINE_EVENT_ENDPOINT="${ENGINE_BASE_URL}/users/${WILCO_ID}/event"

# Update engine that codespace started for user
curl -L -X POST "${ENGINE_EVENT_ENDPOINT}" -H "Content-Type: application/json" --data-raw "{ \"event\": \"github_codespace_started\" }"

# Export welcome prompt in bash:
echo "printf \"\n\n☁️☁️☁️️ Develop in the Cloud ☁️☁️☁️\n\"" >> ~/.bashrc

nohup bash -c "cd /wilco-agent && node agent.js &" >> /tmp/agent.log 2>&1

# Install MongoDB
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] http://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org

# Create the MongoDB data directory
sudo mkdir -p /data/db
sudo chown -R vscode:vscode /data/db

# Start MongoDB
sudo systemctl start mongod

# Print welcome message
echo "MongoDB development environment is ready!"