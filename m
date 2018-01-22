Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxqt2G70zF0Wd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:18 +1100 (AEDT)
In-Reply-To: <20171222111716.13101-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/9] powerpc/powernv: Remove real mode access limit for early
 allocations
Message-Id: <3zPxqt03Kkz9sBZ@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:17 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-12-22 at 11:17:08 UTC, Nicholas Piggin wrote:
> This removes the RMA limit on powernv platform, which constrains
> early allocations such as PACAs and stacks. There are still other
> restrictions that must be followed, such as bolted SLB limits, but
> real mode addressing has no constraints.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Patches 1-6 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1513c33d7174e87a079cfa2666cb9a

cheers
