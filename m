Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYNvK3QGYzDsTp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 22:16:29 +1000 (AEST)
In-Reply-To: <1469510970-11599-2-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nick Piggin <npiggin@gmail.com>
Subject: Re: [2/2] powerpc/64: Do load of PACAKBASE in LOAD_HANDLER
Message-Id: <3sYNvK281Vz9t0G@ozlabs.org>
Date: Tue, 13 Sep 2016 22:16:29 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-26-07 at 05:29:30 UTC, Michael Ellerman wrote:
> The LOAD_HANDLER macro requires that you have previously loaded "reg"
> with PACAKBASE. Although that gives callers flexibility to get PACAKBASE
> in some interesting way, none of the callers actually do that. So fold
> the load of PACAKBASE into the macro, making it simpler for callers to
> use correctly.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Nick Piggin <npiggin@gmail.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/d8d42b0511fefc78165ee9b4c2

cheers
