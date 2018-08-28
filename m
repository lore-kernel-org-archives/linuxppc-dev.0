Return-Path: <David.Gounaris@infinera.com>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 4205ld3dgwzDrJ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 21:15:41 +1000 (AEST)
From: David Gounaris <david.gounaris@infinera.com>
To: qiang.zhao@nxp.com, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: David Gounaris <david.gounaris@infinera.com>
Subject: [PATCH 4/6] net/wan/fsl_ucc_hdlc: default hmask value
Date: Tue, 28 Aug 2018 13:09:19 +0200
Message-Id: <20180828110921.2542-5-david.gounaris@infinera.com>
In-Reply-To: <20180828110921.2542-1-david.gounaris@infinera.com>
References: <20180828110921.2542-1-david.gounaris@infinera.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Set default HMASK to 0x0000 to use
promiscuous mode in the hdlc controller.

Signed-off-by: David Gounaris <david.gounaris@infinera.com>
---
 drivers/net/wan/fsl_ucc_hdlc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.h b/drivers/net/wan/fsl_ucc_hdlc.h
index c21134c1f180..5bc3d1a6ca6e 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.h
+++ b/drivers/net/wan/fsl_ucc_hdlc.h
@@ -134,7 +134,7 @@ struct ucc_hdlc_private {
 
 #define HDLC_HEAD_MASK		0x0000
 #define DEFAULT_HDLC_HEAD	0xff44
-#define DEFAULT_ADDR_MASK	0x00ff
+#define DEFAULT_ADDR_MASK	0x0000
 #define DEFAULT_HDLC_ADDR	0x00ff
 
 #define BMR_GBL			0x20000000
-- 
2.13.6
