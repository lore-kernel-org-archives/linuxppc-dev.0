Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTPG872mvzDr46
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 22:20:00 +1000 (AEST)
In-Reply-To: <1502174365-8293-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/9] powerpc/47x: Guard 47x cputable entries with CONFIG_PPC_47x
Message-Id: <3xTPG85P1Qz9t3x@ozlabs.org>
Date: Fri, 11 Aug 2017 22:20:00 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-08-08 at 06:39:17 UTC, Michael Ellerman wrote:
> Currently we build the 47x cputable entries even when CONFIG_PPC_47x is
> disabled. That means a kernel built without CONFIG_PPC_47x will claim to
> support a 47x CPU and start booting, only to break somewhere later
> because it doesn't have 47x support compiled in.
> 
> So guard the 47x cputable entries with CONFIG_PPC_47x. Note that this is
> inside the #ifdef CONFIG_44x section, because 47x depends on 44x.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/13fef7f9da13ab6cc22d456315e887

cheers
