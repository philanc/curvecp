#!/bin/bash
#
# _very_ crude command line interface :-)
#      
#   loop {
#      read lines from server (fd 6), send them to stdout
#      read line from stdin, send it to server (fd 7)
#   }
#
# The loop can be broken with ctrl-d (end of file) or ctrl-c (interrupt).
# In that case, curvecpclient, client-side and serveside curvecpmessage
# should exit.  curvecpserver is not terminated.
# Beware! this is not robust! :-)
#
#-----------------------------------------------------------
# must exit cleanly on ctrl-c

function ctrl_c() {
	echo " . . . "
	exit 1
}

function on_exit() {
	# close the pipe so that server-side curvecpmessage will exit
	exec 7>&-
	echo "cli.sh exiting."
}

trap ctrl_c INT
trap on_exit EXIT
#-----------------------------------------------------------

while /bin/true ; do
	# read lines from server (if any) and display them
	while /bin/true; do
		# read with timeout 0.5 sec (-t is bash-specific)
		read -t 0.5  line <&6 || break
		echo "== $line"
	done
	
	# read a line from stdin 
	read -p "?? " line
	st=$?
	if  [ $st = 1 ] ; then
		echo "EOF"
		# close output pipe to server
		exec 7>&-
		exit 0
	fi
	# send the line to the server
	echo "$line" >&7
done

