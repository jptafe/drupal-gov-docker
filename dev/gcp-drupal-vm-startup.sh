#!/bin/bash

# DEPENDANCIES
apt-get -y install git
cd /opt
wget https://getcomposer.org/installer
php ./installer

# CONFIGURE DATABASE
mysql -u root -e "grant all privileges on drupal.* to du@localhost identified by 'dp'"
mysql -u root drupal < sql/dump.sql

# CONFIGURE DRUPAL
git clone https://github.com/jptafe/drupal-gov-docker
cd drupal-gov-docker
../composer.phar update --no-interaction
./drush cache:rebuild
./drush updatedb
chmod -R 777 /opt/drupal-gov-docker/web/sites/default/files

# DEPLOY TO HTDOCS
rm -rf /var/www/html
ln -s /opt/drupal-gov-docker/web /var/www/html
