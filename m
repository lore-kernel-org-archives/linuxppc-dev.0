To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dale Farnsworth <dale@farnsworth.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: MPC5200 Patches 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 12 Nov 2003 10:30:38 +0100."
             <Pine.GSO.4.21.0311121029220.885-100000@waterleaf.sonytel.be>
Date: Wed, 12 Nov 2003 10:49:09 +0100
Message-Id: <20031112094914.0D24FC5F59@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <Pine.GSO.4.21.0311121029220.885-100000@waterleaf.sonytel.be> you wrote:
>
> >   We have drivers/i2c/i2c-algo-8xx.c, so maybe we should have
> >   i2c-algo-5xxx.c instead of i2c-algo-m5xxx.c ?
> >
> >   There is include/linux/i2c-algo-8xx.h - how about i2c-algo-5xxx.h
> >   instead of i2c-algo-m5xxx.h ?
...
> What's done in include/asm-ppc/ isn't that important for the outside (non-PPC)
> world, but i2c-algo-5xxx.c may be a too generic name...

Which name do you recommend to cover the MGT5100 and MPC5200 (and
probably other MPC5xxx) processors?

[There is already i2c-algo-8xx.[ch]...]


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Perl already has an IDE.  It's called Unix.
                      -- Tom Christiansen in 375bd509@cs.colorado.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
