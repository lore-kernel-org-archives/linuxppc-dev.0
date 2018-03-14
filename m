Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RHP08cqzDqhw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:28:49 +1100 (AEDT)
In-Reply-To: <20180307013718.13749-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v2, 01/10] powerpc/mm/slice: Simplify and optimise slice context
 initialisation
Message-Id: <401RHM3H5Kz9sRX@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:42 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-03-07 at 01:37:09 UTC, Nicholas Piggin wrote:
> The slice state of an mm gets zeroed then initialised upon exec.
> This is the only caller of slice_set_user_psize now, so that can be
> removed and instead implement a faster and simplified approach that
> requires no locking or checking existing state.
> 
> This speeds up vfork+exec+exit performance on POWER8 by 3%.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Patches 1-9 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1753dd1830367709144f68f539554d

cheers
