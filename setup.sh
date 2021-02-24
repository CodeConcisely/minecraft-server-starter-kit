#!/bin/bash

TOOLS_PATH="./install_tools.sh"

echo "--- Setting up user and group ---"
sudo groupadd minecraft
sudo useradd -r -m -d /opt/minecraft -g minecraft minecraft
sudo chown -R minecraft /opt/minecraft

echo "--- Installing Git and Java"
sudo apt-get install git openjdk-8-jre-headless

echo "--- Running tools installation ---"
su minecraft -c ". $TOOLS_PATH -d /opt/minecraft/BuildTools"
