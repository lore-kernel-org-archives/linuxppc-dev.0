Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNxzn4MbkzDqG1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jun 2016 13:35:49 +1000 (AEST)
In-Reply-To: <201605252359.u4PNx2IH015480@mx0a-001b2d01.pphosted.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, gpiccoli@linux.vnet.ibm.com
Subject: Re: powerpc/pseries: Fix PCI config address for DDW
Message-Id: <3rNxzn3NNLz9t42@ozlabs.org>
Date: Tue,  7 Jun 2016 13:35:49 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-25-05 at 23:56:07 UTC, Gavin Shan wrote:
> In commit <8445a87f7092> ("powerpc/iommu: Remove the dependency
> on EEH struct in DDW mechanism"), the PE address was replaced
> with the PCI config address in order to remove dependency on EEH.
> According to PAPR spec, firmware (pHyp or QEMU) should accept
> "xxBBSSxx" format PCI config address, not "xxxxBBSS" provided
> by the patch. Note that "BB" is PCI bus number and "SS" is the
> combination of slot and function number.
> 
> This fixes the PCI address passed to DDW RTAS calls.
> 
> Fixes: 8445a87f7092 ("powerpc/iommu: Remove the dependency on EEH struct in DDW mechanism")
> Reported-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Tested-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/8a934efe94347eee843aeea65b

cheers
