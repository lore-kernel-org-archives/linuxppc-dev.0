Date: Sun, 19 Aug 2001 22:43:44 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tony Mantler <nicoya@apia.dhs.org>
Cc: "Timothy A. Seufert" <tas@mindspring.com>, mlan@cpu.lu,
	hozer@drgw.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: About TAU (and ICTC)
In-Reply-To: <v04003a08b7a5cb79017f@[24.70.162.12]>
Message-ID: <Pine.LNX.4.05.10108192242020.19135-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 19 Aug 2001, Tony Mantler wrote:
> Hmm, I wonder how much thermal-resistive factors would affect this. Y'know,
> generally when a circuit is warmer, it's resistance increases, and
> subsequently it gets warmer, etc, so depending on how the curves weigh out
> (if at all), there might be some hidden power savings in doing calculations
> cooler and longer rather than warmer and shorter.

Heat is proportional to power dissipation:

    P = UI

while

    I = U/R

So if R increases, I decreases. But then P decreases too and the IC gets
cooler, hence less resistance. Hmm...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
