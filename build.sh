#!/bin/bash

for f in *.md; do
	if [ "$f" == "README.md" ] || [ "$f" == "README.md" ]; then
		continue
	fi
	echo "Building: $f"
	output=${f%.*}.pdf
	pandoc $f --pdf-engine=xelatex -o pdf/$output &
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
	echo -ne "Done: $f \r"
	echo -ne "\n"
	echo "### — ###"
done

exit 0