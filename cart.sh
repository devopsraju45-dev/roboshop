 set -e

 echo setting nodejs
 curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -
 if [ $? -eq 0 ]; then
   echo -e "\esuccess"
 else
   echo -e "failure"
 fi

 echo install nodejs
 yum install nodejs -y
  if [ $? -eq 0 ]; then
    echo -e "\esuccess"
  else
    echo -e "failure"
  fi

 echo adding user
 useradd roboshop
   if [ $? -eq 0 ]; then
     echo -e "\esuccess"
   else
     echo -e "failure"
   fi

 echo downloading application content
 curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip"
 cd /home/roboshop
 if [ $? -eq 0 ]; then
   echo -e "\esuccess"
 else
   echo -e "failure"
 fi

 echo cleaning old application
 rm -rf cart
 if [ $? -eq 0 ]; then
   echo -e "\esuccess"
 else
   echo -e "failure"
 fi

 echo extract application archive
 unzip /tmp/cart.zip
 mv cart-main cart
 cd cart
 if [ $? -eq 0 ]; then
   echo -e "\esuccess"
 else
   echo -e "failure"
 fi

 echo installing nodejs
 npm install
 if [ $? -eq 0 ]; then
   echo -e "\esuccess"
 else
   echo -e "failure"
 fi

 echo configuring cart
 mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
 systemctl daemon-reload
 if [ $? -eq 0 ]; then
   echo -e "\esuccess"
 else
   echo -e "failure"
 fi

 echo starting cart service
 systemctl start cart
 systemctl enable cart
  if [ $? -eq 0 ]; then
    echo -e "\esuccess"
  else
    echo -e "failure"
  fi