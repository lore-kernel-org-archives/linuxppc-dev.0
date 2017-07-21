Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDSmd1ymlzDqts
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 21:13:05 +1000 (AEST)
In-Reply-To: <1500015083-23511-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/3] powerpc/mm/radix: Refactor radix__mark_rodata_ro()
Message-Id: <3xDSmc5N46z9t1y@ozlabs.org>
Date: Fri, 21 Jul 2017 21:13:04 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-07-14 at 06:51:21 UTC, Michael Ellerman wrote:
> Move the core logic into a helper, so we can use it for changing permissions
> other than _PAGE_WRITE.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Series applied to powerpc fixes.

https://git.kernel.org/powerpc/c/b134bd90286dc9f2952c35a91ab405

cheers
