Date: Wed, 10 Apr 2002 10:27:05 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_GENERIC_PPC32
In-Reply-To: <0204091952.AA24042@ivan.Harhan.ORG>
Message-ID: <Pine.GSO.4.21.0204101024580.24941-100000@trillium.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 9 Apr 2002, Michael Sokolov wrote:
> Tom Rini <trini@kernel.crashing.org> wrote:
> > Most of the code is actually rather
> > clean.  The Sandpoint is actally a good candidate for some sort of run-time
> > checks since it's a development board and the X2/X3 (and X3b) do differ in
> > some ways.  I actually think the Spruce thing is a red-herring, but maybe the
> > Spurce Paul/David Gibson have is different than the one mporter has access to.
>
> But the point is that these two ports as they are right now aren't suitable for
> CONFIG_GENERIC_PPC32 because of #ifdefs in them. An #ifdef-ectomy would mean
> splitting the Sandpoint port into two ports, X2 and X3 with different _machine
> codes, selected at run time. I don't know what to do for the Spruce. Does that
> board have a spec saying what the baud clock is supposed to be? If there is,
> assume the value from the spec and fix the boards that don't meet the spec. If
> there is no right value and both values are equally legit, that's a screwed-up
> board that standard OSes like Debian Linux/PPC don't need to support, so don't
> bother putting it in the generic kernel.

Can't you pass the X parameter and the baud clock to the kernel, either using
the kernel command line or a bi_rec? On Amiga we pass things like VBLANK,
E-clock, and power supply frequencies as well (using bi_recs).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
