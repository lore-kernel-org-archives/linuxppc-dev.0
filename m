Date: Thu, 3 Aug 2000 10:00:15 +0200 (CEST)
From: Ronald Wahl <rwa@peppercon.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: iounmap
Message-ID: <Pine.LNX.4.21.0008030950020.1647-100000@goliath.issistance.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm currently writing a device driver for an pci controller and have to
map very large amounts of pci memory and i/o ranges via ioremap. The
problem is that there is no iounmap and ioremap returns NULL after some
insmod/rmmod cycles. When gets this implemented?

ron

--
\\                 Ronald Wahl   |   Peppercon AG                 //
 \\\          rwa@peppercon.de  |||  http://www.peppercon.de/   ///
  \OO  -----------------------  OOO  ------------------------  OO/
   OO  GnuPG/PGP key available  OOO  ||||||||||||||||||||||||  OO


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
