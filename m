Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltwm3R7VzDqk8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:26:16 +1000 (AEST)
In-Reply-To: <20180726122459.9293-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/3] selftests/powerpc: Add a helper for checking if we're on
 ppc64le
Message-Id: <41ltwb0G3Dz9s4V@ozlabs.org>
Date: Thu,  9 Aug 2018 00:26:00 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-07-26 at 12:24:57 UTC, Michael Ellerman wrote:
> Some of our selftests have only been tested on ppc64le and crash or
> behave weirdly on ppc64/ppc32. So add a helper for checking the UTS
> machine.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/95f9b3af401f5b4daeb908a2c658e8

cheers
