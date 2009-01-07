Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B881A474C3
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 01:38:02 +1100 (EST)
Message-Id: <5BCCF860-2DB3-4608-B8F5-3CBF378E06ED@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
In-Reply-To: <200901071510.45923.matthias.fuchs@esd-electronics.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Building current git for 405 is broken
Date: Wed, 7 Jan 2009 08:37:38 -0600
References: <200901071510.45923.matthias.fuchs@esd-electronics.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 7, 2009, at 8:10 AM, Matthias Fuchs wrote:

> Hi Benjamin,
>
> commit 2a4aca114439 (powerpc/mm: Split low level tlb invalidate for  
> nohash processors)
> breaks building for 40x CPUs. This is what I get when building for  
> the walnut board:
>
>  CC      arch/powerpc/kernel/prom.o
> In file included from arch/powerpc/kernel/prom.c:56:
> arch/powerpc/mm/mmu_decl.h: In function '_tlbil_all':
> arch/powerpc/mm/mmu_decl.h:34: error: expected ';' before '}' token
> arch/powerpc/mm/mmu_decl.h:36: error: invalid storage class for  
> function '_tlbil_pid'
> arch/powerpc/mm/mmu_decl.h: In function '_tlbil_pid':
> arch/powerpc/mm/mmu_decl.h:38: error: expected ';' before '}' token
> arch/powerpc/mm/mmu_decl.h:53: warning: ISO C90 forbids mixed  
> declarations and code
> arch/powerpc/mm/mmu_decl.h:62: error: invalid storage class for  
> function '_tlbivax_bcast'
> arch/powerpc/kernel/prom.c:90: error: invalid storage class for  
> function 'find_flat_dt_string'
>
> Seems to be a result of some missing types or whatever. I suppose  
> you are
> more familiar with that code than I am ;-)

Ben posted a patch that might address the issue:

http://patchwork.ozlabs.org/patch/17037/

- k
