Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A3542DDEB9
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 11:28:07 +1000 (EST)
Message-ID: <46E0A953.8080202@freescale.com>
Date: Thu, 06 Sep 2007 20:28:51 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>,
	Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v7 3/3] [POWERPC] MPC832x_RDB: update dts to use SPI1in
	QE, register mmc_spi stub
References: <46D73166.6080103@freescale.com>
	<989B956029373F45A0B8AF02970818900147BD4D@zch01exm26.fsl.freescale.net>
	<ac803797588b40e3d33bbd6f758a5663@kernel.crashing.org>
	<46DC126C.9060603@freescale.com>
	<20070903151319.GA24840@localhost.localdomain>
	<fdaf530168b099fcb5a3fbbe45e38271@kernel.crashing.org>
	<20070904104750.GA32451@localhost.localdomain>
	<20070904182028.GC18280@ld0162-tx32.am.freescale.net>
	<20070905114023.GA4072@localhost.localdomain>
	<20070905132106.GB24637@ld0162-tx32.am.freescale.net>
	<20070907011553.GO26079@localhost.localdomain>
In-Reply-To: <20070907011553.GO26079@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

> Firmwares are, more often than not, crap, and that's unlikely to
> change.  For a lot of things, having the kernel or bootwrapper cope as
> a special case with a handful of crap firmwares which don't set things
> up properly isn't actually any easier than having it set them up
> itself, always.

Similarly, firmware is very often unlikely to be updated.  So we need to 
support situations where we use old firmware with new kernels.  The cuImage 
support is a classic example of this.  Moving code from kernel to firmware 
just because some people think it belongs in the firmware is usually impractical.

If we added code to U-Boot today to configure the par_io pins, it would 
probably still be years before we could safely remove that code from the kernel.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
