Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJBM13Mx3zDrGy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 22:37:17 +1000 (AEST)
In-Reply-To: <1498630168-26376-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc: Build fix for non SPARSEMEM_VMEMAP config
Message-Id: <3xJBM12n7Cz9sDB@ozlabs.org>
Date: Thu, 27 Jul 2017 22:37:17 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-06-28 at 06:09:28 UTC, "Aneesh Kumar K.V" wrote:
> We can use pfn_to_page in realmode for other configs. Hence remove the
> CONFIG_FLATMEM ifdef
> 
> Fixes: 8e0861fa3c4ed (powerpc: Prepare to support kernel handling of IOMMU map/unmap)
> 
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7e7dc66adcf490a619bc3c7763a8ce

cheers
