Subject: kgdb and console output
From: Ibon Gotxi Garcia <igotxi@jazzfree.com>
To: Linux PPC embedded <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain
Message-Id: <1047642589.367.19.camel@muse>
Mime-Version: 1.0
Date: 14 Mar 2003 11:49:50 +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


caution: perhaps a bit offtopic?

Hi all:

I'm still having problems to debug a kernel with kgdb:

both kgdb and console output go to /dev/ttyS0 (no chance of changing
that, we use the second serial port for other purposes). I get an
initial break in gdb (development machine), and the kernel loads
smoothly (outputs are perfect) till it reaches init, when the output
goes mad, repeating everything (but the first char) a number of times.
For example:

INIT: INIT: NIT: IT: T: : version 2.78 bootingersion 2.78 bootingrsion
2.78 bootingsion 2.78 bootingon 2.78 booting

and so on.

a.- Is that a gdb problem?
b.- Is it related with using the same serial port for both output and
debugging?
c.- Maybe i should change the tools i use in the root filesystem (aka
/bin/echo ...)?

I have tried not using colors or scape sequences to print, but a simple
echo "echo this" produces the same problem.
Any ideas?


Many regards.


--
Ibon Gotxi Garcia <igotxi@jazzfree.com>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
