Date: Tue, 8 Aug 2000 15:14:37 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: Gabriel Paubert <paubert@iram.es>, benjamin herrenschmidt <bh40@calva.net>,
        martin costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again...
In-Reply-To: <200008081137.MAA10748@hyperion.valhalla.net>
Message-ID: <Pine.LNX.4.10.10008081513150.442-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 8 Aug 2000, Iain Sandoe wrote:
> I seems to me (in summary) [since I started this thread :-) ]:
>
> we can:
>
> (a) Fix up time in the kernel to emulate UTC
> (b) Fix up time in the kernel to emulates Local Time

Please also think about people who really run their RTC in UTC, who don't run
MacOS anymore, or who simply don't have a PowerMac.

> Which (or will both) of these works with hwclock (since that is the
> mechanism at 2.4.0 ?)  and for those of us switching to-and-ffo is also
> being used at 2.2.17

Hwclock is userspace. It depends on the distro.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
