Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsSzG3t24zDqhv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 23:16:26 +1000 (AEST)
Date: Tue, 20 Jun 2017 15:16:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christoph Hellwig <hch@lst.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, openrisc@lists.librecores.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: new dma-mapping tree, was Re: clean up and modularize arch
 dma_mapping interface V2
Message-ID: <20170620131623.GB30769@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
 <20170620124140.GA27163@lst.de> <20170620230400.1a5ae889@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170620230400.1a5ae889@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 20, 2017 at 11:04:00PM +1000, Stephen Rothwell wrote:
> git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git#dma-mapping-next
> 
> Contacts: Marek Szyprowski and Kyungmin Park (cc'd)
> 
> I have called your tree dma-mapping-hch for now.  The other tree has
> not been updated since 4.9-rc1 and I am not sure how general it is.
> Marek, Kyungmin, any comments?

I'd be happy to join efforts - co-maintainers and reviers are always
welcome.
