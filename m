Message-ID: <D73A25AA6E54D511AD74009027B1110F3C0743@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'curt brune'" <curt@acm.org>,
	"Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: USB on RPXLite-DW w/ ppc-823e + ELDK
Date: Tue, 25 Mar 2003 08:58:36 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If you look at Board Control Status Register 2 of the LITE DW you will see
that bit 21 allows you to route PA7 to PC15.  This allows you to apply a
1KHz signal on PC15.  The microcode patch uses this 1KHz signal to generate
an SOF.

-----Original Message-----
From: curt brune [mailto:curt@acm.org]
Sent: Monday, March 24, 2003 9:10 PM
To: Linuxppc-Embedded (E-mail)
Subject: USB on RPXLite-DW w/ ppc-823e + ELDK



Hello,

I am trying to get USB working on an RPXLite board with a 823e
processor.  I am using the ELDK 2.4.4 kernel from CVS -- in
arch/ppc/8xx_io/ I see several files (uart.c, micropatch.c, etc.) that
depend on CONFIG_USB_MPC8xxx, but I do not see how to set
CONFIG_USB_MPC8xxx from "make menuconfig".

I am also wondering about a potential hardware modification required
to make the USB work on the RPXLite -- from a previous posting to this
list I read:

> The 823e, and newer 850 (Rev. B) processors have some modifications
> to better allow USB host support. These require some external
> support (looping a clock back to the I/O pin) and the downloading of
> a microcode patch for properly generating SOF timing.

Is this modification still necesarry?  Does anyone know the details?

Cheers,
Curt


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
