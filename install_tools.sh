#!/bin/bash

DIR="/opt/minecraft/BuildTools"
REV="latest"

while getopts "hr:" OPTION; do
  case "$OPTION" in
    h)
      echo -e "Installs latest server version by default.\n"
      echo "  -r version      Install a specific server version"
      echo "                  Example: -r 1.16.5"
      ;;

    r)
      REV="$OPTARG";;
    ?)
      echo "Use -h for help"
  esac
done

echo $REV

mkdir -p $DIR
cd $DIR

wget -O BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

git config --global --unset core.autocrlf
java -jar BuildTools.jar --rev $REV
