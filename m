Return-Path: <hongbo.zhang@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 85EDC14010A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Apr 2014 14:28:05 +1100 (EST)
From: <hongbo.zhang@freescale.com>
To: <vkoul@infradead.org>, <dan.j.williams@intel.com>,
 <dmaengine@vger.kernel.org>
Subject: [PATCH v2 0/8] DMA: Freescale: driver cleanups and enhancements
Date: Fri, 4 Apr 2014 11:27:09 +0800
Message-ID: <1396582037-23065-1-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Hongbo Zhang <hongbo.zhang@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hongbo Zhang <hongbo.zhang@freescale.com>

Hi Vinod Koul,
Please have a look at the v2 patch set.

v1 -> v2 change:
The only one change is introducing a new patch[1/7] to remove the unnecessary
macro FSL_DMA_LD_DEBUG, thus the total patches number is 8 now (was 7)

Hongbo Zhang (8):
  DMA: Freescale: remove the unnecessary FSL_DMA_LD_DEBUG
  DMA: Freescale: unify register access methods
  DMA: Freescale: remove attribute DMA_INTERRUPT of dmaengine
  DMA: Freescale: add fsl_dma_free_descriptor() to reduce code
    duplication
  DMA: Freescale: move functions to avoid forward declarations
  DMA: Freescale: change descriptor release process for supporting
    async_tx
  DMA: Freescale: use spin_lock_bh instead of spin_lock_irqsave
  DMA: Freescale: add suspend resume functions for DMA driver

 drivers/dma/fsldma.c |  590 ++++++++++++++++++++++++++++++++------------------
 drivers/dma/fsldma.h |   33 ++-
 2 files changed, 408 insertions(+), 215 deletions(-)

-- 
1.7.9.5
