Return-Path: <David.Gounaris@infinera.com>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 420mKZ2fZ6zF31P
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 23:13:54 +1000 (AEST)
From: David Gounaris <david.gounaris@infinera.com>
To: qiang.zhao@nxp.com, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 robh+dt@kernel.org
Cc: David Gounaris <david.gounaris@infinera.com>
Subject: [PATCH v2 2/6] net/wan/fsl_ucc_hdlc: allow PARITY_CRC16_PR0_CCITT
 parity
Date: Wed, 29 Aug 2018 15:13:24 +0200
Message-Id: <20180829131328.27901-3-david.gounaris@infinera.com>
In-Reply-To: <20180829131328.27901-1-david.gounaris@infinera.com>
References: <20180828110921.2542-2-david.gounaris@infinera.com>
 <20180829131328.27901-1-david.gounaris@infinera.com>
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
index 5cf6dcba039c..c8e526bf1130 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -781,7 +781,8 @@ static int ucc_hdlc_attach(struct net_device *dev, unsigned short encoding,
 
 	if (parity != PARITY_NONE &&
 	    parity != PARITY_CRC32_PR1_CCITT &&
-	    parity != PARITY_CRC16_PR1_CCITT)
+	    parity != PARITY_CRC16_PR1_CCITT && 
+	    parity != PARITY_CRC16_PR0_CCITT)
 		return -EINVAL;
 
 	priv->encoding = encoding;
-- 
2.13.6
