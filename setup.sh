#!/bin/bash

SERVER_DIR="/opt/minecraft/server"
TOOLS_DIR="/opt/minecraft/BuildTools"
SERVER_VERSION="latest"

SETUP_STEPS=4

echo "--- Setting up user and group 1/$SETUP_STEPS ---"
groupadd minecraft
useradd -r -m -d /opt/minecraft -g minecraft minecraft

echo "--- Installing Git and Java 2/$SETUP_STEPS ---"
apt-get install git openjdk-8-jre-headless

echo "--- Running tools installation 3/$SETUP_STEPS ---"
su minecraft -c "./install_tools.sh -d $TOOLS_DIR -v $SERVER_VERSION"

echo "--- Setting up server 4/$SETUP_STEPS ---"
mkdir -p "$SERVER_DIR" || { echo "Failed to create $INSTALL_DIR"; exit 1; }

FILE=$(find "$TOOLS_DIR/build" -type f -name "spigot-*.jar")

if [[ -z $FILE ]]
then
  echo "Failed to find Spigot .jar file"
  exit 1
else
  cp $FILE $SERVER_DIR/spigot.jar
fi

cp "./start_server.sh" "$SERVER_DIR/start_server.sh"
echo "eula=true" > "$SERVER_DIR/eula.txt"

echo "--- Done. Minecraft server can be started by executing $SERVER_DIR/start_server.sh ---"
