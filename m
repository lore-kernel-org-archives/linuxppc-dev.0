Return-Path: <B42677@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F09E22C008A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jul 2013 16:29:46 +1000 (EST)
From: Haijun Zhang <Haijun.Zhang@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH] DTS: Add compatible list for eSDHC
Date: Mon, 1 Jul 2013 13:21:50 +0800
Message-ID: <1372656110-13876-1-git-send-email-Haijun.Zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Fleming Andrew-AFLEMING <AFLEMING@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, Haijun Zhang <Haijun.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add compatible of esdhc for below board:
p2041   p3041   p4080   p5020   p5040

Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
CC: Scott Wood <scottwood@freescale.com>
CC: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
---
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi | 1 +
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi | 1 +
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi | 1 +
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi | 1 +
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
index 531eab8..0a8f1bd 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
@@ -299,6 +299,7 @@
 
 /include/ "qoriq-esdhc-0.dtsi"
 	sdhc@114000 {
+		compatible = "fsl,p2041-esdhc", "fsl,esdhc";
 		sdhci,auto-cmd12;
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
index af4ebc8..2165e17 100644
--- a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
@@ -326,6 +326,7 @@
 
 /include/ "qoriq-esdhc-0.dtsi"
 	sdhc@114000 {
+		compatible = "fsl,p3041-esdhc", "fsl,esdhc";
 		sdhci,auto-cmd12;
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
index 4f9c9f6..cadd81e 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
@@ -335,6 +335,7 @@
 
 /include/ "qoriq-esdhc-0.dtsi"
 	sdhc@114000 {
+		compatible = "fsl,p4080-esdhc", "fsl,esdhc";
 		voltage-ranges = <3300 3300>;
 		sdhci,auto-cmd12;
 	};
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
index 5d7205b..bb0de92 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
@@ -329,6 +329,7 @@
 
 /include/ "qoriq-esdhc-0.dtsi"
 	sdhc@114000 {
+		compatible = "fsl,p5020-esdhc", "fsl,esdhc";
 		sdhci,auto-cmd12;
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
index db2c9a7..bcd0f7a 100644
--- a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
@@ -292,6 +292,7 @@
 
 /include/ "qoriq-esdhc-0.dtsi"
 	sdhc@114000 {
+		compatible = "fsl,p5040-esdhc", "fsl,esdhc";
 		sdhci,auto-cmd12;
 	};
 
-- 
1.8.0
