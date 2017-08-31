Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjgLV2z9GzDqTm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 21:36:18 +1000 (AEST)
In-Reply-To: <1503496584-21970-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/5] powerpc/oops: Fix the oops markers to use pr_cont()
Message-Id: <3xjgLT1g1Mz9t3k@ozlabs.org>
Date: Thu, 31 Aug 2017 21:36:15 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-23 at 13:56:20 UTC, Michael Ellerman wrote:
> When we oops we print a few markers for significant config options
> such as PREEMPT, SMP etc. Currently these appear on separate lines
> because we're not using pr_cont() properly. Fix it.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/72c0d9ee4abc44c82a00eadebe08a7

cheers
