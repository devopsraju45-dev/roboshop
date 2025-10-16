 set -e
 COMPONENT=catalogue
 source common.sh

 APP_USER_SETUP
 NODEJS



 Systemd
 mv /home/centos/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service


