Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjgLX5NwWzDqTm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 21:36:20 +1000 (AEST)
In-Reply-To: <20170825043036.18236-4-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kvm-ppc@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v3,
 3/4] powerpc/64s: idle POWER9 can execute stop in virtual mode
Message-Id: <3xjgLX3Dgkz9sQl@ozlabs.org>
Date: Thu, 31 Aug 2017 21:36:19 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-08-25 at 04:30:35 UTC, Nicholas Piggin wrote:
> The hardware can execute stop in any context, and KVM does not
> require real mode because siblings do not share MMU state. This
> saves a switch to real-mode when going idle.
> 
> Acked-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Paul Mackerras <paulus@ozlabs.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/72b0d51d973beab5a06c97279b61a0

cheers
