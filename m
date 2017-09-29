Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3YHq5nxYzDr8P
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Sep 2017 00:05:59 +1000 (AEST)
In-Reply-To: <20170929033735.28710-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <nicholas.piggin@gmail.com>
Subject: Re: powerpc: Fix workaround for spurious MCE on POWER9
Message-Id: <3y3YHq4NQFz9t4k@ozlabs.org>
Date: Sat, 30 Sep 2017 00:05:59 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-09-29 at 03:37:35 UTC, Michael Neuling wrote:
> In the recent commit:
>   d8bd9f3f09 powerpc: Handle MCE on POWER9 with only DSISR bit 30 set
> I screwed up the bit.  It should be bit 25 (IBM bit 38).
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/bca73f595a566f0262967535bb5b2e

cheers
