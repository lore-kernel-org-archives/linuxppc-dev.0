Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w9nt66RG6zDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Apr 2017 21:53:18 +1000 (AEST)
In-Reply-To: <20170419130551.32378-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/9] powerpc/64s: Remove unnecessary relocation branch from idle
 handler
Message-Id: <3w9nt65Ln9z9s2s@ozlabs.org>
Date: Sun, 23 Apr 2017 21:53:18 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-19 at 13:05:43 UTC, Nicholas Piggin wrote:
> The system reset idle handler system_reset_idle_common is relocated, so
> relocation is not required to branch to kvm_start_guest. The superfluous
> relocation does not result in incorrect code, but it does not compile
> outside of exception-64s.S (with fixed section definitions).
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2563a70c3b2acc4f60083e2aaf1102

cheers
