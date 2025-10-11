source common.sh

NODEJS

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

 cd /home/roboshop
 echo installing nodejs
 npm install --verbose
 StatusCheck

 echo configuring cart
 mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service && systemctl daemon-reload
 StatusCheck

 echo starting cart service
 systemctl start cart && systemctl enable cart
StatusCheck