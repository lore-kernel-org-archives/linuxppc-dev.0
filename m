Date: Thu, 1 Nov 2001 02:21:55 -0500 (EST)
From: Bill Fink <billfink@mindspring.com>
To: <linuxppc-dev@lists.linuxppc.org>
Cc: Bill Fink <billfink@mindspring.com>
Subject: sungem driver won't compile on latest benh kernel
Message-ID: <Pine.LNX.4.33.0111010200230.11565-100000@gwiz.nasa.atd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


When trying to do a make modules on the latest benh kernel (2.4.14-pre5-ben0),
the compile of the sungem driver fails spectacularly.  It looks like there
are missing include files linux/mii.h and linux/ethtool.h, plus undefined
variables and labels.  It was more than I wanted to mess with.  I was
interested in comparing the GigE performance of the gmac and sungem drivers,
but I guess I'll wait.

While on the topic, does anyone know if the GigE hardware in recent G4s
supports jumbo frames (9K byte MTU) for much higher network performance
and/or reduced CPU overhead?

I also want to try using the 3Com 3C996 GigE NIC card, which is supposed
to support jumbo frames.  So far the only Linux driver that I have found
for it is the bcm5700, but it hasn't been ported to PPC AFAIK.  An earlier
version of this driver I was able to compile and insmod, but the hardware
address reported by ifconfig was all FF's.  I believe there are probably
some endian issues with the driver.  I just recently got a newer version
of the bcm5700 driver that came with the RedHat 7.2 release, but I had
even less success with it.  I could build it fine, but when I tried to
insmod it, it hung my machine.

Has anyone else tried to do anything with the 3Com 3C996 GigE NIC card
and/or the bcm5700 driver (or updated the acenic driver to support tigon3,
which the bcm5700 uses)?

						-Thanks

						-Bill


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
