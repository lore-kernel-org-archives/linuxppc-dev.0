Date: Sat, 11 Aug 2001 19:46:06 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: Derrik Pates <demon@devrandom.net>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Fix for PPC audio devices that can't reendianize samples
In-Reply-To: <20010810183346.9F02E2F040@apollo.valhalla.net>
Message-ID: <Pine.LNX.4.05.10108111944430.11186-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 10 Aug 2001, Iain Sandoe wrote:
> > The attached patch adds code to drivers/sound/dmasound/trans_16.c to
> > byteswap little-endian audio samples for hardware that needs it (like the
> > DACA audio chip in the iBook and iBook FireWire), and also marks the DACA
> > in the iBook FireWire as being unable to handle little-endian audio
> > samples (in dmasound_awacs.c).
>
> we've been round this loop ;-)))
>
> the reason that the byte-swap code was taken out of trans_16.c is that it
> will never be allowed into the kernel.

And we'll have to remove the current byteswap code in the kernel (there still
is some).

> (b) if applications don't work properly with BE-only devs then bang on the
> app maintainer (or send patches) to fix it.

And since Debian has a nice bug tracking system: try the Debian version of the
app, if that one doesn't work, file a Debian bug report.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
