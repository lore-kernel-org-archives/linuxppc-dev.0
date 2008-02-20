Return-Path: <SRS0=9nXe=TJ=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 1A582DDE38
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 21:46:31 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 4xx: Fix Haleakala PCIe compatibility problem in dts
Date: Wed, 20 Feb 2008 11:45:58 +0100
Message-Id: <1203504358-21331-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since the 4xx PCIe driver checks for 405ex compatibility, the
PCIe interface was not detected as it is currently defined as
"405exr" compatible. This patch changes it to "405ex".

The 405EX and 405EXr are identical exept that the 2nd PCIe and the
2nd EMAC interfaces are missing.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/boot/dts/haleakala.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/haleakala.dts b/arch/powerpc/boot/dts/haleakala.dts
index 5dd3d15..ae68fef 100644
--- a/arch/powerpc/boot/dts/haleakala.dts
+++ b/arch/powerpc/boot/dts/haleakala.dts
@@ -235,7 +235,7 @@
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
-			compatible = "ibm,plb-pciex-405exr", "ibm,plb-pciex";
+			compatible = "ibm,plb-pciex-405ex", "ibm,plb-pciex";
 			primary;
 			port = <0>; /* port number */
 			reg = <a0000000 20000000	/* Config space access */
-- 
1.5.4.2
