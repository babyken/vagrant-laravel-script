#!/usr/bin/env bash
# Homestad 3.0 compatitable - Not tested

# Use single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='secret'
PROJECTFOLDER='laracast'

# create project folder
# sudo mkdir "/var/www/${PROJECTFOLDER}"

# update
sudo apt-get update

# Add add-apt-repository binary
sudo apt-get install -y python-software-properties

#used the most update repo of apache and php
sudo add-apt-repository -y ppa:ondrej/apache2
sudo add-apt-repository -y ppa:ondrej/php

# update / upgrade
sudo apt-get update
# Get rib of upgrade problem with asking question.
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
#sudo apt-get -y upgrade

# install apache 2.5 and php 5.5
sudo apt-get install -y apache2
sudo apt-get install -y php5.6
sudo apt-get install -y libapache2-mod-php5.6

# install mysql and give password to installer
# sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
# sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
# sudo apt-get -y install mysql-server
sudo apt-get install php5.6-mysql

# install phpmyadmin and give password(s) to installer
# for simplicity I'm using the same password for mysql and phpmyadmin
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo apt-get -y install phpmyadmin


# Install packages for mongo php extension and composer
sudo apt-get install -y php-pear
sudo apt-get install -y php5.6-xml
sudo apt-get install -y php5.6-curl
sudo apt-get install -y pkg-config
sudo apt-get install -y libpcre3-dev
sudo apt-get install -y php5.6-zip
sudo apt-get install -y php5.6-mbstring
sudo apt-get install -y php5.6-common
sudo apt-get install -y php5.6-mcrypt
sudo apt-get install -y php-gettext
sudo apt-get install -y php5.6-mysqli


# setup hosts file
VHOST=$(cat <<EOF
<VirtualHost *:80>
    DocumentRoot "/var/www/${PROJECTFOLDER}/public"
    <Directory "/var/www/${PROJECTFOLDER}/public">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

#enable php
sudo a2enmod php5.6

# enable mod_rewrite
sudo a2enmod rewrite


# enable mcrypt
sudo phpenmod mcrypt


# restart apache
sudo service apache2 restart


# install git
# sudo apt-get -y install git


# install Composer
# curl -s https://getcomposer.org/installer | php
# mv composer.phar /usr/local/bin/composer