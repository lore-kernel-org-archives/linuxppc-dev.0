Date: Wed, 12 May 2004 21:30:55 -0700
From: Bryan Rittmeyer <bryan@staidm.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IBM 750GX SMP on Marvell Discovery II or III?
Message-ID: <20040513043055.GB11357@staidm.org>
References: <c7nb0l$5e3$1@sea.gmane.org> <16544.4592.978105.177882@cargo.ozlabs.ibm.com> <3B3163BD-A2F0-11D8-95B9-003065F9B7DC@embeddededge.com> <16544.16999.648530.393071@cargo.ozlabs.ibm.com> <517E783F-A362-11D8-942E-003065F9B7DC@embeddededge.com> <16545.27647.651552.393992@cargo.ozlabs.ibm.com> <20040512080024.GA26628@iram.es> <16546.3723.214235.623354@cargo.ozlabs.ibm.com> <20040512134551.GB31780@iram.es> <Pine.GSO.4.58.0405121619110.19967@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.58.0405121619110.19967@waterleaf.sonytel.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 12, 2004 at 04:21:04PM +0200, Geert Uytterhoeven wrote:
> Solution: divide memory in pieces, run multiple instances of Linux, each on its
> own CPU and memory piece, and use a piece of uncached RAM for implementing
> communication channels between CPUs ;-)

Non-cacheable I/O throughput on the 60x bus is horrid; might be better to put a
1000Mbps NIC on each CPU and cable em together ;-\

-Bryan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
