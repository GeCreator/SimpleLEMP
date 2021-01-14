HOSTNAME=$1
APP_PATH=$2
BASHRC="/home/vagrant/.bashrc"

sudo apt update
sudo apt install -y htop net-tools vim zip unzip redis-server

echo "cd "$APP_PATH >> $BASHRC
echo "PS1=' \[\e[0;32m\]\u@'"$HOSTNAME"'\n\[\e[1;31m\]\$(__git_ps1 \"[%s]\")\[\e[0m\]\w\$ '" >> $BASHRC
