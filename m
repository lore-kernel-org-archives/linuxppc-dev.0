Return-Path: <B08248@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D992D2C0323
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 07:24:03 +1100 (EST)
From: Stuart Yoder <stuart.yoder@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH] powerpc: add missing deo ISA category to e500mc/e5500 dts
Date: Tue, 5 Mar 2013 14:23:36 -0600
Message-ID: <1362515016-18296-1-git-send-email-stuart.yoder@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stuart Yoder <stuart.yoder@freescale.com>

Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---
 arch/powerpc/boot/dts/fsl/e500mc_power_isa.dtsi |    1 +
 arch/powerpc/boot/dts/fsl/e5500_power_isa.dtsi  |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/e500mc_power_isa.dtsi b/arch/powerpc/boot/dts/fsl/e500mc_power_isa.dtsi
index 870c653..0e7bb68 100644
--- a/arch/powerpc/boot/dts/fsl/e500mc_power_isa.dtsi
+++ b/arch/powerpc/boot/dts/fsl/e500mc_power_isa.dtsi
@@ -53,6 +53,7 @@
 		power-isa-mmc;		// Memory Coherence
 		power-isa-scpm;		// Store Conditional Page Mobility
 		power-isa-wt;		// Wait
+		power-isa-deo;		// Data Cache Extended Operations
 		mmu-type = "power-embedded";
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/e5500_power_isa.dtsi b/arch/powerpc/boot/dts/fsl/e5500_power_isa.dtsi
index 3230212..39eba29 100644
--- a/arch/powerpc/boot/dts/fsl/e5500_power_isa.dtsi
+++ b/arch/powerpc/boot/dts/fsl/e5500_power_isa.dtsi
@@ -54,6 +54,7 @@
 		power-isa-scpm;		// Store Conditional Page Mobility
 		power-isa-wt;		// Wait
 		power-isa-64;		// 64-bit
+		power-isa-deo;		// Data Cache Extended Operations
 		mmu-type = "power-embedded";
 	};
 };
-- 
1.7.9.7
