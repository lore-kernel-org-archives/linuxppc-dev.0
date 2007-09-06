Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 72357DDF2C
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 00:27:30 +1000 (EST)
In-Reply-To: <20070905114023.GA4072@localhost.localdomain>
References: <46D73166.6080103@freescale.com>
	<989B956029373F45A0B8AF02970818900147BD4D@zch01exm26.fsl.freescale.net>
	<ac803797588b40e3d33bbd6f758a5663@kernel.crashing.org>
	<46DC126C.9060603@freescale.com>
	<20070903151319.GA24840@localhost.localdomain>
	<fdaf530168b099fcb5a3fbbe45e38271@kernel.crashing.org>
	<20070904104750.GA32451@localhost.localdomain>
	<20070904182028.GC18280@ld0162-tx32.am.freescale.net>
	<20070905114023.GA4072@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d9d8f9d5d4107d9e313396cecf34257e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v7 3/3] [POWERPC] MPC832x_RDB: update dts to use SPI1in QE,
	register mmc_spi stub
Date: Thu, 6 Sep 2007 16:25:27 +0200
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> The kernel is of course welcome to do so -- and this may be a valid
>> reason to attach pin information to specific device nodes, if it 
>> actually
>> saves a non-negligible amount of power -- but it's not a reason to 
>> force
>> the kernel to have to care by not setting things up in the firmware.
>
> Well, I might agree here. But to me it seems unnatural that I have to
> upgrade bootloader to use SPI -- I can already boot the kernel.
>
> Bootloader's duties are finished when kernel booted. And if already
> running kernel is unable to do something, it's not bootloader's fault
> anymore, but kernel's itself.

If the firmware failed to properly initialise the system into some
stable state, then yeah, it _is_ the firmware's fault.

> And from the practical point of view, upgrading bootloader is much
> more error-prone and risky for the users without proper rescue tools
> and knowledge.

Yeah well -- it's hardly rocket science to make this a very
reliable and safe procedure.

>  Kernel is easier to deploy after bug-fixing (and
> wrongly set up GPIO pin is a bug). That's why I tend to like "dumb
> and simple" bootloaders and do not hang up too much duties on it.

That's one of the ways it is done -- have a "dumb and simple"
recovery firmware that can install new versions of the "main"
firmware.

Anyway, we're getting very far off-topic now :-)


Segher
