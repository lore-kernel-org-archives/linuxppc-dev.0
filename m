Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNHm06QZ9zDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 11:53:20 +1000 (AEST)
In-Reply-To: <201605252359.u4PNx2IH015480@mx0a-001b2d01.pphosted.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, gpiccoli@linux.vnet.ibm.com
Subject: Re: powerpc/pseries: Fix PCI config address for DDW
Message-Id: <3rNHm03Vg2z9t5P@ozlabs.org>
Date: Mon,  6 Jun 2016 11:53:20 +1000 (AEST)
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

That commit was Cc'ed to stable, so this needs to be also.

I've added it here.

cheers
