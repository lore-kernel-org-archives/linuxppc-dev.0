Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 297B01A04B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 11:44:24 +1000 (AEST)
In-Reply-To: <1438917500-12100-2-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, Daniel Axtens <dja@axtens.net>, imunsie@au.ibm.com
Subject: Re: [2/4] cxl: sparse: Make declarations static
Message-Id: <20150813014423.939F414056B@ozlabs.org>
Date: Thu, 13 Aug 2015 11:44:23 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-07-08 at 03:18:18 UTC, Daniel Axtens wrote:
> A few declarations were identified by sparse as needing to be static:
> 
> /scratch/dja/linux-capi/drivers/misc/cxl/irq.c:408:6: warning: symbol 'afu_irq_name_free' was not declared. Should it be static?
> /scratch/dja/linux-capi/drivers/misc/cxl/irq.c:467:6: warning: symbol 'afu_register_hwirqs' was not declared. Should it be static?
> /scratch/dja/linux-capi/drivers/misc/cxl/file.c:254:6: warning: symbol 'afu_compat_ioctl' was not declared. Should it be static?
> /scratch/dja/linux-capi/drivers/misc/cxl/file.c:399:30: warning: symbol 'afu_master_fops' was not declared. Should it be static?
> 
> Make them static.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> Acked-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3d6b040e73387570521d

cheers
