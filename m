Return-Path: <David.Gounaris@infinera.com>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 4205lh09z6zDqC3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 21:15:43 +1000 (AEST)
From: David Gounaris <david.gounaris@infinera.com>
To: qiang.zhao@nxp.com, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: David Gounaris <david.gounaris@infinera.com>
Subject: [PATCH 2/6] net/wan/fsl_ucc_hdlc: allow PARITY_CRC16_PR0_CCITT parity
Date: Tue, 28 Aug 2018 13:09:17 +0200
Message-Id: <20180828110921.2542-3-david.gounaris@infinera.com>
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

Signed-off-by: David Gounaris <david.gounaris@infinera.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 3c0e0a1d19ba..963b3b5ae15e 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -780,7 +780,8 @@ static int ucc_hdlc_attach(struct net_device *dev, unsigned short encoding,
 
 	if (parity != PARITY_NONE &&
 	    parity != PARITY_CRC32_PR1_CCITT &&
-	    parity != PARITY_CRC16_PR1_CCITT)
+	    parity != PARITY_CRC16_PR1_CCITT && 
+	    parity != PARITY_CRC16_PR0_CCITT)
 		return -EINVAL;
 
 	priv->encoding = encoding;
-- 
2.13.6
