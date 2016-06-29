Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfY5g1rq8zDr0H
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 16:43:03 +1000 (AEST)
In-Reply-To: <1467082864-7783-1-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, paulus@samba.org,
 cyrilbur@gmail.com
Subject: Re: powerpc/tm: Avoid SLB faults in treclaim/trecheckpoint when RI=0
Message-Id: <3rfY5g0yx8z9t0j@ozlabs.org>
Date: Wed, 29 Jun 2016 16:43:03 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-28-06 at 03:01:04 UTC, Michael Neuling wrote:
> Currently we have 2 segments that are bolted for the kernel linear
> mapping (ie 0xc000... addresses). This is 0 to 1TB and also the kernel
> stacks.  Anything accessed outside of these regions may need to be
> faulted in.
...
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/190ce8693c23eae09ba5f303a8

cheers
