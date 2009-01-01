Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7E16DDDED9
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jan 2009 01:26:43 +1100 (EST)
Message-Id: <B64DF110-E26A-4229-8384-E7933732BC01@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20081231171017.6FCF585AD247@gemini.denx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v2 4/4] powerpc/83xx: Add PCI-E support for all MPC83xx
	boards with PCI-E
Date: Thu, 1 Jan 2009 08:26:14 -0600
References: <20081229164040.GD8215@oksana.dev.rtsoft.ru>
	<C96CE59B-05FA-4728-930F-D4430EFB9B99@kernel.crashing.org>
	<20081230201916.GA20059@oksana.dev.rtsoft.ru>
	<1F7739C2-930B-49C1-B8FF-679AF1BBAEAE@kernel.crashing.org>
	<20081231171017.6FCF585AD247@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 31, 2008, at 11:10 AM, Wolfgang Denk wrote:

> Dear Kumar,
>
> In message <1F7739C2-930B-49C1- 
> B8FF-679AF1BBAEAE@kernel.crashing.org> you wrote:
>>
>>> This is how FSL U-Boots configure the cfg window, and I'm trying to
>>> retain the compatibility. Anyway, now Linux maps only the first 4kB
>>> of that area, so we don't actually care about this, but dts is still
>>> correct for older u-boots. Newer U-Boots might want to correct this
>>> value if they want to use other cfg window setup...
>>
>> I'd rather not pollute the .dts with this since I don't believe the
>> open source u-boot supports PCIe on 83xx.
>
> What exactly do you mean by "open source u-boot"?  You  don't  really
> mean that there are propriatary (closed source) versions of U-Boot in
> Freescale,  or  are  you?  I  iknow that you know that it's GPL, so I
> guess that was just an unlucky phrase?

I meant the official u-boot from denx.de vs the one FSL ships w/its  
boards & BSPs.  The BSP u-boot has modifications that don't exist in  
the denx.de u-boot (as the quality of the code is not up to open  
source standards).

That is all I meant.

My statement was to convey that the kernel.org kernel should only  
worry itself with the denx.de u-boot (w/regards to compatibility).

- k
