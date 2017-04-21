Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8Mh766SfzDqLB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 14:09:43 +1000 (AEST)
In-Reply-To: <1492667755-16810-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: dan.carpenter@oracle.com
Subject: Re: powerpc/xive: Fix missing check of rc != OPAL_BUSY
Message-Id: <3w8Mh74g2Tz9s2Q@ozlabs.org>
Date: Fri, 21 Apr 2017 14:09:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-04-20 at 05:55:55 UTC, Michael Ellerman wrote:
> Dan Carpenter noticed that the code in __xive_native_disable_queue() has a for
> loop with an unconditional break in the middle, which doesn't make a lot of
> sense.
> 
> What the code's supposed to do is loop as long as OPAL says it's busy, if we get
> any other return code, either success or failure, then we should break the loop.
> 
> So add the missing check.
> 
> Fixes: 243e25112d06 ("powerpc/xive: Native exploitation of the XIVE interrupt controller")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/686978b15cef8314c3b3f38f0124e0

cheers
