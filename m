Reply-To: <tcurran@ultsol.com>
From: "Tom Curran" <tcurran@ultsol.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: On the MPC85xx development boards
Date: Thu, 24 Jun 2004 10:40:00 -0700
Message-ID: <000601c45a12$469704f0$6601a8c0@curranusi>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1088085327022.mikko.alutoin.17388.vROgRbiXwfx6jgnkf5FAxQ@luukku.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You might also want to check out Artis Microsystems for MPC85xx devel
boards:
http://www.artismicro.com/

--Tom

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Mikko
Alutoin
Sent: Thursday, June 24, 2004 6:55 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: On the MPC85xx development boards



Hi folks!

I would be happy to receive some comments on pros & cons of different
development boards for MPC85xx cause I'm in the process of selecting one.
The final design will be using MPC8560 to implement a 1 Gbps Ethernet card
for a router. ATM support will be needed later on.
The development environment includes a Linux PC and Abatron BDI2000
emulator.

Here are the boards that I am aware of:

1)	MPC8560ADS by Motorola
2)	CW8540DSEVAL by Motorola
3)	SBC8560 by Windriver
4)	Silicon Tx GP3 8560
5)	MPC8540 RDK by GDATech

Are these boards all there is?

I am under the impression that 1, 2, 4 and 5 (but not 3) come with a Linux
BSP included? Is this correct?

Being the lazy person that I am, I'm trying to minimize the work to get
Linux up and running on the board. I wonder which board/package gives me
least headache? Are there any pitfalls that I should know about?

Let us assume that the final product will not be based on a commercial
Embedded Linux distro, but a custom 2.6 kernel with busybox & uclibc. Should
that effect the choice in any way?

Forgive me if the questions seem a bit foolish. The bottom line is that I
have not used any kind of development boards in the past and I would like to
receive some insight on which one of the above to choose.

Cheers,
Mikko


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
