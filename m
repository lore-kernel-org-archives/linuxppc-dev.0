Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fwKb40wWzF19d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 22:12:03 +1000 (AEST)
Date: Tue, 31 Jul 2018 14:16:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
 linux-ia64@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 08/20] powerpc/dma: remove the unused dma_nommu_ops export
Message-ID: <20180731121625.GA29793@lst.de>
References: <20180730163824.10064-1-hch@lst.de>
 <20180730163824.10064-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730163824.10064-9-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It turns out cxl actually uses it.  So for now skip this patch,
although random code in drivers messing with dma ops will need to
be sorted out sooner or later.
