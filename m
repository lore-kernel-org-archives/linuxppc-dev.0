Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 485BEDDE1F
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 00:40:15 +1000 (EST)
In-Reply-To: <4640AE88.9040806@mvista.com>
References: <20070425213700.GA8814@blade.az.mvista.com>
	<20070426000852.GA2193@localhost.localdomain>
	<20070426003748.GA30730@blade.az.mvista.com>
	<9903F55A-5E4E-42CE-8C27-6B7143B9FE25@kernel.crashing.org>
	<20070501183220.GA6426@blade.az.mvista.com>
	<20070507232634.GA11166@blade.az.mvista.com>
	<3EF891D2-F973-43D6-B43B-B8BBC4269C60@kernel.crashing.org>
	<4640AE88.9040806@mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6fb05a0954f19c5744369c18670d81ff@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: add dts entries to 85xx for EDAC
Date: Wed, 9 May 2007 16:40:01 +0200
To: Dave Jiang <djiang@mvista.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> we should distinguish the memory controllers on 8540/8560 (DDR1) from
>> the one on 8548 (DDR1 & DDR2).
>
> Do you mean something like:
>
> 8540/8560
> compatible = "fsl,85xx-ddr-controller"

fsl,8540-memory-controller

> 8548
> compatible = "fsl,85xx-ddr2-controller"

fsl,8548-memory-controller

This shows once again why "Nxx" is not such a great
plan; it states that all Nxx devices are compatible,
while some might not even exist yet.


Segher
