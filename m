Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RHH4vNpzDrBV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:28:43 +1100 (AEDT)
In-Reply-To: <1520282935-20111-2-git-send-email-gromero@linux.vnet.ibm.com>
To: Gustavo Romero <gromero@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: cyrilbur@gmail.com, gromero@linux.vnet.ibm.com
Subject: Re: selftests/powerpc: Skip tm-unavailable if TM is not enabled
Message-Id: <401RHH24wVz9sVh@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:39 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-03-05 at 20:48:55 UTC, Gustavo Romero wrote:
> Some processor revisions do not support transactional memory, and
> additionally kernel support can be disabled. In either case the
> tm-unavailable test should be skipped, otherwise it will fail with
> a SIGILL.
> 
> That commit also sets this selftest to be called through the test
> harness as it's done for other TM selftests.
> 
> Finally, it avoids using "ping" as a thread name since it's
> ambiguous and can be confusing when shown, for instance,
> in a kernel backtrace log.
> 
> Fixes: 77fad8bfb1d2 ("selftests/powerpc: Check FP/VEC on exception in TM")
> Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
> Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b395e55b49ecd56ea28dc629f4ca4c

cheers
