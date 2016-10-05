Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spfzs1LqLzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 13:36:25 +1100 (AEDT)
In-Reply-To: <20160914080216.13833-2-cyrilbur@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, wei.guo.simon@gmail.com, anton@samba.org
Subject: Re: [1/2] powerpc: tm: Add TM Unavailable Exception
Message-Id: <3spfzr6MBQz9s9x@ozlabs.org>
Date: Wed,  5 Oct 2016 13:36:24 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-14-09 at 08:02:15 UTC, Cyril Bur wrote:
> If the kernel disables transactional memory (TM) and userspace still
> tries TM related actions (TM instructions or TM SPR accesses) TM aware
> hardware will cause the kernel to take a facility unavailable
> exception.
> 
> Add checks for the exception being caused by illegal TM access in
> userspace.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/172f7aaa75d0eaae167edde25c08aa

cheers
