Date: Wed, 14 Jun 2000 21:07:30 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: recent bk tree broken on LongTrail
Message-ID: <Pine.LNX.4.05.10006142104040.581-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The current bk tree (june 15) no longer works on my CHRP LongTrail. The version
from june 5 works fine.

If I try to boot the new kernel image, OF reboots the box in the `correct mode'
(sic) for the kernel image, after which real-mode? becomes true. Needless to
say, it still doesn't work after that and goes until
`returning from prom_init', which is not good.

I manually have to restore real-mode? to false before I can boot my old kernels
again. I suspect the new chrpboot code for the POWER3/4 boxes is the culprit.

Let's investigate this (after I finished the dishes, of course :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
