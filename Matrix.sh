#!/bin/bash

SPEED=0.1
CHARSET="01"

trap 'tput cnorm; tput sgr0; clear' EXIT

clear
tput civis

ROWS=$(tput lines)
COLS=$(tput cols)

columns=()
for ((i=0; i<COLS; i++)); do
  columns[$i]=$((RANDOM % ROWS))
done

while :; do
  for ((i=0; i<COLS; i++)); do
    trail_row=$((columns[$i] - 4))
    if (( trail_row < 0 )); then
      trail_row=$((ROWS + trail_row))
    fi
    tput cup $trail_row $i
    echo -ne " "

    tput cup ${columns[$i]} $i
    echo -ne "${CHARSET:RANDOM%${#CHARSET}:1}"

    for ((j=1; j<=3; j++)); do
      trail_row=$((columns[$i] - j))
      if (( trail_row < 0 )); then
        trail_row=$((ROWS + trail_row))
      fi
      tput cup $trail_row $i
      echo -ne "\033[2m${CHARSET:RANDOM%${#CHARSET}:1}\033[0m"
    done

    columns[$i]=$(( (columns[$i] + 1) % ROWS ))
  done

  sleep $SPEED

done
