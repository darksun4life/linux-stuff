#!/bin/bash
#
#	Written and coded by Andrei and Levi
#	Use, modify and distribute as you wish.
#	Don't forget to give credits.
#
#	CHAPTER 03 functions :
#	            - foldit()
#				- the_sun()
#				- tavern_road()
#				- tavern()
#				- strangers_table()
#				- the_end()
#				- hint_1()
#				- hint_2()
#				- hint_3()
#               - quit()
#
#

## -- Clear the screen before running the script
## -- Trap on CTRL-C
/usr/bin/clear
trap quit SIGINT
cat ../03.Nekropolis/nekropolis-banner

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


function the_sun() {

	declare VAR
	local VAR

	## -- workaround for MacOSX 10.11
	RTS=$(which shuf 1> /dev/null; echo $?)

	printf "${GREEN}Nekropolis${END_COLOR} ${RED}>${END_COLOR} "
	read VAR

	case ${VAR} in

		"ls")               echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} lost"
							echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} found"
							echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} lost+found"
							the_sun ;;

		"ps")  				if [[ $RTS != "0" ]]; then
								echo "  PID TTY          TIME CMD"
								 perl -MList::Util=shuffle -e 'print shuffle(<>);' < ps.txt | perl -pe "s/PLAYER/${PLAYER}/g"
							else
								echo "  PID TTY          TIME CMD"
								shuf ps.txt | sed -e "s/PLAYER/${PLAYER}/g"
							fi
							the_sun;;
		
		"jobs")  			echo "[1]  + suspended  thesun"
							the_sun ;;

		"fg")				echo "[1]    25048 continued  thesun"
							echo ""
							grep -A 10 "The sun" ch03.txt | foldit
							tavern_road ;;
								
		"cat lost")			echo "I fear for Catherine. All is lost without her!"
							the_sun ;;

		"cat found")		echo "I have to find her! Where could she be?"
							the_sun ;;

		"cat lost+found")	echo "I cannot give up on her! Where are you my love?"
							the_sun ;;

		*) 					if [[ "$VAR" == "" ]]; then
  								hint_1
							else printf ""
							fi
			   				the_sun;;

	esac
}

function tavern_road() {

	declare VAR
	local VAR

	printf "${GREEN}Nekropolis${END_COLOR} ${RED}>${END_COLOR} "
	read VAR

	case ${VAR} in

		"ls")               				echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} road_signs"
											echo "drwxr--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} dragons_cave"
											echo "drwxr--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} doom_mountain"
											tavern_road ;;

		"cat road_signs")  					printf "${PLAYER}@nekropolis.tavern\n"
											tavern_road ;;

		"cd dragons_cave")					echo "Run for your life ${PLAYER} !!"
											echo ""
											cat dragons_cave.txt
											the_sun;;

		"cd doom_mountain")					echo "You fell into the hot lava. Well played ${PLAYER}."
											the_sun;;
		
		"ssh ${PLAYER}@nekropolis.tavern")	grep -A 0 "He sees" ch03.txt | foldit
											tavern ;;

		*)									if [[ "$VAR" == "" ]]; then
  												hint_3
											else printf ""
											fi
			   								tavern_road;;										
	esac
}

function tavern() {

	declare VAR
	local VAR

	printf "${GREEN}Nekropolis Tavern${END_COLOR} ${RED}>${END_COLOR} "
	read VAR

	case ${VAR} in

		"ls")				echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    675 ${DATE} the_keep"
							tavern;;

		"finger the_keep")  count=0
							total=30
							echo "Enquiring information from the keep."
							pstr="[...............................................................]"
							while [ $count -lt $total ]; do
								sleep 0.05
								count=$(( $count + 1 ))
								pd=$(( $count * 73 / $total ))
								printf "\r%3d.%1d%% %.${pd}s" $(( $count * 100 / $total )) $(( ($count * 1000 / $total) % 10 )) $pstr
							done
							echo ""
							printf "The bastard wants some ${BLUE}silver${END_COLOR}, I can see it in his greedy eyes!\n"
							tavern ;;

		"touch silver")  	echo "So that's what he was waiting for..."
							grep -A 1 "Where can I find" ch03.txt | foldit | sed -e "s/PLAYER/${PLAYER}/"
							strangers_table ;;
		
		*)					if [[ "$VAR" == "" ]]; then
  								hint_2
							else printf ""
							fi
			   				tavern;;
	esac
}

function strangers_table() {

	declare VAR
	local VAR

	printf "${GREEN}The table${END_COLOR} ${RED}>${END_COLOR} "
	read VAR

	## -- workaround for MacOSX 10.11
	RTS=$(which shuf 1> /dev/null; echo $?)

	case ${VAR} in

		"ls" )						if [[ $RTS != "0" ]]; then
    									perl -MList::Util=shuffle -e 'print shuffle(<>);' < random.txt | perl -pe "s/PLAYER/${PLAYER}/g;s/today/${DATE}/g"
									else
										shuf random.txt | sed -e "s/PLAYER/${PLAYER}/g;s/today/${DATE}/g"
									fi 
									strangers_table ;;

		"cat ThUg" )				echo "A mindless brute with crooked teeth. "
									strangers_table ;;

		"cat tHug")					echo "Looks like he could use a bath. I could smell him from from the bar."
									strangers_table ;;

		"cat ThuG")				    printf "That old scar on his face. He must be the one I'm looking for. (hint : rename him to ${BLUE}rotten_dagger${END_COLOR})\n" | foldit
									strangers_table ;;

		"mv ThuG rotten_dagger") 	grep -A 7 "Three men are" ch03.txt | foldit | sed -e "s/PLAYER/${PLAYER}/g"
									read -n 1 -p "Press any key to continue ..."
									/usr/bin/clear
									for frame in death{65..205};do cat "death/x${frame}.txt";sleep 0.06;done
									the_end;;

		* )							if [[ "$VAR" == "" ]]; then
  										hint_2
									else printf ""
									fi
									strangers_table ;;

	esac

}

function the_end() {

	declare VAR
	local VAR

	printf "${GREEN}THE END${END_COLOR} ${RED}>${END_COLOR} "
	read VAR

	case ${VAR} in

		"ls")					echo "-rw-r--r--  1 ${PLAYER} ${PLAYER}    275 ${DATE} catherine"
								echo "-rwxr--r--  1 ${PLAYER} ${PLAYER}    275 ${DATE} rotten_dagger"
								the_end;;

		"cat catherine")		grep -A 1 "voice trembled" ch03.txt | foldit | sed -e "s/PLAYER/${PLAYER}/g"
								the_end;;

		"touch catherine")		echo "Damn these chains, I must break free. Stay strong Catherine !! " | foldit
								the_end;;

		"pkill rotten_dagger")	grep -A 12 "feels the end nearing" ch03.txt | foldit | sed -e "s/PLAYER/${PLAYER}/g"
								cat the_end_banner.txt
								read -n 1 -p "Press any key exit the game ..."
							    /usr/bin/clear	
								exit 0;;

		"kill 25055")	grep -A 12 "feels the end nearing" ch03.txt | foldit | sed -e "s/PLAYER/${PLAYER}/g"
								cat the_end_banner.txt
								read -n 1 -p "Press any key exit the game ..."
							    /usr/bin/clear	
								exit 0;;

		"ps")  					if [[ $RTS != "0" ]]; then
								echo "  PID TTY          TIME CMD"
								 perl -MList::Util=shuffle -e 'print shuffle(<>);' < ps.txt | perl -pe "s/PLAYER/${PLAYER}/g"
								else
								echo "  PID TTY          TIME CMD"
								shuf ps.txt | sed -e "s/PLAYER/${PLAYER}/g"
								fi
								the_end ;;

		"cat rotten_dagger")	printf "$PLAYER feels an incredible urge to kill Rotten Dagger! (HINT: ${BLUE}ps${END_COLOR})\n"
								the_end ;;

		*)						if [[ "$VAR" == "" ]]; then
  									hint_2
								else printf ""
								fi
								the_end ;;

	esac

}

## -- HINTS

function hint_1() {

	echo "HINT: jobs, fg, bg, ps, ls"
}

function hint_2() {

	echo "HINT: touch, cd, ls, cat, finger, mv, ps, kill, pkill"
}

function hint_3() {

	echo "HINT: ls, cat, ssh, scp, ftp"
}

## -- Trap CRTL-C
function quit() { 

	exit 0
}

## -- Functions

the_sun
tavern_road
tavern
strangers_table
the_end
