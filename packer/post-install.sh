#!/bin/bash
set -e
sudo yum update -y

# Install Nginx
echo "Installing Nginx..."
sudo amazon-linux-extras enable nginx1
sudo yum install nginx -y

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Install Node.js
echo "Installing Node.js..."
sudo yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
sudo yum install -y nodejs

# Create the Node.js application
echo "Creating the Node.js application..."
cat <<EOL > /home/ec2-user/app.js
const http = require('http');
const hostname = '0.0.0.0';
const port = 3000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('HOLA MUNDO\n');
});

server.listen(port, hostname, () => {
  console.log(\`Server running at http://\${hostname}:\${port}/\`);
});
EOL

# Install dependencies and run the application
cd /home/ec2-user
sudo chown ec2-user:ec2-user *
sudo chmod 777 *

# Create package.json with a dummy test script
echo "Creating package.json with dummy test script..."
cat <<EOL > /home/ec2-user/package.json
{
  "name": "ec2-user",
  "version": "1.0.0",
  "main": "app.js",
  "scripts": {
    "test": "echo \"test\" && exit 0"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "description": ""
}
EOL

echo "Installing Node.js dependencies..."
npm init -y
npm install

sudo chown ec2-user:ec2-user /etc/nginx/conf.d/
sudo chmod 775 /etc/nginx/conf.d/

# Configure Nginx as a reverse proxy
echo "Configuring Nginx as a reverse proxy..."
sudo cat <<EOL > /etc/nginx/conf.d/nodeapp.conf
server {
    listen 80;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOL

# Restart Nginx to apply changes
sudo systemctl restart nginx

# Configure Node.js to run at startup
echo "Configuring Node.js to run at startup..."
#sudo cat <<EOL > /etc/systemd/system/nodeapp.service
sudo cat <<EOL > /tmp/nodeapp.service
[Unit]
Description=Node.js Application
After=network.target

[Service]
ExecStart=/usr/bin/node /home/ec2-user/app.js
Restart=always
User=ec2-user
Group=ec2-user
Environment=PATH=/usr/bin:/usr/local/bin
Environment=NODE_ENV=production
WorkingDirectory=/home/ec2-user

[Install]
WantedBy=multi-user.target
EOL
sudo chown root:ec2-user /tmp/nodeapp.service
sudo chmod 774 /tmp/nodeapp.service
sudo mv /tmp/nodeapp.service /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl start nodeapp
sudo systemctl enable nodeapp

echo "Installation and configuration complete. The application is running on port 80."
