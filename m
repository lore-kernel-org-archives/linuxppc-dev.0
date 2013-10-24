Return-Path: <B44306@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B51622C016B
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Oct 2013 08:03:34 +1100 (EST)
Received: from mail19-ch1 (localhost [127.0.0.1])	by mail19-ch1-R.bigfish.com
 (Postfix) with ESMTP id C45E42E0156	for <linuxppc-dev@ozlabs.org>;
 Thu, 24 Oct 2013 21:03:31 +0000 (UTC)
Received: from CH1EHSMHS036.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.251])	by mail19-ch1.bigfish.com (Postfix) with ESMTP id
 BCCD76009D
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Oct 2013 21:03:29 +0000 (UTC)
From: Lijun Pan <Lijun.Pan@freescale.com>
To: <linuxppc-dev@ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 1/2] powerpc/e6500: Include Power ISA properties
Date: Thu, 24 Oct 2013 16:03:24 -0500
Message-ID: <1382648605-22509-1-git-send-email-Lijun.Pan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Lijun Pan <Lijun.Pan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

b4420 and b4860 device trees do not have these properties.

Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>
---
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi |    2 ++
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
index 7b4426e..cbaecf1 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
@@ -34,6 +34,8 @@
 
 /dts-v1/;
 
+/include/ "e6500_power_isa.dtsi:"
+
 / {
 	compatible = "fsl,B4420";
 	#address-cells = <2>;
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
index 5263fa4..9bc26b1 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
@@ -34,6 +34,8 @@
 
 /dts-v1/;
 
+/include/ "e6500_power_isa.dtsi"
+
 / {
 	compatible = "fsl,B4860";
 	#address-cells = <2>;
-- 
1.7.9.7
