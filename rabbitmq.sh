source common.sh

COMPONENT=rabbitmq

if [ -Z "$APP_RABBITMQ_PASSWORD" ]; then
  echo -e "env var rabbitmq password is needed"
  exit 1
fi
echo Setup YUM Repos
 curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash
StatusCheck
 yum install erlang -y

 curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash

echo  Install rabbitmq
 yum install rabbitmq-server -y
 StstusCheck

 systemctl enable rabbitmq-server
 systemctl start rabbitmq-server

 echo Add tags to rabbitmq


 rabbitmqctl add_user roboshop ${APP_RABBITMQ_PASSWORD}
 rabbitmqctl set_user_tags roboshop administrator
 rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"