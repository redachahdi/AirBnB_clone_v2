#!/usr/bin/env bash
#script that sets up web servers for the deployment of web_static

#Install nginx
sudo apt-get update
sudo apt-get install -y nginx

#create directories and files
mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/
echo "Nginx Config Test" > /data/web_static/releases/test/index.html

#Symbolic link
ln -sf /data/web_static/releases/test/ /data/web_static/current

#Change ownership
sudo chown -R ubuntu /data/
sudo chgrp -R ubuntu /data/

# Update Nginx configuration
config_file="/etc/nginx/sites-available/default"
if grep -q "location /hbnb_static" "$config_file"; then
    sudo sed -i '/location \/hbnb_static/ {N;N;N;N;N;N;N;N;N;N;s/alias.*\n.*\n.*\n.*\n.*\n.*\n.*\n.*\n.*\n.*;/alias \/data\/web_static\/current\/;\n/}' "$config_file"
else
    sudo sed -i '/server_name _;/ a\\n\tlocation \/hbnb_static/ {\n\t\talias \/data\/web_static\/current\/;\n\t}' "$config_file"
fi

# Restart Nginx
service nginx restart