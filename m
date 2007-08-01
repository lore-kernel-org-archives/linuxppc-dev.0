Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 3E743DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 10:12:45 +1000 (EST)
Message-ID: <46AFD0C8.5010704@mvista.com>
Date: Tue, 31 Jul 2007 17:16:08 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] powerpc: MPC85xx EDAC device driver
References: <20070726222225.GB10427@blade.az.mvista.com>
	<200708010007.12922.arnd@arndb.de> <46AFB686.40508@mvista.com>
	<200708010025.33732.arnd@arndb.de>
In-Reply-To: <200708010025.33732.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	norsk5@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Wednesday 01 August 2007, Dave Jiang wrote:
>> Doh! I sent out the reworked patches right before your comments. Do you happen
>> to know where I can find an example of how to do this? In regards to making a
>> platform_device a child of the PCI host bridge that is.... Thanks!
>>
> 
> When you use an open-coded version of platform_device_register_simple(),
> you can set dev->parent before calling platform_device_add.
> 
> 	Arnd <><

Do you mean the pci_controller hose that's allocated in fsl_add_bridge? Couple
questions....
1. How do I even get access to that? (in fsl_soc.c that is)
2. pci_controller has no "struct device" member. It only has "struct device
*parent". What do I set the dev->parent of the platform device to?


-- 

------------------------------------------------------
Dave Jiang
Software Engineer
MontaVista Software, Inc.
http://www.mvista.com
------------------------------------------------------
