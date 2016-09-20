Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdjhk3YwCzDsfj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 23:07:18 +1000 (AEST)
In-Reply-To: <20160915090446.898-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64s: exception optimise MSR handling
Message-Id: <3sdjhk2jgmz9sC7@ozlabs.org>
Date: Tue, 20 Sep 2016 23:07:18 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-15-09 at 09:04:46 UTC, Nicholas Piggin wrote:
> mtmsrd with L=1 only affects MSR_EE and MSR_RI bits, and we always
> know what state those bits are, so the kernel MSR does not need to be
> loaded when modifying them.
> 
> mtmsrd is often in the critical execution path, so avoiding dependency
> on even L1 load is noticable. On a POWER8 this saves about 3 cycles
> from the syscall path, and possibly a few from other exception returns
> (not measured).
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/49d09bf2a66f4b5a6eabefb0d4

cheers
