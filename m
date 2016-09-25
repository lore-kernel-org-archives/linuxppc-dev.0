Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3shWzx2XyhzDrM9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 13:00:13 +1000 (AEST)
In-Reply-To: <20160728050503.17366-1-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: gwshan@linux.vnet.ibm.com, Russell Currey <ruscur@russell.cc>
Subject: Re: [v3] powernv/pci: Add PHB register dump debugfs handle
Message-Id: <3shWzx13pgz9t0p@ozlabs.org>
Date: Sun, 25 Sep 2016 13:00:12 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-28-07 at 05:05:03 UTC, Russell Currey wrote:
> On EEH events the kernel will print a dump of relevant registers.
> If EEH is unavailable (i.e. CONFIG_EEH is disabled, a new platform
> doesn't have EEH support, etc) this information isn't readily available.
> 
> Add a new debugfs handler to trigger a PHB register dump, so that this
> information can be made available on demand.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/98b665da5751b10f3f5f3ce3ba

cheers
