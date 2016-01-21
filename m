Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 98FCC1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 16:34:07 +1100 (AEDT)
In-Reply-To: <20160121130520.6dce1564@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: remove newly added extra definition of pmd_dirty
Message-Id: <20160121053407.7951614030F@ozlabs.org>
Date: Thu, 21 Jan 2016 16:34:07 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-21-01 at 02:05:20 UTC, Stephen Rothwell wrote:
> Commit d5d6a443b243 ("arch/powerpc/include/asm/pgtable-ppc64.h:
> add pmd_[dirty|mkclean] for THP") added a new identical definition
> of pdm_dirty.  Remove it again.
> 
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/0e2bce7411542fa336ef490414

cheers
