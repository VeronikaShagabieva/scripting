#!/bin/bash

guessed_right=0
guessed_wrong=0



while [[ true ]]; do
	rnd=$(shuf -i 0-9 -n 1)
		
	read -p "Guess the number from 0 to 9 (q - end of game): " input

	[[ "${input}" == 'q' ]] && { echo "Finish"; exit 0; }

	[[ "${input}" =~ ^[0-9]$ ]] || { echo "Please enter a valid number from 0 to 9!"; continue; }

	if (( "${input}" == rnd )); then
		guessed_right=$((guessed_right+1))
		echo "Guessed right!"
	else
		guessed_wrong=$((guessed_wrong+1))
		echo "Guessed wrong!"
	fi

RED='\e[31m'
GREEN='\e[32m'
RESET='\e[0m'

if (( rnd != input ))
	then
	    number_string="${RED}${rnd}${RESET}" # неверные выделяем красным
	else
            number_string="${GREEN}${rnd}${RESET}" # верные выделяем зеленым
fi

	rnd_hist+=( $rnd )

	guessed_right_percent=$((guessed_right*100/(guessed_right+guessed_wrong)))

	echo "Statistics (guessed/not guessed): ${guessed_right_percent}% / $((100-guessed_right_percent))%"
	echo "Hidden numbers: ${rnd_hist[@]}"
	
done
