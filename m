Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0128.outbound.protection.outlook.com [207.46.100.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 113DA1A1D50
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 13:49:48 +1000 (AEST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
CC: <Priyanka.Jain@freescale.com>, <devicetree@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Wang Dongsheng
 <dongsheng.wang@freescale.com>
Subject: [PATCH v2 2/2] powerpc/mpc85xx:Add SCFG device tree support of T104x
Date: Fri, 14 Aug 2015 11:12:10 +0800
Message-ID: <1439521930-28191-2-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1439521930-28191-1-git-send-email-dongsheng.wang@freescale.com>
References: <1439521930-28191-1-git-send-email-dongsheng.wang@freescale.com>
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

From: Wang Dongsheng <dongsheng.wang@freescale.com>

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
*V2*
No changes.
diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
index 9e9f7e2..9770d02 100644
--- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
@@ -484,6 +484,11 @@
 		reg	   = <0xea000 0x4000>;
 	};
 
+	scfg: global-utilities@fc000 {
+		compatible = "fsl,t1040-scfg";
+		reg = <0xfc000 0x1000>;
+	};
+
 /include/ "elo3-dma-0.dtsi"
 /include/ "elo3-dma-1.dtsi"
 /include/ "qoriq-espi-0.dtsi"
-- 
2.1.0.27.g96db324
