Date: Thu, 1 Jul 2004 09:08:08 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: compile error, USB gadgets
Message-ID: <Pine.LNX.4.60.0407010905590.18253@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   not sure if i should report this here or to the kernel list proper,
but after selecting support for USB gadgets, ethernet (RPXlite
configuration, just goofing around):

CC      drivers/usb/gadget/ether.o
drivers/usb/gadget/ether.c: In function `eth_bind':
drivers/usb/gadget/ether.c:2380: `fs_status_desc' undeclared (first
use in this function)
drivers/usb/gadget/ether.c:2380: (Each undeclared identifier is
reported only once
drivers/usb/gadget/ether.c:2380: for each function it appears in.)
make[3]: *** [drivers/usb/gadget/ether.o] Error 1
make[2]: *** [drivers/usb/gadget] Error 2
make[1]: *** [drivers] Error 2


   where *is* the right place to note this stuff?

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
