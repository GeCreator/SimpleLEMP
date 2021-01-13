HOSTNAME=$1
PROJECT_DIR=$2

sudo apt install -y nginx

sudo cat /tmp/app.template | sed -e 's@$HOSTNAME@'$HOSTNAME'@g' | sed -e 's@$PROJECT_DIR@'$PROJECT_DIR'@g' > /etc/nginx/sites-available/app

sudo ln -sf /etc/nginx/sites-available/app /etc/nginx/sites-enabled/app
sudo mkdir $PROJECT_DIR -p
 
sudo nginx -s reload