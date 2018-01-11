Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zH8qq2HngzDqlG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 13:25:43 +1100 (AEDT)
In-Reply-To: <20180103211252.24615-2-joserz@linux.vnet.ibm.com>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: benh@au1.ibm.com, david@gibson.dropbear.id.au
Subject: Re: [v3,
 1/1] powerpc/pseries: Make RAS IRQ explicitly dependent on DLPAR WQ
Message-Id: <3zH8qq1SWkz9sRW@ozlabs.org>
Date: Thu, 11 Jan 2018 13:25:43 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-01-03 at 21:12:52 UTC, Jose Ricardo Ziviani wrote:
> The hotplug engine uses its own workqueue to handle IRQ requests, the
> problem is that such workqueue is initialized after init_ras_IRQ, which
> will cause a kernel panic if any hotplug interruption is issued in that
> period of time.
> 
> This patch makes RAS IRQ registration explicitly dependent on DLPAR
> workqueue and adds a check to make sure that the workqueue is not
> initialized more than once.
> 
> Reported-by: Min Deng <mdeng@redhat.com>
> Reported-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> Tested-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/e2d5915293ffdff977ddcfc12b817b

cheers
