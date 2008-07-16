Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 44E18DDEEB
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 21:14:21 +1000 (EST)
Subject: Re: [git pull] Please pull from powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200807161051.12545.arnd@arndb.de>
References: <1216172043.7740.136.camel@pasglop>
	<20080716042042.GA13212@redhat.com> <200807161051.12545.arnd@arndb.de>
Content-Type: text/plain
Date: Wed, 16 Jul 2008 21:13:44 +1000
Message-Id: <1216206824.7740.172.camel@pasglop>
Mime-Version: 1.0
Cc: Kumar Gala <kumar.gala@freescale.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Dave Jones <davej@redhat.com>,
	akpm <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-07-16 at 10:51 +0200, Arnd Bergmann wrote:
> On Wednesday 16 July 2008, Dave Jones wrote:
> > arch/powerpc/platforms/built-in.o: In function `ep8248e_mdio_probe':
> > /builddir/build/BUILD/kernel-2.6.26/linux-2.6.26.ppc/arch/powerpc/platforms/82xx/ep8248e.c:129: undefined reference to `alloc_mdio_bitbang'
> > /builddir/build/BUILD/kernel-2.6.26/linux-2.6.26.ppc/arch/powerpc/platforms/82xx/ep8248e.c:143: undefined reference to `mdiobus_register'
> 
> FS_ENET and EP8248E both select MDIO_BITBANG, but not PHYLIB or MII, which
> looks broken to me.
> 
> Also, I think it would be useful to split out the bitbang
> driver from ep8248e.c, so that you can build it as a loadable
> module if you want to have PHYLIB loadable.

On that note... I already run it through an autobuilder with a bunch of
configs before uploading (though obviously not this one). Kumar, can you
send me 2 or 3 configs you believe cover a reasonable range of the fsl
stuff that I could stick into my list for next time ?

Cheers,
Ben.
