#!/bin/bash

#requires exactly 3 arguments

#argument 1 is the operation to perform ex. testBed
#argument 2 is the file name
#argument 3 is only for testBed and is the assign file for the checking

#put your information here
directoryName="yourDirectoryNameHere"
password="password"

#you'll have to go through file and enter your ipaddress and name in. This is for myself
#if anyone else wants to use it I'll make it more user friendly later


if [ $# -eq 0 ]
then
   echo "##########################################################################"
   echo "requires exactly 2 arguments for submit and styleChecker and 3 for testBed"
   echo "enter cs124Tool help for help"
   echo "##########################################################################"
   exit 1
elif [ "$1" = "help" ]
then
   echo "######################################################################"
   echo "testBed requires 3 arguments"
   echo "ex. cs124Tool testBed assign16 assignment16.cpp"
   echo "######################################################################"
   echo "styleChecker requires 2 arguments"
   echo "ex. cs124Tool styleChecker assignment16.cpp"
   echo "######################################################################"
   echo "submit requires 2 arguments"
   echo "ex. cs124Tool submit assignment16.cpp"
   echo "######################################################################"
   exit 0
fi

if [ "$1" = "testBed" ] 
then
   sshpass -p "${password}" rsync --progress -v -e "ssh -p 215" ./$3 yourname@xxx.xxx.xxx.xxx:/home/${directoryName}
   sshpass -p "${password}" ssh -tt -p 215 yourname@xxx.xxx.xxx.xxx << EOF
      testBed cs124/${2} ${3}
      exit
EOF
elif [ "$1" = "styleChecker" ]
then
   sshpass -p "${password}" rsync --progress -v -e "ssh -p 215" ./$2 yourname@xxx.xxx.xxx.xxx:/home/${directoryName}
   sshpass -p "${password}" ssh -tt -p 215 yourname@xxx.xxx.xxx.xxx << EOF
      styleChecker ${2}
      exit
EOF
elif [ "$1" = "submit" ]
then
   sshpass -p "${password}" rsync --progress -v -e "ssh -p 215" ./$2 yourname@.xxx.xxx.xxx:/home/${directoryName}
   sshpass -p "${password}" ssh -tt -p 215 yourname@xxx.xxx.xxx.xxx << EOF
      submit ${2}
EOF
else
   echo "#####################"
   echo "not a valid operation"
   echo "#####################"
   exit 1
fi

exit 0
