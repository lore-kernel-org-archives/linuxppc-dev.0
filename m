Date: Mon, 24 Mar 2003 18:10:15 -0800
From: curt brune <curt@acm.org>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: USB on RPXLite-DW w/ ppc-823e + ELDK
Message-ID: <20030324181015.A14912@curtisb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
