Return-Path: <becky.bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 99EEFDDF51
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 11:05:06 +1100 (EST)
Message-Id: <282F2715-EFD2-42E5-9AF5-304292F576A8@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
To: benh@kernel.crashing.org
In-Reply-To: <1223985921.8157.341.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH V2 4/4] POWERPC: Merge 32 and 64-bit dma code
Date: Tue, 14 Oct 2008 10:45:15 -0500
References: <1220900995-11928-5-git-send-email-becky.bruce@freescale.com>
	<1221251686-5567-1-git-send-email-becky.bruce@freescale.com>
	<20081013144904.GB18363@yoda.jdub.homelinux.org>
	<20081013154127.GA27124@yoda.jdub.homelinux.org>
	<209E575D-DDE2-406A-82DE-2DD445046C02@kernel.crashing.org>
	<20081013142100.7efc2c81@zod.rchland.ibm.com>
	<AF818ED4-F261-4EF8-A4CB-CA06FCA9386D@kernel.crashing.org>
	<1223940659.8157.288.camel@pasglop>
	<9EE82BA3-5B0C-43BB-90B4-2A93999285C1@kernel.crashing.org>
	<20081014062429.48abfb43@zod.rchland.ibm.com>
	<1223985921.8157.341.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 14, 2008, at 7:05 AM, Benjamin Herrenschmidt wrote:

> On Tue, 2008-10-14 at 06:24 -0400, Josh Boyer wrote:
>>> I pointed out to Stephen that kisskb.ellerman.id.au hasn't been
>>> updating.. there is a chrp32 defconfig in there that would
>> normally
>>> catch something like this.
>>
>> Except if kissb catches it, it's already committed in tree.  Better
>> than nothing, but it would be nice if people did a buildall before
>> they
>> commit.
>
> I have a script that builds a dozen of config's, it looks like it  
> didn't
> catch that one. I'm going to add a chrp32_defconfig to it. Mistakes
> happen, hopefully we can at least make sure the common configs are  
> well
> tested.

Blah. I thought I had built everything before I pushed this stuff  
out.  My apologies (and also for being offline for when the fun  
occurred here.... I just got back from vacation this morning.)  Ben,  
thanks for fixing - let me know if there's anything you need from my  
end.

-B
