Date: Tue, 26 Sep 2000 18:26:33 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
cc: R Shapiro <rshapiro@bbn.com>,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display!
In-Reply-To: <Pine.LNX.4.10.10009251439380.31592-100000@zirkon.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.10.10009261825540.373-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 25 Sep 2000, Michael Schmitz wrote:
> >  > Anything about PCI problems in the server log?
> >
> > The only server log I have right now is for the X I left running
> > yesterday with the fbdev driver.  There are a couple of PCI warnings
> > in this one but no errors (no surprise, since everything is working
> > well with fbdev):
> >
> > (**) (null)(2): claimed PCI slot 0:15:0
> > (II) FBDev(2): using /dev/fb2
> > (WW) ****INVALID IO ALLOCATION**** b: 0x400 e: 0x4ff correcting
> > (II) window:
> >         [0] -1  0x00000000 - 0x0000ffff (0x10000) IXB
> > (II) resSize:
> > (II) window fixed:
> >         [0] -1  0x00000000 - 0x0000ffff (0x10000) IXB
> > (WW) ****INVALID IO ALLOCATION**** b: 0x400 e: 0x4ff correcting
>
> These shouldn't be critical (but they shouldn't happen, either).
>
> > Are there known X-related problems using BootX?
>
> You were looking at it, from what I guess. Apple's drivers set up
> overlapping areas for MMIO and VRAM, and X fixes this by disabling one of
> these. Unfortunatly, the kernel doesn't notice.

Fortunately these PCI assignment bugs should be circumvented by the new PCI
code we're working on.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
