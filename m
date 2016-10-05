Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spfzv5wzrzDrLx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 13:36:27 +1100 (AEDT)
In-Reply-To: <1470111037-18531-5-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: paulus@samba.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [4/9] powerpc/powernv: Use CPU-endian PEST in
 pnv_pci_dump_p7ioc_diag_data()
Message-Id: <3spfzv4MSHz9srZ@ozlabs.org>
Date: Wed,  5 Oct 2016 13:36:26 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-02-08 at 04:10:32 UTC, Gavin Shan wrote:
> This fixes the warnings reported from sparse:
> 
>   gwshan@gwshan:~/sandbox/l$ make C=2 CF=-D__CHECK_ENDIAN__ \
>                              arch/powerpc/platforms/powernv/pci.o
>         :
>   arch/powerpc/platforms/powernv/pci.c:312:33: \
>   warning: restricted __be64 degrades to integer
>   arch/powerpc/platforms/powernv/pci.c:313:33: \
>   warning: restricted __be64 degrades to integer
> 
> Fixes: cee72d5bb489 ("powerpc/powernv: Display diag data on p7ioc EEH errors")
> Cc: stable@vger.kernel.org # v3.3+
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5adaf8629b193f185ca5a1665b9e77

cheers
