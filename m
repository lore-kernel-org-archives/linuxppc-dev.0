Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 77677DE31B
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 23:40:48 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5] powerpc: Remove Kconfig PPC_CPM_NEW_BINDING
Date: Thu, 12 Jun 2008 08:40:34 -0500
Message-Id: <1213278034-28552-6-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1213278034-28552-5-git-send-email-galak@kernel.crashing.org>
References: <1213278034-28552-1-git-send-email-galak@kernel.crashing.org>
	<1213278034-28552-2-git-send-email-galak@kernel.crashing.org>
	<1213278034-28552-3-git-send-email-galak@kernel.crashing.org>
	<1213278034-28552-4-git-send-email-galak@kernel.crashing.org>
	<1213278034-28552-5-git-send-email-galak@kernel.crashing.org>
Cc: scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With arch/ppc gone and all in kernel users of CONFIG_PPC_CPM_NEW_BINDING
fixed up we dont have need for the Kconfig option anymore.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/Kconfig |    1 -
 arch/powerpc/platforms/Kconfig      |    5 -----
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 91d67ee..5627a4e 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -79,7 +79,6 @@ config TQM8548
 	help
 	  This option enables support for the TQ Components TQM8548 board.
 	select DEFAULT_UIMAGE
-	select PPC_CPM_NEW_BINDING
 	select TQM85xx
 
 config TQM8555
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 87454c5..10efaf8 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -286,11 +286,6 @@ config CPM2
 	  you wish to build a kernel for a machine with a CPM2 coprocessor
 	  on it (826x, 827x, 8560).
 
-config PPC_CPM_NEW_BINDING
-	bool
-	depends on CPM1 || CPM2
-	default y
-
 config AXON_RAM
 	tristate "Axon DDR2 memory device driver"
 	depends on PPC_IBM_CELL_BLADE
-- 
1.5.5.1
