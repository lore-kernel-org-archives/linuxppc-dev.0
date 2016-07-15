Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrTvY17wzzDqyj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 20:53:45 +1000 (AEST)
In-Reply-To: <1468214718-15190-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: selftests/powerpc: Add a test for PROT_SAO
Message-Id: <3rrTvX3bRWz9sCg@ozlabs.org>
Date: Fri, 15 Jul 2016 20:53:44 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-11-07 at 05:25:18 UTC, Michael Ellerman wrote:
> PROT_SAO is a powerpc-specific flag to mmap(), and we rely on arch
> specific logic to allow it to be passed to mmap().
> 
> Add a small test to ensure mmap() accepts PROT_SAO. We don't have a good
> way to test that it actually causes the mapping to be created with the
> right flags, so for now we just touch the mapping so it's faulted in. In
> future we might be able to do something better.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/24af8c5a52a70bbfd275f59836

cheers
