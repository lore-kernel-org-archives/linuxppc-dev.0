Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EAC3ADDEEC
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 00:29:04 +1000 (EST)
In-Reply-To: <20070906141901.GC16353@ld0162-tx32.am.freescale.net>
References: <46D73166.6080103@freescale.com>
	<989B956029373F45A0B8AF02970818900147BD4D@zch01exm26.fsl.freescale.net>
	<ac803797588b40e3d33bbd6f758a5663@kernel.crashing.org>
	<46DC126C.9060603@freescale.com>
	<6c73dab2fcf21490edc64b9b7ec52295@kernel.crashing.org>
	<46DCCE19.6050401@freescale.com>
	<3299c27fe2551315c6f5ecff3569f2e0@kernel.crashing.org>
	<20070906141901.GC16353@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e1e47fc85bd53065b8d2a87deea96ec3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v7 3/3] [POWERPC] MPC832x_RDB: update dts to use SPI1in QE,
	register mmc_spi stub
Date: Thu, 6 Sep 2007 16:29:03 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> AFAIK, there is no other standard data structure that could take 
>>> place
>>> of the par_io nodes in the DTS.
>>
>> The device tree is not a dumping ground for all your "I need some
>> standard data structure" stuff.  Use an XML file if you have to ;-)
>
> Bah.  How about we just remove the nodes you don't want to see before
> passing it on to the kernel? :-)

That is fine.  In fact, LinuxBIOS will probably do similar things.

Since this node will have one user only, feel free to create a
format for it that is as simple as possible for what you need
it for, there's no need to follow any conventions (as long as
you can create a _real_ tree from it later ;-) )


Segher
