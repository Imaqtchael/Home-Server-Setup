#! /bin/bash

# Update date and time
echo 'Updating date and time...'
sudo date -s "$(curl -s --head http://google.com | grep ^Date: | sed 's/Date: //g')"
echo '
Date and time updated successfull!'

# Update the system
echo 'Updating the system...'
sudo apt-get update && sudo apt-get upgrade -y
echo '
System updated successfully!'

# Create docker containers
echo 'Creating directories for docker containers...'
mkdir /home/$USER/server
mkdir /home/$USER/server/compose
cd /home/$USER/server/compose
mkdir adguardhome jackett lidarr jellyfin qbittorrent homarr
echo 'Docker containers created successfully!'

# Install docker and docker-compose
sudo apt-get install ca-certificates curl gnupg apt-transport-https lsb-release
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/d>  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER

# Exit now
echo '
Part 1 done. Exit the shell by typing "exit" and ssh back in'