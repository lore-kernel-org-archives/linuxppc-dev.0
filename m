Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spfzr3BwjzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 13:36:24 +1100 (AEDT)
In-Reply-To: <1474806941-5006-1-git-send-email-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, npiggin@gmail.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/2] powerpc: Only disable HAVE_EFFICIENT_UNALIGNED_ACCESS on
 POWER7 little endian
Message-Id: <3spfzr1tf0z9s5g@ozlabs.org>
Date: Wed,  5 Oct 2016 13:36:24 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-25-09 at 12:35:40 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> POWER8 handles unaligned accesses in little endian mode, but commit
> 0b5e6661ac69 ("powerpc: Don't set HAVE_EFFICIENT_UNALIGNED_ACCESS on
> little endian builds") disabled it for all.
> 
> The issue with unaligned little endian accesses is specific to POWER7,
> so update the Kconfig check to match. Using the stat() testcase from
> commit a75c380c7129 ("powerpc: Enable DCACHE_WORD_ACCESS on ppc64le"),
> performance improves 15% on POWER8.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8a18cc0c2c36ee49d70a620ac0190d

cheers
