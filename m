From: "Tameen Khan" <tameen@cisco.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Kgdb on Motorola 8451 ppc board
Date: Tue, 29 Jun 2004 11:21:24 -0700
Message-ID: <004801c45e05$e33a1b20$273147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm trying to run kgdb on  Motorola 8451 ppc board.
I've compiled the kernel with the CONFIG_KGDB option.
The test machine is a linux host. I'm using gdb compiled for target ppc
architecture. When I try to connect to the dev machine from the test
machine, I get the following error.

(gdb) set remotebaud 9600
(gdb) target remote /dev/ttyS1
Remote debugging using /dev/ttyS1
^^
^^^^Ignoring packet error, continuing...
^^^Ignoring packet error, continuing...
Ignoring packet error, continuing...
Ignoring packet error, continuing...
Couldn't establish connection to remote target
Malformed response to offset query, timeout
(gdb)

I've tried other baudrates, but get the same error with them.
Any pointers to where I can get info to get kgdb working for this cross arch
debugging will be helpful.. So far I've searched the web without much luck
on this topic.

Thanks
-Tameen


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
