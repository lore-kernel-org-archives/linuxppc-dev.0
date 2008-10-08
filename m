Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7096CDE039
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 17:30:43 +1100 (EST)
Message-Id: <B8EF017C-5055-4637-8203-4052D79E0900@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Remi Machet <rmachet@slac.stanford.edu>
In-Reply-To: <1223413433.17585.26.camel@pcds-ts102.slac.stanford.edu>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 0/3] powerpc: dma code cleanup
Date: Wed, 8 Oct 2008 01:30:35 -0500
References: <1223413433.17585.26.camel@pcds-ts102.slac.stanford.edu>
Cc: Linux PPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 7, 2008, at 4:03 PM, Remi Machet wrote:

> Hi,
>
> Following is the whole DMA code cleanup on top of the work
> already done by Becky Bruce. It includes removing __dma_sync
> and __dma_sync_page that got replaced by dma_mapping_ops->sync,
> getting rid of the old dma-noncoherent code which is now another
> type of dma_mapping_ops and cleaning up the dma non-coherent
> code by removing the virtual address pool it was using.
>
> This code was tested on a 32bits PowerPC C2K board (noncoherent
> cache) and I verified it builds on pmac32 (coherent cache, 32bits)
> and pseries (64bits).
>
> If anyone would be willing to test this code on other platforms
> (mainly ones with non-coherent DMA architectures), I would
> greatly appreciate!

Your patch commit subject should be more descriptive for each patch.   
Have the same "subject" is not acceptable.

- k
