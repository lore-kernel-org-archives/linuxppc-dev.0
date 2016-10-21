Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t10624L8CzDvd1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Oct 2016 09:02:34 +1100 (AEDT)
In-Reply-To: <20161018093344.1f52d1f9@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: powerpc: ignore the pkey system calls for now
Message-Id: <3t106220fDz9t14@ozlabs.org>
Date: Sat, 22 Oct 2016 09:02:34 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-17-10 at 22:33:44 UTC, Stephen Rothwell wrote:
> Eliminates warning messages:
> 
> <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
> <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
> <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
> 
> Hopefully we will remember to revert this commit if we ever implement
> them.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/78914ff0843623ee6dbeae92fa0bb8

cheers
