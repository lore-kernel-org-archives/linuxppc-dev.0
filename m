Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4ABCDDDEF8
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 03:54:02 +1000 (EST)
In-Reply-To: <4694F608.2090503@freescale.com>
References: <46B96294322F7D458F9648B60E15112C6F3D1E@zch01exm26.fsl.freescale.net>
	<4694F608.2090503@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <368E1200-1315-4C24-9876-C92CCF65EFE3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4] Add DMA sector to
	Documentation/powerpc/booting-without-of.txt file.
Date: Wed, 11 Jul 2007 19:53:52 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> I'd rather just treat the different DMA channels as independent  
>>> devices,
>>> rather than children of a dma "bus", and change the compatible  
>>> name if
>>> they're not general purpose.  There's only one register that's  
>>> shared
>>> among the channels, and it's a superfluous status summary register.
>>>
>> Your and my ideas are both sides of a coin. :-)
>
> I think there's a substantive difference between them.  Making each  
> channel an independent device makes it easier for other drivers to  
> use them.

True.  If the DMA channels are independent enough, putting them
in nodes of their own isn't too cumbersome, either.


Segher
