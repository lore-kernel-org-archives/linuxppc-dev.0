Message-ID: <3A3E2F0A.3D687E6A@dspace.de>
Date: Mon, 18 Dec 2000 16:36:42 +0100
From: Andreas Schreckenberg <ASchreckenberg@dspace.de>
Reply-To: Andreas Schreckenberg <ASchreckenberg@dspace.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: 16550 uart without interrupts ?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Is there anybody with a serial console uart driver for
ppc systems without using interrupts ?
Is is possible to use any driver in "polling mode" ?
(drivers/char/serial.c or arch/8xx_io/uart.c)

I try to bring up Linux on my custom ppc board
(PPC750, 64M, uart 16550) and my
(selfmade) interrupt controller will not work at this
moment.

But it would be nice to have debug messages on the
serial console. (log_buf is okay but not really the
thing I would like to have)

Can I work with a "polling driver" -> bash input/output ?

I hope that I must not understand the whole driver :-)
(only set the uart I/O range, and set the quartz divider)

bye
Andreas
EMail: ASchreckenberg@dspace.de
--
          Life's not fair. But the root password helps ! :-)
                   http://schrecky.home.pages.de

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
