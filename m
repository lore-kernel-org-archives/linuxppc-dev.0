Return-Path: <gustavo@zacarias.com.ar>
Received: from loknar.toptech.com.ar (loknar.toptech.com.ar [74.118.36.95])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.toptech.com.ar", Issuer "mail.toptech.com.ar" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 22DFBB6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 06:48:44 +1100 (EST)
From: Gustavo Zacarias <gustavo@zacarias.com.ar>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/boot: fix typo in p1010rdb.dtsi
Date: Tue, 28 Feb 2012 16:43:08 -0300
Message-Id: <1330458188-17265-1-git-send-email-gustavo@zacarias.com.ar>
Cc: Gustavo Zacarias <gustavo@zacarias.com.ar>, afleming@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix typo introduced by "powerpc: Add TBI PHY node to first MDIO bus"
from Andy Fleming.
It's device_type rather than device-type, which causes the mdio probe to
fail thus making all gianfar ethernet interfaces unusable.

Signed-off-by: Gustavo Zacarias <gustavo@zacarias.com.ar>
---
 arch/powerpc/boot/dts/p1010rdb.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1010rdb.dtsi b/arch/powerpc/boot/dts/p1010rdb.dtsi
index d4c4a77..9e0a0b7 100644
--- a/arch/powerpc/boot/dts/p1010rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1010rdb.dtsi
@@ -196,7 +196,7 @@
 		};
 
 		tbi-phy@3 {
-			device-type = "tbi-phy";
+			device_type = "tbi-phy";
 			reg = <0x3>;
 		};
 	};
-- 
1.7.3.4
