Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BFB4BDDEDA
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 05:27:25 +1000 (EST)
In-Reply-To: <1180983026.9632.22.camel@ld0161-tx32>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
	<1180734314.5674.49.camel@rhino>
	<4fb92a9dfccf515bdc1522d08f10f823@kernel.crashing.org>
	<1180983026.9632.22.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5edf9ad94147c257a7d88671646187fc@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Date: Mon, 4 Jun 2007 21:27:19 +0200
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> "reg" included in "ranges"?  Something is wrong here.
>>>
>>> I think it's correct for soc nodes.
>>
>> It is not.  "ranges" is the address space translation
>> between the parent and child busses; "reg" is the stuff
>> that's on the bridge device itself.
>>
>>> At least, it appears that all of
>>> the dts files with soc nodes do similar things (including this one 
>>> even
>>> without this patch).
>>
>> Yes, but that doesn't make it right.
>
> But removing it does break things.

What breaks?  This sounds like a Linux bug, in
your port perhaps, or in some OF parsing code.

> I'm going to leave
> it as-is for now, and we can wrestle over "fixing" it
> in a follow up patch.

Fine with me -- please figure out what exactly it
is that is breaking though.

Thanks,


Segher
