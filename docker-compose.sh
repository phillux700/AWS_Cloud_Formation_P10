#!/bin/bash

sudo apt update -y  && sudo apt upgrade -y
sudo apt install mysql-client-core-8.0
sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose 
sudo mkdir -p /wp_data/wp
sudo mkdir /wordpress && cd /wordpress
sudo touch docker-compose.yml
sudo chmod 664 docker-compose.yml
cat << EOF > docker-compose.yml
version: '3'
services:
  wordpress:
    image: conetix/wordpress-with-wp-cli
    ports:
      - 80:80
    restart: always
    environment:
      WORDPRESS_DB_HOST: instance.cbuldxbfw2ls.eu-west-3.rds.amazonaws.com:3306
      WORDPRESS_DB_USER: wordpressuser
      WORDPRESS_DB_PASSWORD: wordpresspw
      WORDPRESS_DB_NAME: wordpressdb
    volumes:
      - /wp_data/wp:/var/www/html
EOF
sudo docker-compose up -d
sudo docker exec wordpress_wordpress_1 wp core install --url="52.47.111.86" --title="Project10" --admin_user="Admin" --admin_password="Admin123/" --admin_email="morganadmin@gmail.com"
