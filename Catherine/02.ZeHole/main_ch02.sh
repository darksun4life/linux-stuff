#!/bin/bash
#
#	Written and coded by Andrei and Levi
#	Use, modify and distribute as you wish.
#	Don't forget to give credits.
#
#	CHAPTER 02 functions :
#	            - foldit()
#				- hole()
#				- intro_titus()
#				- tavern()
#				- woods()
#				- woods_helper()
#				- the_run()
#				- boy_safe()
#               - house()
#				- house_helper()
#               - quit()
#				- hint_1()
#				- hint_2()
#
#

## -- Clear the screen before running the script
## -- Trap on CTRL-C
/usr/bin/clear
trap quit SIGINT
cat beggarshole-banner.txt

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

function hole() {
	
	declare VAR
	local VAR

	printf "${GREEN}Beggar's Hole${END_COLOR} ${RED}>${END_COLOR} "
	read VAR

	case ${VAR} in

		"ls")               	echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE}  one_eye.gz"
								echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE}  the_bum"
								echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE}  the_clueless"
								hole ;;

		"zcat one_eye.gz")  	grep "During" -A 10 ch02.txt | foldit
								intro_titus;;
		
		"cat the_bum")  		echo "I slip from workaholic to bum real easy..."
								hole ;;

		"cat the_clueless")		echo "Use zcat you fool!!! Said Mr. T ..."
								hole ;;

		*) 						if [[ "$VAR" == "" ]]; then
  								hint_1
								else printf ""
								fi
								hole ;;

	esac
}


function intro_titus() {

	declare VAR
	local VAR

	printf "${GREEN}Beggar's Hole${END_COLOR} ${RED}>${END_COLOR} "
	read VAR

	case ${VAR} in

		"ls") 					column -t <<< "
  								drwxr--r--  1 root root             675 ${DATE} the_tavern
  								drwxr--r--  1 ${PLAYER} ${PLAYER}   675 ${DATE} marketplace" | \
								awk '{ printf "%s %s %-8s %-8s %s %s %s %s %s\n", $1, $2, $3, $4, $5, $6, $7, $8, $9 }'
								intro_titus ;;
	
		"cd the_tavern") 		printf "Access denied! (hint: ${BLUE}sudo${END_COLOR})\n"
					 			intro_titus ;;

		"sudo cd the_tavern") 	grep -A 2 "The tavern was" ch02.txt | foldit
						  		tavern;;

		"cd marketplace") 		echo "Market is closed until 08:00 AM. Do something useful until then ${PLAYER}." | foldit
						  		intro_titus ;;

		*) 						if [[ "$VAR" == "" ]]; then
  								hint_1
								else printf ""
								fi
			   					intro_titus ;;

	esac
}

function tavern() {

	declare VAR
	local VAR

	printf "${GREEN}The Tavern${END_COLOR} ${RED}>${END_COLOR} "
	read VAR

	case ${VAR} in

		"ls") 					echo "drwxr-xr-x  1 ${PLAYER} ${PLAYER}    675 ${DATE} beggar_woods"
			  					echo "drwxr-xr-x  1 ${PLAYER} ${PLAYER}    675 ${DATE} crystal_lake"
			  					echo "drwxr-xr-x  1 ${PLAYER} ${PLAYER}    675 ${DATE} spooky_woods"
					  			tavern;;

		"cd beggar_woods") 		beggar_woods ;;

		"cd crystal_lake")		echo "You fell off a rock and drifted to the shore. Watch your step ${PLAYER}."
								intro_titus ;;

		"cd spooky_woods")		echo "You expected something spooky... But the GHOSTS are sleeping during the day."
								tavern;;

		"sudo cd the_tavern")	grep -A 2 "The tavern was" ch02.txt | foldit
						  		tavern ;;

		*) 						if [[ "$VAR" == "" ]]; then
  								hint_1
								else printf ""
								fi
			   					tavern ;;

	esac
}

function beggar_woods() {

	declare VAR
	local VAR

	printf "${GREEN}Beggar Woods${END_COLOR} ${RED}>${END_COLOR} "
	read VAR

	case ${VAR} in

		"ls")				echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} the_boy"
							echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} mushrooms"
							echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} black_tar"
							echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} rabbit"
							beggar_woods ;;

		"cat the_boy")		echo "The boys is lost. Find him ${PLAYER} !!"
							beggar_woods ;;

		"find the_boy")		grep -A 1 "goes to the nearby" ch02.txt | foldit | sed -e "s/PLAYER/${PLAYER}/"
							printf "Make a hideout to save him. The dogs are attacking, hurry ${PLAYER}! (Tip: create a folder named ${BLUE}hideout${END_COLOR})" | foldit
							echo ""
							beggar_woods ;;

		"cat mushrooms") 	echo "You found some mushrooms. You'll be high like a kite if you eat them ${PLAYER}, but the boy will be lost forever!" | foldit
					 		tavern ;;

		"cat black_tar") 	echo "You got stuck in the black tar. Well done ${PLAYER}!"
					 		tavern ;;

		"cat rabbit") 		echo "Follow the white rabbit!? Can it be that simple ??"
					  		intro_titus ;;

		"mkdir hideout")	echo "Hideout created. Move the boy to the hideout ${PLAYER}!"
					 		woods_helper ;;

		*) 					if [[ "$VAR" == "" ]]; then
  							hint_2
							else printf ""
							fi
			   				beggar_woods ;;

	esac
}

function woods_helper() {

	declare VAR
	local VAR

	printf "${GREEN}Beggar Woods${END_COLOR} ${RED}>${END_COLOR} "
	read VAR

	case ${VAR} in

		"ls") 					echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} the_boy"
			  					echo "drwxrwxrwx  1 ${PLAYER} ${PLAYER}    675 ${DATE} hideout"
			  					woods_helper ;;

		"mv the_boy hideout") 	echo "Well done. The brat is safe!"
								grep -A 0 "exiting from the" ch02.txt | foldit | sed -e "s/PLAYER/${PLAYER}/" && the_run && boy_safe ;;


		*) 						if [[ "$VAR" == "" ]]; then
  								hint_2
								else printf ""
								fi
			   					woods_helper ;;

	esac
}

function the_run() {
  	
  	count=0
	total=30
	echo "Running back to the tavern"
	pstr="[...............................................................]"
		
	while [ $count -lt $total ]; do
		sleep 0.1
		count=$(( $count + 1 ))
		pd=$(( $count * 73 / $total ))
		printf "\r%3d.%1d%% %.${pd}s" $(( $count * 100 / $total )) $(( ($count * 1000 / $total) % 10 )) $pstr
	done
		
	echo ""
	echo "Tavern reached"
	grep -A 0 "Once there" ch02.txt | foldit
}

function boy_safe() {

	declare VAR
	declare RTS

	local VAR
	local RTS

	## -- workaround for MacOSX 10.11
	RTS=$(which shuf 1> /dev/null; echo $?)

	printf "${GREEN}The Tavern${END_COLOR} ${RED}>${END_COLOR} "
	read VAR

	case ${VAR} in

		"ls") 						if [[ $RTS != "0" ]]; then
    									perl -MList::Util=shuffle -e 'print shuffle(<>);' < random.txt | perl -pe "s/PLAYER/${PLAYER}/g;s/today/${DATE}/g"
									else
										shuf random.txt | sed -e "s/PLAYER/${PLAYER}/g" -e "s/today/${DATE}/"
									fi 
									boy_safe ;;

		"cat titus_BlAKE")			echo "== Titus S. Blake =="
				   					echo "Address: Angry Dragon street, no. 666!"
						   			printf "Write down the address ${PLAYER} and hurry! (Tip: copy it to your ${BLUE}notes${END_COLOR})\n"
							   		boy_safe ;;

		"cat titus_blAke")			echo "== Titus A. Blake =="
				   					echo "Address: Blue Muffin Avenue, no. 69!"
						   			boy_safe ;;

		"cat titus_BlakE")			echo "== Titus X. Blake =="
				   					echo "Address: Cameltoe Plaza, no. 69!"
						   			boy_safe ;;

		"cat titus_bLAke")			echo "== Titus L. Blake =="
				   					echo "Address: Blue Ballz Square, no. 69!"
						   			boy_safe ;;

		"cat titus_BlaKE")			echo "== Titus D. Blake =="
				   					echo "Address: Curly Dick Road, no. 69!"
						   			boy_safe ;;						   							   			

		"cp titus_BlAKE notes") 	echo "At last, you found Titus ${PLAYER}!"
									grep -A 9 "Where is" ch02.txt | foldit | sed -e "s/PLAYER/${PLAYER}/"
									house ;;

		*) 							if [[ "$VAR" == "" ]]; then
  									hint_2
									else printf ""
									fi
			   						boy_safe ;;

	esac
}

function house() {
  	
  	declare VAR
  	local VAR
	
  	printf "${GREEN}Blake House${END_COLOR} ${RED}>${END_COLOR} "
  	read VAR
	
  	case ${VAR} in

		"ls") 				echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} fireplace"
		  					echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} crates"
			  				echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} table"
			  				echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} bed"
			  				printf "Titus, finding out about his parents death, can't seem to remember where the ${BLUE}letter${END_COLOR} is.\n" | foldit
			  				echo "Help him find it ${PLAYER}."
			  				house ;;

		"cat fireplace")	echo "You feel the warmth of the fire on your cold cheeks"
							house ;;

		"cat crates")		echo "I wonder what Titus is hidding in those crates. I guess I'll have a look when I get back." | foldit
							house ;;

		"cat table")		echo "A piece of moldy bread sits on the table."
							house ;;

		"cat bed")			echo "That bed looks really uncomfortable."
							house ;;

		"find letter") 		echo "Letter from Catherine to Titus:"
					   		echo ""
					   		grep -A 7 "Dear brother" ch02.txt | foldit
					   		house_helper ;;

		*) 					if [[ "$VAR" == "" ]]; then
  							hint_2
							else printf ""
							fi
		   					house ;;

	esac
}



function house_helper() {
			
  	declare VAR
  	local VAR
	
  	printf "${GREEN}Blake House${END_COLOR} ${RED}>${END_COLOR} "
  	read VAR
	
  	case ${VAR} in

		"ls") 				echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} fireplace"
							echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} letter"
		  					echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} crates"
			  				echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} table"
			  				echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} bed"
			  				echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} rage"
			  				house_helper ;;

		"cat fireplace")	echo "You feel the warmth of the fire on your cold cheeks"
							house_helper ;;

		"cat crates")		echo "I wonder what Titus is hidding in those crates. I guess I'll have a look when I get back." | foldit
							house_helper ;;

		"cat table")		echo "A piece of moldy bread sits on the table."
							house_helper ;;

		"cat bed")			echo "That bed looks really uncomfortable."
							house_helper ;;

		"cat letter") 		echo "Letter from Catherine to Titus:"
					   		echo ""
					   		grep -A 7 "Dear brother" ch02.txt | foldit
					   		house_helper ;;

		"cat rage") 		echo "su password is Catherine"
							house_helper ;;

		"su")				printf "Enter password: "
							read -s var1
							if  [[ $var1 = "Catherine" ]];then
								echo ""
								grep -A 5 "Damn bastard" ch02.txt | foldit | sed -e "s/PLAYER/${PLAYER}/"
								echo ""
								sleep 1
								count=0
								total=30
								read -n 1 -p "Press any key to continue ..."
								echo "Loading Chapter 03 :"
								pstr="[...............................................................]"
					
								while [ $count -lt $total ]; do
								  	sleep 0.1 
								  	count=$(( $count + 1 ))
								  	pd=$(( $count * 73 / $total ))
								  	printf "\r%3d.%1d%% %.${pd}s" $(( $count * 100 / $total )) $(( ($count * 1000 / $total) % 10 )) $pstr
	   							done
	   							cd ../03.Nekropolis
								/bin/bash ../03.Nekropolis/main_ch03.sh
								exit 0
				
		  					else
								echo ""
								echo "Password incorrect ${PLAYER}"
								
		  					fi
		  					house_helper ;;

		*) 					if [[ "$VAR" == "" ]]; then
  							hint_2
							else printf ""
							fi
		   					house_helper ;;

	esac
}

## -- HINTS

function hint_1() {

	echo "HINT: sudo, find, ls, cd, gunzip, cat, zcat"
}

function hint_2() {

	echo "HINT: find, ls, cd, gunzip, cat, cp, mv, mkdir, rm"
}


## -- Trap CRTL-C
function quit() { 

	exit 0 
}

## -- Functions

hole
intro_titus
tavern
woods
boy_safe
house
