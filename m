Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 379F9DDEBF
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 00:19:10 +1000 (EST)
Date: Thu, 6 Sep 2007 09:19:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v7 3/3] [POWERPC] MPC832x_RDB: update dts to use SPI1in QE,
	register mmc_spi stub
Message-ID: <20070906141901.GC16353@ld0162-tx32.am.freescale.net>
References: <46D73166.6080103@freescale.com>
	<989B956029373F45A0B8AF02970818900147BD4D@zch01exm26.fsl.freescale.net>
	<ac803797588b40e3d33bbd6f758a5663@kernel.crashing.org>
	<46DC126C.9060603@freescale.com>
	<6c73dab2fcf21490edc64b9b7ec52295@kernel.crashing.org>
	<46DCCE19.6050401@freescale.com>
	<3299c27fe2551315c6f5ecff3569f2e0@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3299c27fe2551315c6f5ecff3569f2e0@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2007 at 04:13:56PM +0200, Segher Boessenkool wrote:
> > AFAIK, there is no other standard data structure that could take place 
> > of the par_io nodes in the DTS.
> 
> The device tree is not a dumping ground for all your "I need some
> standard data structure" stuff.  Use an XML file if you have to ;-)

Bah.  How about we just remove the nodes you don't want to see before
passing it on to the kernel? :-)

-Scott
