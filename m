Message-ID: <1088085327022.mikko.alutoin.17388.vROgRbiXwfx6jgnkf5FAxQ@luukku.com>
Date: Thu, 24 Jun 2004 16:55:27 +0300 (EEST)
From: Mikko Alutoin <mikko.alutoin@luukku.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: On the MPC85xx development boards
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi folks!

I would be happy to receive some comments on pros & cons of different development boards for MPC85xx cause I'm in the process of selecting one.
The final design will be using MPC8560 to implement a 1 Gbps Ethernet card for a router. ATM support will be needed later on.
The development environment includes a Linux PC and Abatron BDI2000 emulator.

Here are the boards that I am aware of:

1)	MPC8560ADS by Motorola
2)	CW8540DSEVAL by Motorola
3)	SBC8560 by Windriver
4)	Silicon Tx GP3 8560
5)	MPC8540 RDK by GDATech

Are these boards all there is?

I am under the impression that 1, 2, 4 and 5 (but not 3) come with a Linux BSP included? Is this correct?

Being the lazy person that I am, I'm trying to minimize the work to get Linux up and running on the board. I wonder which board/package gives me least headache? Are there any pitfalls that I should know about?

Let us assume that the final product will not be based on a commercial Embedded Linux distro, but a custom 2.6 kernel with busybox & uclibc. Should that effect the choice in any way?

Forgive me if the questions seem a bit foolish. The bottom line is that I have not used any kind of development boards in the past and I would like to receive some insight on which one of the above to choose.

Cheers,
Mikko


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
