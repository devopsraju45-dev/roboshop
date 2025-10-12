#!/bin/bash
COMPONENT=frontend
source common.sh



 echo installing nginx
 yum install nginx -y
 StatusCheck

DOWNLOAD

echo Clean Old Content
cd /usr/share/nginx/html && rm -rf *
StatusCheck


 echo Extract Download Content
 unzip -o /tmp/frontend.zip
 mv frontend-main/static/* .
 mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf
 StatusCheck

 echo Start Nginx Service
 systemctl restart nginx


