Return-Path: <BATV+3740c4db088a71c572a8+5047+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wr4wt65LhzDqZP
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Jun 2017 17:09:34 +1000 (AEST)
Date: Sun, 18 Jun 2017 00:09:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, the arch/x86 maintainers <x86@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, openrisc@lists.librecores.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org,
 "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
 Netdev <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/44] dmaengine: ioat: don't use DMA_ERROR_CODE
Message-ID: <20170618070925.GA18526@infradead.org>
References: <20170616181059.19206-1-hch@lst.de>
 <20170616181059.19206-4-hch@lst.de>
 <CAKgT0UdxrimWrxNVsLMQ9G6ABBJZwfWHTcP18qqd4rT0Fa-KWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKgT0UdxrimWrxNVsLMQ9G6ABBJZwfWHTcP18qqd4rT0Fa-KWg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 16, 2017 at 01:40:24PM -0700, Alexander Duyck wrote:
> dma_unmap_page on dest_dma if "op == IOAT_OP_XOR"? Odds are it is what
> the compiler is already generating and will save a few lines of code
> so what you end up with is something like:

Honestly wanted to touch the code as little as possible :)  If we want
to make it prettier and more readable it needs to be refactored.

If you're interested I can take a stab at that, but I'd like to keep
it out of this already giant series.
