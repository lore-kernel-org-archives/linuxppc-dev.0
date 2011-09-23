Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1CA79B6F85
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 24 Sep 2011 05:33:03 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: Kumar Gala <galak@kernel.crashing.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/85xx: fix PHYS_64BIT selection for P1022DS
Date: Fri, 23 Sep 2011 21:32:50 +0200
Message-Id: <1316806370-21067-1-git-send-email-agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove wrong CONFIG_ prefix in Kconfig file.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/platforms/85xx/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 1b393f4..b29d4f2 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -80,7 +80,7 @@ config P1010_RDB
 config P1022_DS
 	bool "Freescale P1022 DS"
 	select DEFAULT_UIMAGE
-	select CONFIG_PHYS_64BIT	# The DTS has 36-bit addresses
+	select PHYS_64BIT	# The DTS has 36-bit addresses
 	select SWIOTLB
 	help
 	  This option enables support for the Freescale P1022DS reference board.
-- 
1.7.1
