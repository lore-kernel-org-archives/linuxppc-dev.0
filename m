Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 601051A1D13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 19:59:09 +1000 (AEST)
In-Reply-To: <1434022072-31754-1-git-send-email-linux@rasmusvillemoes.dk>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Ian Munsie <imunsie@au1.ibm.com>, Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Joe Perches <joe@perches.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v3,1/2] cxl: Add explicit precision specifiers
Message-Id: <20150716095909.3C4701402B5@ozlabs.org>
Date: Thu, 16 Jul 2015 19:59:09 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-11-06 at 11:27:51 UTC, Rasmus Villemoes wrote:
> C99 says that a precision given as simply '.' with no following digits
> or * should be interpreted as 0. The kernel's printf implementation,
> however, treats this case as if the precision was omitted. C99 also
> says that if both the precision and value are 0, no digits should be
> printed. Even if the kernel followed C99 to the letter, I don't think
> that would be particularly useful in these cases. For consistency with
> most other format strings in the file, use an explicit precision of 16
> and add a 0x prefix.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/80c394fab89649585089

cheers
