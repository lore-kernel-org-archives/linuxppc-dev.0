Return-Path: <B29983@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 367BB2C02BB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 12:49:07 +1000 (EST)
Received: from mail43-am1 (localhost [127.0.0.1])	by mail43-am1-R.bigfish.com
 (Postfix) with ESMTP id 896F2600A3	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,
 13 Jul 2012 02:49:04 +0000 (UTC)
Received: from AM1EHSMHS003.bigfish.com (unknown [10.3.201.248])	by
 mail43-am1.bigfish.com (Postfix) with ESMTP id 7D63140049	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 02:49:02 +0000 (UTC)
From: <b29983@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: Fix pci base address error for p2020rdb-pc in
 dts
Date: Fri, 13 Jul 2012 10:27:35 +0800
Message-ID: <1342146455-27729-2-git-send-email-b29983@freescale.com>
In-Reply-To: <1342146455-27729-1-git-send-email-b29983@freescale.com>
References: <1342146455-27729-1-git-send-email-b29983@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tang Yuantian <Yuantian.Tang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <Yuantian.Tang@freescale.com>

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
 arch/powerpc/boot/dts/p2020rdb-pc_32b.dts |    4 ++--
 arch/powerpc/boot/dts/p2020rdb-pc_36b.dts |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/p2020rdb-pc_32b.dts b/arch/powerpc/boot/dts/p2020rdb-pc_32b.dts
index 852e5b2..57573bd 100644
--- a/arch/powerpc/boot/dts/p2020rdb-pc_32b.dts
+++ b/arch/powerpc/boot/dts/p2020rdb-pc_32b.dts
@@ -56,7 +56,7 @@
 		ranges = <0x0 0x0 0xffe00000 0x100000>;
 	};
 
-	pci0: pcie@ffe08000 {
+	pci2: pcie@ffe08000 {
 		reg = <0 0xffe08000 0 0x1000>;
 		status = "disabled";
 	};
@@ -76,7 +76,7 @@
 		};
 	};
 
-	pci2: pcie@ffe0a000 {
+	pci0: pcie@ffe0a000 {
 		reg = <0 0xffe0a000 0 0x1000>;
 		ranges = <0x2000000 0x0 0xe0000000 0 0x80000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
diff --git a/arch/powerpc/boot/dts/p2020rdb-pc_36b.dts b/arch/powerpc/boot/dts/p2020rdb-pc_36b.dts
index b5a56ca..470247e 100644
--- a/arch/powerpc/boot/dts/p2020rdb-pc_36b.dts
+++ b/arch/powerpc/boot/dts/p2020rdb-pc_36b.dts
@@ -56,7 +56,7 @@
 		ranges = <0x0 0xf 0xffe00000 0x100000>;
 	};
 
-	pci0: pcie@fffe08000 {
+	pci2: pcie@fffe08000 {
 		reg = <0xf 0xffe08000 0 0x1000>;
 		status = "disabled";
 	};
@@ -76,7 +76,7 @@
 		};
 	};
 
-	pci2: pcie@fffe0a000 {
+	pci0: pcie@fffe0a000 {
 		reg = <0xf 0xffe0a000 0 0x1000>;
 		ranges = <0x2000000 0x0 0xe0000000 0xc 0x00000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc00000 0x0 0x10000>;
-- 
1.6.4
