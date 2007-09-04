Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B3CC8DDE11
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Sep 2007 13:17:08 +1000 (EST)
Message-ID: <46DCCE19.6050401@freescale.com>
Date: Mon, 03 Sep 2007 22:16:41 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v7 3/3] [POWERPC] MPC832x_RDB: update dts to use SPI1in
	QE, register mmc_spi stub
References: <20070823113349.GA11870@localhost.localdomain><20070823113600.GC18080@localhost.localdomain>
	<46D73166.6080103@freescale.com>
	<989B956029373F45A0B8AF02970818900147BD4D@zch01exm26.fsl.freescale.net>
	<ac803797588b40e3d33bbd6f758a5663@kernel.crashing.org>
	<46DC126C.9060603@freescale.com>
	<6c73dab2fcf21490edc64b9b7ec52295@kernel.crashing.org>
In-Reply-To: <6c73dab2fcf21490edc64b9b7ec52295@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:

> This kind of thing is typically hardcoded into the firmware (just like
> the device tree is) -- just put it somewhere _next to_ the device tree,
> not _in_ it. 

What is next to the device tree?  AFAIK, there is no other standard data 
structure that could take place of the par_io nodes in the DTS.

I agree with your points, Segher, but replacing the par_io node with a bunch 
of par_io_config_pin() calls in the kernel is not really an improvement, I 
think.  Until we migrate the QE pin configuration code to U-boot, I suggest 
that we keep the device tree structure as-is and continue to use it for new 
code.  That way, it will all stay in one place.


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
