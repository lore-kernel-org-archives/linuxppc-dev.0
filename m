Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 02D21B72E1
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 18:16:40 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAH7Gbs8026648
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 01:16:37 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 15/29] powerpc/85xx: Add RTC to P1010RDB device tree
Date: Thu, 17 Nov 2011 01:16:07 -0600
Message-Id: <1321514181-28897-15-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1321514181-28897-14-git-send-email-galak@kernel.crashing.org>
References: <1321514181-28897-1-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-2-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-3-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-4-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-5-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-6-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-7-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-8-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-9-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-10-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-11-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-12-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-13-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-14-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/p1010rdb.dtsi |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1010rdb.dtsi b/arch/powerpc/boot/dts/p1010rdb.dtsi
index 149d196..3aa2b82 100644
--- a/arch/powerpc/boot/dts/p1010rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1010rdb.dtsi
@@ -125,6 +125,13 @@
 };
 
 &board_soc {
+	i2c@3000 {
+		rtc@68 {
+			compatible = "pericom,pt7c4338";
+			reg = <0x68>;
+		};
+	};
+
 	spi@7000 {
 		flash@0 {
 			#address-cells = <1>;
-- 
1.7.3.4
