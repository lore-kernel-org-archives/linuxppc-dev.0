Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRWWk54kszDqjB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 20:55:14 +1000 (AEST)
In-Reply-To: <20170804011218.10489-1-matthew.brown.dev@gmail.com>
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v3] powerpc/powernv: Use darn instr for random_seed on p9
Message-Id: <3xRWWk47ZVz9s7C@ozlabs.org>
Date: Tue,  8 Aug 2017 20:55:14 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-08-04 at 01:12:18 UTC, Matt Brown wrote:
> This adds the powernv_get_random_darn function which utilises the darn
> instruction, introduced in POWER9. The powernv_get_random_darn function
> is used as the ppc_md.get_random_seed on P9.
> 
> The DARN instruction can potentially throw an error, so we attempt to
> register the powernv_get_random_darn function up to 10 times before
> failing.
> 
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e66ca3db5917f4bcad039d3a3df9f1

cheers
