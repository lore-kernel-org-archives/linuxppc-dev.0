Date: Thu, 1 Jun 2000 21:54:59 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Josh Huber <huberj@wpi.edu>
cc: Michel Lanners <mlan@cpu.lu>, jgarzik@mandrakesoft.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Lite-On ethernet controller
In-Reply-To: <20000601085349.A307@mclinux.com>
Message-ID: <Pine.LNX.4.05.10006012152150.2148-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 1 Jun 2000, Josh Huber wrote:
> On Wed, May 31, 2000 at 08:40:57PM +0200, Michel Lanners wrote:
> > 00:05.0 Ethernet controller: Lite-On Communications Inc: Unknown device c115 (rev 25)
> >         Subsystem: Asante Technologies, Inc.: Unknown device f001
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 8 min, 56 max, 32 set, cache line size 08
> >         Interrupt: pin A routed to IRQ 30
> >         Region 0: I/O ports at 1c00 [size=256]
> >                   ^^^^^^^^^    ^^^^
> >         Region 1: Memory at c3002000 (32-bit, non-prefetchable) [size=256]
> >         Expansion ROM at c1240000 [disabled] [size=256K]
> >
> > The IO port region above might be your problem. What machine type is

I/O port is OK, since the card does work most of the time.

> > this? Do you have any ISA slots in your machine? Form the i8259
> > interrupt controller I deduce it's not a PowerMac...
>
> It's not a powermac...it's a CHRP Longtrail board.  Geert's board has an ISA
> slot, and I believe mine has all the hardware for an ISA slot, except the
> actual slot was removed.

CHRP LongTrail has ISA. Interrupts are controlled by an OpenPIC master, and the
traditional dual i8259 cascade as a slave.

> Geert, how did you get the tulip-diag program to compile on your chrp
> machine?  I'd like to give it a try and see what it tells me.

By pathing it to map ISA I/O space :-) I mailed the patch to you.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
