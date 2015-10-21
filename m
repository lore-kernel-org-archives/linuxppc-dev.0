Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA2021A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 22:41:46 +1100 (AEDT)
In-Reply-To: <1445163833-10320-1-git-send-email-kda@linux-powerpc.org>
To: Denis Kirjanov <kda@linux-powerpc.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Denis Kirjanov <kda@linux-powerpc.org>
Subject: Re: [v2] selftests/powerpc: run eeb tests only on POWER8
Message-Id: <20151021114146.A17BC140E3B@ozlabs.org>
Date: Wed, 21 Oct 2015 22:41:46 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-18-10 at 10:23:53 UTC, Denis Kirjanov wrote:
> Event Based Branches currenly available on POWER8.
> so we can skip them on other CPUs.
> 
> I've found that at least one test loops forever
> on 970MP (cycles_with_freeze_test).
> 
> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/39fcfb911c3862f1366ef84e

cheers
