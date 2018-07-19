Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WNmy5f4NzDq6t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 16:06:10 +1000 (AEST)
In-Reply-To: <20180717071913.2167-2-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Nicholas Piggin <npiggin@gmail.com>,
 kvm-ppc@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kernel, v7,
 1/2] vfio/spapr: Use IOMMU pageshift rather than pagesize
Message-Id: <41WNmy1B2zz9s1R@ozlabs.org>
Date: Thu, 19 Jul 2018 16:06:10 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-07-17 at 07:19:12 UTC, Alexey Kardashevskiy wrote:
> The size is always equal to 1 page so let's use this. Later on this will
> be used for other checks which use page shifts to check the granularity
> of access.
> 
> This should cause no behavioral change.
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/1463edca6734d42ab4406fa2896e20

cheers
