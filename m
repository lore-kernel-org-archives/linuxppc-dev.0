Return-Path: <B43644@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B9FBF2C0103
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 13:10:38 +1000 (EST)
From: Po Liu <Po.Liu@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/4] powerpc/85xx: Add SEC6.0 device tree
Date: Thu, 25 Apr 2013 09:54:14 +0800
Message-ID: <1366854857-22791-1-git-send-email-Po.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mingkai Hu <Mingkai.Hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mingkai Hu <Mingkai.Hu@freescale.com>

Add device tree for SEC 6.0 used on C29x silicon.

Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
Singed-off-by: Po Liu <Po.Liu@freescale.com>
---
Base on git://git.am.freescale.net/gitolite/mirrors/linux-2.6.git
 arch/powerpc/boot/dts/fsl/qoriq-sec6.0-0.dtsi | 58 +++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sec6.0-0.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-sec6.0-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-sec6.0-0.dtsi
new file mode 100644
index 0000000..eb99a46
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-sec6.0-0.dtsi
@@ -0,0 +1,58 @@
+/*
+ * QorIQ Sec/Crypto 6.0 device tree stub
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
+	compatible = "fsl,sec-v6.0", "fsl,sec-v5.2",
+		     "fsl,sec-v5.0", "fsl,sec-v4.4",
+		     "fsl,sec-v4.0";
+	fsl,sec-era = <6>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	jr@1000 {
+		compatible = "fsl,sec-v6.0-job-ring",
+			     "fsl,sec-v5.2-job-ring",
+			     "fsl,sec-v5.0-job-ring",
+			     "fsl,sec-v4.4-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg	   = <0x1000 0x1000>;
+	};
+
+	jr@2000 {
+		compatible = "fsl,sec-v6.0-job-ring",
+			     "fsl,sec-v5.2-job-ring",
+			     "fsl,sec-v5.0-job-ring",
+			     "fsl,sec-v4.4-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg	   = <0x2000 0x1000>;
+	};
-- 
1.8.0
