Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 355341A0567
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 11:44:26 +1000 (AEST)
In-Reply-To: <1438153805-31828-6-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org
Subject: Re: [6/8] powerpc/prom: Simplify the logic while fetching SLB size
Message-Id: <20150813014425.B91D814075D@ozlabs.org>
Date: Thu, 13 Aug 2015 11:44:24 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-29-07 at 07:10:03 UTC, Anshuman Khandual wrote:
> This patch just simplifies the existing code logic while fetching
> the SLB size property from the device tree. This also changes the
> function name from check_cpu_slb_size to init_mmu_slb_size as
> it just initializes the mmu_slb_size value.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9c61f7a0ad6fdff85b0c

cheers
