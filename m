Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6561A1A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 10:58:39 +1000 (AEST)
Message-ID: <1437785913.19730.1.camel@ellerman.id.au>
Subject: Re: [PATCH 3/3] powerpc/iommu: Support "hybrid" iommu/direct DMA
 ops for coherent_mask < dma_mask
From: Michael Ellerman <mpe@ellerman.id.au>
To: Brian King <brking@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Date: Sat, 25 Jul 2015 10:58:33 +1000
In-Reply-To: <55B2983E.5020300@linux.vnet.ibm.com>
References: <1435123531.3996.31.camel@kernel.crashing.org>
 <55B2983E.5020300@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-07-24 at 14:55 -0500, Brian King wrote:
> Ben,
> 
> It looks like this patch has bit rot. I have a system now where I can test the
> latest version. Any chance you can rediff and resend and I can test?

It's in next:

  https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/log/?h=next


Or just grab linux-next.

So please test it, but hopefully it works :)

cheers
