Date: Mon, 25 Oct 1999 18:11:43 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: atyfb and ppc config
In-Reply-To: <Pine.LNX.4.10.9910250832260.18574-100000@shell.unixbox.com>
Message-ID: <Pine.LNX.4.05.9910251811010.32285-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 25 Oct 1999, Ani Joshi wrote:
> hey geert, i was playing with 2.3.23 last nite and fixing it up for ppc
> when i noticed my vmode/cmode kernel args weren't "working" with 2.3.23,
> then i when back and realized that in atyfb_setup, you only allow these if
> CONFIG_PMAC is defined, and i had build a "common" CONFIG_PPC_ALL kernel.
> 
> should you add #ifdefined CONFIG_PMAC || or defined CONFIG_PPC_ALL
> or for a more general solution, if CONFIG_PPC_ALL is defined, shouldn't
> CONFIG_PMAC also be defined, along with PREP, etc...

What do you guys think about this? I like the idea of having CONFIG_PMAC etc.
be defined if CONFIG_PPC_ALL is defined.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
