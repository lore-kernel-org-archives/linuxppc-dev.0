Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5ABE7DDD0D
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 06:13:07 +1000 (EST)
In-Reply-To: <200707051813.53762.arnd@arndb.de>
References: <468D1F23.6000803@freescale.com> <200707051813.53762.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <07B2FA81-13F7-41AF-AAE8-171A72FA1DE0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: PowerPC equivalent to dma_mmap_writecombine()?
Date: Thu, 5 Jul 2007 22:11:05 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> There are no dma_mmap_x() functions in arch/powerpc.  Can someone  
>> tell me what the powerpc
>> equivalent to dma_mmap_writecombine() is?
>
> Not sure exactly what arm does here, but it sounds like you want
> to call remap_pfn_range with the _PAGE_NO_CACHE bit set in the
> protection flags, and _PAGE_GUARDED not set.

Either that, or just map it as normal cache-coherent DMA
memory.


Segher
