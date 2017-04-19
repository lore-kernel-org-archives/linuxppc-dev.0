Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w77H92sjlzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 13:47:17 +1000 (AEST)
In-Reply-To: <20170413101624.26628-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/4] powerpc: change the doorbell IPI calling convention
Message-Id: <3w77H91kH3z9s7L@ozlabs.org>
Date: Wed, 19 Apr 2017 13:47:17 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-04-13 at 10:16:21 UTC, Nicholas Piggin wrote:
> Change the doorbell callers to know about their msgsnd addressing,
> rather than have them set a per-cpu target data tag at boot that gets
> sent to the cause_ipi functions. The data is only used for doorbell IPI
> functions, no other IPI types, so it makes sense to keep that detail
> local to doorbell.
> 
> Have the platform code understand doorbell IPIs, rather than the
> interrupt controller code understand them. Platform code can look at
> capabilities it has available and decide which to use.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b866cc2199d6a6cdcefe4acfe4cfca

cheers
