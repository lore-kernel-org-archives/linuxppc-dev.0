Return-Path: <B44306@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BD2B72C00B9
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Oct 2013 08:03:32 +1100 (EST)
Received: from mail64-co9 (localhost [127.0.0.1])	by mail64-co9-R.bigfish.com
 (Postfix) with ESMTP id 14D04CC008B	for <linuxppc-dev@ozlabs.org>;
 Thu, 24 Oct 2013 21:03:29 +0000 (UTC)
Received: from CO9EHSMHS031.bigfish.com (unknown [10.236.132.231])	by
 mail64-co9.bigfish.com (Postfix) with ESMTP id 3AE2286003E	for
 <linuxppc-dev@ozlabs.org>; Thu, 24 Oct 2013 21:03:28 +0000 (UTC)
From: Lijun Pan <Lijun.Pan@freescale.com>
To: <linuxppc-dev@ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 2/2] powerpc/e500v2: Include Power ISA properties
Date: Thu, 24 Oct 2013 16:03:25 -0500
Message-ID: <1382648605-22509-2-git-send-email-Lijun.Pan@freescale.com>
In-Reply-To: <1382648605-22509-1-git-send-email-Lijun.Pan@freescale.com>
References: <1382648605-22509-1-git-send-email-Lijun.Pan@freescale.com>
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

bsc9131 device tree does not have these properties.

Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>
---
 arch/powerpc/boot/dts/fsl/bsc9131si-pre.dtsi |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/bsc9131si-pre.dtsi b/arch/powerpc/boot/dts/fsl/bsc9131si-pre.dtsi
index 743e4ae..f6ec4a6 100644
--- a/arch/powerpc/boot/dts/fsl/bsc9131si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/bsc9131si-pre.dtsi
@@ -33,6 +33,9 @@
  */
 
 /dts-v1/;
+
+/include/ "e500v2_power_isa.dtsi"
+
 / {
 	compatible = "fsl,BSC9131";
 	#address-cells = <2>;
-- 
1.7.9.7
