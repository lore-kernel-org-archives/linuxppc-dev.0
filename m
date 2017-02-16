Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP58h2X1rzDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 16:59:48 +1100 (AEDT)
In-Reply-To: <1487214078-3893-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: jallen@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com
Subject: Re: powerpc/pseries: Fix build break when MEMORY_HOTREMOVE=n
Message-Id: <3vP58g54Wtz9sD9@ozlabs.org>
Date: Thu, 16 Feb 2017 16:59:47 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-02-16 at 03:01:18 UTC, Michael Ellerman wrote:
> We broke the build when CONFIG_MEMORY_HOTREMOVE=n:
> 
>   arch/powerpc/platforms/pseries/hotplug-memory.c:821:8: error: implicit
>   declaration of function 'dlpar_memory_readd_by_index'
> 
> Add a dummy to fix it.
> 
> Fixes: e70d59700fc3 ("powerpc/pseries: Introduce memory hotplug READD operation")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/f84775c2d5d92581f2df60d53b574b

cheers
