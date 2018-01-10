Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGtH03krDzDqHT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 02:29:48 +1100 (AEDT)
Date: Wed, 10 Jan 2018 16:29:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
 linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, x86@kernel.org,
 Konrad Rzeszutek Wilk <konrad@darnok.org>,
 linux-snps-arc@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 patches@groups.riscv.org, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 20/33] dma-mapping: clear harmful GFP_* flags in common
 code
Message-ID: <20180110152945.GC17790@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-21-hch@lst.de>
 <27b90341-f9d0-356f-0194-1c7203a3f93e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <27b90341-f9d0-356f-0194-1c7203a3f93e@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 10, 2018 at 11:59:30AM +0000, Robin Murphy wrote:
> Just a note that if we're all happy to enshrine the "allocations are always 
> zeroed" behaviour in the API (I am too, for the record), we should remember 
> to follow up once the dust settles to update the docs and I guess just 
> #define dma_zalloc_coherent dma_alloc_coherent.

And then just remove it.  But yes, another item for the todo list..
