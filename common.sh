StatusCheck() {
   if [ $? -eq 0 ]; then
     echo -e "\e success"
   else
     echo -e "failure"
     exit 1
   fi
  }

  DOWNLOAD{} {
         echo downloading ${COMPONENT} application content
         curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>/tmp/${COMPONENT}.log
         cd /home/roboshop
         StatusCheck
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

     DOWNLOAD

     echo cleaning old application
     rm -rf ${COMPONENT}
     StatusCheck

     echo extract application archive
     unzip /tmp/${COMPONENT}.zip && mv ${COMPONENT}-main ${COMPONENT}
     StatusCheck

     cd /home/roboshop
     echo installing nodejs
     npm install --verbose
     StatusCheck
  }

  USER_ID=$(id -u)
  if [ $USER_ID -ne 0 ]; then
    echo -e "the user should be an root user"
  exit 1
  fi