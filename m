Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
 [209.85.192.174])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 384AE1A02E3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 17:56:27 +1000 (EST)
Received: by mail-pd0-f174.google.com with SMTP id y10so444670pdj.33
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 00:56:24 -0700 (PDT)
Message-ID: <53A14623.4080900@ozlabs.ru>
Date: Wed, 18 Jun 2014 17:56:19 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/6] powerpc/powernv: Applying it_page_shift to platform
 code
References: <1402044246-13650-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1402044246-13650-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=KOI8-R
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Alistair Popple <alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/06/2014 06:44 PM, Alexey Kardashevskiy wrote:
> Here is what I got for powernv in order to support variable page size
> in iommu_table.
> 
> I am very uncertain about Patch #4 "Add @it_owner to iommu_table struct"
> and wonder if there any better way to get PE from iommu_table.
> 
> Please comment. Thanks.


Ben, these patches are really simple :)


> 
> 
> Alexey Kardashevskiy (6):
>   powerpc/powernv: use it_page_shift for TCE invalidation
>   powerpc/powernv: use it_page_shift in TCE build
>   powerpc/powernv: Add a page size parameter to
>     pnv_pci_setup_iommu_table()
>   powerpc/powernv: Add @it_owner to iommu_table struct
>   powerpc/powernv: Make set_bypass() callback a type
>   powerpc/powernv: Make invalidate() callback an iommu_table callback
> 
>  arch/powerpc/include/asm/iommu.h            | 13 ++++++-
>  arch/powerpc/platforms/powernv/pci-ioda.c   | 55 ++++++++++++++---------------
>  arch/powerpc/platforms/powernv/pci-p5ioc2.c |  3 +-
>  arch/powerpc/platforms/powernv/pci.c        | 43 +++++++++++++++-------
>  arch/powerpc/platforms/powernv/pci.h        |  7 ++--
>  5 files changed, 74 insertions(+), 47 deletions(-)
> 


-- 
Alexey
