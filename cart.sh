source common.sh
COMPONENT=cart
NODEJS



 echo configuring cart
 mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service && systemctl daemon-reload
 StatusCheck

 echo starting cart service
 systemctl start cart && systemctl enable cart
StatusCheck