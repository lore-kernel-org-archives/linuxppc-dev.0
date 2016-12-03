Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tW80N4mpkzDw3c
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2016 22:28:20 +1100 (AEDT)
In-Reply-To: <1480488725-12783-2-git-send-email-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kernel, v7,
 1/7] powerpc/iommu: Pass mm_struct to init/cleanup helpers
Message-Id: <3tW80N3VT7z9t1d@ozlabs.org>
Date: Sat,  3 Dec 2016 22:28:20 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-30 at 06:51:59 UTC, Alexey Kardashevskiy wrote:
> We are going to get rid of @current references in mmu_context_boos3s64.c
> and cache mm_struct in the VFIO container. Since mm_context_t does not
> have reference counting, we will be using mm_struct which does have
> the reference counter.
> 
> This changes mm_iommu_init/mm_iommu_cleanup to receive mm_struct rather
> than mm_context_t (which is embedded into mm).
> 
> This should not cause any behavioral change.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/88f54a3581eb9deaa3bd1aade40aef

cheers
