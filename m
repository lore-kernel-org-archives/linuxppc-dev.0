Return-Path: <joe@perches.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AAE4FB6F35
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Jun 2009 02:38:45 +1000 (EST)
Received: from mail.perches.com (136-022.dsl.LABridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id B5428DDD0B
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 02:38:43 +1000 (EST)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 15/62] drivers/dma/fsldma.c: Remove unnecessary semicolons
Date: Sun, 28 Jun 2009 09:26:20 -0700
Message-Id: <03676ce0e272d44d1d4ea19639b28afb994c65eb.1246173680.git.joe@perches.com>
In-Reply-To: <cover.1246173664.git.joe@perches.com>
References: <cover.1246173664.git.joe@perches.com>
Cc: trivial@kernel.org, linuxppc-dev@ozlabs.org,
	Maciej Sosnowski <maciej.sosnowski@intel.com>,
	Zhang Wei <zw@zh-kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Li Yang <leoli@freescale.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/dma/fsldma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index f18d1bd..71ce8ed 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -136,7 +136,7 @@ static int dma_is_idle(struct fsl_dma_chan *fsl_chan)
 
 static void dma_start(struct fsl_dma_chan *fsl_chan)
 {
-	u32 mr_set = 0;;
+	u32 mr_set = 0;
 
 	if (fsl_chan->feature & FSL_DMA_CHAN_PAUSE_EXT) {
 		DMA_OUT(fsl_chan, &fsl_chan->reg_base->bcr, 0, 32);
-- 
1.6.3.1.10.g659a0.dirty
