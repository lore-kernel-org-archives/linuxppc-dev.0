Return-Path: <jesper.nilsson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGGzt5qJMzDqlG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 02:59:38 +1100 (AEDT)
Date: Tue, 9 Jan 2018 16:53:17 +0100
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-mips@linux-mips.org,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
 x86@kernel.org, linux-snps-arc@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net,
 linux-m68k@lists.linux-m68k.org, patches@groups.riscv.org,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 34/67] cris: use dma-direct
Message-ID: <20180109155317.GN32368@axis.com>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-35-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171229081911.2802-35-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 29, 2017 at 09:18:38AM +0100, Christoph Hellwig wrote:
> cris currently has an incomplete direct mapping dma_map_ops implementation
> is PCI support is enabled.  Replace it with the fully feature generic
> dma-direct implementation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For CRIS:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> ---
>  arch/cris/Kconfig                       |  4 ++
>  arch/cris/arch-v32/drivers/pci/Makefile |  2 +-
>  arch/cris/arch-v32/drivers/pci/dma.c    | 78 ---------------------------------
>  arch/cris/include/asm/Kbuild            |  1 +
>  arch/cris/include/asm/dma-mapping.h     | 20 ---------
>  5 files changed, 6 insertions(+), 99 deletions(-)
>  delete mode 100644 arch/cris/arch-v32/drivers/pci/dma.c
>  delete mode 100644 arch/cris/include/asm/dma-mapping.h
> 

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
