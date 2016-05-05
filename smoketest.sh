#!/bin/sh

# generate server keypair
./curvecpmakekey serverkey

# dump server public key (will be used by the client)
./curvecpprintkey serverkey > serverkey.hex
echo "server public key:"
cat serverkey.hex

echo -e "\nlaunch a server that serves a file."

# start curvecp server
# on each request, it launches curvecpmessage which serves a file
# (the curvecpserver itself for this test)
./curvecpserver this.machine.name serverkey \
  127.0.0.1 10000 31415926535897932384626433832795 \
  ./curvecpmessage cat ./curvecpserver &
serverpid=$!
echo "server PID: $serverpid"

echo -e "\nlaunch a client that get the file and compute its hash."

# launch the client. It launches curvecpmessage which reads the file
# sent by the server (on file descriptor 6) and compute the md5 hash

./curvecpclient this.machine.name `cat serverkey.hex` \
  127.0.0.1 10000 31415926535897932384626433832795 \
  ./curvecpmessage -c sh -c 'md5sum <&6'

echo -e "\ncompare with local hash:"
md5sum ./curvecpserver

# cleanup
echo -e "\nremove keys, kill server"
rm -R serverkey*
kill $serverpid

echo "done."

