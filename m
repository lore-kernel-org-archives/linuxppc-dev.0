Date: Wed, 10 Apr 2002 08:17:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_GENERIC_PPC32
Message-ID: <20020410151741.GD26754@opus.bloom.county>
References: <0204091952.AA24042@ivan.Harhan.ORG> <Pine.GSO.4.21.0204101024580.24941-100000@trillium.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.21.0204101024580.24941-100000@trillium.sonytel.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Apr 10, 2002 at 10:27:05AM +0200, Geert Uytterhoeven wrote:
>
> On Tue, 9 Apr 2002, Michael Sokolov wrote:
> > Tom Rini <trini@kernel.crashing.org> wrote:
> > > Most of the code is actually rather
> > > clean.  The Sandpoint is actally a good candidate for some sort of run-time
> > > checks since it's a development board and the X2/X3 (and X3b) do differ in
> > > some ways.  I actually think the Spruce thing is a red-herring, but maybe the
> > > Spurce Paul/David Gibson have is different than the one mporter has access to.
> >
> > But the point is that these two ports as they are right now aren't suitable for
> > CONFIG_GENERIC_PPC32 because of #ifdefs in them. An #ifdef-ectomy would mean
> > splitting the Sandpoint port into two ports, X2 and X3 with different _machine
> > codes, selected at run time. I don't know what to do for the Spruce. Does that
> > board have a spec saying what the baud clock is supposed to be? If there is,
> > assume the value from the spec and fix the boards that don't meet the spec. If
> > there is no right value and both values are equally legit, that's a screwed-up
> > board that standard OSes like Debian Linux/PPC don't need to support, so don't
> > bother putting it in the generic kernel.
>
> Can't you pass the X parameter and the baud clock to the kernel, either using
> the kernel command line or a bi_rec? On Amiga we pass things like VBLANK,
> E-clock, and power supply frequencies as well (using bi_recs).

>From PPCBoot/StarMON/other linux knowing firmware, yes.  From
arch/ppc/boot we'd still have to compile it in and then pass it.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
