Date: Wed, 12 Nov 2003 10:30:38 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Dale Farnsworth <dale@farnsworth.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: MPC5200 Patches 
In-Reply-To: <20031112003502.BBA4CC5F59@atlas.denx.de>
Message-ID: <Pine.GSO.4.21.0311121029220.885-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 12 Nov 2003, Wolfgang Denk wrote:
> * Some files/directories have been renamed into 5xxx, others in
>   m5xxx. The same applies to the CONFIG_ options: Maybe we can make
>   this a bit more consistent?
>
>   Given the fact that we use CONFIG_6xx, CONFIG_40x, CONFIG_44x,
>   CONFIG_8xx, ... we should probably use CONFIG_5xxx instead of
>   CONFIG_M5XXX ?
>
>   We have drivers/i2c/i2c-algo-8xx.c, so maybe we should have
>   i2c-algo-5xxx.c instead of i2c-algo-m5xxx.c ?
>
>   There is include/linux/i2c-algo-8xx.h - how about i2c-algo-5xxx.h
>   instead of i2c-algo-m5xxx.h ?
>
>   We have include/asm-ppc/mpc8xx.h and mpc8260.h and ibm4xx.h - maybe
>   we should use mpc5xxx.h instead of m5xxx.h ?

What's done in include/asm-ppc/ isn't that important for the outside (non-PPC)
world, but i2c-algo-5xxx.c may be a too generic name...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
