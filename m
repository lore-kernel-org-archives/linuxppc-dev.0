Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdjhq6N5QzDsg3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 23:07:23 +1000 (AEST)
In-Reply-To: <20160915142944.9322-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc: do not use kprobe section to exempt exception handlers
Message-Id: <3sdjhq4Jcdz9t0p@ozlabs.org>
Date: Tue, 20 Sep 2016 23:07:23 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-15-09 at 14:29:44 UTC, Nicholas Piggin wrote:
> Use the blacklist macros instead. This allows the linker to move
> exception handler functions close to callers and avoids trampolines in
> larger kernels.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/03465f899bdac70d34f6ca447a

cheers
