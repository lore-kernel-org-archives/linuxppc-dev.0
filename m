Date: Tue, 25 Jul 2000 14:15:54 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: linuxppc-dev@lists.linuxppc.org, jsun@mvista.com
Subject: Re: [ANN] IRQ Latency tool 0.1.3 release.
In-Reply-To: <200007242244.XAA21388@hyperion.valhalla.net>
Message-ID: <Pine.LNX.4.10.10007251413580.434-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 24 Jul 2000, Iain Sandoe wrote:
> BTW: on my system ll_rw_blk.c gets up to 750 us quite often when the system
> is loaded... this **IS** a potential problem for audio use.
>
> log entry : 3  (16  history entries)
>         Peak Block Time  :        430.0 us  (    7185) [ OK ]
>         startFilename    : ll_rw_blk.c                    Line : 167
>         endFileName      : ll_rw_blk.c                    Line : 179
>
> I still haven't found the "hard-block" that is effecting the overall audio
> latency performance... ah well, back to the drawing board...

Do you have IDE? The IDE driver turned out to be the major interrupt messing
problem on m68k, since it can disable interrupts for quite a while.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
