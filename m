Return-Path: <qiang.zhao@nxp.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0096.outbound.protection.outlook.com [157.56.111.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNQV53PzHzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 16:56:45 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <oss@buserror.net>, <davem@davemloft.net>, <Joakim.Tjernlund@infinera.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <xiaobo.xie@nxp.com>, Zhao Qiang
 <qiang.zhao@nxp.com>
Subject: [Patch v3 3/5] fsl/qe: Make regs resouce_size_t
Date: Mon, 6 Jun 2016 14:30:00 +0800
Message-ID: <1465194602-43209-3-git-send-email-qiang.zhao@nxp.com>
In-Reply-To: <1465194602-43209-1-git-send-email-qiang.zhao@nxp.com>
References: <1465194602-43209-1-git-send-email-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
Changes for v2:
	- modify subject
Changes for v3:
	- na

 include/soc/fsl/qe/ucc_fast.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/soc/fsl/qe/ucc_fast.h b/include/soc/fsl/qe/ucc_fast.h
index b2633b7..e898895 100644
--- a/include/soc/fsl/qe/ucc_fast.h
+++ b/include/soc/fsl/qe/ucc_fast.h
@@ -123,7 +123,7 @@ struct ucc_fast_info {
 	enum qe_clock tx_clock;
 	enum qe_clock rx_sync;
 	enum qe_clock tx_sync;
-	u32 regs;
+	resource_size_t regs;
 	int irq;
 	u32 uccm_mask;
 	int bd_mem_part;
-- 
2.1.0.27.g96db324
