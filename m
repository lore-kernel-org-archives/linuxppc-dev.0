Date: Fri, 9 Jul 2004 10:27:34 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Pawe? Sikora <pluto@pld-linux.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [kernel26@ppc] fixes...
In-Reply-To: <20040709010446.GM23135@smtp.west.cox.net>
Message-ID: <Pine.GSO.4.58.0407091026340.2286@waterleaf.sonytel.be>
References: <200407070042.56649.pluto@pld-linux.org> <20040709010446.GM23135@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 8 Jul 2004, Tom Rini wrote:
> On Wed, Jul 07, 2004 at 12:42:56AM +0200, Pawe? Sikora wrote:
> > [4] 2.6.7-ppc-saa7146-workaround.patch
> > is only workaround for a conflict:
> >
> > "CC [M] ?drivers/media/common/saa7146_video.o
> >  drivers/media/common/saa7146_video.c:3: error: conflicting types for `memory'
> >  include/asm-m68k/setup.h:365: error: previous declaration of `memory'"

What kernel tree are you using that declares `memory' in
include/asm-m68k/setup.h? It's been called `m68k_memory' since as far as I can
remember...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
