Date: Mon, 27 Mar 2000 13:58:47 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Kostas Gewrgiou <gewrgiou@imbc.gr>, Michel Dänzer <michdaen@iiic.ethz.ch>,
        Gabriel Paubert <paubert@iram.es>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.GSO.4.10.10003271349510.11532-100000@dandelion.sonytel.be>
Message-ID: <Pine.LNX.4.10.10003271355370.32203-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> s/bpp/depth/
>
> There's a difference between bpp (`bit per pixel': 8, 16, 24 or 32 are
> supported by atyfb) and depth (8, 15 and 24 are supported by atyfb).

Imagine my confusion. What bpp will X use for depth 24 by default? Would
32 help any?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
