Date: Tue, 25 Jul 2000 14:17:12 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Jordan <ledzep37@home.com>,
        Linuxppc Developer <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Errors while compiling 2.4.0test5 from BitKeeper
In-Reply-To: <Pine.LNX.4.10.10007250929510.16526-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.10.10007251416470.434-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 25 Jul 2000, Michael Schmitz wrote:
> > arch/ppc/kernel/kernel.o(.text+0x8ff8): relocation truncated to fit:
> > R_PPC_REL24 pmu_request
> > arch/ppc/kernel/kernel.o(.text+0x9008): undefined reference to
> > `pmu_poll'
> > arch/ppc/kernel/kernel.o(.text+0x9008): relocation truncated to fit:
> > R_PPC_REL24 pmu_poll
> > make: *** [vmlinux] Error 1
>
> Include PMU support.

Or make the calls to the PMU stuff dependent on the PMU config option.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
