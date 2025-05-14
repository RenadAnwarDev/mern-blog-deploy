#!/bin/bash

exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

apt update -y
apt install -y git curl unzip tar gcc g++ make awscli

# تثبيت NVM وNode.js
su - ubuntu -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash'
su - ubuntu -c 'export NVM_DIR="$HOME/.nvm" && . "$NVM_DIR/nvm.sh" && nvm install --lts'
su - ubuntu -c 'export NVM_DIR="$HOME/.nvm" && . "$NVM_DIR/nvm.sh" && nvm alias default node'

# تثبيت PM2
su - ubuntu -c 'export NVM_DIR="$HOME/.nvm" && . "$NVM_DIR/nvm.sh" && npm install -g pm2'
su - ubuntu -c 'export NVM_DIR="$HOME/.nvm" && . "$NVM_DIR/nvm.sh" && pm2 startup'

# إنشاء مجلد لملفات اللوق
su - ubuntu -c 'mkdir -p ~/logs'

echo "EC2 user-data script done."