Return-Path: <Shengzhou.Liu@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 642832C00E2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2013 22:59:45 +1100 (EST)
Received: from mail89-am1 (localhost [127.0.0.1])	by mail89-am1-R.bigfish.com
 (Postfix) with ESMTP id 5F0F5160297	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,
 22 Nov 2013 11:59:38 +0000 (UTC)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 1/4 v2] powerpc/85xx/dts: add third elo3 dma component
Date: Fri, 22 Nov 2013 19:12:49 +0800
Message-ID: <1385118772-15126-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Liu Gang <Gang.Liu@freescale.com>,
 Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add elo3-dma-2.dtsi to support the third DMA controller.
This is used on T2080, T4240, etc.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
---
v2: no change

 arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi | 82 +++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi b/arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi
new file mode 100644
index 0000000..b89d816
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi
@@ -0,0 +1,82 @@
+/*
+ * QorIQ Elo3 DMA device tree stub [ controller @ offset 0x102300 ]
+ *
+ * Copyright 2013 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+dma2: dma@102300 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "fsl,elo3-dma";
+	reg = <0x102300 0x4>,
+	      <0x102600 0x4>;
+	ranges = <0x0 0x102100 0x500>;
+	dma-channel@0 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x0 0x80>;
+		interrupts = <256 2 0 0>;
+	};
+	dma-channel@80 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x80 0x80>;
+		interrupts = <257 2 0 0>;
+	};
+	dma-channel@100 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x100 0x80>;
+		interrupts = <258 2 0 0>;
+	};
+	dma-channel@180 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x180 0x80>;
+		interrupts = <259 2 0 0>;
+	};
+	dma-channel@300 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x300 0x80>;
+		interrupts = <260 2 0 0>;
+	};
+	dma-channel@380 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x380 0x80>;
+		interrupts = <261 2 0 0>;
+	};
+	dma-channel@400 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x400 0x80>;
+		interrupts = <262 2 0 0>;
+	};
+	dma-channel@480 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x480 0x80>;
+		interrupts = <263 2 0 0>;
+	};
+};
-- 
1.8.0
