Return-Path: <ruscur@russell.cc>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhTtT0BxzzDr1w
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 15:26:40 +1100 (AEDT)
Message-ID: <1511324789.1886.1.camel@russell.cc>
Subject: Re: [PATCH kernel] powerpc/powernv/idoa: Remove unnecessary pcidev
 from pci_dn
From: Russell Currey <ruscur@russell.cc>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 22 Nov 2017 15:26:29 +1100
In-Reply-To: <20171023080702.23479-1-aik@ozlabs.ru>
References: <20171023080702.23479-1-aik@ozlabs.ru>
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

On Mon, 2017-10-23 at 19:07 +1100, Alexey Kardashevskiy wrote:
> The pcidev value stored in pci_dn is only used for NPU/NPU2
> initialization. We can easily drop the cached pointer and
> use an ancient helper - pci_get_domain_bus_and_slot() instead in
> order
> to reduce complexity.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

My bad, must have missed this one.  Thanks for the cleanup.

s/idoa/ioda in the title.

Acked-by: Russell Currey <ruscur@russell.cc>
