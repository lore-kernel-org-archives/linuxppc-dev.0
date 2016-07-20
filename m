Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvWMv1jJhzDqQK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 19:10:19 +1000 (AEST)
In-Reply-To: <f03894c6-edf7-9fcc-c817-6e0ee6234dd6@linux.vnet.ibm.com>
To: John Allen <jallen@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: Re: [1/3] powerpc/pseries: Add pseries hotplug workqueue
Message-Id: <3rvWMv15qLz9t0t@ozlabs.org>
Date: Wed, 20 Jul 2016 19:10:19 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-07-07 at 15:00:34 UTC, John Allen wrote:
> In support of PAPR changes to add a new hotplug interrupt, introduce a
> hotplug workqueue to avoid processing hotplug events in interrupt context.
> We will also take advantage of the queue on PowerVM to ensure hotplug
> events initiated from different sources (HMC and PRRN events) are handled
> and serialized properly.
> 
> Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>
> Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9054619ef54a3a832863ae25d1

cheers
