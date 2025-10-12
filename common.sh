StatusCheck() {
   if [ $? -eq 0 ]; then
     echo -e "\e success"
   else
     echo -e "failure"
     exit 1
   fi
  }

 DOWNLOAD() {

         echo downloading ${COMPONENT} application content
         curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>/tmp/${COMPONENT}.log
         StatusCheck

 }

 Systemd(){
   systemctl daemon-reload
   systemctl start ${COMPONENT}
   systemctl enable ${COMPONENT}
   }
 APP_USER_SETUP(){

    id roboshop
     if [ $? -ne 0 ]; then
      echo adding user
      useradd roboshop
     StatusCheck
     fi
}
  APP_CLEAN(){
     echo cleaning old application
     rm -rf ${COMPONENT}
     StatusCheck
}
  NODEJS() {
     echo setting nodejs
     curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -
     StatusCheck

     echo install nodejs
     yum install nodejs -y
     StatusCheck

    APP_USER_SETUP

     DOWNLOAD

     APP_CLEAN

     echo extract application archive
     unzip /tmp/${COMPONENT}.zip && mv ${COMPONENT}-main ${COMPONENT}
     StatusCheck

     cd /home/roboshop
     echo installing nodejs
     npm install --verbose
     StatusCheck
  }
JAVA() {
  echo Install Maven
   yum install maven -y
   StatusCheck

   APP_USER_SETUP
   DOWNLOAD
   APP_CLEAN
     echo "Extracting application archive"
     cd /home/roboshop
     unzip -o /tmp/${COMPONENT}.zip &>>/tmp/${COMPONENT}.log
     mv ${COMPONENT}-main ${COMPONENT}
     cd ${COMPONENT}
     StatusCheck

     echo "Building Java package"
     mvn clean package &>>/tmp/${COMPONENT}.log
     mv target/${COMPONENT}-1.0.jar ${COMPONENT}.jar
     StatusCheck

   mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
   StatusCheck

   Systemd
}

PYTHON() {
  echo Install Python
   yum install python36 gcc python3-devel -y
   StatusCheck

   APP_USER_SETUP
   DOWNLOAD
   APP_CLEAN

   echo Install Python Dependencies
   cd /home/roboshop/payment
   pip3 install -r requirements.txt
   StatusCheck

   Systemd
 }
  USER_ID=$(id -u)
  if [ $USER_ID -ne 0 ]; then
    echo -e "the user should be an root user"
  exit 1
  fi

  LOG=/tmp/${COMPONENT}.log
  rm -f ${LOG}
