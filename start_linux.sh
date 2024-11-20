#!/bin/bash

# Chemins vers les fichiers .jar des serveurs
BUNGEECORD_JAR="BungeeCord.jar"
SERVER1_JAR="hub.jar"
SERVER2_JAR="survie.jar"

# Dossiers des serveurs
BUNGEECORD_DIR="./BungeeCord"
SERVER1_DIR="./lobby"
SERVER2_DIR="./survie"

# Vérifie si les fichiers existent
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

# Fonction pour lancer un serveur dans un terminal séparé
start_server_in_terminal() {
  local name=$1
  local dir=$2
  local jar=$3
  local memory=$4

  echo "Lancement du serveur $name dans un nouveau terminal..."
  gnome-terminal -- bash -c "cd $dir && java -Xms${memory}M -Xmx${memory}M -jar $jar nogui; exec bash"
  if [[ $? -eq 0 ]]; then
    echo "Serveur $name démarré dans un nouveau terminal."
  else
    echo "Erreur lors du démarrage de $name"
  fi
}

# Démarrage des serveurs dans des terminaux séparés
start_server_in_terminal "BungeeCord" "$BUNGEECORD_DIR" "$BUNGEECORD_JAR" 512
start_server_in_terminal "Server1" "$SERVER1_DIR" "$SERVER1_JAR" 1024
start_server_in_terminal "Server2" "$SERVER2_DIR" "$SERVER2_JAR" 1024

echo "Tous les serveurs sont en cours de démarrage dans des terminaux séparés."
