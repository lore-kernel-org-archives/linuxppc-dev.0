Date: Sat, 25 Mar 2000 14:28:29 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Gabriel Paubert <paubert@iram.es>, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.LNX.4.10.10003241806210.22814-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.05.10003251427290.11322-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 24 Mar 2000, Michael Schmitz wrote:
> > > So it's perfectly legal for resources within the same device to overlap?
> > > WTF does X not tolerate this and disables the overlapping one?
> >
> > It may be legal if the internal decoders are prioritized and the priority
> > is the right one (which it should if the firmware has set it up this way).
>
> They are prioritized the right way: if you memset the whole aperture to 0
> the chip freaks out instead of just painting the whole screen black. Been
> there, done that.

Aha, now I know why I had to remove the last 4K. You had overlapping regions!
Which means my patch was not really necessary, since it worked around the real
problem instead of fixing it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
