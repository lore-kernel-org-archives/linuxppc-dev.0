Return-Path: <b20052@nmglablinux22.freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 43E202C0555
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 21:23:40 +1100 (EST)
Received: from mail190-co1 (localhost [127.0.0.1])	by
 mail190-co1-R.bigfish.com (Postfix) with ESMTP id 219218C0085	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 10:23:34 +0000 (UTC)
Received: from CO1EHSMHS022.bigfish.com (unknown [10.243.78.254])	by
 mail190-co1.bigfish.com (Postfix) with ESMTP id 8ADA6B20045	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 10:23:31 +0000 (UTC)
From: <vakul@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/5][RFC] powerpc/85xx: add SEC-5.3 device tree
Date: Wed, 20 Mar 2013 15:53:25 +0530
Message-ID: <1363775005-29970-1-git-send-email-vakul@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shaveta Leekha <shaveta@freescale.com>, Vakul Garg <vakul@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Shaveta Leekha <shaveta@freescale.com>

Signed-off-by: Vakul Garg <vakul@freescale.com>
Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
---
 arch/powerpc/boot/dts/fsl/qoriq-sec5.3-0.dtsi |  118 +++++++++++++++++++++++++
 1 files changed, 118 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sec5.3-0.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-sec5.3-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-sec5.3-0.dtsi
new file mode 100644
index 0000000..0339825
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-sec5.3-0.dtsi
@@ -0,0 +1,118 @@
+/*
+ * QorIQ Sec/Crypto 5.3 device tree stub [ controller @ offset 0x300000 ]
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
+crypto: crypto@300000 {
+	compatible = "fsl,sec-v5.3", "fsl,sec-v5.0", "fsl,sec-v4.0";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	reg		 = <0x300000 0x10000>;
+	ranges		 = <0 0x300000 0x10000>;
+	interrupts	 = <92 2 0 0>;
+
+	sec_jr0: jr@1000 {
+		compatible = "fsl,sec-v5.3-job-ring",
+			     "fsl,sec-v5.0-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg = <0x1000 0x1000>;
+		interrupts = <88 2 0 0>;
+	};
+
+	sec_jr1: jr@2000 {
+		compatible = "fsl,sec-v5.3-job-ring",
+			     "fsl,sec-v5.0-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg = <0x2000 0x1000>;
+		interrupts = <89 2 0 0>;
+	};
+
+	sec_jr2: jr@3000 {
+		compatible = "fsl,sec-v5.3-job-ring",
+			     "fsl,sec-v5.0-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg = <0x3000 0x1000>;
+		interrupts = <90 2 0 0>;
+	};
+
+	sec_jr3: jr@4000 {
+		compatible = "fsl,sec-v5.3-job-ring",
+			     "fsl,sec-v5.0-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg = <0x4000 0x1000>;
+		interrupts = <91 2 0 0>;
+	};
+
+	rtic@6000 {
+		compatible = "fsl,sec-v5.3-rtic",
+			     "fsl,sec-v5.0-rtic",
+			     "fsl,sec-v4.0-rtic";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x6000 0x100>;
+		ranges = <0x0 0x6100 0xe00>;
+
+		rtic_a: rtic-a@0 {
+			compatible = "fsl,sec-v5.3-rtic-memory",
+				     "fsl,sec-v5.0-rtic-memory",
+				     "fsl,sec-v4.0-rtic-memory";
+			reg = <0x00 0x20 0x100 0x80>;
+		};
+
+		rtic_b: rtic-b@20 {
+			compatible = "fsl,sec-v5.3-rtic-memory",
+				     "fsl,sec-v5.0-rtic-memory",
+				     "fsl,sec-v4.0-rtic-memory";
+			reg = <0x20 0x20 0x200 0x80>;
+		};
+
+		rtic_c: rtic-c@40 {
+			compatible = "fsl,sec-v5.3-rtic-memory",
+				     "fsl,sec-v5.0-rtic-memory",
+				     "fsl,sec-v4.0-rtic-memory";
+			reg = <0x40 0x20 0x300 0x80>;
+		};
+
+		rtic_d: rtic-d@60 {
+			compatible = "fsl,sec-v5.3-rtic-memory",
+				     "fsl,sec-v5.0-rtic-memory",
+				     "fsl,sec-v4.0-rtic-memory";
+			reg = <0x60 0x20 0x500 0x80>;
+		};
+	};
+};
+
+sec_mon: sec_mon@314000 {
+	compatible = "fsl,sec-v5.3-mon", "fsl,sec-v5.0-mon", "fsl,sec-v4.0-mon";
+	reg = <0x314000 0x1000>;
+	interrupts = <93 2 0 0>;
+};
-- 
1.7.6.GIT
