Date: Tue, 20 Jun 2000 12:36:18 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
cc: "Timothy A. Seufert" <tas@mindspring.com>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>
Subject: Re: 3D accel on PPC
In-Reply-To: <Pine.LNX.4.21.0006192208210.23156-100000@idd-01.imbc.gr>
Message-ID: <Pine.LNX.4.05.10006201235030.17597-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 19 Jun 2000, Kostas Gewrgiou wrote:
> What is holding back ppc voodoo3 in xfree right now
> is PIO support, i tried to use tdfxfb to get away from
> this but there a problems there as well (the xserver
> needs a 2*vramsize mapping in the framebuffer but fbdev
> can't do this unless i patch tdfxfb to think that its
> vram is 2*realsize, Geert any ideas how we can get away
> from this ?)

Why do they want 2*vramsize? Is the extra space where no RAM is used for
something different? Can they map something there?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
