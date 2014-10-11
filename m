Return-Path: <vinod.koul@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id 936191A1B73
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Oct 2014 03:21:02 +1100 (EST)
From: Vinod Koul <vinod.koul@intel.com>
To: dmaengine@vger.kernel.org
Subject: [PATCH 6/6] dmaengine: remove FSLDMA_EXTERNAL_START
Date: Sat, 11 Oct 2014 21:16:48 +0530
Message-Id: <1413042408-28491-7-git-send-email-vinod.koul@intel.com>
In-Reply-To: <1413042408-28491-1-git-send-email-vinod.koul@intel.com>
References: <1413042408-28491-1-git-send-email-vinod.koul@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Zhang Wei <zw@zh-kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

as users have been converted, so no need of this custom method

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/linux/dmaengine.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index ce8a08e..3254a03 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -199,15 +199,12 @@ enum dma_ctrl_flags {
  * configuration data in statically from the platform). An additional
  * argument of struct dma_slave_config must be passed in with this
  * command.
- * @FSLDMA_EXTERNAL_START: this command will put the Freescale DMA controller
- * into external start mode.
  */
 enum dma_ctrl_cmd {
 	DMA_TERMINATE_ALL,
 	DMA_PAUSE,
 	DMA_RESUME,
 	DMA_SLAVE_CONFIG,
-	FSLDMA_EXTERNAL_START,
 };
 
 /**
-- 
1.7.0.4
