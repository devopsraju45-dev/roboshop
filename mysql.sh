source common.sh

COMPONENT=mysql

if [ -z "$MYSQL_PASSWORD" ]; then
  echo -e "mysql password is missing"
  exit 1
fi


echo SETUP YUM REPO
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo
StatusCheck

echo Start Mysql
dnf module disable mysql
 yum install mysql-community-server -y

 systemctl enable mysqld
 systemctl start mysqld

 StatusCheck

 grep temp /var/log/mysqld.log

 mysql_secure_installation

 if [ $? -ne 0 ]; then
  echo Changing Default Password
  DEFAULT_PASSWORD=$(grep 'A temporary password' /var/log/mysqld.log | awk '{print $NF}')
  echo "alter user 'root'@'localhost' identified with mysql_native_password by 'RoboShop@1';" | mysql --connect-expired-password -uroot -p${DEFAULT_PASSWORD}
  StatusCheck
 fi

 echo "show plugins" | mysql -uroot -p$MYSQL_PASSWORD
  if [ $? -eq 0 ]; then
    echo remove plugin
    echo "uninstall plugin validate_password" | mysql -uroot -p$MYSQL_PASSWORD
    StatusCheck
  fi

 exit

 mysql -uroot -p$MYSQL_PASSWORD

#> uninstall plugin validate_password;

 curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"

 echo extract and load schema
 cd /tmp
 unzip mysql.zip
 cd mysql-main
 mysql -u root -pRoboShop@1 <shipping.sql