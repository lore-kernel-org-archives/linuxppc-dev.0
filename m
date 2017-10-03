Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y63ht3QRDzDql7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 03:02:52 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christoph Hellwig' <hch@lst.de>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
CC: Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, "Max
 Filippov" <jcmvbkbc@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, "Robin
 Murphy" <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH 02/11] x86: make dma_cache_sync a no-op
Date: Tue, 3 Oct 2017 16:02:10 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD0088B73@AcuExch.aculab.com>
References: <20171003104311.10058-1-hch@lst.de>
 <20171003104311.10058-3-hch@lst.de>
In-Reply-To: <20171003104311.10058-3-hch@lst.de>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christoph Hellwig
> Sent: 03 October 2017 11:43
> x86 does not implement DMA_ATTR_NON_CONSISTENT allocations, so it doesn't
> make any sense to do any work in dma_cache_sync given that it must be a
> no-op when dma_alloc_attrs returns coherent memory.

I believe it is just about possible to require an explicit
write flush on x86.
ISTR this can happen with something like write combining.

Whether this can actually happen is the kernel is another matter.

	David
