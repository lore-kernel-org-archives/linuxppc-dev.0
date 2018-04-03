Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Fv5g1Pq7zF28m
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 02:03:35 +1000 (AEST)
In-Reply-To: <20171117140807.22105-3-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [2/3] powerpc/64s/idle: avoid sync for KVM state when waking from
 idle
Message-Id: <40Fv5f4Pfpz9s1r@ozlabs.org>
Date: Wed,  4 Apr 2018 02:03:32 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-11-17 at 14:08:06 UTC, Nicholas Piggin wrote:
> When waking from a CPU idle instruction (e.g., nap or stop), the sync
> for ordering the KVM secondary thread state can be avoided if there
> wakeup is coming from a kernel context rather than KVM context.
> 
> This improves performance for ping-pong benchmark with the stop0 idle
> state by 0.46% for 2 threads in the same core, and 1.02% for different
> cores.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8c1c7fb0b5ec95c392e9b585a6cf8c

cheers
