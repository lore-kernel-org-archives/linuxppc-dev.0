Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN60n03FrzDvHd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:34:17 +1100 (AEDT)
In-Reply-To: <20161019031600.17933-7-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [6/7] powerpc: switch to using thin archives if COMPILE_TEST is
 set
Message-Id: <3tN60m4b66z9t26@ozlabs.org>
Date: Tue, 22 Nov 2016 11:34:16 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-10-19 at 03:15:59 UTC, Nicholas Piggin wrote:
> Enable thin archives build for powerpc when COMPILE_TEST is set.
> Thin archives are explained in this commit:
> 
>   a5967db9af51a84f5e181600954714a9e4c69f1f
> 
> This is a gradual way to introduce the option to testers.
> 
> Some change to the way we invoke ar is required so it can be used
> by scripts/link-vmlinux.sh.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/43c9127d94d62a232ed33ed2eab8a0

cheers
