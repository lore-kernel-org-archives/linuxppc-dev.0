Date: Sat, 20 Mar 2004 14:42:08 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
Subject: [TRIVIAL PATCH] Correctly print MAC address of BMAC
To: linuxppc-dev@lists.linuxppc.org, netdev@oss.sgi.com
Message-id: <Pine.LNX.4.58.0403201433570.20621@portland.hansa.lan>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello!

Sorry for crosspost, not sure what list would be right.

The BMAC driver (drivers/net/bmac.c) in Linux 2.6.5-rc2 prints the MAC
address incorrectly:

 00:50:e4:40:9e:43<6>eth0: BMAC+ at

Somehow the loop to print the address was moved before the code that
prints the rest of the line.  The attached patch fixes that.  Now that
line appears in the kernel log as

eth0: BMAC+ at 00:50:e4:40:9e:43

--
Regards,
Pavel Roskin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
