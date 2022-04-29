#!bin/bash

##### Install Docker ####
sudo apt update -y
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update -y
apt-cache policy docker-ce
sudo apt install docker-ce -y

echo "${BACKEND_URL}"

sudo git clone --branch feature/upload-file https://github.com/JuliannyRpoL/app-carpex.git
sudo docker build -t app /app-carpex
sudo docker run -dp 80:80 app