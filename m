Date: Tue, 6 Jun 2000 08:37:49 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Lanners <mlan@cpu.lu>
cc: toa@pop.agri.ch, linuxppc-dev@lists.linuxppc.org
Subject: Re: 2940UW & 2.4.0-test-ac7 PCI probs
In-Reply-To: <200006052039.WAA01344@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.05.10006060837130.5880-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 5 Jun 2000, Michel Lanners wrote:
> Hi Andreas,
> On   5 Jun, this message from Andreas Tobler echoed through cyberspace:
> > I try to get the 2.4.0-test1-ac7 to boot on my 7200. It fails. I have a
> > 2940UW where all my disks are connected to. A 2.3.99p9 from linuxcare
> > boots, but the ac7 from bk fails with the following message:
> >
> > Total memory = 80MB; using 512kB for hash table (at c0300000)
> > Linux version 2.4.0-test1-ac7 (root@pm7200) (gcc version 2.95.3 19991030
> > (prerelease/franzo)) #4 Mon Jun 5 17:14:33 CEST 2000
> > PCI bus 0 controlled by bandit at f2000000
> > [snip]
> > PCI: Device 00:0e.0 not available because of resource collisions
> > [snip]
>
> Get either my PCI patches or Geert's patches posted here a few hours

Note that my patches need some changes to make them work on PowerMac.

> ago. Then enable hotswap (still needed, right, Geert?), and the resource
> code should fix any collisions it finds.

I don't think you need hotswap to fix collisions.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
