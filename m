Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN60m32sbzDvsf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:34:16 +1100 (AEDT)
In-Reply-To: <20161108121445.15303-3-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [2/2] powerpc: fix second nested oops hang
Message-Id: <3tN60m1HVZz9s3s@ozlabs.org>
Date: Tue, 22 Nov 2016 11:34:16 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-08 at 12:14:45 UTC, Nicholas Piggin wrote:
> When ending an oops, don't clear die_owner unless the nest count
> went to zero. This prevents a second nested oops from hanging forever
> on the die_lock.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7458e8b2ce62e65051fec0bcb14cac

cheers
