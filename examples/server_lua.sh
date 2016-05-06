#!/bin/sh

../curvecpserver this.machine.name servk \
    127.0.0.1 10000 31415926535897932384626433832795 \
      ../curvecpmessage /bin/sh -c "lua repl.lua 2>&1 " &
pid=$!
echo "server_lua PID: $pid"


