Date: Wed, 31 Jan 2001 19:43:13 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Dänzer <michdaen@iiic.ethz.ch>
cc: Andreas Hundt <andi@convergence.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Re: r128 DRI driver now fully functional on PPC
In-Reply-To: <3A785A27.C0366BC3@iiic.ethz.ch>
Message-ID: <Pine.LNX.4.05.10101311942170.9168-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 31 Jan 2001, Michel Dänzer wrote:
> > - no more messed up colors in modes > 8 bpp. driver no longer uses hardware
> >   palette in modes > 8bpp, sets fbcon palette correctly instead.
>
> Sounds great!

The disadvantage is that if you change the palette, the text colors don't
change until you redraw the screen (or switch VC back-and-forth). That's why I
decided to use the hardware palette in directcolor modes.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
