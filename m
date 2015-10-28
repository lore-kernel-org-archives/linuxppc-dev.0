Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E51391A0D31
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 13:21:21 +1100 (AEDT)
Message-ID: <1445998805.1856.24.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/7 v2] powerpc/dma-mapping: override dma_get_page_shift
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, Alexey Kardashevskiy
 <aik@ozlabs.ru>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Matthew Wilcox
 <willy@linux.intel.com>, Keith Busch <keith.busch@intel.com>, Paul
 Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>,
 Christoph Hellwig <hch@infradead.org>, "David S. Miller"
 <davem@davemloft.net>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Date: Wed, 28 Oct 2015 11:20:05 +0900
In-Reply-To: <20151028015451.GH7716@linux.vnet.ibm.com>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
 <20151023205718.GC10197@linux.vnet.ibm.com> <562F1368.1030204@ozlabs.ru>
 <20151027222706.GF7716@linux.vnet.ibm.com> <56301E24.1060304@ozlabs.ru>
 <20151028015451.GH7716@linux.vnet.ibm.com>
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

On Tue, 2015-10-27 at 18:54 -0700, Nishanth Aravamudan wrote:
> 
> In "bypass" mode, what TCE size is used? Is it guaranteed to be 4K?

None :-) The TCEs are completely bypassed. You get a N:M linear mapping
of all memory starting at 1<<59 PCI side.

> Seems like this would be a different platform implentation I'd put in
> for 'powernv', is that right?
> 
> My apologies for missing that, and thank you for the review!

Cheers,
Ben.
