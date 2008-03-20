Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id A40BCDDEF0
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 21:33:47 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Add "amcc,
	haleakala" to the toplevel compatible property
Date: Thu, 20 Mar 2008 11:33:39 +0100
Message-Id: <1206009219-17889-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently Haleakala uses the Kilauea platform code. This patch adds
"haleakala" to the compatible property, in case later kernel versions
will introduce a Haleakala platform code.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/boot/dts/haleakala.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/haleakala.dts b/arch/powerpc/boot/dts/haleakala.dts
index ae68fef..02e4ba3 100644
--- a/arch/powerpc/boot/dts/haleakala.dts
+++ b/arch/powerpc/boot/dts/haleakala.dts
@@ -12,7 +12,7 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 	model = "amcc,haleakala";
-	compatible = "amcc,kilauea";
+	compatible = "amcc,haleakala", "amcc,kilauea";
 	dcr-parent = <&/cpus/cpu@0>;
 
 	aliases {
-- 
1.5.4.4
