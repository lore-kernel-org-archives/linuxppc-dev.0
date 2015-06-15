Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9680B1A06AD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 16:49:50 +1000 (AEST)
In-Reply-To: <1434089957-27135-1-git-send-email-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kernel] powerpc/powernv/ioda2: Add devices only from buses which
 belong to PE
Message-Id: <20150615064950.7C42514029E@ozlabs.org>
Date: Mon, 15 Jun 2015 16:49:50 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-12-06 at 06:19:17 UTC, Alexey Kardashevskiy wrote:
> The existing code puts all devices from a root PE to the same IOMMU group.
> However it is a possible situation when subordinate buses belong to
> separate PEs, in this case devices from these subordinate buses
> should be added to lower level PE rather to the root PE.
> 
> This limits pnv_ioda_setup_bus_dma() invocation to only PEs which own
> all subordinate buses.
> 
> Suggested-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Alexey/Gavin, can one of you write a better changelog for this. Explaining
what exactly is broken without it, how it fixes the problem, and why that is
the right fix.

cheers
