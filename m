Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVGNB6FHpzDqlb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 15:13:46 +1100 (AEDT)
In-Reply-To: <20171023080702.23479-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [kernel] powerpc/powernv/idoa: Remove unnecessary pcidev from
 pci_dn
Message-Id: <3zVGNB1b68z9sDB@ozlabs.org>
Date: Mon, 29 Jan 2018 15:13:46 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-10-23 at 08:07:02 UTC, Alexey Kardashevskiy wrote:
> The pcidev value stored in pci_dn is only used for NPU/NPU2
> initialization. We can easily drop the cached pointer and
> use an ancient helper - pci_get_domain_bus_and_slot() instead in order
> to reduce complexity.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Acked-by: Russell Currey <ruscur@russell.cc>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/902bdc57451c2c64aa139bbe24067f

cheers
