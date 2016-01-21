Return-Path: <minchan@kernel.org>
Received: from lgeamrelo13.lge.com (LGEAMRELO13.lge.com [156.147.23.53])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 61F8C1A0023
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 15:09:49 +1100 (AEDT)
Date: Thu, 21 Jan 2016 12:57:01 +0900
From: Minchan Kim <minchan@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] powerpc: remove newly added extra definition of pmd_dirty
Message-ID: <20160121035701.GA15813@bbox>
References: <20160121130520.6dce1564@canb.auug.org.au>
MIME-Version: 1.0
In-Reply-To: <20160121130520.6dce1564@canb.auug.org.au>
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 21, 2016 at 01:05:20PM +1100, Stephen Rothwell wrote:
> Commit d5d6a443b243 ("arch/powerpc/include/asm/pgtable-ppc64.h:
> add pmd_[dirty|mkclean] for THP") added a new identical definition
> of pdm_dirty.  Remove it again.
> 
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Thanks for the fix!
