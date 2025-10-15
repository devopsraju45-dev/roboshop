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

 sed -e '/catalogue/ s/localhost/catalogue-dev.learndevopspractice.online/' '/cart/ s/localhost/cart-dev.learndevopspractice.online/' '/user/ s/localhost/user-dev.learndevopspractice.online/' '/payement/ s/localhost/payement-dev.learndevopspractice.online/' /etc/nginx/default.d/roboshop.conf


 echo Start Nginx Service
 systemctl restart nginx


