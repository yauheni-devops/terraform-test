#!/bin/bash
# Получаем локальный IP адрес через метаданные AWS (IMDSv2)
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
PRIVATE_IP=`curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4`

# Записываем IP в файл в домашней директории пользователя ubuntu
echo "My Private IP is: $PRIVATE_IP" > /home/ubuntu/private-ip.txt

# Устанавливаем права, чтобы файл принадлежал пользователю ubuntu, а не root
chown ubuntu:ubuntu /home/ubuntu/private-ip.txt