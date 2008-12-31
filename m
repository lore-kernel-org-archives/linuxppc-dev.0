Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B955ADDEEB
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jan 2009 04:41:27 +1100 (EST)
Date: Wed, 31 Dec 2008 20:41:25 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 4/4] powerpc/83xx: Add PCI-E support for all MPC83xx
	boards with PCI-E
Message-ID: <20081231174125.GA13027@oksana.dev.rtsoft.ru>
References: <20081229164040.GD8215@oksana.dev.rtsoft.ru>
	<C96CE59B-05FA-4728-930F-D4430EFB9B99@kernel.crashing.org>
	<20081230201916.GA20059@oksana.dev.rtsoft.ru>
	<1F7739C2-930B-49C1-B8FF-679AF1BBAEAE@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <1F7739C2-930B-49C1-B8FF-679AF1BBAEAE@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 31, 2008 at 10:48:07AM -0600, Kumar Gala wrote:
>
> On Dec 30, 2008, at 2:19 PM, Anton Vorontsov wrote:
>
>>>>
>>>>
>>>> +		compatible = "fsl,mpc8315-pcie", "fsl,mpc8314-pcie";
>>>> +		reg = <0xe0009000 0x00001000 0xb0000000 0x01000000>;
>>>
>>> the size on the 0xb0000000 seems wrong
>>
>> This is how FSL U-Boots configure the cfg window, and I'm trying to
>> retain the compatibility. Anyway, now Linux maps only the first 4kB
>> of that area, so we don't actually care about this, but dts is still
>> correct for older u-boots. Newer U-Boots might want to correct this
>> value if they want to use other cfg window setup...
>
> I'd rather not pollute the .dts with this

So you prefer to change the cfg window size to 0x1000?

> since I don't believe the open 
> source u-boot supports PCIe on 83xx.

Yes, that's correct. PCI-E support for community U-Boot is ongoing.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
