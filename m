Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4DFF9FDD@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Steve.Ferri@radisys.com'" <Steve.Ferri@radisys.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Unhandled interrupt 0, disabled
Date: Fri, 3 May 2002 10:09:27 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mr. Ferri,

I've started a thread of discussion about that a couple of weeks ago, but I
didn't have a satisfying answer. However, I've proposed a fix which seems to
work. I think I should go further with Motorola about that problem. Can you
take a look at it and tell me if it helps? Also, can you tell me which
processor mask you are running on?

Look at
http://lists.linuxppc.org/linuxppc-embedded/200204/threads2.html#00074

The thread is titled:
  8260 - Spurious interrupt when calling __sti()

--------------------------------------------
 Jean-Denis Boyer, B.Eng., System Architect
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

> -----Original Message-----
> From: Steve.Ferri@radisys.com [mailto:Steve.Ferri@radisys.com]
> Sent: 3 mai, 2002 09:04
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Unhandled interrupt 0, disabled
>
>
>
> All:
>
> I have run different kernel versions (2.4.7 to 2.4.15) on an the 8260
> based card we are using.  After the
> kernel has been loaded, I always seem to see the message "Unhandled
> interrupt 0, disabled".
> It doesn't always occur at the same time.  I've seen the message right
> after the kernel has finished
> booting, after i started my application, or initialized some
> drivers.  It
> occurs only once.
>
> Looking at the 8260 manual IRQ 0 is described as "Error (No
> Interrupt)".
> Looking at the code in irq.c
> this event doesn't hurt anything, and most likely can be
> ignored.  I just
> want to understand
> how this interrupt vector is getting to the irq_distacher.
> Also, should I
> be concerned about this
> or should I just continue to ignore the event ?
>
> Also this is marked in the /proc/interrupts  file under the BAD: entry
> (counted as a spurious interrupt)
>
>               CPU0
>  13:       8629            8260 SIU   Edge      timer_irq
>  19:          0                8260 SIU   Edge      qfalc_irq
>  21:          1                8260 SIU   Edge      pci_irq
>  33:       25438          8260 SIU   Edge      fenet
>  36:       29585934   8260 SIU   Edge      mcc1_irq
> BAD:          1
>
> Perhaps this just always occurs in 8260's after boot ?
>
> Regards,
> Steve
>
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Steve Ferri                         Radisys Corporation
>                                                520 Fellowship Rd.
>                                                Suite C-304
> www.radisys.com             Mt. Laurel, NJ 08054
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
