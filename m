Date: Mon, 27 Mar 2000 13:46:36 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
cc: Michel Dänzer <michdaen@iiic.ethz.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Gabriel Paubert <paubert@iram.es>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.LNX.4.21.0003271409210.22822-100000@idd-01.imbc.gr>
Message-ID: <Pine.LNX.4.10.10003271335250.32203-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Without acceleration its logical to be *alot* slower than the old server
> the shadowfb helps a little there (its used by default unless you disabled
> it in the config)

So the old server was accelerating already?

> 16bpp isn't supported by atyfb, you should use 15bpp instead (the xserver
> needs to be fixed to report that 16bpp isn't supported)

I guessed as much, and Geert said 565 weight needs to be implemented
already.

> 32bpp should have worked fine, the (no screen found, weight 000 inconsistent
> with depth 32) message probably means that you tried a startx -- -depth 32
> instead of the correct -fbbpp 32

I did no such thing. I just used the DefaultDisplayDepth option in the
config file. How do I specify fbbpp in the config?

> > Even with not loading the more arcane extensions the X server weighs in at
> > 21 MB (I recall 17 or so before), that might explain the slowdown a bit.
> > Need to work on the accelerated Mach64 driver perhaps.
>
>   My xserver weights about 74mb (it hits 100+mb with dual head) but keep in
> mind that this includes the  mmaped fb/mmio areas which in my case is 64mb
> so the server is using about 10mb of memory which isn't too much.

With only 64 MB RAM (yes I was cheap but the Powerbook was expensive
enough already) it's a bit heavy on the system.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
