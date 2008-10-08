Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 89899DDFC4
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 06:59:44 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org
Subject: [PATCH] powerpc: remove default=y from PMAC and CHRP Kconfigs
Date: Wed,  8 Oct 2008 14:57:25 -0500
Message-Id: <1223495845-14149-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove the "default y" from the Kconfig options for CHRP, PMAC, and PMAC64
platforms.  This patch is a follow-up to "remove CHRP and PMAC support from
defconfigs, fix Kconfigs", which was applied incompletely.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Ben, in the future, please apply either all of my patch or none of it.
Applying half of my patch and "thinking about" the other half doesn't do me
any good.

 arch/powerpc/platforms/chrp/Kconfig     |    1 -
 arch/powerpc/platforms/powermac/Kconfig |    4 ----
 2 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/chrp/Kconfig b/arch/powerpc/platforms/chrp/Kconfig
index 22b4b4e..682afbc 100644
--- a/arch/powerpc/platforms/chrp/Kconfig
+++ b/arch/powerpc/platforms/chrp/Kconfig
@@ -9,4 +9,3 @@ config PPC_CHRP
 	select PPC_UDBG_16550
 	select PPC_NATIVE
 	select PCI
-	default y
diff --git a/arch/powerpc/platforms/powermac/Kconfig b/arch/powerpc/platforms/powermac/Kconfig
index 055990c..85619d3 100644
--- a/arch/powerpc/platforms/powermac/Kconfig
+++ b/arch/powerpc/platforms/powermac/Kconfig
@@ -6,7 +6,6 @@ config PPC_PMAC
 	select PPC_INDIRECT_PCI if PPC32
 	select PPC_MPC106 if PPC32
 	select PPC_NATIVE
-	default y
 
 config PPC_PMAC64
 	bool
@@ -16,6 +15,3 @@ config PPC_PMAC64
 	select MPIC_U3_HT_IRQS
 	select GENERIC_TBSYNC
 	select PPC_970_NAP
-	default y
-
-
-- 
1.5.5
