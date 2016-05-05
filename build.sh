#!/bin/sh

# build curvecp programs (static build, with Musl libc)

# adjust the following path to the location of your Musl libc tree 
# and gcc wrapper
CC="/f/b/musl1114/bin/musl-gcc"

# stop at first error
set -e

# display commands
# set -x

SRCS="blocking.c byte_copy.c byte_isequal.c byte_zero.c crypto_block.c \
	die.c e.c hexparse.c load.c nameparse.c nanoseconds.c open_cwd.c  \
	open_lock.c open_pipe.c open_read.c open_write.c portparse.c  \
	randommod.c  safenonce.c savesync.c socket_bind.c socket_recv.c  \
	socket_send.c socket_udp.c uint16_pack.c uint16_unpack.c   \
	uint32_pack.c uint32_unpack.c uint64_pack.c uint64_unpack.c  \
	writeall.c curvecpprintkey.c curvecpmakekey.c curvecpclient.c  \
	curvecpserver.c curvecpmessage.c iptostr.c randombytes.c tweetnacl.c  \
	curvecpupdatenoncecounter.c curvecpprintkey32.c"

LIBOBJS="blocking.o byte_copy.o byte_isequal.o byte_zero.o crypto_block.o \
	die.o e.o hexparse.o load.o nameparse.o nanoseconds.o open_cwd.o  \
	open_lock.o open_pipe.o open_read.o open_write.o portparse.o \
	randommod.o safenonce.o savesync.o socket_bind.o socket_recv.o \
	socket_send.o socket_udp.o uint16_pack.o uint16_unpack.o \
	uint32_pack.o uint32_unpack.o uint64_pack.o uint64_unpack.o \
	writeall.o iptostr.o randombytes.o tweetnacl.o"

PROGS="curvecpprintkey curvecpmakekey curvecpclient curvecpserver \
	curvecpmessage curvecpupdatenoncecounter curvecpprintkey32"

for x in $SRCS; do 
	echo "compiling $x"
	$CC -c src/$x
done

ar rcu libcurvecp.a $LIBOBJS

for x in $PROGS; do 	
	echo "building $x"
	$CC -static -o $x $x.o libcurvecp.a
	strip $x
done

rm *.o *.a

echo "done."
