Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y702s6bGHzDr1l
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 15:21:41 +1100 (AEDT)
In-Reply-To: <20170927054558.26007-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Meng YK Li <shlimeng@cn.ibm.com>, Jeremy Kerr <jk@ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/powernv: Use early_radix_enabled in POWER9 tlb flush
Message-Id: <3y702s5FlCz9t3k@ozlabs.org>
Date: Thu,  5 Oct 2017 15:21:41 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-09-27 at 05:45:58 UTC, Nicholas Piggin wrote:
> This code is used at boot and machine checks, so it should be using
> early_radix_enabled() (which is usable any time).
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/969a86a2855d484a00205a424df1c6

cheers
