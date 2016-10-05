Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spfzv6hvGzDrM1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 13:36:27 +1100 (AEDT)
In-Reply-To: <1470111037-18531-8-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: paulus@samba.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [7/9] powerpc/powernv: Fix data type for @r in
 pnv_ioda_parse_m64_window()
Message-Id: <3spfzv5cj9z9syB@ozlabs.org>
Date: Wed,  5 Oct 2016 13:36:27 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-02-08 at 04:10:35 UTC, Gavin Shan wrote:
> This fixes warning reported from sparse:
> 
>   gwshan@gwshan:~/sandbox/l$ make C=2 CF=-D__CHECK_ENDIAN__ \
>                              arch/powerpc/platforms/powernv/pci-ioda.o
>         :
>   arch/powerpc/platforms/powernv/pci-ioda.c:451:49: \
>   warning: incorrect type in argument 2 (different base types)
>   arch/powerpc/platforms/powernv/pci-ioda.c:451:49: \
>   expected restricted __be32 const [usertype] *addr
>   arch/powerpc/platforms/powernv/pci-ioda.c:451:49: \
>   got unsigned int const [usertype] *
>   arch/powerpc/platforms/powernv/pci-ioda.c:452:50: \
>   warning: incorrect type in argument 1 (different base types)
>   arch/powerpc/platforms/powernv/pci-ioda.c:452:50: \
>   expected restricted __be32 const [usertype] *cell
>   arch/powerpc/platforms/powernv/pci-ioda.c:452:50: \
>   got unsigned int const [usertype] *
>   arch/powerpc/platforms/powernv/pci-ioda.c:454:35: \
>   warning: incorrect type in argument 1 (different base types)
>   arch/powerpc/platforms/powernv/pci-ioda.c:454:35: \
>   expected restricted __be32 const [usertype] *cell
>   arch/powerpc/platforms/powernv/pci-ioda.c:454:35: \
>   got unsigned int const [usertype] *[assigned] r
> 
> Fixes: 262af557dd75 ("powerpc/powernv: Enable M64 aperatus for PHB3")
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0e7736c6b806b24c693367196a076c

cheers
