Return-Path: <r63875@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 48BC42C0326
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2012 17:20:08 +1000 (EST)
Received: from mail95-tx2 (localhost [127.0.0.1])	by mail95-tx2-R.bigfish.com
 (Postfix) with ESMTP id 3EC541401B9	for <linuxppc-dev@ozlabs.org>;
 Wed,  8 Aug 2012 07:20:05 +0000 (UTC)
Received: from TX2EHSMHS022.bigfish.com (unknown [10.9.14.240])	by
 mail95-tx2.bigfish.com (Postfix) with ESMTP id B7FEFC016E	for
 <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2012 07:20:03 +0000 (UTC)
From: Olivia Yin <hong-hua.yin@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/3] powerpc/e5500: Add power isa properties to comply with
 ePAPR 1.1
Date: Wed, 8 Aug 2012 14:53:28 +0800
Message-ID: <1344408808-29411-3-git-send-email-hong-hua.yin@freescale.com>
In-Reply-To: <1344408808-29411-2-git-send-email-hong-hua.yin@freescale.com>
References: <1344408808-29411-1-git-send-email-hong-hua.yin@freescale.com>
 <1344408808-29411-2-git-send-email-hong-hua.yin@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Olivia Yin <hong-hua.yin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch update all the e5500 platforms.

Signed-off-by: Liu Yu <yu.liu@freescale.com>
Signed-off-by: Olivia Yin <hong-hua.yin@freescale.com>
---
git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
branch: next

 arch/powerpc/boot/dts/fsl/e5500_power_isa.dtsi |   59 ++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi     |    3 +
 2 files changed, 62 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/e5500_power_isa.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/e5500_power_isa.dtsi b/arch/powerpc/boot/dts/fsl/e5500_power_isa.dtsi
new file mode 100644
index 0000000..0e26eb5
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/e5500_power_isa.dtsi
@@ -0,0 +1,59 @@
+/*
+ * e5500 power isa Device Tree Source (include)
+ *
+ * Copyright 2012 Freescale Semiconductor Inc.
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
+/ {
+	cpus {
+		power-isa-version = "2.06";
+		power-isa-b;		// Base
+		power-isa-e;		// Embedded
+		power-isa-atb;		// Alternate Time Base
+		power-isa-cs;		// Cache Specification
+		power-isa-ds;		// Decorated Storage
+		power-isa-e.ed;		// Embedded.Enhanced Debug
+		power-isa-e.pd;		// Embedded.External PID
+		power-isa-e.hv;		// Embedded.Hypervisor
+		power-isa-e.le;		// Embedded.Little-Endian
+		power-isa-e.pm;		// Embedded.Performance Monitor
+		power-isa-e.pc;		// Embedded.Processor Control
+		power-isa-ecl;		// Embedded Cache Locking
+		power-isa-exp;		// External Proxy
+		power-isa-fp;		// Floating Point
+		power-isa-fp.r;		// Floating Point.Record
+		power-isa-mmc;		// Memory Coherence
+		power-isa-scpm;		// Store Conditional Page Mobility
+		power-isa-wt;		// Wait
+		power-isa-64;		// 64-bit
+		mmu-type = "power-embedded";
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
index ae823a4..0a198b0 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
@@ -33,6 +33,9 @@
  */
 
 /dts-v1/;
+
+/include/ "e5500_power_isa.dtsi"
+
 / {
 	compatible = "fsl,P5020";
 	#address-cells = <2>;
-- 
1.6.4
