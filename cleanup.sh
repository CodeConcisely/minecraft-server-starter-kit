#!/bin/bash

FORCE_MODE=0

while getopts "f" OPTION; do
  case "$OPTION" in
      f) FORCE_MODE=1;;
      ?) exit 1;
  esac
done

function cleanup() {
    sudo rm /etc/cron.d/minecraft_server_jobs
    sudo userdel minecraft
    sudo rm -rf /opt/minecraft/
    echo "--- Cleaned up ---"
}

echo "--- Starting cleanup ---"

if [[ $FORCE_MODE = 1 ]]
then
  cleanup
else
  read -p "Are you sure you want to delete minecraft user and group and /opt/minecraft? [y/N] " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    cleanup
  else
    echo "--- Cleanup canceled ---"
  fi
fi


