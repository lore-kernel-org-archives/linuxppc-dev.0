Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGTdm4dMkzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 May 2017 12:58:52 +1000 (AEST)
In-Reply-To: <20170324063721.16887-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [guest,kernel] powerpc/pseries: Enable VFIO
Message-Id: <3wGTdm3YNXz9sNH@ozlabs.org>
Date: Mon,  1 May 2017 12:58:52 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-03-24 at 06:37:21 UTC, Alexey Kardashevskiy wrote:
> This enables VFIO on pseries host in order to allow VFIO in nested guest
> under PR KVM or DPDK in a HV guest. This adds support of
> the VFIO_SPAPR_TCE_IOMMU type.
> 
> This adds exchange() callback to allow TCE updates by the SPAPR TCE IOMMU
> driver in VFIO.
> 
> This initializes DMA32 window parameters in iommu_table_group as
> as this does not implement VFIO_SPAPR_TCE_v2_IOMMU and
> VFIO_SPAPR_TCE_IOMMU just reuses the existing DMA32 window.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b6e1f6adce8068620f728f717f90f4

cheers
