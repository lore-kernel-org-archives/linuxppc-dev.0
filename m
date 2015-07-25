Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BEF841A1D39
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 11:01:20 +1000 (AEST)
Message-ID: <1437786063.7562.76.camel@kernel.crashing.org>
Subject: Re: [PATCH 3/3] powerpc/iommu: Support "hybrid" iommu/direct DMA
 ops for coherent_mask < dma_mask
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brian King <brking@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Sat, 25 Jul 2015 11:01:03 +1000
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

Hrm, Michael didn't upstream it ? Ok, I'll have a look on monday.

(ping me if I don't).

Cheers,
Ben.
