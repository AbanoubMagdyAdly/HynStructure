#!/bin/bash
### This script will setup the environement to allow multi tenant to work 



read -p "Before you continue please configure your .env DB_CONNECTION to 'system'"
read -p "Be aware that this script appends some urls to /etc/hosts"
# Create hynstructure.conf file in /etc/apache2/sites-available
sudo touch /etc/apache2/sites-available/hynstructure.conf

CURRENT_DIRECTORY=`pwd`

hynstructure_DIRECTORY="${CURRENT_DIRECTORY}/public"

sudo bash -c "cat >/etc/apache2/sites-available/hynstructure.conf <<"EOL"
<VirtualHost *:80>
    ServerName hynstructure.com
    ServerAlias *.hynstructure.com

    # public path, serving content
    DocumentRoot ${hynstructure_DIRECTORY}
    # default document handling
    DirectoryIndex index.html index.php


    # allow cross domain loading of resources
    Header set Access-Control-Allow-Origin "*"

    <Directory "${hynstructure_DIRECTORY}">
        Options FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOL"

HOSTS=`cat /etc/hosts`

sudo bash -c "cat >>/etc/hosts <<"EOL"
127.0.0.1	hynstructure.com
127.0.1.1	admin.hynstructure.com
127.0.1.1	garas.hynstructure.com
127.0.1.1	xyz.hynstructure.com
EOL"


sudo a2enmod headers
sudo a2enmod rewrite
sudo a2ensite hynstructure
sudo systemctl restart apache2


# https://laracasts.com/discuss/channels/general-discussion/laravel-framework-file-permission-security
# allowing webserver to write to cache and storage
sudo groupadd hynstructure
sudo usermod -a -G hynstructure $USER 
sudo usermod -a -G hynstructure www-data
sudo chgrp -R hynstructure storage bootstrap/cache 
sudo chmod -R ug+rwx storage bootstrap/cache
