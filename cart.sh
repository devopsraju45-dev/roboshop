StatusCheck() {
   if [ $? -eq 0 ]; then
     echo -e "\e success"
   else
     echo -e "failure"
     exit 1
   fi
  }

 echo setting nodejs
 curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -
 StatusCheck

 echo install nodejs
 yum install nodejs -y
 StatusCheck

id roboshop
if [ $? -ne 0 ]; then
 echo adding user
 useradd roboshop
StatusCheck
fi

 echo downloading application content
 curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip"
 cd /home/roboshop
 StatusCheck

 echo cleaning old application
 rm -rf cart
 StatusCheck

 echo extract application archive
 unzip /tmp/cart.zip && mv cart-main cart
 StatusCheck

 echo installing nodejs
 npm install --verbose
 StatusCheck

 echo configuring cart
 mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service && systemctl daemon-reload
 StatusCheck

 echo starting cart service
 systemctl start cart && systemctl enable cart
StatusCheck