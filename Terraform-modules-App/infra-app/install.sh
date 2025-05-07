#!/bin/bash

sudo yum install update
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>This is my sever owner yash</h1" | sudo tee /var/www/html/index.html
