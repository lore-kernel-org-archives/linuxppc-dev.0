Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 66FCE1A0030
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 15:45:15 +1100 (AEDT)
Message-ID: <1453351515.468.7.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: remove newly added extra definition of pmd_dirty
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Minchan Kim <minchan@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>
Date: Thu, 21 Jan 2016 15:45:15 +1100
In-Reply-To: <20160121130520.6dce1564@canb.auug.org.au>
References: <20160121130520.6dce1564@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-01-21 at 13:05 +1100, Stephen Rothwell wrote:

> Commit d5d6a443b243 ("arch/powerpc/include/asm/pgtable-ppc64.h:
> add pmd_[dirty|mkclean] for THP") added a new identical definition
> of pdm_dirty.  Remove it again.
> 
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Thanks.

I have a couple of other things to send to Linus so I'll pick this up.

cheers
