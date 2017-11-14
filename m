Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yblG04JgxzDqsP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 22:12:08 +1100 (AEDT)
In-Reply-To: <20171023080507.21974-4-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v2,
 3/3] powerpc/powernv: Avoid waiting for secondary hold spinloop with
 OPAL
Message-Id: <3yblG02h0Vz9sRg@ozlabs.org>
Date: Tue, 14 Nov 2017 22:12:08 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-10-23 at 08:05:07 UTC, Nicholas Piggin wrote:
> OPAL boot does not insert secondaries at 0x60 to wait at the secondary
> hold spinloop. Instead they are started later, and inserted at
> generic_secondary_smp_init(), which is after the secondary hold
> spinloop.
> 
> Avoid waiting on this spinloop when booting with OPAL firmware. This
> wait always times out that case.
> 
> This saves 100ms boot time on powernv, and 10s of seconds of real time
> when booting on the simulator in SMP.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/339a3293f4e493a6c40f71e4faab0c

cheers
