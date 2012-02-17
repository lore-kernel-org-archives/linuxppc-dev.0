Return-Path: <dhdang@apm.com>
Received: from exprod5og106.obsmtp.com (exprod5og106.obsmtp.com [64.18.0.182])
 by ozlabs.org (Postfix) with SMTP id 4B79F1007D5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 19:06:57 +1100 (EST)
Received: by dadp13 with SMTP id p13so3208516dad.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 00:06:54 -0800 (PST)
MIME-Version: 1.0
From: Duc Dang <dhdang@apm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/2] powerpc/44x: Add new compatible value for EMAC node of
 APM821XX dts file.
Date: Fri, 17 Feb 2012 15:06:17 +0700
Message-Id: <1329465977-15924-1-git-send-email-dhdang@apm.com>
Cc: Duc Dang <dhdang@apm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This compatible value will be used to distinguish some special
features of APM821XX EMAC: no half duplex mode support, configuring 
jumbo frame.

Signed-off-by: Duc Dang <dhdang@apm.com>
---
 arch/powerpc/boot/dts/bluestone.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/bluestone.dts b/arch/powerpc/boot/dts/bluestone.dts
index 2a56a0d..74876f7 100644
--- a/arch/powerpc/boot/dts/bluestone.dts
+++ b/arch/powerpc/boot/dts/bluestone.dts
@@ -222,7 +222,7 @@
 
 			EMAC0: ethernet@ef600c00 {
 				device_type = "network";
-				compatible = "ibm,emac4sync";
+				compatible = "ibm,emac-apm821xx", "ibm,emac4sync";
 				interrupt-parent = <&EMAC0>;
 				interrupts = <0x0 0x1>;
 				#interrupt-cells = <1>;
-- 
1.7.5.4
