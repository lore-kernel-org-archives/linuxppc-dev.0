Date: Mon, 8 Jan 2001 08:16:05 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: drscholl <drscholl@users.sourceforge.net>,
        "Clayton,Keith - Programmer" <Clayton@ltcc.cc.ca.us>,
        "'alex@cosmo.allay.net'" <alex@cosmo.allay.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Endianness and comparing IP's
In-Reply-To: <20010106234445.44216E690@apollo.valhalla.net>
Message-ID: <Pine.LNX.4.05.10101080815200.27204-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 6 Jan 2001, Iain Sandoe wrote:
> > /* convert the bytes of a 32-bit integer to little endian */
> > #define BSWAP32(c)
> > ((c>>24)&0xff)|((c>>8)&0xff00)|((c<<8)&0xff0000)|(c<<24)
>
>  #define BSWAP32(c) \
> (((c>>24)&0xff)|((c>>8)&0xff00)|((c<<8)&0xff0000)|(c<<24))
>
>
> will work as you expect it too... ;-)
>
> precedence is a funny thing...

Similarly, replace `c' by `(c)'.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
