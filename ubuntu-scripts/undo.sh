#!/bin/bash

# Remove Caffeine
sudo apt purge --auto-remove caffeine -y


# Remove Wine and its dependencies
sudo apt purge --auto-remove winehq-stable -y

# Remove WineHQ key and sources file
sudo rm /etc/apt/keyrings/winehq-archive.key -y
sudo rm /etc/apt/sources.list.d/winehq-focal.sources -y

# Remove Docker, containerd, and Docker Compose
sudo apt purge --auto-remove docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Remove Docker key and sources file
sudo rm /etc/apt/keyrings/docker.gpg -y
sudo rm /etc/apt/sources.list.d/docker.list -y

# Remove Docker group for the current user
sudo gpasswd -d $USER docker -y

# Remove BYOB prerequisites
sudo pip3 uninstall -y Flask-SQLAlchemy swig pyinstaller

# Remove other packages
sudo apt purge --auto-remove git python3-pip -y

# Remove BYOB repository
rm -rf ~/byob -y

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

echo "All changes from before_reboot.sh and after_reboot.sh have been reverted."
