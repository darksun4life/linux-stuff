#!/bin/bash
#
#	Written and coded by Andrei and Levi
#	Use, modify and distribute as you wish.
#	Don't forget to give credits.
#


## -- Clear the screen before running the functions
/usr/bin/clear

## -- Run the ASCII
tput civis # hide cursor
for i in start_game/t{1..80}; do cat $i; sleep 0.08; clear; done
tput cnorm # get back to normal cursor

## --
title="-- Select your action --"
prompt="Pick an option:"
options=("Start game")

echo "$title"
PS3="$prompt "
select opt in "${options[@]}" "Quit"; do 

    case "$REPLY" in

    1)							## -- get working directory for script call
								CURRENT=$(pwd)
								printf "Enter desired player name: "
								read PLAYER
								export PLAYER  
								cd "${CURRENT}/01.Arkala/"; /bin/bash main_ch01.sh
								exit 0;;
    
    $(( ${#options[@]}+1 )) ) 	echo "Goodbye!"; break;;
    
    *) 							echo "Invalid option. Try another one.";continue;;

    esac

done