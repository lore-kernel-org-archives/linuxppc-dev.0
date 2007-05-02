Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5E480DDF59
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 03:51:33 +1000 (EST)
Subject: Re: [PATCH 1/6] powerpc: split out CPU specific options into a new
	Kconfig file
From: Jon Loeliger <jdl@freescale.com>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <4638B42B.7040208@freescale.com>
References: <20070502114709.074174446@arndb.de>
	<20070502115644.638734471@arndb.de>  <4638B42B.7040208@freescale.com>
Content-Type: text/plain
Message-Id: <1178128283.32136.13.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 02 May 2007 12:51:24 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-02 at 10:54, Timur Tabi wrote:
> Arnd Bergmann wrote:
> 
> > +config CLASSIC32
> > +	bool "52xx/6xx/7xx/74xx"
> > +	select PPC_FPU
> > +	select 6xx
> > +	help
> > +	  There are four families of PowerPC chips supported.  The more common
> > +	  types (601, 603, 604, 740, 750, 7400), the Motorola embedded
> > +	  versions (821, 823, 850, 855, 860, 52xx, 82xx, 83xx), the AMCC
> > +	  embedded versions (403 and 405) and the high end 64 bit Power
> > +	  processors (POWER 3, POWER4, and IBM PPC970 also known as G5).
> 
> Is this help text still accurate?  The bool line says "52xx/6xx/7xx/74xx", but you talk 
> about many more processors in the help text.  You mention the 83xx, but not the 85xx or 
> 86xx, nor do you mention Freescale.  Not only that, but the help text implies that 8xx, 
> 52xx, 82xx, and 83xx are part of the same family, but the bool text implies that 52xx is 
> part of a different family.

Timur,

Please read through the rest of the patch sequence.
This patch was just the "first step", moving things
around without additional changes.

jdl
