COMPONENT=redis
source common.sh



echo setup YUM Repo
 curl -L https://raw.githubusercontent.com/roboshop-devops-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo
 StatusCheck

 echo install Redis
 yum install redis
 StatusCheck

  echo Update Listen address
  sed -i 's/1277.0.0.1/0.0.0.0/' /etc/redis.conf  /etc/redis/redis.conf
  StatusCheck

 echo Start Redis service
 systemctl enable redis && systemctl start redis
 StatusCheck