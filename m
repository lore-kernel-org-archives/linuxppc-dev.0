Return-Path: <hongbo.zhang@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CFB0C2C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 18:38:43 +1100 (EST)
Message-ID: <530D99EB.3090900@freescale.com>
Date: Wed, 26 Feb 2014 15:38:19 +0800
From: Hongbo Zhang <hongbo.zhang@freescale.com>
MIME-Version: 1.0
To: <vinod.koul@intel.com>, <dan.j.williams@intel.com>,
 <dmaengine@vger.kernel.org>
Subject: Re: [PATCH 0/7] DMA: Freescale: driver cleanups and enhancements
References: <1389851246-8564-1-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1389851246-8564-1-git-send-email-hongbo.zhang@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Vinod,
How about these patches?
Thanks.


On 01/16/2014 01:47 PM, hongbo.zhang@freescale.com wrote:
> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>
> Hi Vinod Koul and Dan Williams,
> Please have a look at these patches.
>
> Note that patch 2~6 had beed sent out for upstream before, but were together
> with other storage patches at that time, that was not easy for being reviewed
> and merged, so I send them separately this time.
>
> Thanks.
>
> Hongbo Zhang (7):
>    DMA: Freescale: unify register access methods
>    DMA: Freescale: remove attribute DMA_INTERRUPT of dmaengine
>    DMA: Freescale: add fsl_dma_free_descriptor() to reduce code
>      duplication
>    DMA: Freescale: move functions to avoid forward declarations
>    DMA: Freescale: change descriptor release process for supporting
>      async_tx
>    DMA: Freescale: use spin_lock_bh instead of spin_lock_irqsave
>    DMA: Freescale: add suspend resume functions for DMA driver
>
>   drivers/dma/fsldma.c |  592 ++++++++++++++++++++++++++++++++------------------
>   drivers/dma/fsldma.h |   33 ++-
>   2 files changed, 412 insertions(+), 213 deletions(-)
>
