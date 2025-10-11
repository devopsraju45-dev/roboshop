StatusCheck() {
   if [ $? -eq 0 ]; then
     echo -e "\e success"
   else
     echo -e "failure"
     exit 1
   fi
  }

  NODEJS() {
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
  }