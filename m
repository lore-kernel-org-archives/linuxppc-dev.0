Date: Wed, 13 Sep 2000 21:32:30 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
cc: Takashi Oe <toe@unlserve.unl.edu>,
        Paul Mackerras <paulus@linuxcare.com.au>, mlan@cpu.lu,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: zeroing pages in the idle task?
In-Reply-To: <Pine.LNX.3.96.1000913092239.15334F-100000@deepspace.mklinux.org>
Message-ID: <Pine.LNX.4.10.10009132130250.452-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 13 Sep 2000, David A. Gatwood wrote:
> On Wed, 13 Sep 2000, Takashi Oe wrote:
> > > Since the only use of this number is for oohs and aahs, there's not a
> > > lot of motivation to try and work out if OF is wrong and work out the
> > > correct number.
> >
> > Could you possibly tell me how one might implement this?  That is: how one
> > would measure/calculate this.  On NuBus, there is no OF, so I'd like to
> > implement.
>
> Ask the guys at Newer Tech for their Clockometer sources.  I don't know if
> they'd be willing to open-source them, but it's worth a shot.  As I
> understand it, their program does just what you're looking for.

On the m68k, we have some code to guestimate the CPU clock based on the
BogoMIPS (see get_cpuinfo() in arch/m68k/kernel/setup.c). Since we didn't care
about the overhead incurred by interrupt processing, it's not that accurate
though (I get 24.8 MHz on my 25 MHz 68040).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
