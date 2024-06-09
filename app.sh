#!/bin/bash

sleep 30

sudo yum update -y
sudo sudo yum install -y gcc-c++ make unzip -y
curl -sL https://rpm.nodesource.com/setup_14.x | sudo -E bash -
sudo yum install -y nodejs

echo "The node version is "
npm -v

cd ~/ && unzip cocktails_app.zip
cd cocktails && npm i --only=prod

sudo cp /tmp/cocktails.service /etc/systemd/system/cocktails.service
sudo systemctl start cocktails.service
sudo systemctl enable cocktails.service