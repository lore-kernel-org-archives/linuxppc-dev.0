Message-ID: <37D044CE.B31A1907@broadlink.com>
Date: Fri, 03 Sep 1999 14:59:42 -0700
From: Scott Wood <scott@broadlink.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: DEC Tulip not working in B&W G3
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a NetGear FA-310TX (DEC 21141) NIC in my new B&W G3 running kernel
2.2.6.
The kernel detects the card and gives me an eth1 interface, but I can't 
pass any traffic into or out of the interface, and I get some strange
kernel
messages:

eth0: BMAC+ at 00:50:e4:20:d7:43
  The PCI BIOS has not enabled this device!  Updating PCI command
0000->0005.
tulip.c:v0.89H 5/23/98 becker@cesdis.gsfc.nasa.gov
eth1: Digital DS21140 Tulip at 0x1080, 40 00 35 05 fc db, IRQ 23.
eth1:  MII transceiver found at MDIO address 0, config 1000 status 7809.
eth1:  Advertising 01e1 on PHY 0, previously advertising 01e1.

>---snip---<

phy registers:
 0800 7809 7810 0001 01e1 40a1 0003 0000
 0000 0000 0000 0000 0000 0000 0000 0000
 0000 0002 0000 1000 0048 0010 0000 0002
 0001 0000 0000 0000 0000 0000 0000 0000

I'm not certain exactly what causes this message to be printed, though. 
Has
anyone else got the Tulip NICs to work in a B&W G3??

-- 
+---------------------+----------------------+
|     Scott Wood      |   Systems  Engineer  |
|=====================+======================|
|           BroadLink Communications         |
+--------------------------------------------+

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
