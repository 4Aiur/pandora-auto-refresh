#!/bin/bash

echo "Pip install at $(date)"
python3 -m venv venv
pip install -r requirements.txt

echo "Refresh token at $(date)"
python3 /app/generate_token.py
ls -all

echo "Kill old process at $(date)"
# Check if there are any processes listening on port 3008
if [ "$(lsof -t -i:3000)" ]; then
  # If processes exist, kill them using kill -9
  kill -9 $(lsof -t -i:3000)
  echo "Kill old process Success!"
else
  # If no processes exist, print a message indicating that no processes were found
  echo "No processes found on port 3000. Skipping kill command."
fi

# $(env | grep USERNAME | cut -d= -f2) From Docker compose env
echo $(env | grep USERNAME | cut -d= -f2)
nohup pandora -s 0.0.0.0:3000 -t ./$(env | grep USERNAME | cut -d= -f2)_token.txt > output.log 2>&1

ps -ef | grep pandora
