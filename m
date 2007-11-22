Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2E954DDE2B
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 11:47:04 +1100 (EST)
Message-ID: <4744D1D0.70800@freescale.com>
Date: Wed, 21 Nov 2007 18:48:16 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/3] [POWERPC] Add docs for Freescale DMA & DMA channel
	device	tree nodes
References: <Pine.LNX.4.64.0711202310280.24220@blarg.am.freescale.net>
	<Pine.LNX.4.64.0711202314030.24220@blarg.am.freescale.net>
	<474447EF.8080405@freescale.com>
	<E9CED991-4E10-44AE-A446-B6CB151FB9EE@kernel.crashing.org>
In-Reply-To: <E9CED991-4E10-44AE-A446-B6CB151FB9EE@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

>> Shouldn't we put some text somewhere that we're calling it the Elo 
>> controller even though that word isn't used in the reference manual?
> 
> we don't really have a place to put that.  its effectively documented 
> right here.

I still think we need something.  Otherwise, people are going to be confused. 
  I know I would.  I'd be searching the RM for the string "ELO" and wonder why 
it wasn't there.


>>> +  Example:
>>> +    dma@21000 {
>>
>> Shouldn't this be dma@21300?
> 
> its an example that has not basis is reality :)

Eh?

>> The DMA controller and the DMA channels need a "device-id", so that 
>> they can be identified by number.  Some peripherals, like the SSI, can 
>> only use the controller and channel number.  This is what I have in my 
>> 8610 DTS:
> 
> Why not use reg for this?  I don't see any reason to add another "unique 
> id" when there is already one.

There isn't one.  Why should the driver assume that reg/80 == channel #? 
Besides, I still can't differentiate between DMA controller 0 and DMA 
controller 1 that way.  No, we need a device-id.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
