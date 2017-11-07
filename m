Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWlyz3pW9zDrCX
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 10:30:19 +1100 (AEDT)
In-Reply-To: <20171024130654.1223-3-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v2,2/3] powerpc/64s/radix: tlbie improve preempt handling
Message-Id: <3yWlyz1CNnz9t2V@ozlabs.org>
Date: Wed,  8 Nov 2017 10:30:18 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-10-24 at 13:06:53 UTC, Nicholas Piggin wrote:
> Preempt should be consistently disabled for mm_is_thread_local tests,
> so bring the rest of these under preempt_disable().
> 
> Preempt does not need to be disabled for the mm->context.id tests,
> which allows simplification and removal of gotos.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/dffe8449c5dd63ff18b47709de7555

cheers
