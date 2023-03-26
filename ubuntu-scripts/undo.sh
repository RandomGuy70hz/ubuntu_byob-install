#!/bin/bash

# Remove Caffeine
sudo apt purge --auto-remove caffeine


# Remove Wine and its dependencies
sudo apt purge --auto-remove winehq-stable

# Remove WineHQ key and sources file
sudo rm /etc/apt/keyrings/winehq-archive.key
sudo rm /etc/apt/sources.list.d/winehq-focal.sources

# Remove Docker, containerd, and Docker Compose
sudo apt purge --auto-remove docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Remove Docker key and sources file
sudo rm /etc/apt/keyrings/docker.gpg
sudo rm /etc/apt/sources.list.d/docker.list

# Remove Docker group for the current user
sudo gpasswd -d $USER docker

# Remove BYOB prerequisites
sudo pip3 uninstall -y Flask-SQLAlchemy swig pyinstaller

# Remove other packages
sudo apt purge --auto-remove git python3-pip

# Remove BYOB repository
rm -rf ~/byob

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

echo "All changes from before_reboot.sh and after_reboot.sh have been reverted."
