Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltwF3WLHzDqk9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:25:49 +1000 (AEST)
In-Reply-To: <20180723150756.11108-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/5] powerpc/asm: Add a patch_site macro & helpers for patching
 instructions
Message-Id: <41ltw948whz9s4V@ozlabs.org>
Date: Thu,  9 Aug 2018 00:25:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-07-23 at 15:07:52 UTC, Michael Ellerman wrote:
> Add a macro and some helper C functions for patching single asm
> instructions.
> 
> The gas macro means we can do something like:
> 
>   1:	nop
>   	patch_site 1b, patch__foo
> 
> Which is less visually distracting than defining a GLOBAL symbol at 1,
> and also doesn't pollute the symbol table which can confuse eg. perf.
> 
> These are obviously similar to our existing feature sections, but are
> not automatically patched based on CPU/MMU features, rather they are
> designed to be manually patched by C code at some arbitrary point.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/06d0bbc6d0f56dacac3a79900e9a9a

cheers
