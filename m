Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE41E1A0748
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 07:58:33 +1000 (AEST)
In-Reply-To: <1440480888-7885-1-git-send-email-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, imunsie@au1.ibm.com
Subject: Re: cxl: Release irqs if memory allocation fails
Message-Id: <20150827215833.B3D441401B5@ozlabs.org>
Date: Fri, 28 Aug 2015 07:58:33 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-25-08 at 05:34:48 UTC, Vaibhav Jain wrote:
> This minor patch plugs a potential irq leak in case of a memory
> allocation failure inside function the afu_allocate_irqs. Presently the
> irqs allocated to the context gets leaked if allocation of either
> one of context irq_bitmap or irq_names fails.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a6897f39660cc07fa78b4459

cheers
