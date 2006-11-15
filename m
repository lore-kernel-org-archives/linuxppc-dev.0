Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0997067C87
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 10:43:55 +1100 (EST)
Subject: Re: [PATCH 10/16] IOMMU on Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200611150947.kAF9lDMi007946@toshiba.co.jp>
References: <200611150947.kAF9lDMi007946@toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 10:43:50 +1100
Message-Id: <1163634230.5940.279.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-11-15 at 18:47 +0900, Ishizaki Kou wrote:

> +	pci_dma_ops.alloc_coherent = celleb_alloc_coherent;
> +	pci_dma_ops.free_coherent = celleb_free_coherent;
> +	pci_dma_ops.map_single = celleb_map_single;
> +	pci_dma_ops.unmap_single = celleb_unmap_single;
> +	pci_dma_ops.map_sg = celleb_map_sg;
> +	pci_dma_ops.unmap_sg = celleb_unmap_sg;
> +	pci_dma_ops.dma_supported = celleb_dma_supported;

You need to adapt that to the new DMA ops mecanism I've implemented for
powerpc, though I suppose I could do the adaptation myself once I get
the HW to test with.

Ben.
