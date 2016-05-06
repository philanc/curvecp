#!/bin/sh

../curvecpclient this.machine.name `cat servk.hex` \
    127.0.0.1 10000 31415926535897932384626433832795 \
       ../curvecpmessage -c sh -i -c  ./cli.sh

# sh -i  ... 
#   make shell interactive so that ctrl-c is not propagated to parent
#   processes, as curvecpclient would die without letting the server know
#   (took time to find this one :-))
#
exit
