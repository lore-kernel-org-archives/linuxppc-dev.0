Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BEDE3DDD0C
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 23:26:03 +1100 (EST)
In-Reply-To: <20070221002443.GE10231@localhost.localdomain>
References: <20070220021235.DC02DDDD06@ozlabs.org>
	<1171984191.24204.84.camel@zod.rchland.ibm.com>
	<20070221002443.GE10231@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b97d3ed6affcbb9cd1f58a82db8a5465@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 12/14] Add device tree for Ebony
Date: Wed, 21 Feb 2007 13:25:55 +0100
To: David Gibson <dwg@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +		POB0: opb@0 {
>>
>> I think you meant "OPB0:" for the label.
>
> Not really.  The 440GP user manual refers to the bridge (as opposed to
> the bus) as POB0.  The label is meant to reflect that.

The device node represents both the bridge _and_ the bus
behind it, so you could use OPB just as well as POB, and
it probably would be less confusing ;-)

But it's just a label, who cares.


Segher
