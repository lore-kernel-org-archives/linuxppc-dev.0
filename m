Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: kgdb and mpc8xx (again)
From: Ibon Gotxi Garcia <igotxi@jazzfree.com>
To: Linux PPC embedded <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain
Message-Id: <1047318121.29389.44.camel@muse>
Mime-Version: 1.0
Date: 10 Mar 2003 17:42:01 +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi:

I'm trying to debug a kernel on a 8xx board with kgdb, using the SMC1. I
have disabled all the outputs to the console made by the bootstrap code,
and simply running kermit, i get this line

$T0540:c0009db0;01:c01152fe;#b1

If i run ppc-linux-gdb instead of kermit, i get

0xc0009db0 in breakpoint () at ppc-stub.c:726

and the board restarts itself.

I have no idea why. Maybe:

1.- It's something related with some console output (don't know if
enabling kgdb disables all the console output in SMC1).
2.- A watchdog timeout happens (Does the kgdb code resets the
watchdog?).
3.- Do I have to do a "set endian xxx" in ppc-linux-gdb ??? (to get that
output i have done a "set endian big")


I'm using the denx kernel from the cvs and ppc-linux-gdb from ELDK 2.0.2
(on a x86 development machine)


Cheers
Ibon

--
Ibon Gotxi Garcia <igotxi@jazzfree.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
