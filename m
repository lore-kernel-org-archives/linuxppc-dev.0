Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B7A9ADDED9
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 14:31:29 +1100 (EST)
Message-Id: <F174C43D-B59A-47E0-AF99-DA8182F8A6D0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Zhang Wei <wei.zhang@freescale.com>
In-Reply-To: <78567AC4946EDC42B7DE978C350CD869EC52AE@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Introduce lowmem_end_addr to distiguish
	fromtotal_lowmem
Date: Mon, 24 Mar 2008 22:31:16 -0500
References: <Pine.LNX.4.64.0803241832570.29472@blarg.am.freescale.net>
	<78567AC4946EDC42B7DE978C350CD869EC52AE@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Wang Haiying <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 24, 2008, at 10:18 PM, Zhang Wei wrote:
> Hi, Kumar,
>
>> -----Original Message-----
>> From: linuxppc-dev-bounces+wei.zhang=freescale.com@ozlabs.org
>>
>> total_lowmem represents the amount of low memory not the
>> physical address
>> that low memory ends at.  If the start of memory is at 0 it
>> happends that
>> total_lowmem can be used as both the size and the address that lowmem
>> ends at. (technical its one byte beyond the end)
>>
>> To make the code a bit more clear and deal with the case when
>> the start of
>> memory isn't at physical 0, we introduce lowmem_end_addr that
>> represents
>> one byte beyond the last physical address in the lowmem region.
>
> About the kernel memory offset, if the memory area from phyical 0
> to lowmem start address is reserved for other usage in this kernel,
> no more comments. If it will be used by other kernel (in asmp mode),
> how about to use tlb mapping physical address to virtual address 0
> not move the kernel lowmem address? I consider the tlb mapping
> will be more safe.

I'm not sure I follow your question.

- k
