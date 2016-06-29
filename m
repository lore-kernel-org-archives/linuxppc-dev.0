Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfY5f5BCtzDqxC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 16:43:02 +1000 (AEST)
In-Reply-To: <20160617045834.22275-2-cyrilbur@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v2,
 2/2] powerpc: tm: Always reclaim in start_thread() for exec() class
 syscalls
Message-Id: <3rfY5f2vVyz9t0X@ozlabs.org>
Date: Wed, 29 Jun 2016 16:43:02 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-17-06 at 04:58:34 UTC, Cyril Bur wrote:
> Userspace can quite legitimately perform an exec() syscall with a
> suspended transaction. exec() does not return to the old process,
...
> 
> Fixes: bc2a940 ("powerpc: Hook in new transactional memory code")
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/8e96a87c5431c256feb65bcfc5

cheers
