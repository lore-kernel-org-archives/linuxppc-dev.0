Date: Fri, 21 Sep 2001 09:22:00 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Timothy A. Seufert" <tas@mindspring.com>
Cc: Mark Salisbury <mbs@mc.com>,
	Holger Bettag <hobold@Informatik.Uni-Bremen.DE>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ppc LE questions (seeking help hand info pointers)
In-Reply-To: <p05100304b7d00bd21d35@[10.0.0.42]>
Message-ID: <Pine.GSO.4.21.0109210920440.3006-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 20 Sep 2001, Timothy A. Seufert wrote:
> At 4:19 PM -0400 9/20/01, Mark Salisbury wrote:
> >Holger Bettag wrote:
> (Specifically: in order to support PPC-LE, all the hardware drivers
> needed for your platform will need to be rewritten to be aware of
> munging.  The alternative is to make the kernel run in regular BE

But PCI drivers already use readl() and friends, so the differences can be
hidden there? => no driver changes.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
