#!/bin/bash

# Fresh Ubuntu 20.04 install
sudo apt update && sudo apt upgrade -y 


# Install Docker
# Docs: https://docs.docker.com/engine/install/ubuntu/
sudo apt-get install -y ca-certificates curl gnupg lsb-release

sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt-get update

# Install Docker Engine, containerd, and Docker Compose.
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Check if Docker is running
docker_status=$(sudo service docker status)

if [[ $docker_status != *"active (running)"* ]]; then
  echo "Docker is not running. Starting Docker..."
  sudo systemctl start docker
fi

# Add the current user to the docker group
sudo usermod -aG docker $USER
#newgrp docker


# Install Wine
# Docs: https://wine.htmlvalidator.com/install-wine-on-ubuntu-20.04.html

# Check installed architectures
dpkg --print-architecture
dpkg --print-foreign-architectures

# Add 32-bit architecture if not installed
if ! dpkg --print-foreign-architectures | grep -q "i386"; then
  sudo dpkg --add-architecture i386
  dpkg --print-foreign-architectures
fi

# Download and add the WineHQ repository key
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key

# Download the WineHQ sources file
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/focal/winehq-focal.sources

# Update the package database
sudo apt update && sudo apt upgrade -y 


# Install Wine
sudo apt install --install-recommends winehq-stable

# Verify the installation succeeded
wine --version

# Configure Wine
wine winecfg

sudo apt update && sudo apt upgrade -y 

# Prompt the user to reboot
echo "You should reboot your system now and run after_reboot.sh. Reboot now? (y/n)"
read -r response

if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo "Rebooting..."
    sudo reboot
else
    echo "Reboot later and remember to run after_reboot.sh."
fi