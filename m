Date: Fri, 1 Sep 2000 16:40:48 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Gabriel Paubert <paubert@iram.es>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Platform configuration (was: Re: CONFIG_PPC != Mac)
In-Reply-To: <20000831162209.31786@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10009011640250.373-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 31 Aug 2000, Benjamin Herrenschmidt wrote:
> >First, kernel compile times are only fairly large after a big update, when
> >I do `make dep clean zImage'. Second, the proportion of time spend in the
> >specific PPC code (mostly arch/ppc and drivers/macintosh) is rather small.
> >Third, building a minimal kernel image for each machine would involve a
> >ton (and that's an undrestatement) of kernel options: CONFIG_INTC_8259,
> >CONFIG_INTC_POWERMAC, CONFIG_INTC_OPENPIC and others for the interrupt
> >controllers, half a dozen or so CONFIG_RTC types, same for CONFIG_NVRAM
> >and a few other things I surely forget. The only reasonable solution is to
> >aim for the smallest runtime kernel image.
>
> Well, an easy first step is to have those per-machine cumulative compile
> options so you can choose pmac only, pmac+chrp, etc...

Right, just like we had 2 years ago.

> That's only a few more config stuffs (CONFIG_PPC_PMAC, CONFIG_PPC_PREP,
> etc...), the core code wouldn't need to change. We can even optimize the
> various if (_machine == xxxx) using maros that get resolved to a constant
> when only one machine type is compiled in.

Yes indeed.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
