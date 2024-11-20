#!/bin/bash

# relativ .jar files
BUNGEECORD_JAR="BungeeCord.jar"
SERVER1_JAR="hub.jar"
SERVER2_JAR="survie.jar"

# Abs path for directory
BUNGEECORD_DIR="/Users/lucas/Desktop/mc_serv/BungeeCord"
SERVER1_DIR="/Users/lucas/Desktop/mc_serv/lobby"
SERVER2_DIR="/Users/lucas/Desktop/mc_serv/survie"

# Check I_OK / X_OK
if [[ ! -f "$BUNGEECORD_DIR/$BUNGEECORD_JAR" ]]; then
  echo "Erreur : $BUNGEECORD_JAR introuvable dans $BUNGEECORD_DIR"
  exit 1
fi

if [[ ! -f "$SERVER1_DIR/$SERVER1_JAR" ]]; then
  echo "Erreur : $SERVER1_JAR introuvable dans $SERVER1_DIR"
  exit 1
fi

if [[ ! -f "$SERVER2_DIR/$SERVER2_JAR" ]]; then
  echo "Erreur : $SERVER2_JAR introuvable dans $SERVER2_DIR"
  exit 1
fi

start_server_in_terminal() {
  local name=$1
  local dir=$2
  local jar=$3
  local memory=$4

  echo "Lancement du serveur $name dans un nouveau terminal..."

  # Apple script handling terminal opening for logs
  osascript -e "
    tell application \"Terminal\"
        do script \"cd $dir && java -Xms${memory}M -Xmx${memory}M -jar $jar nogui; exec bash\"
    end tell
  "
  
  if [[ $? -eq 0 ]]; then
    echo "Serveur $name demarre dans un nouveau terminal."
  else
    echo "Erreur lors du demarrage de $name"
  fi
}

start_server_in_terminal "BungeeCord" "$BUNGEECORD_DIR" "$BUNGEECORD_JAR" 512
start_server_in_terminal "Server1" "$SERVER1_DIR" "$SERVER1_JAR" 1024
start_server_in_terminal "Server2" "$SERVER2_DIR" "$SERVER2_JAR" 1024

echo "Tous les serveurs sont en cours de demarrage dans des terminaux separes."
