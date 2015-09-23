Return-Path: <bywxiaobai@163.com>
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
 by lists.ozlabs.org (Postfix) with ESMTP id 5D5FF1A0210
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 00:00:43 +1000 (AEST)
From: Yaowei Bai <bywxiaobai@163.com>
To: perex@perex.cz, tiwai@suse.com, johannes@sipsolutions.net,
 k.kozlowski@samsung.com, elfring@users.sourceforge.net, fabf@skynet.be,
 lars@metafoo.de
Cc: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 2/4] sound/i2sbus/core: make format more appropriate
Date: Wed, 23 Sep 2015 21:58:29 +0800
Message-Id: <1443016711-5297-2-git-send-email-bywxiaobai@163.com>
In-Reply-To: <1443016711-5297-1-git-send-email-bywxiaobai@163.com>
References: <1443016711-5297-1-git-send-email-bywxiaobai@163.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make 'return' stay in a singe line.

No functional change.

Signed-off-by: Yaowei Bai <bywxiaobai@163.com>
---
 sound/aoa/soundbus/i2sbus/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index 1cbf210..6f216c0 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -62,7 +62,8 @@ static int alloc_dbdma_descriptor_ring(struct i2sbus_dev *i2sdev,
 static void free_dbdma_descriptor_ring(struct i2sbus_dev *i2sdev,
 				       struct dbdma_command_mem *r)
 {
-	if (!r->space) return;
+	if (!r->space)
+		return;
 
 	dma_free_coherent(&macio_get_pci_dev(i2sdev->macio)->dev,
 			    r->size, r->space, r->bus_addr);
-- 
1.9.1
