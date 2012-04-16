Return-Path: <B21284@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe005.messaging.microsoft.com [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E7F2BB6FFF
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2012 12:20:09 +1000 (EST)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/4] powerpc/mpc85xx: add MPIC message dts node
Date: Mon, 16 Apr 2012 10:05:08 +0800
Message-ID: <1334541908-19331-4-git-send-email-Mingkai.hu@freescale.com>
In-Reply-To: <1334541908-19331-3-git-send-email-Mingkai.hu@freescale.com>
References: <1334541908-19331-1-git-send-email-Mingkai.hu@freescale.com>
 <1334541908-19331-2-git-send-email-Mingkai.hu@freescale.com>
 <1334541908-19331-3-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mingkai Hu <Mingkai.hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
---
 arch/powerpc/boot/dts/fsl/pq3-mpic-message-B.dtsi |   43 +++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi           |   10 +++++
 2 files changed, 53 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-mpic-message-B.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/pq3-mpic-message-B.dtsi b/arch/powerpc/boot/dts/fsl/pq3-mpic-message-B.dtsi
new file mode 100644
index 0000000..1cf0b77
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-mpic-message-B.dtsi
@@ -0,0 +1,43 @@
+/*
+ * PQ3 MPIC Message (Group B) device tree stub [ controller @ offset 0x42400 ]
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
+message@42400 {
+	compatible = "fsl,mpic-v3.1-msgr";
+	reg = <0x42400 0x200>;
+	interrupts = <
+		0xb4 2 0 0
+		0xb5 2 0 0
+		0xb6 2 0 0
+		0xb7 2 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi b/arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi
index fdedf7b..71c30eb 100644
--- a/arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi
+++ b/arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi
@@ -53,6 +53,16 @@ timer@41100 {
 		      3 0 3 0>;
 };
 
+message@41400 {
+	compatible = "fsl,mpic-v3.1-msgr";
+	reg = <0x41400 0x200>;
+	interrupts = <
+		0xb0 2 0 0
+		0xb1 2 0 0
+		0xb2 2 0 0
+		0xb3 2 0 0>;
+};
+
 msi@41600 {
 	compatible = "fsl,mpic-msi";
 	reg = <0x41600 0x80>;
-- 
1.7.5.1
