Return-Path: <David.Gounaris@infinera.com>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 4205ld3gSnzDrM8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 21:15:41 +1000 (AEST)
From: David Gounaris <david.gounaris@infinera.com>
To: qiang.zhao@nxp.com, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: David Gounaris <david.gounaris@infinera.com>
Subject: [PATCH 1/6] net/wan/fsl_ucc_hdlc: allow ucc index up to 4
Date: Tue, 28 Aug 2018 13:09:16 +0200
Message-Id: <20180828110921.2542-2-david.gounaris@infinera.com>
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

There is a need to allow higher indexes to be
able to support MPC83xx platforms. (UCC1-UCC5)

Signed-off-by: David Gounaris <david.gounaris@infinera.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 5f0366a125e2..3c0e0a1d19ba 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1015,7 +1015,7 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
 	}
 
 	ucc_num = val - 1;
-	if ((ucc_num > 3) || (ucc_num < 0)) {
+	if ((ucc_num > 4) || (ucc_num < 0)) {
 		dev_err(&pdev->dev, ": Invalid UCC num\n");
 		return -EINVAL;
 	}
-- 
2.13.6
