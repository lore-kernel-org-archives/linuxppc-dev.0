Date: Mon, 15 Feb 1999 13:33:14 -0500
From: Mayan Moudgill <mayan@watson.ibm.com>
Message-Id: <9902151833.AA34022@mayan.watson.ibm.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Porting to PPC750 embedded board; what should I do now?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I am porting Linux (pre-) 2.2 to a PPC750 embedded board. The board has
(currently) a 750, 2 16450-compatible UARTs, and 16MB of memory
I have got Linux ported to the point where it can use initrd to
do something useful.

I am cross-compiling from an AIX power-pc box using egcs-1.1.1.

I am wondering how to proceed. I have access to a x86-based Linux
system, and may be able to get access to a PPC box running Linux.

What I think I should do next is build a ramdisk with the
appropriate pieces of software on it, and then compile a kernel
with that as the initrd.

Questions:
	- on which platform should I build the ramdisk?
		(in particular, since the endiannes of a PPC 
		is different from an x86, can I do it on an x86)
	- what should I put on the ramdisk?
		(which executables are the minimum neccessary?;
		remember I only have 16M total)
	- should I use the executables from the linux-ppc RPMs, or
		should I build from scratch? If so, what is
		the best path.

Thanks!

Mayan Moudgill
mayan@watson.ibm.com
914 945 4348

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
