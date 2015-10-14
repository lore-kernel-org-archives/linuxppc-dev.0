Return-Path: <BATV+723121e0e7a892d27077+4434+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1869F1A0730
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 02:42:58 +1100 (AEDT)
Date: Wed, 14 Oct 2015 08:42:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 Matthew Wilcox <willy@linux.intel.com>,
 Keith Busch <keith.busch@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/5 v2] dma-mapping: add generic dma_get_page_shift API
Message-ID: <20151014154251.GA7271@infradead.org>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002200953.GB40695@linux.vnet.ibm.com>
 <20151002201142.GC40695@linux.vnet.ibm.com>
 <20151006095136.GB14144@infradead.org>
 <20151012210651.GB26702@linux.vnet.ibm.com>
 <20151014153900.GC30179@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151014153900.GC30179@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nishanth,

sorry for the late reply.

> > On Power, since it's technically variable, we'd need a function. So are
> > you suggesting define'ing it to a function just on Power and leaving it
> > a constant elsewhere?
> > 
> > I noticed that sparc has a IOMMU_PAGE_SHIFT already, fwiw.
> 
> Sorry, I should have been more specific -- I'm ready to spin out a v3,
> with a sparc-specific function.
> 
> Are you ok with leaving it a function for now (the only caller is in
> NVMe obviously).


I guess we do indeed need a function then.  I'll take a look at your
patch, but as long you found a way to avoid adding too much boilerplate
code it should be fine.
