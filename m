Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E4FC01A0342
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 21:58:52 +1100 (AEDT)
In-Reply-To: <1456728831-31862-2-git-send-email-cyrilbur@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [1/9] selftests/powerpc: Test the preservation of FPU and VMX
 regs across syscall
Message-Id: <20160303105852.A3A60140C3B@ozlabs.org>
Date: Thu,  3 Mar 2016 21:58:52 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-29-02 at 06:53:43 UTC, Cyril Bur wrote:
> Test that the non volatile floating point and Altivec registers get
> correctly preserved across the fork() syscall.
> 
> fork() works nicely for this purpose, the registers should be the same for
> both parent and child
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/01127f1ead4cef75e2b9b309e0

cheers
