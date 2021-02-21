#!/bin/awk -f
BEGIN {
	numlist = 0
	nblines = 15
}
{
	if ( numlist == 1 && $1 == "--------------------------------------------------------------------------------------------" ) {
		exit
	}

	if ( numlist == 0 && $1 == "--------------------------------------------------------------------------------------------" ) {
		numlist = 1
		next
	}

	if ( numlist == 1 ) {
		if ( $0 ~ "=>" && nblines > 0 ) {
			SENDER = $2
			STX = pfFormat($5)
			getline
			RECEIVER = $1
			RTX = pfFormat($4)
			printf "%s,%s,%s,%s\n", SENDER, RECEIVER, RTX, STX
			nblines--
			if ( nblines < 1 ) {
				exit
			}
		}
		next
	}
}
END {
}

function pfFormat(str) {
 	sub("b","",str)
	return str
}
