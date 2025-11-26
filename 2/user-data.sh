#!/bin/bash
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
PRIVATE_IP=`curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4`

# Изменили имя файла
echo "My Private IP is: $PRIVATE_IP" > /home/ubuntu/private-ip-address.txt
chown ubuntu:ubuntu /home/ubuntu/private-ip-address.txt