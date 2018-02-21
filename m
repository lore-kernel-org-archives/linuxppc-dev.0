Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmdwX636TzF0xg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 00:43:08 +1100 (AEDT)
In-Reply-To: <20180216130118.26008-1-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, andrew.donnellan@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: dan.carpenter@oracle.com
Subject: Re: ocxl: Fix potential bad errno on irq allocation
Message-Id: <3zmdwX4ty5z9sWK@ozlabs.org>
Date: Thu, 22 Feb 2018 00:43:08 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-02-16 at 13:01:18 UTC, Frederic Barrat wrote:
> Fix some issues found by a static checker:
> 
> When allocating an AFU interrupt, if the driver cannot copy the output
> parameters to userland, the errno value was not set to EFAULT
> 
> Remove a (now) useless cast.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/423688abd9ab654044bddd82eb5983

cheers
