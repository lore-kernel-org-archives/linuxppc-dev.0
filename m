Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNxzn38qCzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jun 2016 13:35:49 +1000 (AEST)
In-Reply-To: <1461601157-27478-1-git-send-email-raj.khem@gmail.com>
To: Khem Raj <raj.khem@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Khem Raj <raj.khem@gmail.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [V2] powerpc/ptrace: Fix out of bounds array access warning
Message-Id: <3rNxzn27hwz9t3x@ozlabs.org>
Date: Tue,  7 Jun 2016 13:35:49 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-25-04 at 16:19:17 UTC, Khem Raj wrote:
> gcc-6 correctly warns about a out of bounds access
> 
> arch/powerpc/kernel/ptrace.c:407:24: warning: index 32 denotes an offset greater than size of 'u64[32][1] {aka long long unsigned int[32][1]}' [-Warray-bounds]
>         offsetof(struct thread_fp_state, fpr[32][0]));
>                         ^
> 
> check the end of array instead of beginning of next element to fix this
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Acked-by: Olof Johansson <olof@lixom.net>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/1e407ee3b21f981140491d5b8a

cheers
