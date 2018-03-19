Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404rD823T8zF0xN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 09:22:48 +1100 (AEDT)
In-Reply-To: <20170720062514.2069-1-matthew.brown.dev@gmail.com>
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/include/asm: Remove unused 64bit cacheflush function
Message-Id: <404rD6034wz9sVZ@ozlabs.org>
Date: Tue, 20 Mar 2018 09:22:45 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-07-20 at 06:25:14 UTC, Matt Brown wrote:
> The flush_dcache_phys_range function is no longer used in the kernel.
> This patch removes and cleans up the function.
> 
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1d82fc5c54ef7956f5c01bbcf26b52

cheers
