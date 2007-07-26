Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F4EEDDFB1
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 16:33:20 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 7/8] [POWERPC] Only allow building of BootX text support on
	PPC_MULTIPLATFORM
Date: Thu, 26 Jul 2007 01:32:38 -0500
Message-Id: <11854315691845-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

BootX text code is only supported on systems with real OF at this point
which is PPC_OF && PPC_MULTIPLATFORM.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Kconfig.debug |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 346cd3b..5c71624 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -134,7 +134,7 @@ config BDI_SWITCH
 
 config BOOTX_TEXT
 	bool "Support for early boot text console (BootX or OpenFirmware only)"
-	depends PPC_OF
+	depends PPC_OF && PPC_MULTIPLATFORM
 	help
 	  Say Y here to see progress messages from the boot firmware in text
 	  mode. Requires either BootX or Open Firmware.
-- 
1.5.2.2
