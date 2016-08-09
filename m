Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7sS35YBVzDqgw
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 21:26:43 +1000 (AEST)
In-Reply-To: <1470524052-27133-1-git-send-email-linux@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Kevin Hao <haokexin@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: powerpc: vdso: Add missing include file
Message-Id: <3s7sS34mtdz9sC3@ozlabs.org>
Date: Tue,  9 Aug 2016 21:26:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-06-08 at 22:54:12 UTC, Guenter Roeck wrote:
> Some powerpc builds fail with the following buld error.
> 
> In file included from ./arch/powerpc/include/asm/mmu_context.h:11:0,
>                  from arch/powerpc/kernel/vdso.c:28:
> arch/powerpc/include/asm/cputhreads.h: In function 'get_tensr':
> arch/powerpc/include/asm/cputhreads.h:101:2: error:
> 	implicit declaration of function 'cpu_has_feature'
> 
> Fixes: b92a226e5284 ("powerpc: Move cpu_has_feature() to a separate file")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/546c4402c57497a6ffdf5373af

cheers
