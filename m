Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwfrg3VhBzDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 15:50:43 +1000 (AEST)
In-Reply-To: <1468903711-5869-2-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: duwe@lst.de, aneesh.kumar@linux.vnet.ibm.com,
 Anton Blanchard <anton@samba.org>
Subject: Re: [2/2] powerpc/modules: Never restore r2 for a mprofile-kernel
 style mcount() call
Message-Id: <3rwfrg24k8z9t0d@ozlabs.org>
Date: Fri, 22 Jul 2016 15:50:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-19-07 at 04:48:31 UTC, Michael Ellerman wrote:
> In the module loader we process relocations, and for long jumps we
> generate trampolines (aka stubs). At the call site for one of these
> trampolines we usually need to generate a load instruction to restore
> the TOC pointer into r2.
...
> 
> The fix is relatively simple, in restore_r2() we check for an
> mprofile-kernel style mcount() call first, before looking for the
> presence of a nop.
> 
> Fixes: 153086644fd1 ("powerpc/ftrace: Add support for -mprofile-kernel ftrace ABI")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/31278b17a0dfed3014786b623f

cheers
