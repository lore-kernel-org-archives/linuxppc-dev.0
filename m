From: Miles Lane <miles.lane@comcast.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: linuxppc-2.5 (rsync mvista) -- drivers/input/evdev.c:243: error: invalid lvalue in asm statement
Date: Sat, 2 Aug 2003 18:23:30 -0700
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200308021823.30382.miles.lane@comcast.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  CC      drivers/input/evdev.o
drivers/input/evdev.c: In function `evdev_ioctl':
drivers/input/evdev.c:243: error: invalid lvalue in asm statement
drivers/input/evdev.c:243: error: invalid lvalue in asm statement
drivers/input/evdev.c:243: error: invalid lvalue in asm statement
drivers/input/evdev.c:243: error: invalid lvalue in asm statement
make[2]: *** [drivers/input/evdev.o] Error 1

Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11x
e2fsprogs              1.32
pcmcia-cs              3.2.3
PPP                    2.4.1
nfs-utils              1.0.5
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
GNU ld version 2.14 20030612

CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=m


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
