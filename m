Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rp1Kw6bvhzDqyG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 20:19:32 +1000 (AEST)
In-Reply-To: <1466747662-9868-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: powerpc/eeh: fix pr_debug()s in eeh_cache.c
Message-Id: <3rp1Kw58dVz9t1C@ozlabs.org>
Date: Mon, 11 Jul 2016 20:19:32 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-24-06 at 05:54:22 UTC, Andrew Donnellan wrote:
> eeh_cache.c doesn't build cleanly with -DDEBUG when
> CONFIG_PHYS_ADDR_T_64BIT is set, as a couple of pr_debug()s use "%lx" for
> resource_size_t parameters.
> 
> Use "%pap" instead, as it's the correct format specifier for types deriving
> from phys_addr_t.
> 
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Cc: Russell Currey <ruscur@russell.cc>
> Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/91dc068202a61741a458232de7

cheers
