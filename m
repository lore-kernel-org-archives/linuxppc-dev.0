Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EBE0CE0342
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 05:29:27 +1000 (EST)
Date: Wed, 5 Sep 2007 14:29:17 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 07/10] mpc82xx: Rename mpc82xx_ads to mpc8272_ads.
Message-ID: <20070905192917.GF32462@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905192841.GA32441@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is just a rename patch; internal references to mpc82xx_ads will be
changed in the next one.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/82xx/Kconfig                |    8 ++++----
 arch/powerpc/platforms/82xx/Makefile               |    2 +-
 .../82xx/{mpc82xx_ads.c => mpc8272_ads.c}          |    0 
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename arch/powerpc/platforms/82xx/{mpc82xx_ads.c => mpc8272_ads.c} (100%)

diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/platforms/82xx/Kconfig
index 89fde43..f260c01 100644
--- a/arch/powerpc/platforms/82xx/Kconfig
+++ b/arch/powerpc/platforms/82xx/Kconfig
@@ -1,17 +1,17 @@
 choice
 	prompt "82xx Board Type"
 	depends on PPC_82xx
-	default MPC82xx_ADS
+	default MPC8272_ADS
 
-config MPC82xx_ADS
-	bool "Freescale MPC82xx ADS"
+config MPC8272_ADS
+	bool "Freescale MPC8272 ADS"
 	select DEFAULT_UIMAGE
 	select PQ2ADS
 	select 8272
 	select 8260
 	select FSL_SOC
 	help
-	This option enables support for the MPC8272 ADS board
+	  This option enables support for the MPC8272 ADS board
 
 endchoice
 
diff --git a/arch/powerpc/platforms/82xx/Makefile b/arch/powerpc/platforms/82xx/Makefile
index 534c353..9b7c851 100644
--- a/arch/powerpc/platforms/82xx/Makefile
+++ b/arch/powerpc/platforms/82xx/Makefile
@@ -1,4 +1,4 @@
 #
 # Makefile for the PowerPC 82xx linux kernel.
 #
-obj-$(CONFIG_MPC82xx_ADS) += mpc82xx_ads.o
+obj-$(CONFIG_MPC8272_ADS) += mpc8272_ads.o
diff --git a/arch/powerpc/platforms/82xx/mpc82xx_ads.c b/arch/powerpc/platforms/82xx/mpc8272_ads.c
similarity index 100%
rename from arch/powerpc/platforms/82xx/mpc82xx_ads.c
rename to arch/powerpc/platforms/82xx/mpc8272_ads.c
-- 
1.5.3
