 set -e

 echo setting nodejs
 curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -
 if [ $? -eq 0 ]; then
   echo -e "\e success"
 else
   echo -e "failure"
   exit 1
 fi

 echo install nodejs
 yum install nodejs -y
  if [ $? -eq 0 ]; then
    echo -e "\e success"
  else
    echo -e "failure"
       exit 1
  fi

id roboshop
if [ $? -ne 0 ]; then
 echo adding user
 useradd roboshop
   if [ $? -eq 0 ]; then
     echo -e "\e success"
   else
     echo -e "failure"
        exit 1
   fi
fi

 echo downloading application content
 curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip"
 cd /home/roboshop
 if [ $? -eq 0 ]; then
   echo -e "\e success"
 else
   echo -e "failure"
      exit 1
 fi

 echo cleaning old application
 rm -rf cart
 if [ $? -eq 0 ]; then
   echo -e "\e success"
 else
   echo -e "failure"
      exit 1
 fi

 echo extract application archive
 unzip /tmp/cart.zip
 mv cart-main cart
 cd cart
 if [ $? -eq 0 ]; then
   echo -e "\e success"
 else
   echo -e "failure"
      exit 1
 fi

 echo installing nodejs
 npm install
 if [ $? -eq 0 ]; then
   echo -e "\e success"
 else
   echo -e "failure"
      exit 1
 fi

 echo configuring cart
 mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
 systemctl daemon-reload
 if [ $? -eq 0 ]; then
   echo -e "\e success"
 else
   echo -e "failure"
      exit 1
 fi

 echo starting cart service
 systemctl start cart
 systemctl enable cart
  if [ $? -eq 0 ]; then
    echo -e "\e success"
  else
    echo -e "failure"
    exit 1
  fi