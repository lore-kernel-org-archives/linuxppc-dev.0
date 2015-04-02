Return-Path: <sandeep@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0AD3F1A0CF3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 22:05:20 +1100 (AEDT)
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0117.outbound.protection.outlook.com [65.55.169.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1BF81140083
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2015 22:05:18 +1100 (AEDT)
Received: from localhost.localdomain (nmglablinux22.zin33.ap.freescale.net
 [10.232.20.244])
 by tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id t32AnKs5002965
 for <linuxppc-dev@ozlabs.org>; Thu, 2 Apr 2015 03:49:22 -0700
From: <sandeep@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [3/3][PATCH] powerpc/85xx: Device tree entry for Freescale TDM
 controller.
Date: Thu, 2 Apr 2015 16:19:20 +0530
Message-ID: <1427971760-32445-1-git-send-email-sandeep@freescale.com>
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

From: Sandeep Singh <sandeep@freescale.com>

Add device tree for TDM on QorIQ chips.

Signed-off-by: Sandeep Singh <sandeep@freescale.com>
Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
---
 arch/powerpc/boot/dts/fsl/qoriq-tdm1.0.dtsi | 41 +++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-tdm1.0.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-tdm1.0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-tdm1.0.dtsi
new file mode 100644
index 0000000..f70ad37
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-tdm1.0.dtsi
@@ -0,0 +1,41 @@
+/*
+ * QorIQ TDM device tree stub [ controller @ offset 0x185000 ]
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
+tdm@185000 {
+	compatible = "fsl,tdm1.0";
+	reg = <0x185000 0x200 0x186000 0x2000>;
+	clock-frequency = <0>;
+	interrupts = <49 8 0 0>;
+	fsl,max-time-slots = <128>;
+};
-- 
1.8.1.4
