Return-Path: <m.szyprowski@samsung.com>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by ozlabs.org (Postfix) with ESMTP id 8EAF5B6F86
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2012 23:00:57 +1000 (EST)
Received: from epcpsbgm2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M6D00E7NQSV15H0@mailout2.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 29 Jun 2012 22:00:54 +0900 (KST)
Received: from AMDC159 ([106.116.147.30])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M6D00NWGQT23S00@mmp1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 29 Jun 2012 22:00:54 +0900 (KST)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: 'Clemens Ladisch' <clemens@ladisch.de>
References: <1339741135-7841-1-git-send-email-m.szyprowski@samsung.com>
 <4FED8D03.10507@ladisch.de>
In-reply-to: <4FED8D03.10507@ladisch.de>
Subject: RE: [PATCH] common: dma-mapping: add support for generic dma_mmap_*
 calls
Date: Fri, 29 Jun 2012 15:00:37 +0200
Message-id: <00a501cd55f7$323946f0$96abd4d0$%szyprowski@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Cc: linux-arch@vger.kernel.org,
 'Russell King - ARM Linux' <linux@arm.linux.org.uk>,
 'Arnd Bergmann' <arnd@arndb.de>,
 'Konrad Rzeszutek Wilk' <konrad.wilk@oracle.com>,
 'Subash Patel' <subash.ramaswamy@linaro.org>, linux-kernel@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org,
 'Kyungmin Park' <kyungmin.park@samsung.com>, linuxppc-dev@lists.ozlabs.org,
 'Sumit Semwal' <sumit.semwal@linaro.org>, linux-arm-kernel@lists.infradead.org,
 'David Gibson' <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Friday, June 29, 2012 1:10 PM Clemens Ladisch wrote:

> Marek Szyprowski wrote:
> > +++ b/drivers/base/dma-mapping.c
> > ...
> > +int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
> > +		    void *cpu_addr, dma_addr_t dma_addr, size_t size)
> > +{
> > +	int ret = -ENXIO;
> > +	...
> > +	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
> > +		return ret;
> 
> This will return -ENXIO if dma_mmap_from_coherent() succeeds.
 
Thanks for spotting this! I will fix it in the next version of the patch.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
