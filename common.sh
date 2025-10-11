StatusCheck() {
   if [ $? -eq 0 ]; then
     echo -e "\e success"
   else
     echo -e "failure"
     exit 1
   fi
  }