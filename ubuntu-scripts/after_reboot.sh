#!/bin/bash

# Install Caffeine
sudo apt install -y caffeine

# Activate Caffeine
caffeine &


# Install BYOB prerequisites
sudo pip3 install Flask-SQLAlchemy==2.5.0
sudo pip3 install swig
sudo pip3 install pyinstaller

sudo apt install -y git 
sudo apt install -y python3-pip 
#sudo apt-get install python-is-python3 -y

# Check the firewall status
ufw_status=$(sudo ufw status | grep -i 'Status')

# If UFW is enabled, disable it
if [[ $ufw_status == *"active"* ]]; then
    echo "UFW is enabled, disabling..."
    sudo ufw disable
else
    echo "UFW is already disabled, continuing..."
fi


# Clone the repository
git clone https://github.com/fireFerry/byob.git
cd byob/web-gui/
sudo chmod +x startup.sh
sudo ./startup.sh

# Install required packages and start BYOB
cd byob/web-gui
sudo pip3 install -r requirements.txt
sudo pip3 install Flask-SQLAlchemy==2.5.0

#chown -R $(whoami):$(whoami) ~/byob

sudo python3 run.py
