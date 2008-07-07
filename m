Return-Path: <linnj@wolfgang-pc.public.xilinx.com>
Received: from WA4EHSOBE003.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id E41FDDDED6
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 06:02:21 +1000 (EST)
From: John Linn <john.linn@xilinx.com>
To: linuxppc-dev@ozlabs.org,
	linux-input@vger.kernel.org
Subject: [PATCH] powerpc: Xilinx: PS2: Update Kconfig for new XPS PS2 driver
Date: Mon, 7 Jul 2008 13:02:08 -0700
Message-ID: <20080707200216.78A3B1568059@mail174-wa4.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: dmitry.torokhov@gmail.com, Sadanand <sadanan@xilinx.com>,
	John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch is an incremental patch for the patch titled:
[V3] powerpc: Xilinx: PS2: Added new XPS PS2 driver. This patch
adds powerpc as a dependency for the driver.

Signed-off-by: Sadanand <sadanan@xilinx.com>
Signed-off-by: John Linn <john.linn@xilinx.com>
---
 drivers/input/serio/Kconfig |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index 0e62b39..683f495 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -192,7 +192,9 @@ config SERIO_RAW
 
 config SERIO_XILINX_XPS_PS2
 	tristate "Xilinx XPS PS/2 Controller Support"
+	depends on PPC
 	help
-	  This driver supports XPS PS/2 IP from Xilinx EDK.
+	  This driver supports XPS PS/2 IP from the Xilinx EDK on the
+	  PowerPC platform.
 
 endif
-- 
1.5.2.1



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
