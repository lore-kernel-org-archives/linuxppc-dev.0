Return-Path: <Chunhe.Lan@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0238.outbound.protection.outlook.com [207.46.163.238])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 622121A024F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 18:44:45 +1000 (EST)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] t4240/dts: Enable third elo3 DMA engine support
Date: Wed, 28 May 2014 16:47:34 +0800
Message-ID: <1401266854-31088-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

T4240QDS and T4240RDB have the third DMA engine
controller. So add corresponding DMA node into
dts file.

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi |    1 +
 arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi  |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index f99d74f..001183c 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -475,6 +475,7 @@
 
 /include/ "elo3-dma-0.dtsi"
 /include/ "elo3-dma-1.dtsi"
+/include/ "elo3-dma-2.dtsi"
 
 /include/ "qoriq-espi-0.dtsi"
 	spi@110000 {
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
index 0b8ccc5..05fb23b 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
@@ -57,6 +57,7 @@
 		pci3 = &pci3;
 		dma0 = &dma0;
 		dma1 = &dma1;
+		dma2 = &dma2;
 		sdhc = &sdhc;
 	};
 
-- 
1.7.6.5
