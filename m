Return-Path: <valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPq660GRtzDqBm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 21:30:05 +1100 (AEDT)
From: Valentin Longchamp <valentin.longchamp@keymile.com>
To: linuxppc-dev@lists.ozlabs.org, qiang.zhao@nxp.com
Cc: oss@buserror.net, Valentin Longchamp <valentin.longchamp@keymile.com>
Subject: [PATCH 3/3] soc/fsl/qe: add EXPORT_SYMBOL for the 2 qe_tdm functions
Date: Fri, 17 Feb 2017 11:29:47 +0100
Message-Id: <1487327387-26370-4-git-send-email-valentin.longchamp@keymile.com>
In-Reply-To: <1487327387-26370-1-git-send-email-valentin.longchamp@keymile.com>
References: <1487327387-26370-1-git-send-email-valentin.longchamp@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This allows to build the fsl_ucc_hdlc driver as a module.

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
---
 drivers/soc/fsl/qe/qe_tdm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
index a1048b4..f744c21 100644
--- a/drivers/soc/fsl/qe/qe_tdm.c
+++ b/drivers/soc/fsl/qe/qe_tdm.c
@@ -177,6 +177,7 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 	devm_iounmap(&pdev->dev, utdm->si_regs);
 	return ret;
 }
+EXPORT_SYMBOL(ucc_of_parse_tdm);
 
 void ucc_tdm_init(struct ucc_tdm *utdm, struct ucc_tdm_info *ut_info)
 {
@@ -274,3 +275,4 @@ void ucc_tdm_init(struct ucc_tdm *utdm, struct ucc_tdm_info *ut_info)
 		break;
 	}
 }
+EXPORT_SYMBOL(ucc_tdm_init);
-- 
1.8.3.1
