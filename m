Date: Wed, 20 Sep 2000 14:08:42 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Matt Porter <mporter@mvista.com>
cc: Paul Mackerras <paulus@linuxcare.com.au>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <20000919150621.A9826@cx258813-a.chnd1.az.home.com>
Message-ID: <Pine.LNX.4.10.10009201408040.389-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 19 Sep 2000, Matt Porter wrote:
> would only be used on the "primary" host bridge.  I realize there
> are plenty of drivers (like de4x5) that insist on using inw/outw
> (and thus break on host bridge 2) but these drivers should be
> fixed.

Is there still a need for de4x5? Since Jeff Garzik fixed the Tulip driver,
that one works fine on PPC.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
