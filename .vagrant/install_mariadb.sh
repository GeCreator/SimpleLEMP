# This script automatically installs and configures MariaDB 10.1.
user=$1
password=$2

sudo apt -y install software-properties-common gnupg-curl apt-transport-https
sudo apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
sudo add-apt-repository 'deb [arch=amd64,arm64,i386,ppc64el] https://archive.mariadb.org/repo/10.5/ubuntu xenial main'

sudo apt -y update

# install mariadb
sudo apt -y install mariadb-server

# set root password
#sudo /usr/bin/mysqladmin -u root password  123456

sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO '"$user"'@'%' IDENTIFIED BY '"$password"' WITH GRANT OPTION;"

# ensure it is running
sudo /etc/init.d/mysql restart
