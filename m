Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC8401A1DDA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 18:03:30 +1000 (AEST)
In-Reply-To: <1439535518-19192-1-git-send-email-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, imunsie@au1.ibm.com
Subject: Re: [RESEND] cxl:Plug irq_bitmap getting leaked in cxl_context
Message-Id: <20150817080330.AA2001402B1@ozlabs.org>
Date: Mon, 17 Aug 2015 18:03:30 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-14-08 at 06:58:38 UTC, Vaibhav Jain wrote:
> This patch plugs the leak of irq_bitmap, allocated as part of
> initialization of cxl_context struct; during the call to
> afu_allocate_irqs. The bitmap is now release during the call to function
> afu_release_irqs.
> 
> Reported-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8c7dd08a8ccac3f0f3df

cheers
