#!/bin/bash

DIR="."
REV="latest"

while getopts "hd:v:" OPTION; do
  case "$OPTION" in
    d)
      DIR="$OPTARG";;
    h)
      echo -e "Usage: ./install_tools.sh [-d path] [-v version]"
      echo -e "Example: ./install_tools.sh -d /opt/minecraft/BuildTools -v 1.16.5 \n"
      echo -e "Installs the latest server version in current directory by default.\n"
      echo "  -d path         Specify a path where to install server files"
      echo "  -v version      Install a specific server version"
      exit 0;;

    r)
      REV="$OPTARG";;
    ?)
      echo "Use -h for help"
      exit 1;;
  esac
done

mkdir -p $DIR
cd $DIR

echo "--- Downloading BuildTools in $DIR ---"

wget -O BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

echo "--- Installing server version $REV ---"

git config --global --unset core.autocrlf
java -jar BuildTools.jar --rev $REV
