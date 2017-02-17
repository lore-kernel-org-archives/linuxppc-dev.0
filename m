Return-Path: <valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPq7j36LqzDqKc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 21:31:29 +1100 (AEDT)
From: Valentin Longchamp <valentin.longchamp@keymile.com>
To: qiang.zhao@nxp.com, netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
 Valentin Longchamp <valentin.longchamp@keymile.com>
Subject: [PATCH] net/wan: add MODULE_LICENSE for fsl_ucc_hdlc
Date: Fri, 17 Feb 2017 11:31:22 +0100
Message-Id: <1487327482-26482-1-git-send-email-valentin.longchamp@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is required to build it as a module.

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index e38ce4d..1f38c06 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1175,3 +1175,4 @@ static int ucc_hdlc_remove(struct platform_device *pdev)
 };
 
 module_platform_driver(ucc_hdlc_driver);
+MODULE_LICENSE("GPL");
-- 
1.8.3.1
