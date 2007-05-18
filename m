Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EBA1BDDEE2
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 03:43:58 +1000 (EST)
Message-ID: <464DE5D2.5000301@freescale.com>
Date: Fri, 18 May 2007 12:43:46 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and Rev
	1.02hardware
References: <1179245829.8132.100.camel@rhino>
	<1179247809.8132.138.camel@rhino>	<46B96294322F7D458F9648B60E15112C23441B@zch01exm26.fsl.freescale.net>	<1179417813.8132.250.camel@rhino>	<744CD970-5421-47D6-A30A-C7C79BE21BE8@kernel.crashing.org>	<1179421139.8132.256.camel@rhino>
	<464CA302.9060707@freescale.com>	<20070518005641.GA27350@localhost.localdomain>	<464DB986.20205@freescale.com>
	<20070518164628.GA16825@ld0162-tx32.am.freescale.net>
	<464DE2D3.3090805@smiths-aerospace.com>
	<464DE4C7.7030906@freescale.com>
In-Reply-To: <464DE4C7.7030906@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Just being able to delete a given node/property would be enough. 

I'd rather have an additive model than a subtractive one.  And it would 
not be enough, as you would not be able to have two different versions 
of a property with the same name.

>> On a related note, would it be better to name the node 
>> "/u-boot/hwoptions" (two levels deep)?  It seems very desirable to me to 
> 
> 
> It's not a u-boot-specific concept.  The idea of representing jumpers 
> (and other hardware options) in the device tree is not something that's 
> unique to u-boot or any boot loader. The conditionals, however, are a 
> bootloader-specific concept.  We don't want Linux to see them.

I put the u-boot namespace qualifier on there because the implementation 
is being suggested in the context of u-boot, and it's not a general OF 
binding.  However, as long as it gets nuked before passing it on to the 
kernel, OF/ePAPR/whatever compliance isn't quite as relevant, so plain 
old "hwoptions" should be OK.

-Scott
