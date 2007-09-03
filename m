Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A4FF3DDEAB
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Sep 2007 01:11:16 +1000 (EST)
Date: Mon, 3 Sep 2007 19:13:19 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v7 3/3] [POWERPC] MPC832x_RDB: update dts to use SPI1in
	QE, register mmc_spi stub
Message-ID: <20070903151319.GA24840@localhost.localdomain>
References: <46D73166.6080103@freescale.com>
	<989B956029373F45A0B8AF02970818900147BD4D@zch01exm26.fsl.freescale.net>
	<ac803797588b40e3d33bbd6f758a5663@kernel.crashing.org>
	<46DC126C.9060603@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <46DC126C.9060603@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 03, 2007 at 08:55:56AM -0500, Timur Tabi wrote:
[...]
> Besides, every other board does it's par_io configuration based on the 
> device tree.

My words. ;-) See
http://ozlabs.org/pipermail/linuxppc-dev/2007-August/040685.html

Also, see how it was made initially:
http://ozlabs.org/pipermail/linuxppc-dev/2007-August/040440.html

par_io was in the device tree. But Kumar and Segher convinced me to
not do that.

> So if Anton is going to break that pattern, we should be 
> talking about moving all that code into U-boot,
[...]

To my personal taste that's bad idea. In that scheme, I need to upgrade
bootloader to use such a little thing as SPI from the kernel.

I expect very few things from the bootloader: setup memory controller,
copy kernel from the source (flash, ethernet, rs232, ide, sata, ...)
into the RAM and boot it. Everything else from the bootloader side is
profusion.

p.s. Cc'ing Kumar.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
