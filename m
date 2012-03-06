Return-Path: <B35336@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EA6C3B6FC3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 20:05:04 +1100 (EST)
Received: from mail11-tx2 (localhost [127.0.0.1])	by mail11-tx2-R.bigfish.com
 (Postfix) with ESMTP id AB99680091	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Mar 2012 09:05:00 +0000 (UTC)
Received: from TX2EHSMHS035.bigfish.com (unknown [10.9.14.252])	by
 mail11-tx2.bigfish.com (Postfix) with ESMTP id B3F4C40004C	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 09:04:58 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 7/9] powerpc/mpc8548cds: fix alias in mpc8548si-pre.dtsi
Date: Tue, 6 Mar 2012 17:06:43 +0800
Message-ID: <1331024805-15926-6-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1331024805-15926-1-git-send-email-chenhui.zhao@freescale.com>
References: <1331024805-15926-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Correct ethernet1 and add ethernet2 and ethernet3.

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/boot/dts/fsl/mpc8548si-pre.dtsi |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/mpc8548si-pre.dtsi b/arch/powerpc/boot/dts/fsl/mpc8548si-pre.dtsi
index 289f121..720422d 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8548si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8548si-pre.dtsi
@@ -43,7 +43,9 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		ethernet0 = &enet0;
-		ethernet1 = &enet2;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
-- 
1.6.4.1
