Date: Mon, 27 Mar 2000 14:04:27 +0200 (MET DST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Kostas Gewrgiou <gewrgiou@imbc.gr>, Michel Dänzer <michdaen@iiic.ethz.ch>,
        Gabriel Paubert <paubert@iram.es>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.LNX.4.10.10003271335250.32203-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.GSO.4.10.10003271400580.11532-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 27 Mar 2000, Michael Schmitz wrote:
> > Without acceleration its logical to be *alot* slower than the old server
> > the shadowfb helps a little there (its used by default unless you disabled
> > it in the config)
>
> So the old server was accelerating already?

Yes, I had ported Ryuichi Oikawa's Mach64 acceleration for Xpmac to
XF68_FBDev. It was not that much accelerated as on ia32, but the difference
with the unaccelerated server was definitely noticable. Try `option no_accel'
in XF86Config and compare. I expect unaccelerated 4.0 to be faster than
unaccelerated 3.3.x.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
