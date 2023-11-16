#!/bin/bash

echo "Starting the crontab at $(date)"
/usr/sbin/cron

echo "Starting the main application at $(date)"
./run.sh

# Tail the log file in the background
tail -f ./output.log