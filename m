Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Fv5w5zlqzF29D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 02:03:48 +1000 (AEST)
In-Reply-To: <20180403155318.18266-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: selftests/powerpc: Fix copyloops build since Power4 assembler
 change
Message-Id: <40Fv5v37Vrz9s1r@ozlabs.org>
Date: Wed,  4 Apr 2018 02:03:46 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-04-03 at 15:53:18 UTC, Michael Ellerman wrote:
> The recent commit 15a3204d24a3 ("powerpc/64s: Set assembler machine
> type to POWER4") set the machine type in our ASFLAGS when building the
> kernel, and removed some ".machine power4" directives from various asm
> files.
> 
> This broke the selftests build on old toolchains (that don't assume
> Power4), because we build the kernel source files into the selftests
> using different ASFLAGS.
> 
> The fix is simply to add -mpower4 to the selftest ASFLAGS as well.
> 
> Fixes: 15a3204d24a3 ("powerpc/64s: Set assembler machine type to POWER4")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/b6f534d1a642a9b6263fd52df30806

cheers
