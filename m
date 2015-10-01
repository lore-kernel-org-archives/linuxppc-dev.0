Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 870671A010A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 16:49:49 +1000 (AEST)
In-Reply-To: <1443578287-7847-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, mrochs@linux.vnet.ibm.com, imunsie@au1.ibm.com,
 vaibhav@linux.vnet.ibm.com
Subject: Re: [1/3] cxl: fix leak of IRQ names in cxl_free_afu_irqs()
Message-Id: <20151001064949.5D0F0140D6F@ozlabs.org>
Date: Thu,  1 Oct 2015 16:49:49 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-30-09 at 01:58:05 UTC, Andrew Donnellan wrote:
> cxl_free_afu_irqs() doesn't free IRQ names when it releases an AFU's IRQ
> ranges. The userspace API equivalent in afu_release_irqs() calls
> afu_irq_name_free() to release the IRQ names.
> 
> Call afu_irq_name_free() in cxl_free_afu_irqs() to release the IRQ names.
> Make afu_irq_name_free() non-static to allow this.
> 
> Reported-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Fixes: 6f7f0b3df6d4 ("cxl: Add AFU virtual PHB and kernel API")
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/8dde152ea34860403c839598

cheers
