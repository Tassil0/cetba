#!/bin/bash

output=${1%.*}.pdf
echo "Building: $1"
pandoc $1 --pdf-engine=xelatex -o pdf/$output &
pid=$!
trap "kill $pid 2> /dev/null" EXIT
counter=0
while kill -0 $pid 2> /dev/null; do
	case $counter in
		0)
			echo -ne "### | ### \r"
			counter=1
			;;
		1)
			echo -ne "### / ### \r"
			counter=2
			;;
		2)
			echo -ne "### — ### \r"
			counter=3
			;;
		3)
			echo -ne "### \\ ### \r"
			counter=0
			;;
	esac
	sleep 0.1
done
trap - EXIT
echo -ne "Done: $1 \r"
echo -ne "\n"

exit 0