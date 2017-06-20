Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsSxk35S8zDqmt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 23:15:06 +1000 (AEST)
Date: Tue, 20 Jun 2017 15:15:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
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
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: new dma-mapping tree, was Re: clean up and modularize arch
 dma_mapping interface V2
Message-ID: <20170620131503.GA30769@lst.de>
References: <20170620124140.GA27163@lst.de>
 <6025d4d4-1975-9598-c16d-26d17d029ec7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6025d4d4-1975-9598-c16d-26d17d029ec7@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 20, 2017 at 02:14:36PM +0100, Robin Murphy wrote:
> Hi Christoph,
> 
> On 20/06/17 13:41, Christoph Hellwig wrote:
> > On Fri, Jun 16, 2017 at 08:10:15PM +0200, Christoph Hellwig wrote:
> >> I plan to create a new dma-mapping tree to collect all this work.
> >> Any volunteers for co-maintainers, especially from the iommu gang?
> > 
> > Ok, I've created the new tree:
> > 
> >    git://git.infradead.org/users/hch/dma-mapping.git for-next
> > 
> > Gitweb:
> > 
> >    http://git.infradead.org/users/hch/dma-mapping.git/shortlog/refs/heads/for-next
> > 
> > And below is the patch to add the MAINTAINERS entry, additions welcome.
> 
> I'm happy to be a reviewer, since I've been working in this area for
> some time, particularly with the dma-iommu code and arm64 DMA ops.

Great, I'll add you!
