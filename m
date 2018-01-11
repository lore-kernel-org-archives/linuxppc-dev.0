Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zH8qq7410zDqpF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 13:25:43 +1100 (AEDT)
In-Reply-To: <20180111022135.19532-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/kernel: Print actual address of regs when oopsing
Message-Id: <3zH8qq552bz9t3C@ozlabs.org>
Date: Thu, 11 Jan 2018 13:25:43 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-01-11 at 02:21:35 UTC, Michael Ellerman wrote:
> When we oops or otherwise call show_regs() we print the address of the
> regs structure. Being able to see the address is fairly useful,
> firstly to verify that the regs pointer is not completely bogus, and
> secondly it allows you to dump the regs and surrounding memory with a
> debugger if you have one.
> 
> In the normal case the regs will be located somewhere on the stack, so
> printing their location discloses no further information than printing
> the stack pointer does already.
> 
> So switch to %px and print the actual address, not the hashed value.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/182dc9c7f217146d69d9c0b75c150c

cheers
