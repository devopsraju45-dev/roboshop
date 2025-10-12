source common.sh

COMPONENT=redis

echo setup YUM Repo
 curl -L https://raw.githubusercontent.com/roboshop-devops-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo
 StatusCheck

 echo install Redis
 yum install redis
 StatusCheck

 echo Start Redis service
 systemctl enable redis && systemctl start redis
 StatusCheck