From: greggiraud@netcourrier.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: debugging ppcboot bdi2000
Date: Wed, 23 Apr 2003 17:25:33 CEST
Mime-Version: 1.0
Message-Id: <mnet1.1051111533.7670.greggiraud@netcourrier.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I succeed in flashing my mpc8266ads board. But I can't debug ppcboot.
How to do to debug ppcboot?
So I flash my board with my ppcboot.bin.
I make a reset, ppcboot run normally.
Now I just want to try my bdi200 to debug.
So, I try:
telnet 192.168.15.3
ppcboot is halted at 0xfff00100(reset)


Normally ppcboot
then run gdb:
ppc_82xx-gdb ppcboot
target remote 192.168.15.3:2001
c

normally ppcboot would run normally, but i see nothing on my console?

Is there documentation on how using gdb, ddd, bdi2000? And examples?
tahnks for helping.
grego
greggiraud@netcourrier.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
