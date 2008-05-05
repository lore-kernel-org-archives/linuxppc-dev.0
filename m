Return-Path: <jeremy.mcnicoll@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 1E457DDDFD
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 08:25:32 +1000 (EST)
Message-ID: <481F896E.1000303@windriver.com>
Date: Mon, 05 May 2008 18:25:50 -0400
From: Jeremy McNicoll <jeremy.mcnicoll@windriver.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] SBC8548: Add flash support and HW Rev reporting
References: <1209759601-5659-1-git-send-email-jeremy.mcnicoll@windriver.com>
	<1210025844-20681-1-git-send-email-jeremy.mcnicoll@windriver.com>
	<7C3FC1D9-52B1-41C6-8C77-2C4335CCD780@kernel.crashing.org>
In-Reply-To: <7C3FC1D9-52B1-41C6-8C77-2C4335CCD780@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On May 5, 2008, at 5:17 PM, Jeremy McNicoll wrote:
> 
>> The following adds local bus, flash and MTD partition nodes for
>> sbc8548. As well, a compatible field for the soc node, so that
>> of_platform_bus_probe() will pick it up.
>>
>> Something that is provided through this newly added epld node
>> is the Hardware Revision which is now being utilized.
>>
>> Signed-off-by: Jeremy McNicoll <jeremy.mcnicoll@windriver.com>
> 
> What was changed in this version?

The dts is the same.  I decided to remove the arch_initcall 
and the associated printk in sbc8548_hw_rev().

-jeremy
