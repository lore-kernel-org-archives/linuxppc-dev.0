Return-Path: <hrai@nmglablinux22.freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 26A732C008D
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2013 20:14:13 +1100 (EST)
Received: from mail72-am1 (localhost [127.0.0.1])	by mail72-am1-R.bigfish.com
 (Postfix) with ESMTP id 76EF442018A	for <linuxppc-dev@ozlabs.org>;
 Tue, 19 Feb 2013 09:14:08 +0000 (UTC)
Received: from AM1EHSMHS010.bigfish.com (unknown [10.3.201.227])	by
 mail72-am1.bigfish.com (Postfix) with ESMTP id D33BC4E003F	for
 <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2013 09:14:04 +0000 (UTC)
From: Harninder Rai <harninder.rai@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] bsc9131/dts: Correct typo in SDHC device node
Date: Tue, 19 Feb 2013 14:43:58 +0530
Message-ID: <1361265238-28100-1-git-send-email-harninder.rai@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Harninder Rai <harninder.rai@freescale.com>, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

BSC9131RDB doesn't have SDHC enabled. As a result of this typo,
the node was not getting disabled from the device tree which was
leading to linux hang during bootup

Signed-off-by: Harninder Rai <harninder.rai@freescale.com>
---
 arch/powerpc/boot/dts/bsc9131rdb.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/bsc9131rdb.dtsi b/arch/powerpc/boot/dts/bsc9131rdb.dtsi
index 638adda..9e6c013 100644
--- a/arch/powerpc/boot/dts/bsc9131rdb.dtsi
+++ b/arch/powerpc/boot/dts/bsc9131rdb.dtsi
@@ -126,7 +126,7 @@
 		};
 	};
 
-	sdhci@2e000 {
+	sdhc@2e000 {
 		status = "disabled";
 	};
 
-- 
1.7.6.GIT
