Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTPFz2pVCzDr3N
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 22:19:51 +1000 (AEST)
In-Reply-To: <20170731005826.32044-1-matthew.brown.dev@gmail.com>
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v4,1/5] powerpc/lib/sstep: Add cmpb instruction emulation
Message-Id: <3xTPFz0shgz9t2W@ozlabs.org>
Date: Fri, 11 Aug 2017 22:19:50 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-07-31 at 00:58:22 UTC, Matt Brown wrote:
> This patch adds emulation of the cmpb instruction, enabling xmon to
> emulate this instruction.
> Tested for correctness against the cmpb asm instruction on ppc64le.
> 
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
> Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/02c0f62a60b67d6c9bfe9429cbe3aa

cheers
