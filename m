Date: Mon, 26 May 2003 08:47:02 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Trevor Woerner <ppc339@vtnet.ca>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ide interrupts
In-Reply-To: <200305251912.24266.ppc339@vtnet.ca>
Message-ID: <Pine.GSO.4.21.0305260846410.11579-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 25 May 2003, Trevor Woerner wrote:
> On May 23, 2003 12:09 pm, Benjamin Herrenschmidt wrote:
> > On Fri, 2003-05-23 at 17:36, Trevor Woerner wrote:
> > > There seems to be a lot of code in the IDE subsystem relating to
> > > interrupts. Is there a way to set a device in polled (i.e.
> > > non-interrupt) mode? Maybe some way to run the tasklet/bh
> > > periodically?
> > >
> > > Does the IDE system want to monitor my ATA device's Ready_NotBusy
> > > interrupt?
> >
> > No, linux IDE layer can't do that in a sane way, you are asking for
> > a _lot_ of trouble... (especially if doing DMA)
>
> "No" there isn't a way to set the device into polled mode, or "No" it
> doesn't monitor the Ready_NotBusy interrupt?

Can't you use the Ready_NotBusy interrupt as IDE interrupt?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
