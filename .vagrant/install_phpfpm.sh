sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:ondrej/php
sudo apt update
sudo apt install -y php7.4-raphf php7.4-propro php7.4-fpm php7.4-imagick php7.4-zip php7.4-curl php7.4-gd php7.4-json php7.4-sqlite3 php7.4-redis php7.4-xml php7.4-opcache php7.4-http php7.4-mbstring php7.4-mysql php7.4-cli php7.4-common

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
sudo mv composer.phar /usr/bin/composer

rm composer-setup.php -f