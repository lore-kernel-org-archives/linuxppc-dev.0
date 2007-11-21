Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8179EDDDF6
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 06:21:26 +1100 (EST)
Message-Id: <8B189FFE-F45E-470C-87A0-E9FC61A1CF59@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20071121173540.GC4413@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 3/3] [POWERPC] Add docs for Freescale DMA & DMA channel
	device tree nodes
Date: Wed, 21 Nov 2007 13:21:07 -0600
References: <Pine.LNX.4.64.0711202310280.24220@blarg.am.freescale.net>
	<Pine.LNX.4.64.0711202314030.24220@blarg.am.freescale.net>
	<474447EF.8080405@freescale.com>
	<E9CED991-4E10-44AE-A446-B6CB151FB9EE@kernel.crashing.org>
	<20071121173540.GC4413@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 21, 2007, at 11:35 AM, Scott Wood wrote:

> On Wed, Nov 21, 2007 at 09:33:05AM -0600, Kumar Gala wrote:
>> On Nov 21, 2007, at 8:59 AM, Timur Tabi wrote:
>>>> +  Example:
>>>> +	dma@21000 {
>>>
>>> Shouldn't this be dma@21300?
>>
>> its an example that has not basis is reality :)
>
> But it should at least be internally consistent with this:
>
>>>> +		reg = <21300 4>;

ahh, i see.. yes I'll fix that.

> [snip]
>>> The DMA controller and the DMA channels need a "device-id", so that
>>> they can be identified by number.  Some peripherals, like the SSI,
>>> can only use the controller and channel number.  This is what I have
>>> in my 8610 DTS:
>>
>> Why not use reg for this?  I don't see any reason to add another
>> "unique id" when there is already one.
>
> A cell-index property would be useful here for indexing into the  
> summary
> status register.

Divide by 0x80.

>>>               dma@21300 {
>>>                       #address-cells = <1>;
>>>                       #size-cells = <1>;
>>>                       compatible = "fsl,mpc8610-dma", "fsl,mpc8540-
>>> dma";
>>>       -->             device-id = <0>;
>
> I don't see any justification for having such a property in the  
> parent node,
> though.

huh?
- k
