Date: Wed, 14 Jun 2000 12:52:09 +0200 (MET DST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: cs4232 module crash
Message-ID: <Pine.GSO.4.10.10006141247540.8589-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


If I put the commands to load the sounddriver for the CS4236 in my CHRP
LongTrail in /etc/modules to auto-load them on startup:

    cs4232 io=0x530 irq=5 dma=1 dma2=5

The system crashes somewhere in the module code.

If I manually do

    modprobe cs4232 io=0x530 irq=5 dma=1 dma2=5

after boot up, everything works fine.

Anyone seeing a similar problem? Perhaps the PReP boys (some of those boxes
also have CS4236 sound, right)? This has been annoying me since a while (for at
least a year :-), but it never was a high-priority problem to me...

I haven't tried compiling the module into the kernel yet...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
