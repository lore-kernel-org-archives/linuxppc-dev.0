Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMWZQ3d8yzDrfR
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 20:42:37 +1000 (AEST)
From: Colin King <colin.king@canonical.com>
To: Zhao Qiang <qiang.zhao@nxp.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] wan/fsl_ucc_hdlc: fix spelling mistake "prameter" ->
 "parameter"
Date: Sun, 28 Aug 2016 11:40:41 +0100
Message-Id: <20160828104041.9272-1-colin.king@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 6f04445..5fbf83d 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -162,7 +162,7 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
 				ALIGNMENT_OF_UCC_HDLC_PRAM);
 
 	if (priv->ucc_pram_offset < 0) {
-		dev_err(priv->dev, "Can not allocate MURAM for hdlc prameter.\n");
+		dev_err(priv->dev, "Can not allocate MURAM for hdlc parameter.\n");
 		ret = -ENOMEM;
 		goto free_tx_bd;
 	}
-- 
2.9.3
