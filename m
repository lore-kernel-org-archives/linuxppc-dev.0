Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 288A4DDEE4
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 00:13:57 +1000 (EST)
In-Reply-To: <46DCCE19.6050401@freescale.com>
References: <20070823113349.GA11870@localhost.localdomain><20070823113600.GC18080@localhost.localdomain>
	<46D73166.6080103@freescale.com>
	<989B956029373F45A0B8AF02970818900147BD4D@zch01exm26.fsl.freescale.net>
	<ac803797588b40e3d33bbd6f758a5663@kernel.crashing.org>
	<46DC126C.9060603@freescale.com>
	<6c73dab2fcf21490edc64b9b7ec52295@kernel.crashing.org>
	<46DCCE19.6050401@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3299c27fe2551315c6f5ecff3569f2e0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v7 3/3] [POWERPC] MPC832x_RDB: update dts to use SPI1in QE,
	register mmc_spi stub
Date: Thu, 6 Sep 2007 16:13:56 +0200
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> This kind of thing is typically hardcoded into the firmware (just like
>> the device tree is) -- just put it somewhere _next to_ the device 
>> tree,
>> not _in_ it.
>
> What is next to the device tree?

"Anywhere else in the firmware".

> AFAIK, there is no other standard data structure that could take place 
> of the par_io nodes in the DTS.

The device tree is not a dumping ground for all your "I need some
standard data structure" stuff.  Use an XML file if you have to ;-)

> I agree with your points, Segher, but replacing the par_io node with a 
> bunch of par_io_config_pin() calls in the kernel is not really an 
> improvement, I think.  Until we migrate the QE pin configuration code 
> to U-boot, I suggest that we keep the device tree structure as-is and 
> continue to use it for new code.  That way, it will all stay in one 
> place.

Sure, some migration plan is in order, things won't change overnight.
That doesn't mean you don't need to start planning _now_ ;-)


Segher
