Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0E62467A2F
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Mar 2005 21:08:18 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Fedin <sonic_amiga@rambler.ru>
In-Reply-To: <42485636.4000106@rambler.ru>
References: <42485636.4000106@rambler.ru>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 21:07:49 +1000
Message-Id: <1112008070.5473.58.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Again ISA DMA question
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-03-28 at 14:08 -0500, Pavel Fedin wrote:
>   Hello, all!
> 
>   In a source code or AROS operating system (http://www.aros.org) i 
> found this comment:
> 
>   --- cut ---
>      The older PReP machines have the DMA area limited to first 16MB of 
> system
>      memory. Therefore it is reasonable, to place the kernel at the end 
> of DMA
>      RAM. Both areas may be then easily separated.
>   --- cut ---
> 
>   Does this mean that Linux has an option to limit DMA memory space to 
> first 16 MB? PReP machines are fully supported i guess. Or not fully?

Linux can do it, but we choose no to implement this on ppc, as slicing
the memory into zones has disadvantages. Only legacy ISA DMA is
concerned, which is mostly not a problem. PCI DMA shouldn't be limited.

Ben.
