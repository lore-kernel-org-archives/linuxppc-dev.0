Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Fv5s5qn9zF28s
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 02:03:45 +1000 (AEST)
In-Reply-To: <20180401055036.18078-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/2] KVM: PPC: Book3S HV: Fix ppc_breakpoint_available compile
 error
Message-Id: <40Fv5r73CLz9s21@ozlabs.org>
Date: Wed,  4 Apr 2018 02:03:44 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-04-01 at 05:50:35 UTC, Nicholas Piggin wrote:
> arch/powerpc/kvm/book3s_hv.c: In function ‘kvmppc_h_set_mode’:
> arch/powerpc/kvm/book3s_hv.c:745:8: error: implicit declaration of function ‘ppc_breakpoint_available’; did you mean ‘hw_breakpoint_disable’? [-Werror=implicit-function-declaration]
>    if (!ppc_breakpoint_available())
>         ^~~~~~~~~~~~~~~~~~~~~~~~
>         hw_breakpoint_disable
> 
> Cc: Michael Neuling <mikey@neuling.org>
> Fixes: 398e712c00 ("KVM: PPC: Book3S HV: Return error from h_set_mode(SET_DAWR) on POWER9")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e303c08787c4cbe1ca07912817dff2

cheers
