Return-Path: <fabio.estevam@nxp.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0054.outbound.protection.outlook.com [104.47.37.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGb186VdqzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 00:01:32 +1100 (AEDT)
From: Fabio Estevam <fabio.estevam@nxp.com>
To: <mpe@ellerman.id.au>
CC: <paulus@samba.org>, <benh@kernel.crashing.org>, <robh+dt@kernel.org>,
 <festevam@gmail.com>, <linuxppc-dev@lists.ozlabs.org>, Fabio Estevam
 <fabio.estevam@nxp.com>
Subject: [PATCH] powerpc/40x: acadia: Fix the 'interrupt-parent' property
Date: Tue, 17 Oct 2017 11:01:18 -0200
Message-ID: <1508245278-5692-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

'interrupts-parent' property does not exist. Fix the typo.

Fixes: 00f3ca740a9c26 ("powerpc/40x: AMCC PowerPC 405EZ Acadia DTS")
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/powerpc/boot/dts/acadia.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/acadia.dts b/arch/powerpc/boot/dts/acadia.dts
index 57291f6..8626615 100644
--- a/arch/powerpc/boot/dts/acadia.dts
+++ b/arch/powerpc/boot/dts/acadia.dts
@@ -183,7 +183,7 @@
 			usb@ef603000 {
 				compatible = "ohci-be";
 				reg = <0xef603000 0x80>;
-				interrupts-parent = <&UIC0>;
+				interrupt-parent = <&UIC0>;
 				interrupts = <0xd 0x4 0xe 0x4>;
 			};
 
-- 
2.7.4
