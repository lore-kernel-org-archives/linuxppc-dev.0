Return-Path: <B25806@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B3BC0B72B2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 21:25:32 +1100 (EST)
Received: from mail52-ch1 (localhost [127.0.0.1])	by mail52-ch1-R.bigfish.com
 (Postfix) with ESMTP id A62EF500124	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 10 Jan 2012 10:25:27 +0000 (UTC)
Received: from CH1EHSMHS029.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.247])	by mail52-ch1.bigfish.com (Postfix) with ESMTP id
 87AEE4E0043
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 10:25:27 +0000 (UTC)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/3] powerpc/fsl: Document Pulse Width Modulator controller
 device tree binding
Date: Tue, 10 Jan 2012 18:26:43 +0800
Message-ID: <1326191203-11207-3-git-send-email-Chunhe.Lan@freescale.com>
In-Reply-To: <1326191203-11207-1-git-send-email-Chunhe.Lan@freescale.com>
References: <1326191203-11207-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This document is created for freescale PWM node in dts file. In addition,
it explicates the properties and gives example about PWM node.

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
---
 .../devicetree/bindings/powerpc/fsl/pwm.txt        |   27 ++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/pwm.txt

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/pwm.txt b/Documentation/devicetree/bindings/powerpc/fsl/pwm.txt
new file mode 100644
index 0000000..92d68e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/fsl/pwm.txt
@@ -0,0 +1,27 @@
+=====================================================================
+Freescale Pulse Width Modulator Controller Node
+Copyright (C) 2012 Freescale Semiconductor Inc.
+=====================================================================
+
+Properties:
+
+- name : Should be pwm.
+- compatible : Should contain "fsl,psc9131-pwm".
+- cell-index : The cell index is the pwm controller serial number,
+	       <0> = PWM1, <1> = PWM2, and so on.
+- #address-cells : Should be one.
+- #size-cells : Should be zero.
+- reg : Offset and length of the register set for the device.
+- interrupts : <interrupt mapping for PWM IRQ>
+
+Example:
+
+		pwm@13000 {
+			cell-index = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,psc9131-pwm";
+			reg = <0x13000 0x1000>;
+			interrupts = <44 2 0 0>;
+			interrupt-parent = <&mpic>;
+		};
-- 
1.5.6.5
