Return-Path: <B45939@freescale.com>
From: <hongbo.zhang@freescale.com>
To: <vinod.koul@intel.com>, <djbw@fb.com>, <leoli@freescale.com>,
 <scottwood@freescale.com>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH V2 1/2] DMA: Freescale: Add new 8-channel DMA engine device
 tree nodes
Date: Fri, 5 Jul 2013 14:27:05 +0800
Message-ID: <1373005626-20726-2-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1373005626-20726-1-git-send-email-hongbo.zhang@freescale.com>
References: <1373005626-20726-1-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Hongbo Zhang <hongbo.zhang@freescale.com>,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 vakul@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hongbo Zhang <hongbo.zhang@freescale.com>

Freescale QorIQ T4 and B4 introduce new 8-channel DMA engines, this patch add
the device tree nodes for them.

Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
---
 arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi   |   90 +++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi   |   90 +++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi |    4 +-
 3 files changed, 182 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi b/arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi
new file mode 100644
index 0000000..50cd911
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi
@@ -0,0 +1,90 @@
+/*
+ * QorIQ DMA device tree stub [ controller @ offset 0x100000 ]
+ *
+ * Copyright 2011-2013 Freescale Semiconductor Inc.
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
+dma0: dma@100300 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "fsl,elo3-dma";
+	reg = <0x100300 0x4 0x100600 0x4>;
+	ranges = <0x0 0x100100 0x500>;
+	cell-index = <0>;
+	dma-channel@0 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x0 0x80>;
+		cell-index = <0>;
+		interrupts = <28 2 0 0>;
+	};
+	dma-channel@80 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x80 0x80>;
+		cell-index = <1>;
+		interrupts = <29 2 0 0>;
+	};
+	dma-channel@100 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x100 0x80>;
+		cell-index = <2>;
+		interrupts = <30 2 0 0>;
+	};
+	dma-channel@180 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x180 0x80>;
+		cell-index = <3>;
+		interrupts = <31 2 0 0>;
+	};
+	dma-channel@300 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x300 0x80>;
+		cell-index = <4>;
+		interrupts = <76 2 0 0>;
+	};
+	dma-channel@380 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x380 0x80>;
+		cell-index = <5>;
+		interrupts = <77 2 0 0>;
+	};
+	dma-channel@400 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x400 0x80>;
+		cell-index = <6>;
+		interrupts = <78 2 0 0>;
+	};
+	dma-channel@480 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x480 0x80>;
+		cell-index = <7>;
+		interrupts = <79 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi b/arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi
new file mode 100644
index 0000000..c1aec68
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi
@@ -0,0 +1,90 @@
+/*
+ * QorIQ DMA device tree stub [ controller @ offset 0x101000 ]
+ *
+ * Copyright 2011-2013 Freescale Semiconductor Inc.
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
+dma1: dma@101300 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "fsl,elo3-dma";
+	reg = <0x101300 0x4 0x101600 0x4>;
+	ranges = <0x0 0x101100 0x500>;
+	cell-index = <1>;
+	dma-channel@0 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x0 0x80>;
+		cell-index = <0>;
+		interrupts = <32 2 0 0>;
+	};
+	dma-channel@80 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x80 0x80>;
+		cell-index = <1>;
+		interrupts = <33 2 0 0>;
+	};
+	dma-channel@100 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x100 0x80>;
+		cell-index = <2>;
+		interrupts = <34 2 0 0>;
+	};
+	dma-channel@180 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x180 0x80>;
+		cell-index = <3>;
+		interrupts = <35 2 0 0>;
+	};
+	dma-channel@300 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x300 0x80>;
+		cell-index = <4>;
+		interrupts = <80 2 0 0>;
+	};
+	dma-channel@380 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x380 0x80>;
+		cell-index = <5>;
+		interrupts = <81 2 0 0>;
+	};
+	dma-channel@400 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x400 0x80>;
+		cell-index = <6>;
+		interrupts = <82 2 0 0>;
+	};
+	dma-channel@480 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x480 0x80>;
+		cell-index = <7>;
+		interrupts = <83 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index bd611a9..ec95c60 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -387,8 +387,8 @@
 		reg	   = <0xea000 0x4000>;
 	};
 
-/include/ "qoriq-dma-0.dtsi"
-/include/ "qoriq-dma-1.dtsi"
+/include/ "elo3-dma-0.dtsi"
+/include/ "elo3-dma-1.dtsi"
 
 /include/ "qoriq-espi-0.dtsi"
 	spi@110000 {
-- 
1.7.9.5
