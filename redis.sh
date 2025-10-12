source common.sh

COMPONENT=redis

echo setup YUM Repo
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
dnf module enable redis:remi-6.2 -y
 StatusCheck

 echo install Redis
 yum install redis -y
 StatusCheck

 echo Start Redis service
 systemctl enable redis && systemctl start redis
 StatusCheck