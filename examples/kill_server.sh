#!/bin/sh

serverpid=`pidof curvecpserver`
if  [ z$serverpid = z ] ; then
	echo "no curvecpserver running"
	exit 
fi

echo "kill $serverpid"
kill $serverpid




