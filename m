Return-Path: <qiang.zhao@nxp.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0059.outbound.protection.outlook.com [65.55.169.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZhS52HPQzDqFZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 20:00:21 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <davem@davemloft.net>
CC: <akpm@linux-foundation.org>, <gregkh@linuxfoundation.org>,
 <oss@buserror.net>, <xiaobo.xie@nxp.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, Zhao Qiang
 <qiang.zhao@nxp.com>
Subject: [PATCH 3/5] fsl/qe: Make regs resouce_size_t
Date: Wed, 30 Mar 2016 16:50:28 +0800
Message-ID: <1459327830-19829-3-git-send-email-qiang.zhao@nxp.com>
In-Reply-To: <1459327830-19829-1-git-send-email-qiang.zhao@nxp.com>
References: <1459327830-19829-1-git-send-email-qiang.zhao@nxp.com>
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
