Message-ID: <B1243F436404D511A5CF009027E705DA0261F7B0@USWAUMSX09MEDGE>
From: "Petersen, David (MED, GEMS-IT)" <David.Petersen@med.ge.com>
To: linuxppc emb3dd3d list <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: HZ to MHZ, 2.4.2 kernel
Date: Fri, 17 Aug 2001 14:25:28 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Look at the board information structure you are passing to linux. hh2.0
is expecting the cpu clock in HZ.
Look at commproc.c in arch/ppc/8260_io to see how the cpu freq is used
for baud rates.

> 	David Petersen
> 	g		GE Medical Systems
> 			Information Technologies
> 	________________________________
> 	David T Petersen
> 	Engineer, Clinical Information Systems
> 	8200 W. Tower Avenue
> 	Milwaukee, WI  53223
> 	Phone:  414-362-2565  Fax:  414-362--2676
> 	Mailto:david.petersen@med.ge.com
> 	Visit Us On The Internet: http://www.gemedicalsystems.com
>


-----Original Message-----
From: Kevin Fry [mailto:kevin@carts.com]
Sent: Friday, August 17, 2001 2:16 PM
To: linuxppc emb3dd3d list
Subject: HZ to MHZ, 2.4.2 kernel



I remember someone having a problem with the kernel using hz and
expecting MHZ or the other way around and it seems I'm running into this
problem right now.   Are there any patches or anything that address this
issue with regards to the 8260 serial and also the time.c code? This is
in HHL 2.0, 2.4.2 kernel
Thanks!

Kevin Fry


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
