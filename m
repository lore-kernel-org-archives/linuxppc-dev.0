Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN60t36ylzDvsC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:34:22 +1100 (AEDT)
In-Reply-To: <1477636793-32760-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/64: Used named initialisers for ibm_pa_features
Message-Id: <3tN60t0qd4z9t3K@ozlabs.org>
Date: Tue, 22 Nov 2016 11:34:21 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-10-28 at 06:39:53 UTC, Michael Ellerman wrote:
> The ibm_pa_features array consists of structures that describe which bit
> and byte in the ibm,pa-features property toggles one or more flags in
> either the CPU, MMU, or user visible feature flags.
> 
> Each one consists of 7 values, which are all unsigned long, int or char,
> meaning the compiler gives us no warning if we assign the wrong values
> to the wrong elements. In fact we have had a bug here in the past, where
> we were setting incorrect bits, see commit 6997e57d693b ("powerpc:
> scan_features() updates incorrect bits for REAL_LE").
> 
> So switch to using named initialisers for the structure elements, to
> reduce the likelihood of future bugs, and hopefully improve readability
> also.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/e9eb0278dad9c7a2631d5432180a13

cheers
