Date: Sat, 25 Mar 2000 15:49:42 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Dänzer <michdaen@iiic.ethz.ch>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <38DCCCF4.2868082E@iiic.ethz.ch>
Message-ID: <Pine.LNX.4.05.10003251547440.11621-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 25 Mar 2000, Michel Dänzer wrote:
> > X is free to disable whatever it likes on cards that aren't handled by
> > framebuffer drivers. It should not disable anything otherwise and leave it
> > to the kernel framebuffer drivers to sort things out. More communication
> > between X and kernel is fine, but why not leave things as they were for
> > framebuffer drivers? This is all that the framebuffer concept was about,
> > why throw it out?
>
> Because X can currently only determine what is controlled by an fbdev via
> heuristics regarding the memory regions themselves. (With 32 bit busses on 64
> bit machines it may even be impossible). Jeff Garzik has proposed a solution
> for this with a new ioctl.

fix.smem_start is unsigned long, which is 64-bit on all 64-bit platforms.

Please tell me where you're hiding that 32-bit box with 64-bit PCI addressing
inside :-)

Anyway, it's perfectly possible to do it correctly _now_ on 32-bit boxes with
32-bit PCI addressing and on all 64-bit boxes, so I see no reason for breaking
the game for those.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
