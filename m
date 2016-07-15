Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrTv119NrzDqyY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 20:53:17 +1000 (AEST)
In-Reply-To: <1468444634-1866-9-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Huy Nguyen <huyn@mellanox.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [08/15] cxl: Add support for using the kernel API with a real PHB
Message-Id: <3rrTv04m8hz9srX@ozlabs.org>
Date: Fri, 15 Jul 2016 20:53:16 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-13-07 at 21:17:07 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> This hooks up support for using the kernel API with a real PHB. After
> the AFU initialisation has completed it calls into the PHB code to pass
> it the AFU that will be used by other peer physical functions on the
> adapter.
> 
> The cxl_pci_to_afu API is extended to work with peer PCI devices,
> retrieving the peer AFU from the PHB. This API may also now return an
> error if it is called on a PCI device that is not associated with either
> a cxl vPHB or a peer PCI device to an AFU, and this error is propagated
> down.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/317f5ef1b363417b6f1e93b90d

cheers
