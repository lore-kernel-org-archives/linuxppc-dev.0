Date: Mon, 28 Jan 2002 20:45:31 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Momchil Velikov <velco@fadata.bg>,
	Kaoru Fukui <k_fukui@highway.ne.jp>, hozer@drgw.net,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Broken asm/div64.h macro
In-Reply-To: <20020128152813.GG19960@opus.bloom.county>
Message-ID: <Pine.GSO.4.21.0201282042470.2836-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 28 Jan 2002, Tom Rini wrote:
> On Mon, Jan 28, 2002 at 10:16:28AM +0200, Momchil Velikov wrote:
> > >>>>> "Kaoru" == Kaoru Fukui <k_fukui@highway.ne.jp> writes:
> >
> > Kaoru> On 27 Jan, Troy Benjegerdes wrote:
> > >> Did you actually try compiling PPC this way??
> > >>
> > >> vsprintf.o(.text+0x494): undefined reference to `__umoddi3'
> > >> vsprintf.o(.text+0x494): relocation truncated to fit: R_PPC_REL24
> > >> __umoddi3
> > >> vsprintf.o(.text+0x4ac): undefined reference to `__udivdi3'
> > >> vsprintf.o(.text+0x4ac): relocation truncated to fit: R_PPC_REL24
> > >> __udivdi3
> >
> > Kaoru> libgcc.a has those libraries.
> >
> > Yeah, but we don't link with libgcc.a. (which I forgot).
>
> Er, but isn't it (sort-of) considered a bug if the kernel links with
> libgcc.a ?  I think the consensious on l-k would be yes.

So you copy the code from the libgcc sources, cfr. arch/m68k/lib/.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
