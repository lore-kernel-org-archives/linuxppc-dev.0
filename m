Date: Mon, 27 Mar 2000 13:51:15 +0200 (MET DST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Michel Dänzer <michdaen@iiic.ethz.ch>,
        Gabriel Paubert <paubert@iram.es>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.LNX.4.21.0003271409210.22822-100000@idd-01.imbc.gr>
Message-ID: <Pine.GSO.4.10.10003271349510.11532-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 27 Mar 2000, Kostas Gewrgiou wrote:
> 16bpp isn't supported by atyfb, you should use 15bpp instead (the xserver
> needs to be fixed to report that 16bpp isn't supported)
>
> 32bpp should have worked fine, the (no screen found, weight 000 inconsistent
> with depth 32) message probably means that you tried a startx -- -depth 32
> instead of the correct -fbbpp 32

s/bpp/depth/

There's a difference between bpp (`bit per pixel': 8, 16, 24 or 32 are
supported by atyfb) and depth (8, 15 and 24 are supported by atyfb).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
