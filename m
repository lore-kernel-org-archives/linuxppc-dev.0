Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjgLp170RzDqTy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 21:36:34 +1000 (AEST)
In-Reply-To: <20170830104512.13502-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: selftests/powerpc: Force ptrace tests to build -fno-pie
Message-Id: <3xjgLn5ZFfz9sQl@ozlabs.org>
Date: Thu, 31 Aug 2017 21:36:33 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-30 at 10:45:12 UTC, Michael Neuling wrote:
> Currently these tests won't build with a `--enable-default-pie`
> compiler as they require r30 to be clobbered. This gives
> an error:
>   ptrace-tm-spd-gpr.c:41:2: error: PIC register clobbered by 'r30' in 'asm'
> 
> This forces these tests to be built no-pie.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a3c01050584da30405181505d20cd6

cheers
