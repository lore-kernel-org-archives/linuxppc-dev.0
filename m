Date: Tue, 4 Nov 2003 23:30:06 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Walther <trag@io.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IRQS on 6 Slot Macs
In-Reply-To: <a04310105bbcdcaaea8e5@[199.170.89.159]>
Message-ID: <Pine.GSO.4.21.0311042328150.3207-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 4 Nov 2003, Jeff Walther wrote:
> At 20:14 +1100 11/04/2003, Benjamin Herrenschmidt wrote:
> >>  After all, one can, in theory, add 1024 PCI slots to a machine using
> >>  PPBs.   There aren't going to be 1024 interrupts available.
> >
> >Why ? Some iSeries have up to 2048 irq lines afaik ;)
>
> By iSeries, do you mean iBook and iMac?   Or is that something else?

iSeries are the big IBM boxes formerly known as AS/400.

> I think I can find GC's connection to MESH as well, but I'm
> uncertain.   I believe that MESH is just a licensed NEC (now LSI
                                                      ^^^
> Logic) 53CF96 and I have the pinout for the 53CF96 so tracing

NCR, I assume?

> I haven't dug into that, but I'd like to know how they made that
> work.  Does an Enet card require an interrupt?  Does it ever master
> the PCI bus?

Ethernet prefers to have an interrupt, else it becomes quite slow :-)
Most modern Ethernet interfaces do bus mastering. Old NE2000 clones don't.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
