Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGtPP258qzF0ld
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 02:35:21 +1100 (AEDT)
Date: Wed, 10 Jan 2018 16:35:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
 linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
 Michal Simek <monstr@monstr.eu>, linux-ia64@vger.kernel.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 Konrad Rzeszutek Wilk <konrad@darnok.org>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 08/22] swiotlb: wire up ->dma_supported in swiotlb_dma_ops
Message-ID: <20180110153517.GF17790@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
 <20180110080932.14157-9-hch@lst.de>
 <7a058876-08fc-7323-7cb3-fe85116e2ea8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7a058876-08fc-7323-7cb3-fe85116e2ea8@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 10, 2018 at 12:16:15PM +0000, Robin Murphy wrote:
> On 10/01/18 08:09, Christoph Hellwig wrote:
>> To properly reject too small DMA masks based on the addressability of the
>> bounce buffer.
>
> I reckon this is self-evident enough that it should simply be squashed into 
> the previous patch.

x86 didn't wire it up before, so I want a clear blaimpoint for this
change instead of mixing it up.
