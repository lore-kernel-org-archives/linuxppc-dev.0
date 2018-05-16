Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mFrr2pn6zF15L
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 23:38:52 +1000 (AEST)
In-Reply-To: <20180512033525.18762-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: selftests/powerpc: fix exec benchmark
Message-Id: <40mFrp33blz9s3x@ozlabs.org>
Date: Wed, 16 May 2018 23:38:50 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2018-05-12 at 03:35:24 UTC, Nicholas Piggin wrote:
> The exec_target binary could segfault calling _exit(2) because r13
> is not set up properly (and libc looks at that when performing a
> syscall). Call SYS_exit using syscall(2) which doesn't seem to
> have this problem.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c906d2c74e0bb9059fbf43e21f8a96

cheers
