Return-Path: <B37400@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0B7912C039A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2013 22:28:05 +1100 (EST)
From: Sandeep Singh <Sandeep@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/4] Device tree entry for Freescale TDM controller
Date: Thu, 7 Mar 2013 16:57:45 +0530
Message-ID: <1362655668-26721-1-git-send-email-Sandeep@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Sandeep Singh <Sandeep@freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Added dtsi file for Freescale TDM controller.
This controller is available on many Freescale SOCs like MPC8315, P1020, P1010,
P1022 and P1024
Signed-off-by: Sandeep Singh <Sandeep@freescale.com>
Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
---
 arch/powerpc/boot/dts/fsl/pq3-tdm1.0-0.dtsi |   42 +++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-tdm1.0-0.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/pq3-tdm1.0-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-tdm1.0-0.dtsi
new file mode 100644
index 0000000..e89f637
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-tdm1.0-0.dtsi
@@ -0,0 +1,42 @@
+/*
+ * PQ3 TDM device tree stub [ controller @ offset 0x16000 ]
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
+tdm@16000 {
+	compatible = "fsl,tdm1.0";
+	reg = <0x16000 0x200 0x2c000 0x2000>;
+	clock-frequency = <0>;
+	tdm_tx_clk = <2048000>;
+	interrupts = <62 8 0 0>;
+	fsl,max-time-slots = <128>;
+};
-- 
1.7.6.GIT
