Date: Fri, 14 May 2004 10:02:10 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bryan Rittmeyer <bryan@staidm.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IBM 750GX SMP on Marvell Discovery II or III?
In-Reply-To: <20040513043055.GB11357@staidm.org>
Message-ID: <Pine.GSO.4.58.0405141001001.27660@waterleaf.sonytel.be>
References: <c7nb0l$5e3$1@sea.gmane.org> <16544.4592.978105.177882@cargo.ozlabs.ibm.com>
 <3B3163BD-A2F0-11D8-95B9-003065F9B7DC@embeddededge.com>
 <16544.16999.648530.393071@cargo.ozlabs.ibm.com>
 <517E783F-A362-11D8-942E-003065F9B7DC@embeddededge.com>
 <16545.27647.651552.393992@cargo.ozlabs.ibm.com> <20040512080024.GA26628@iram.es>
 <16546.3723.214235.623354@cargo.ozlabs.ibm.com> <20040512134551.GB31780@iram.es>
 <Pine.GSO.4.58.0405121619110.19967@waterleaf.sonytel.be>
 <20040513043055.GB11357@staidm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 12 May 2004, Bryan Rittmeyer wrote:
> On Wed, May 12, 2004 at 04:21:04PM +0200, Geert Uytterhoeven wrote:
> > Solution: divide memory in pieces, run multiple instances of Linux, each on its
> > own CPU and memory piece, and use a piece of uncached RAM for implementing
> > communication channels between CPUs ;-)
>
> Non-cacheable I/O throughput on the 60x bus is horrid; might be better to put a
> 1000Mbps NIC on each CPU and cable em together ;-\

You can always put the real data in cacheable memory, and keep only some
control descriptors in uncached memory. Needs some explicit cache handling, but
should be faster.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
