Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Date: Wed, 12 Nov 2003 12:51:31 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Wolfgang Denk <wd@denx.de>,
	Dale Farnsworth <dale@farnsworth.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: MPC5200 Patches
In-Reply-To: <20031112114114.GA8526@iram.es>
Message-ID: <Pine.GSO.4.21.0311121250470.885-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 12 Nov 2003, Gabriel Paubert wrote:
> On Wed, Nov 12, 2003 at 10:59:59AM +0100, Geert Uytterhoeven wrote:
> > On Wed, 12 Nov 2003, Wolfgang Denk wrote:
> > > In message <Pine.GSO.4.21.0311121029220.885-100000@waterleaf.sonytel.be> you wrote:
> > > >
> > > > >   We have drivers/i2c/i2c-algo-8xx.c, so maybe we should have
> > > > >   i2c-algo-5xxx.c instead of i2c-algo-m5xxx.c ?
> > > > >
> > > > >   There is include/linux/i2c-algo-8xx.h - how about i2c-algo-5xxx.h
> > > > >   instead of i2c-algo-m5xxx.h ?
> > > ...
> > > > What's done in include/asm-ppc/ isn't that important for the
> > > > outside (non-PPC) world, but i2c-algo-5xxx.c may be a too
> > > > generic name...
> > >
> > > Which name do you recommend to cover the MGT5100 and MPC5200 (and
> > > probably other MPC5xxx) processors?
> >
> > i2c-algo-m5xxx.c, like the original?
>
> Hmmm, dont't repeated x have a tendency to trigger spam filters
> (especially the dumbest ones)?
>
> Why not 5nnn or 5xyz?

i2c-algo-m5x00.c? (or i2c-algo-m5<censored>.c :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
