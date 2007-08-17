Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B7565DDDF7
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 06:50:11 +1000 (EST)
Date: Fri, 17 Aug 2007 15:50:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] [POWERPC] Copy over headers from arch/ppc to
	arch/powerpc that we need
Message-ID: <20070817205001.GB6128@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0708170157140.15311@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708170212210.15311@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708170213040.15311@blarg.am.freescale.net>
	<200708171905.52855.arnd@arndb.de>
	<20070817204502.GA6128@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070817204502.GA6128@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 17, 2007 at 03:45:02PM -0500, Scott Wood wrote:
> On Fri, Aug 17, 2007 at 07:05:52PM +0200, Arnd Bergmann wrote:
> > The m8260_pci.h file is not namespace clean, it defines macros like
> > PCI_CFG_ADDR_REG that are likely to create conflicts at some point of
> > time. Since the only file including this header is 
> > arch/powerpc/platforms/82xx/m82xx_pci.h, I'd suggest merging the two,
> > to make sure nobody can accidentally include it.
> 
> Better yet, just get rid of that define -- nothing uses it AFAICT.

To elaborate, I grepped for all of the symbols defined in m8260_pci.h,
and none get any hits in arch/powerpc.

-Scott
