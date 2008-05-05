Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound7-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 10AE1DE126
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 04:02:12 +1000 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org
Subject: [PATCH] Xilinx: framebuffer: add compatibility for ml507 dvi core.
Date: Mon,  5 May 2008 10:59:08 -0700
Message-Id: <20080505175918.2AD03A58056@mail164-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
---
 drivers/video/xilinxfb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index 848752e..a82c530 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -396,6 +396,7 @@ static int __devexit xilinxfb_of_remove(struct of_device *op)
 /* Match table for of_platform binding */
 static struct of_device_id xilinxfb_of_match[] __devinitdata = {
 	{ .compatible = "xlnx,plb-tft-cntlr-ref-1.00.a", },
+	{ .compatible = "xlnx,plb-dvi-cntlr-ref-1.00.c", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, xilinxfb_of_match);
-- 
1.5.3.4-dirty
