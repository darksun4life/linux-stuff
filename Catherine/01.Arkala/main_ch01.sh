#!/bin/bash
#
#	Written and coded by Andrei and Levi
#	Use, modify and distribute as you wish.
#	Don't forget to give credits.
#
#	CHAPTER 01 functions :
#				- foldit()
#				- beginnings()
#				- middle()
#				- poem()
#				- eremus()
#				- plant()
#				- cartographer()
#				- quit()
#				- hint_1()
#				- hint_2()
#				- hint_3()
#
#

## -- Clear the screen before running the script
## -- Trap on CTRL-C
/usr/bin/clear
trap quit SIGINT

## -- Improve variable visibility
declare PLAYER
declare RED
declare BLUE
declare GREEN
declare END_COLOR

## -- Colors
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
END_COLOR="\e[0m"

## -- Getting date for the script
declare DATE
DATE=$(date +"%b %d %H:%M")

## -- Fold text at a maximum width of 80 characters
function foldit() {

	fold -w 80 -s
}

sed -e "s/PLAYER/${PLAYER}/" header.txt | foldit

function beginnings() {
	
    declare VAR
	local VAR

	printf "${RED}>${END_COLOR} "
	read VAR

	case ${VAR} in
		"cd arkala")		/usr/bin/clear
							cat arkala-banner.txt ;;

		"ls")				echo "drwxr-xr-x. 2 ${PLAYER} ${PLAYER}    6 ${DATE}  arkala"
							echo "drwxr-xr-x. 2 ${PLAYER} ${PLAYER}    6 ${DATE}  black_woods"
							echo "drwxr-xr-x. 2 ${PLAYER} ${PLAYER}    6 ${DATE}  certain_death"
							echo "drwxr-xr-x. 2 ${PLAYER} ${PLAYER}    6 ${DATE}  nebula_sea"
							beginnings;;

		"cd black_woods")	grep "You've reached the" ch01_folders -A 1 | sed -e "s/PLAYER/${PLAYER}/" | foldit
							beginnings;;

		"cd certain_death")	grep "You fell off the" ch01_folders -A 0 | sed -e "s/PLAYER/${PLAYER}/" | foldit
							beginnings;;

		"cd nebula_sea")	grep "You fell into the" ch01_folders -A 1 | sed -e "s/PLAYER/${PLAYER}/" | foldit
							beginnings;;

		*)					if [[ "$VAR" == "" ]]; then
  							hint_1
							else printf ""
							fi
							beginnings;;

	esac
}

function middle() {

	declare VAR
	local VAR

	printf "${GREEN}Arkala${END_COLOR} ${RED}>${END_COLOR} "
	read VAR

	case ${VAR} in
		"ls")					echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} the_black_dye"
								echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} the_roses"
								echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} the_rumours"
								echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} the_wait"
								middle;;

		"cat the_black_dye")	grep -A 0 "you found a bottle" ch01_folders | sed -e "s/PLAYER/${PLAYER}/" | foldit
								middle;;

		"cat the_roses")		grep -A 0 "you found some" ch01_folders | sed -e "s/PLAYER/${PLAYER}/" | foldit
								middle;;

		"cat the_rumours") 		grep -A 0 "there's some rumours" ch01_folders | sed -e "s/PLAYER/${PLAYER}/" | foldit
								middle;;

		"cat the_wait")			grep -A 5 "In an era" ch01.txt | sed -e "s/PLAYER/${PLAYER}/" | foldit
								poem;;

		*)						if [[ "$VAR" == "" ]]; then
  								hint_1
								else printf ""
								fi
								middle;;

	esac

}

function poem() {

	declare VAR
	local VAR

	printf "${GREEN}Arkala${END_COLOR} ${RED}>${END_COLOR} "
	read VAR

	case ${VAR} in
		"ls")				echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} poem.gz"
							poem;;

		"cat poem.gz")		echo "${PLAYER}, the file seems to be an archive."
							poem;;

		"gunzip poem.gz")	count=0
							total=30
							echo decompressing poem.gz
							pstr="[===============================================================]"

							while [ $count -lt $total ]; do
							  	sleep 0.1 
							  	count=$(( $count + 1 ))
							  	pd=$(( $count * 73 / $total ))
							  	printf "\r%3d.%1d%% %.${pd}s" $(( $count * 100 / $total )) $(( ($count * 1000 / $total) % 10 )) $pstr
	   						done

							echo ""
							echo done
							grep -A 17 "The wild" ch01.txt | sed -e "s/PLAYER/${PLAYER}/" | foldit
							eremus;;

		*)					if [[ "$VAR" == "" ]]; then
  							hint_3
							else printf ""
							fi
							poem;;

	esac
}

function eremus() {

	declare VAR
	local VAR

	printf "${GREEN}Arkala's cartographer${END_COLOR} ${RED}>${END_COLOR} "
	read VAR

	case ${VAR} in
		"ls")					echo "drwxr-xr-x. 2 ${PLAYER} ${PLAYER}    6 ${DATE}  black_tulip_inn"
								echo "drwxr-xr-x. 2 ${PLAYER} ${PLAYER}    6 ${DATE}  nebula_sea"
								echo "drwxr-xr-x. 2 ${PLAYER} ${PLAYER}    6 ${DATE}  red_woods"
								echo "drwxr-xr-x. 2 ${PLAYER} ${PLAYER}    6 ${DATE}  town_square"
								eremus;;

		"cd red_woods")			echo "You've reached the Red Woods, try finding some eremus plants"
								plant;;

		"cd town_square")		grep "You have" ch01_folders -A 0 | sed -e "s/PLAYER/${PLAYER}/" | foldit
								eremus;;

		"cd black_tulip_inn")	grep "No time for" ch01_folders -A 0 | sed -e "s/PLAYER/${PLAYER}/" | foldit
								eremus;;

		"cd nebula_sea")		grep "You fell into" ch01_folders -A 0 | sed -e "s/PLAYER/${PLAYER}/" | foldit
								beginnings;;

		"cat eremus")			echo "42";;

		*)						if [[ "$VAR" == "" ]]; then
  								hint_2
								else printf ""
								fi
								eremus;;

	esac

}

function plant() {

	declare VAR
	local VAR

	printf "${GREEN}Red Woods${END_COLOR} ${RED}>${END_COLOR} "
	read VAR

	case ${VAR} in
		"ls")				echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE}  eremus"
							echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE}  moonglow"
							echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE}  spider_rose"
							echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE}  quiet_clover"
							plant;;

		"find eremus")		echo "A batch of 42 Eremus plants found, let's pick them up and hurry back to the cartographer"
							echo ""
							cartographer;;

		"cat eremus")		echo "Some eremus plants found ${PLAYER}, but these won't be enough (tip: use find)"
	        				plant;;

	    "cat moonglow")		echo "Not the right plant, keep looking ${PLAYER}. "
	        				plant;;

	    "cat spider_rose")	echo "Not the right plant, keep looking ${PLAYER}. "
	        				plant;;

	    "cat quiet_clover")	echo "Not the right plant, keep looking ${PLAYER}. "
	        				plant;;

	    *)					if [[ "$VAR" == "" ]]; then
  							hint_2
							else printf ""
							fi
							plant;;

	esac
}

function cartographer() {

	declare VAR
	local VAR

	echo "- Please tell me you've got the plants for my wife!?!"
	echo "- Yes, I found a batch of them."
	echo "- How many?"

	printf "Please enter the number of plants you found ${PLAYER}: "
	read VAR

	if [[ ${VAR} = 42 ]]
	    then
			echo "- Marvelous!!! Here's the map you need."
			echo "The journey to Beggar's Hole begins!"
			echo ""
			sleep 1
			count=0
			total=30
			read -n 1 -p "Press any key to continue ..."
			echo "Loading Chapter 02 :"
			pstr="[...............................................................]"

			while [ $count -lt $total ]; do
			  	sleep 0.1
			  	count=$(( $count + 1 ))
			  	pd=$(( $count * 73 / $total ))
			  	printf "\r%3d.%1d%% %.${pd}s" $(( $count * 100 / $total )) $(( ($count * 1000 / $total) % 10 )) $pstr
	   		done

			cd ../02.ZeHole/
			/bin/bash ../02.ZeHole/main_ch02.sh
			exit 0

		else
			echo "- Hmmmm, I think you're trying to kill my wife, please be more careful !!!"
			echo ""
			sleep 2
			cartographer
			return 0
	fi
}

## -- Trap CRTL-C and print a more user friendly exit message
function quit() {

	printf "\nGoodbye ${BLUE}${PLAYER}${END_COLOR}. Do come again.\n"
	exit 0
}

## -- HINTS

function hint_1() {

	echo "HINT: cat, cd, ls, man"
}

function hint_2() {

	echo "HINT: ls, cd, man, cat, find"
}

function hint_3() {

	echo "HINT: ls, cd, man, cat, zcat, tar, gunzip"
}

## -- Functions

beginnings
middle
poem
eremus
cartographer
