From: Steve.Ferri@radisys.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: Unhandled interrupt 0, disabled
MIME-Version: 1.0
Message-ID: <OF372ADE2C.72EE3078-ON85256BAE.0047B532@radisys.com>
Date: Fri, 3 May 2002 09:03:59 -0400
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


All:

I have run different kernel versions (2.4.7 to 2.4.15) on an the 8260
based card we are using.  After the
kernel has been loaded, I always seem to see the message "Unhandled
interrupt 0, disabled".
It doesn't always occur at the same time.  I've seen the message right
after the kernel has finished
booting, after i started my application, or initialized some drivers.  It
occurs only once.

Looking at the 8260 manual IRQ 0 is described as "Error (No Interrupt)".
Looking at the code in irq.c
this event doesn't hurt anything, and most likely can be ignored.  I just
want to understand
how this interrupt vector is getting to the irq_distacher.  Also, should I
be concerned about this
or should I just continue to ignore the event ?

Also this is marked in the /proc/interrupts  file under the BAD: entry
(counted as a spurious interrupt)

              CPU0
 13:       8629            8260 SIU   Edge      timer_irq
 19:          0                8260 SIU   Edge      qfalc_irq
 21:          1                8260 SIU   Edge      pci_irq
 33:       25438          8260 SIU   Edge      fenet
 36:       29585934   8260 SIU   Edge      mcc1_irq
BAD:          1

Perhaps this just always occurs in 8260's after boot ?

Regards,
Steve

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Steve Ferri                         Radisys Corporation
                                               520 Fellowship Rd.
                                               Suite C-304
www.radisys.com             Mt. Laurel, NJ 08054

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
