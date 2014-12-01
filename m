Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 552EC1A09BF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Dec 2014 21:13:00 +1100 (AEDT)
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0117.outbound.protection.outlook.com [65.55.169.117])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4AE2614017C
 for <linuxppc-dev@ozlabs.org>; Mon,  1 Dec 2014 21:12:59 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <linuxppc-dev@ozlabs.org>,
 <devicetree@vger.kernel.org>
Subject: [PATCH v3 1/4] powerpc/mpc85xx: Create dts components for the FSL
 QorIQ DPAA BMan
Date: Mon, 1 Dec 2014 04:02:12 -0600
Message-ID: <1417428135-12895-2-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1417428135-12895-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1417428135-12895-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Geoff Thorpe <Geoff.Thorpe@Freescale.com>,
 Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>

Change-Id: I16e63db731e55a3d60d4e147573c1af8718082d3
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Geoff Thorpe <Geoff.Thorpe@freescale.com>
Signed-off-by: Hai-Ying Wang <Haiying.Wang@freescale.com>
[Emil Medve: Sync with the upstream binding]
Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 arch/powerpc/boot/dts/fsl/qoriq-bman1-portals.dtsi | 90 ++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/qoriq-bman1.dtsi         | 41 ++++++++++
 2 files changed, 131 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-bman1-portals.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-bman1.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-bman1-portals.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-bman1-portals.dtsi
new file mode 100644
index 0000000..5022432
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-bman1-portals.dtsi
@@ -0,0 +1,90 @@
+/*
+ * QorIQ BMan Portal device tree stub for 10 portals
+ *
+ * Copyright 2011 - 2014 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
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
+&bportals {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "simple-bus";
+
+	bman-portal@0 {
+		compatible = "fsl,bman-portal";
+		reg = <0x0 0x4000>, <0x100000 0x1000>;
+		interrupts = <105 2 0 0>;
+	};
+	bman-portal@4000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x4000 0x4000>, <0x101000 0x1000>;
+		interrupts = <107 2 0 0>;
+	};
+	bman-portal@8000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x8000 0x4000>, <0x102000 0x1000>;
+		interrupts = <109 2 0 0>;
+	};
+	bman-portal@c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0xc000 0x4000>, <0x103000 0x1000>;
+		interrupts = <111 2 0 0>;
+	};
+	bman-portal@10000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x10000 0x4000>, <0x104000 0x1000>;
+		interrupts = <113 2 0 0>;
+	};
+	bman-portal@14000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x14000 0x4000>, <0x105000 0x1000>;
+		interrupts = <115 2 0 0>;
+	};
+	bman-portal@18000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x18000 0x4000>, <0x106000 0x1000>;
+		interrupts = <117 2 0 0>;
+	};
+	bman-portal@1c000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x1c000 0x4000>, <0x107000 0x1000>;
+		interrupts = <119 2 0 0>;
+	};
+	bman-portal@20000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x20000 0x4000>, <0x108000 0x1000>;
+		interrupts = <121 2 0 0>;
+	};
+	bman-portal@24000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x24000 0x4000>, <0x109000 0x1000>;
+		interrupts = <123 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-bman1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-bman1.dtsi
new file mode 100644
index 0000000..1adc09f
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-bman1.dtsi
@@ -0,0 +1,41 @@
+/*
+ * QorIQ BMan device tree stub [ controller @ offset 0x31a000 ]
+ *
+ * Copyright 2011 - 2014 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
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
+bman: bman@31a000 {
+	compatible = "fsl,bman";
+	reg = <0x31a000 0x1000>;
+	interrupts = <16 2 1 2>;
+	fsl,bman-portals = &bportals;
+	memory-region = <&bman_fbpr>;
+};
-- 
2.1.3
