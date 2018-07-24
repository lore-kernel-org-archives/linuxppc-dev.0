Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Zg3J0TPzzDrC4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 23:59:56 +1000 (AEST)
In-Reply-To: <20180709142426.26999-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: malat@debian.org, rdunlap@infradead.org, npiggin@gmail.com
Subject: Re: [1/2] powerpc: Add ppc32_allmodconfig defconfig target
Message-Id: <41Zg3G6V47z9s55@ozlabs.org>
Date: Tue, 24 Jul 2018 23:59:54 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-07-09 at 14:24:25 UTC, Michael Ellerman wrote:
> Because the allmodconfig logic just sets every symbol to M or Y, it
> has the effect of always generating a 64-bit config, because
> CONFIG_PPC64 becomes Y.
> 
> So to make it easier for folks to test 32-bit code, provide a phony
> defconfig target that generates a 32-bit allmodconfig.
> 
> The 32-bit port has several mutually exclusive CPU types, we choose
> the Book3S variants as that's what the help text in Kconfig says is
> most common.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/8db0c9d416f26018cb7cabfb0b144f

cheers
