 set -e

 echo Setup YUM repo
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>${LOG}
StatusCheck

 echo Installing MONGODB
 yum install -y mongodb-org &>>${LOG}
 StatusCheck

 echo Start MONGODB service
 systemctl enable mongod
 systemctl start mongod
 systemctl restart mongod


DOWNLOAD

echo extract scheama file
 cd /tmp
 unzip mongodb.zip
 StatusCheck

 echo load schema
 cd mongodb-main
 mongo < catalogue.js
 mongo < users.js

