Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8CE5CDDE19
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 23:21:19 +1000 (EST)
Date: Wed, 5 Sep 2007 08:21:06 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v7 3/3] [POWERPC] MPC832x_RDB: update dts to use SPI1in QE,
	register mmc_spi stub
Message-ID: <20070905132106.GB24637@ld0162-tx32.am.freescale.net>
References: <46D73166.6080103@freescale.com>
	<989B956029373F45A0B8AF02970818900147BD4D@zch01exm26.fsl.freescale.net>
	<ac803797588b40e3d33bbd6f758a5663@kernel.crashing.org>
	<46DC126C.9060603@freescale.com>
	<20070903151319.GA24840@localhost.localdomain>
	<fdaf530168b099fcb5a3fbbe45e38271@kernel.crashing.org>
	<20070904104750.GA32451@localhost.localdomain>
	<20070904182028.GC18280@ld0162-tx32.am.freescale.net>
	<20070905114023.GA4072@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905114023.GA4072@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2007 at 03:40:23PM +0400, Anton Vorontsov wrote:
> On Tue, Sep 04, 2007 at 01:20:28PM -0500, Scott Wood wrote:
> > The kernel is of course welcome to do so -- and this may be a valid
> > reason to attach pin information to specific device nodes, if it actually
> > saves a non-negligible amount of power -- but it's not a reason to force
> > the kernel to have to care by not setting things up in the firmware.
> 
> Well, I might agree here. But to me it seems unnatural that I have to
> upgrade bootloader to use SPI -- I can already boot the kernel.

Sure -- the firmware should have been done right the first time.

Unfortunately, it very often doesn't, and thus fixups in the kernel's
platform code are warranted, but the firmware is still the preferred
place to do it.

> Bootloader's duties are finished when kernel booted.

And this line of thinking is what causes boards to be shipped with
half-assed firmware. :-)

-Scott
