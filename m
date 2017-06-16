Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpv8p2DR0zDq88
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 18:45:45 +1000 (AEST)
Date: Fri, 16 Jun 2017 10:45:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andreas Larsson <andreas@gaisler.com>
Cc: Christoph Hellwig <hch@lst.de>, x86@kernel.org,
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
Subject: Re: [PATCH 27/44] sparc: remove leon_dma_ops
Message-ID: <20170616084542.GD10582@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-28-hch@lst.de> <593E4B82.70306@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <593E4B82.70306@gaisler.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 12, 2017 at 10:06:26AM +0200, Andreas Larsson wrote:
> Yes, it is needed. LEON systems are AMBA bus based. The common case here is 
> DMA over AMBA buses. Some LEON systems have PCI bridges, but in general 
> CONFIG_PCI is not a given.

Ok, and even for AMBA we use the pci ops, so I'll leave it in and drop
the comment from the commit.
