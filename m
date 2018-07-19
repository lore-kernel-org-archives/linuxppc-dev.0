Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WNph49g3zDqCK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 16:07:40 +1000 (AEST)
In-Reply-To: <20180702074205.12837-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org
Subject: Re: [kernel] powerpc/powernv/ioda2: Add 256M IOMMU page size to the
 default POWER8 case
Message-Id: <41WNpf5qnDz9s78@ozlabs.org>
Date: Thu, 19 Jul 2018 16:07:38 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-07-02 at 07:42:05 UTC, Alexey Kardashevskiy wrote:
> The sketchy bypass uses 256M pages so add this page size as well.
> 
> This should cause no behavioral change but will be used later.
> 
> Fixes: 477afd6ea6 "powerpc/ioda: Use ibm,supported-tce-sizes for IOMMU page size mask"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/00c376fdd7ed6cc083da3a3c51a63a

cheers
