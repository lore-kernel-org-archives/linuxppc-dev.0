Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spfzq6bcDzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 13:36:23 +1100 (AEDT)
In-Reply-To: <1475626984-18770-2-git-send-email-mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org, npiggin@gmail.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v3,01/42] powerpc/64s: Add new exception vector macros
Message-Id: <3spfzq52Ywz9ryQ@ozlabs.org>
Date: Wed,  5 Oct 2016 13:36:23 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-05-10 at 00:22:23 UTC, Michael Ellerman wrote:
> Create arch/powerpc/include/asm/head-64.h with macros that specify
> an exception vector (name, type, location), which will be used to
> label and lay out exceptions into the object file.
> 
> Naming is moved out of exception-64s.h, which is used to specify the
> implementation of exception handlers.
> 
> objdump of generated code in exception vectors is unchanged except for
> names. Alignment directives scattered around are annoying, but done
> this way so that disassembly can verify identical instruction
> generation before and after patch. These get cleaned up in future
> patch.
> 
> We change the way KVMTEST works, explicitly passing EXC_HV or EXC_STD
> rather than overloading the trap number. This removes the need to have
> SOFTEN values for the overloaded trap numbers, eg. 0x502.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/da2bc4644c75d992427c45c5ade3bd

cheers
