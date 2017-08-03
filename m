Return-Path: <peda@axentia.se>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00101.outbound.protection.outlook.com [40.107.0.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNVWl5dlzzDqjP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 22:59:47 +1000 (AEST)
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/fsl/dts: fix the i2c-mux compatible for t104xqds
Date: Thu,  3 Aug 2017 14:59:34 +0200
Message-Id: <20170803125934.14960-1-peda@axentia.se>
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

The sanctioned compatible is "nxp,pca9547".

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/powerpc/boot/dts/fsl/t104xqds.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/fsl/t104xqds.dtsi b/arch/powerpc/boot/dts/fsl/t104xqds.dtsi
index 2fd4cbe7098f..615479732252 100644
--- a/arch/powerpc/boot/dts/fsl/t104xqds.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t104xqds.dtsi
@@ -269,7 +269,7 @@
 
 		i2c@118000 {
 			pca9547@77 {
-				compatible = "philips,pca9547";
+				compatible = "nxp,pca9547";
 				reg = <0x77>;
 			};
 			rtc@68 {
-- 
2.11.0
