Date: Thu, 20 Sep 2001 18:07:48 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Mark Salisbury <mbs@mc.com>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ppc LE questions (seeking help hand info pointers)
In-Reply-To: <20010920085825.F13721@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.GSO.4.21.0109201807150.14835-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 20 Sep 2001, Tom Rini wrote:
> On Thu, Sep 20, 2001 at 11:42:39AM -0400, Mark Salisbury wrote:
> > question 4. assuming I was willing to deliver a clean, complete LE
> > enabling patch (including devices that are relevant to me), as a compile
> > time config option and maintain that patch, what would be the primary
> > obstacle to inclusion in the main line.
>
> The objection to being an arch that attempts to support both LE and BE.

Note that we already have a precedent: mips and mipsel, both in arch/mips/.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
