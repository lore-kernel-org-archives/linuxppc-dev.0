Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4CYm5k45zDq64
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 07:48:44 +1000 (AEST)
In-Reply-To: <1461920124-21719-3-git-send-email-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Dan Carpenter <dan.carpenter@oracle.com>, Daniel Axtens <dja@axtens.net>
Subject: Re: [kernel, v4,
 02/11] vfio/spapr: Relax the IOMMU compatibility check
Message-Id: <3r4CYm3zcRz9t4k@ozlabs.org>
Date: Wed, 11 May 2016 07:48:44 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-29-04 at 08:55:15 UTC, Alexey Kardashevskiy wrote:
> We are going to have multiple different types of PHB on the same system
> with POWER8 + NVLink and PHBs will have different IOMMU ops. However
> we only really care about one callback - create_table - so we can
> relax the compatibility check here.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Acked-by: Alex Williamson <alex.williamson@redhat.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/45295687a90a31135ab575803e

cheers
