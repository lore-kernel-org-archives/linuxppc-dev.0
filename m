Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED98C1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 14:11:17 +1000 (AEST)
In-Reply-To: <1438153805-31828-4-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org
Subject: Re: [4/8] powerpc/slb: Add some helper functions to improve
 modularization
Message-Id: <20150812041117.CFFC91401CD@ozlabs.org>
Date: Wed, 12 Aug 2015 14:11:17 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-29-07 at 07:10:01 UTC, Anshuman Khandual wrote:
> This patch adds the following six helper functions to help improve
> modularization and readability of the code.
> 
> (1) slb_invalidate_all:		Invalidates the entire SLB
> (2) slb_invalidate:		Invalidates SLB entries present in PACA
> (3) mmu_linear_vsid_flags:	VSID flags for kernel linear mapping
> (4) mmu_virtual_vsid_flags:	VSID flags for kernel virtual mapping
> (5) mmu_vmemmap_vsid_flags:	VSID flags for kernel vmem mapping
> (6) mmu_io_vsid_flags:		VSID flags for kernel I/O mapping

That's too many changes for one patch, it's certainly not a single logical change.

I'm happy with all the flag ones being done in a single patch, but please do
the other two in separate patches.

cheers
