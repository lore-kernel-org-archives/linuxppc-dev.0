Return-Path: <B16394@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9CCE22C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 13:47:58 +1000 (EST)
From: Vakul Garg <vakul@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/crypto: removed qoriq-sec4.1-0.dtsi.
Date: Thu, 11 Apr 2013 09:13:39 +0530
Message-ID: <1365651819-23350-1-git-send-email-vakul@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shaveta Leekha <shaveta@freescale.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Andy Fleming <afleming@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Removing qoriq-sec4.1-0.dtsi as it is not used by any soc anymore.

Signed-off-by: Vakul Garg <vakul@freescale.com>
---
 arch/powerpc/boot/dts/fsl/qoriq-sec4.1-0.dtsi |  109 -------------------------
 1 files changed, 0 insertions(+), 109 deletions(-)
 delete mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sec4.1-0.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-sec4.1-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-sec4.1-0.dtsi
deleted file mode 100644
index 3308986..0000000
--- a/arch/powerpc/boot/dts/fsl/qoriq-sec4.1-0.dtsi
+++ /dev/null
@@ -1,109 +0,0 @@
-/*
- * QorIQ Sec/Crypto 4.1 device tree stub [ controller @ offset 0x300000 ]
- *
- * Copyright 2011 Freescale Semiconductor Inc.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Freescale Semiconductor nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
- * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-crypto: crypto@300000 {
-	compatible = "fsl,sec-v4.1", "fsl,sec-v4.0";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	reg		 = <0x300000 0x10000>;
-	ranges		 = <0 0x300000 0x10000>;
-	interrupts	 = <92 2 0 0>;
-
-	sec_jr0: jr@1000 {
-		compatible = "fsl,sec-v4.1-job-ring",
-			     "fsl,sec-v4.0-job-ring";
-		reg = <0x1000 0x1000>;
-		interrupts = <88 2 0 0>;
-	};
-
-	sec_jr1: jr@2000 {
-		compatible = "fsl,sec-v4.1-job-ring",
-			     "fsl,sec-v4.0-job-ring";
-		reg = <0x2000 0x1000>;
-		interrupts = <89 2 0 0>;
-	};
-
-	sec_jr2: jr@3000 {
-		compatible = "fsl,sec-v4.1-job-ring",
-			     "fsl,sec-v4.0-job-ring";
-		reg = <0x3000 0x1000>;
-		interrupts = <90 2 0 0>;
-	};
-
-	sec_jr3: jr@4000 {
-		compatible = "fsl,sec-v4.1-job-ring",
-			     "fsl,sec-v4.0-job-ring";
-		reg = <0x4000 0x1000>;
-		interrupts = <91 2 0 0>;
-	};
-
-	rtic@6000 {
-		compatible = "fsl,sec-v4.1-rtic",
-			     "fsl,sec-v4.0-rtic";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <0x6000 0x100>;
-		ranges = <0x0 0x6100 0xe00>;
-
-		rtic_a: rtic-a@0 {
-			compatible = "fsl,sec-v4.1-rtic-memory",
-				     "fsl,sec-v4.0-rtic-memory";
-			reg = <0x00 0x20 0x100 0x80>;
-		};
-
-		rtic_b: rtic-b@20 {
-			compatible = "fsl,sec-v4.1-rtic-memory",
-				     "fsl,sec-v4.0-rtic-memory";
-			reg = <0x20 0x20 0x200 0x80>;
-		};
-
-		rtic_c: rtic-c@40 {
-			compatible = "fsl,sec-v4.1-rtic-memory",
-				     "fsl,sec-v4.0-rtic-memory";
-			reg = <0x40 0x20 0x300 0x80>;
-		};
-
-		rtic_d: rtic-d@60 {
-			compatible = "fsl,sec-v4.1-rtic-memory",
-				     "fsl,sec-v4.0-rtic-memory";
-			reg = <0x60 0x20 0x500 0x80>;
-		};
-	};
-};
-
-sec_mon: sec_mon@314000 {
-	compatible = "fsl,sec-v4.1-mon", "fsl,sec-v4.0-mon";
-	reg = <0x314000 0x1000>;
-	interrupts = <93 2 0 0>;
-};
-- 
1.7.7.6
