#!/bin/bash

cyan=`tput setaf 6`
green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput setaf 5`
reset1=`tput sgr0`

# cd /media/sreeraj/20A81E3CA81E10C0/laravel/diary/
 echo "${green}Entered in to the laravel project folder${reset}" 

git checkout sreeraj
git status
echo "${cyan}Enter the number of files want to be add${yellow} // if 0 add all files${reset}"
read count
if [ $count -eq 0 ]
then
	git add .
	echo "${green}added all the files${reset}"
else
	while [ $count -gt 0 ];
	do
    		echo "${cyan}Add the file${reset}"
		read file
		git add $file
		((count--))
	done
fi
git status
echo "${cyan}Enter the commit message${reset}"
read msg
 git commit -m "${msg##*  }"
echo "${green}Committed successfully and start to push...${reset}"

echo "${reset1}"

git push origin sreeraj

echo "${green}pushed successfully${reset}"

git checkout main
git pull origin main
git pull origin sreeraj
echo "${reset1}"
git push origin main

echo "${green}Pushed to main branch${reset}"
git checkout sreeraj
# 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