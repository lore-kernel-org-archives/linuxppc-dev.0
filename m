Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id 4597867CAA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Oct 2006 14:18:55 +1000 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-embedded@ozlabs.org
Subject: [POWERPC] MPC52xx is a 6xx variant, remove PPC_52xx config option
Date: Wed, 25 Oct 2006 21:52:39 -0600
Message-Id: <11618347593934-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/Kconfig |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f9b11c1..6bff8b7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -126,11 +126,6 @@ config CLASSIC32
 	  systems, 64 bit IBM RS/6000 or an Apple G5, choose 6xx.
 	  Note that the kernel runs in 32-bit mode even on 64-bit chips.
 
-config PPC_52xx
-	bool "Freescale 52xx"
-	select 6xx
-	select PPC_FPU
-	
 config PPC_82xx
 	bool "Freescale 82xx"
 	select 6xx
-- 
1.4.3.rc2.g0503
