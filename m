Message-ID: <20021024125152.51288.qmail@web8004.mail.in.yahoo.com>
Date: Thu, 24 Oct 2002 05:51:52 -0700 (PDT)
From: rekha gvv <rekhagvvc@yahoo.co.in>
Subject: linux booted on fads!!!!
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello all,

Am happy to tell that linux booted up ....
the problem was that the  at  the time of low level
initialization the devices rs232,ethernet,irdn has to
be enabled using the BCSR1 register ..simple right ;)
but...kernel
 is hanging at this point ,,
vfs:unable to mount /dev/ram0 ....
rebooting in 180 seconds ..
to solve this problem  i downloaded  the ramdisk image
from the denx site
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/simple-ramdisk.image.gz.

I put this image in /arc/ppc/mbxboot  i did a
mkimage -n "linuxppc" -A ppc -O linux \
 -T ramdisk -C gzip -a 0 -e 0 -d
simple-ramdisk.image.gz. /tftpboot/ramimg

then
tftpboot 100000 linuximg
tftpboot 200000 ramimg
bootm 100000 200000

it hangs after
verifying checksum ....ok
Loading Ramdisk to 0035b000, end 0075b000...ok
then no output :(

how do i go abt this problem ....any hints


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
