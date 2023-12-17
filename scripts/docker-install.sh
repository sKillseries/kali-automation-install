#!/bin/bash

# Téléchargement du script d'install docker
curl -fsSL "https://get.docker.com/" -o get-docker.sh

# Exécution du script d'install docker
sh get-docker.sh

# Ajout de l'utilisateur dans le groupe docker
sudo usermod -aG docker "$(id -u -n)"

# Rechargement du groupe docker
newgrp docker
