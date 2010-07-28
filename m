Return-Path: <tie-fei.zang@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) by ozlabs.org (Postfix) with ESMTP id 2C152B6EEE
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 16:14:08 +1000 (EST)
From: Roy Zang <tie-fei.zang@freescale.com>
To: linux-mmc-approval@vger.kernel.org
Subject: [PATCH 2/3] dts: Add sdhci-auto-cmd12 field for p4080 device tree
Date: Wed, 28 Jul 2010 13:44:47 +0800
Message-ID: <1280295887-14251-1-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/boot/dts/p4080ds.dts |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index 6b29eab..11c8884 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -280,6 +280,7 @@
 			reg = <0x114000 0x1000>;
 			interrupts = <48 2>;
 			interrupt-parent = <&mpic>;
+			fsl,sdhci-auto-cmd12;
 		};
 
 		i2c@118000 {
-- 
1.5.6.5
