 set -e

 echo setting nodejs
 curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -
 echo $?

 echo install nodejs
 yum install nodejs -y
 echo $?

 echo adding user
 useradd roboshop
  echo $?

 echo downloading application content
 curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip"
 cd /home/roboshop
  echo $?

 echo cleaning old application
 rm -rf cart
  echo $?

 echo extract application archive
 unzip /tmp/cart.zip
 mv cart-main cart
 cd cart
  echo $?

 echo installing nodejs
 npm install
  echo $?

 echo configuring cart
 mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
 systemctl daemon-reload
  echo $?

 echo starting cart service
 systemctl start cart
 systemctl enable cart
  echo $?