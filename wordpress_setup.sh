#!/bin/bash

# Update package lists
sudo apt update

# Install Apache server
sudo apt install -y apache2

# Install PHP and PHP MySQL connector
sudo apt install -y php libapache2-mod-php php-mysql

# Install MySQL server
sudo apt install -y mysql-server

# Login to MySQL server
sudo mysql -u root <<MYSQL_SCRIPT
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Testpassword@123';
CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'Testpassword@123';
CREATE DATABASE wp;
GRANT ALL PRIVILEGES ON wp.* TO 'wp_user'@localhost;
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# Download WordPress
cd /tmp
wget -q https://wordpress.org/latest.tar.gz

# Unzip WordPress
tar -xvf latest.tar.gz

# Move WordPress folder to Apache document root
sudo mv wordpress/ /var/www/html

# Restart Apache server
sudo systemctl restart apache2

# Install Certbot
sudo apt-get install -y certbot python3-certbot-apache

# Request and install SSL certificate
sudo certbot --apache

# Restart Apache server
sudo systemctl restart apache2

echo "WordPress installation and SSL setup completed!"
