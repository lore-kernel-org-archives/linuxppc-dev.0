Return-Path: <r66093@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D29EFB6FED
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2011 18:45:44 +1100 (EST)
Received: from mail73-ch1 (localhost [127.0.0.1])	by mail73-ch1-R.bigfish.com
 (Postfix) with ESMTP id BE5B54002CB	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 20 Dec 2011 07:45:55 +0000 (UTC)
Received: from CH1EHSMHS005.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.251])	by mail73-ch1.bigfish.com (Postfix) with ESMTP id
 9966146004A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2011 07:45:55 +0000 (UTC)
From: <r66093@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/mpc85xx: 32bit address support for p1022ds
Date: Tue, 20 Dec 2011 14:58:26 +0800
Message-ID: <1324364306-20176-1-git-send-email-r66093@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

All features for p1022ds are based on the 32bit address, 36bit only optional.
We should make the PHYS_64BIT optional, remove the 'select PHYS_64BIT'
from the Kconfig file in order to support 32bit address for P1022DS platform.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
---
 arch/powerpc/platforms/85xx/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 8f0543f..d58987f 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -80,7 +80,6 @@ config P1010_RDB
 config P1022_DS
 	bool "Freescale P1022 DS"
 	select DEFAULT_UIMAGE
-	select PHYS_64BIT	# The DTS has 36-bit addresses
 	select SWIOTLB
 	help
 	  This option enables support for the Freescale P1022DS reference board.
-- 
1.7.4.1
