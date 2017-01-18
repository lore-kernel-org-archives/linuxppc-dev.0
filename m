Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3Qlj0cnzzDqMj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 23:10:25 +1100 (AEDT)
In-Reply-To: <20170103155517.24347-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc: fix pgtable pmd cache init
Message-Id: <3v3Qlh4YsSz9t0q@ozlabs.org>
Date: Wed, 18 Jan 2017 23:10:24 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-01-03 at 15:55:17 UTC, Nicholas Piggin wrote:
> Commit 9b081e10805cd ("powerpc: port 64 bits pgtable_cache to 32 bits")
> mixed up PMD_INDEX_SIZE and PMD_CACHE_INDEX a couple of times. This
> resulted in 64s/hash/4k configs to panic at boot with a false positive
> error check.
> 
> Fix that and simplify error handling by moving the check to the caller.
> 
> Fixes: 9b081e10805cd ("powerpc: port 64 bits pgtable_cache to 32 bits")
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Scott Wood <oss@buserror.net>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/bf5ca68dd2eef59a936969e802d811

cheers
