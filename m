Return-Path: <BATV+9a74b0e5f9a269ad7b1a+4422+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9D23C1A05CB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 03:41:52 +1000 (AEST)
Date: Fri, 2 Oct 2015 10:41:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 Matthew Wilcox <willy@linux.intel.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@intel.com>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/2] drivers/nvme: default to the IOMMU page size on Power
Message-ID: <20151002174146.GA21503@infradead.org>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002171800.GB41011@linux.vnet.ibm.com>
 <20151002172313.GC41011@linux.vnet.ibm.com>
 <20151002172544.GA16139@infradead.org>
 <20151002173947.GA40695@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151002173947.GA40695@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 02, 2015 at 10:39:47AM -0700, Nishanth Aravamudan wrote:
> Ok, I'm happy to do that instead -- what I struggled with is that I
> don't have enough knowledge of the various architectures to provide the
> right default implementation. It should be sufficient for the default to
> return PAGE_SHIFT, and on Power just override that to return the IOMMU
> table's page size? Since the only user will be the NVMe driver
> currently, that should be fine?

I think that's fine.

> Sorry for the less-than-ideal patch!

Np, it's a reasonable first attempt that we just need to refine.
