Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Ln4Y5C1YzF1Rd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 00:49:33 +1000 (AEST)
In-Reply-To: <20180410114933.24581-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/3] powerpc/powernv: define a standard delay for OPAL_BUSY type
 retry loops
Message-Id: <40Ln4Y2zCHz9s4Z@ozlabs.org>
Date: Thu, 12 Apr 2018 00:49:33 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-04-10 at 11:49:31 UTC, Nicholas Piggin wrote:
> This is the start of an effort to tidy up and standardise all the
> delays. Existing loops have a range of delay/sleep periods from 1ms
> to 20ms, and some have no delay. They all loop forever except rtc,
> which times out after 10 retries, and that uses 10ms delays. So use
> 10ms as our standard delay. The OPAL maintainer agrees 10ms is a
> reasonable starting point.
> 
> The idea is to use the same recipe everywhere, once this is proven to
> work then it will be documented as an OPAL API standard. Then both
> firmware and OS can agree, and if a particular call needs something
> else, then that can be documented with reasoning.
> 
> This is not the end-all of this effort, it's just a relatively easy
> change that fixes some existing high latency delays. There should be
> provision for standardising timeouts and/or interruptible loops where
> possible, so non-fatal firmware errors don't cause hangs.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/34dd25de9fe3f60bfdb31b473bf04b

cheers
