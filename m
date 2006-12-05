Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id 7E4D467BBD
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 11:29:29 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-dev@ozlabs.org,
	paulus@samba.org
Subject: [PATCH] [POWERPC] Remove obsolete PPC_52xx and update PPC_6xx comment
Date: Mon,  4 Dec 2006 17:29:13 -0700
Message-Id: <116527855527-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1165278553297-git-send-email-grant.likely@secretlab.ca>
References: <1165278553297-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/Kconfig |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 90efb0a..a75bccf 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -112,7 +112,7 @@ choice
 	default 6xx
 
 config CLASSIC32
-	bool "6xx/7xx/74xx"
+	bool "52xx/6xx/7xx/74xx"
 	select PPC_FPU
 	select 6xx
 	help
@@ -121,16 +121,18 @@ config CLASSIC32
 	  versions (821, 823, 850, 855, 860, 52xx, 82xx, 83xx), the AMCC
 	  embedded versions (403 and 405) and the high end 64 bit Power
 	  processors (POWER 3, POWER4, and IBM PPC970 also known as G5).
+
+	  This option is the catch-all for 6xx types, including some of the
+	  embedded versions.  Unless there is see an option for the specific
+	  chip family you are using, you want this option.
+	  
+	  You do not want this if you are building a kernel for a 64 bit
+	  IBM RS/6000 or an Apple G5, choose 6xx.
+	  
+	  If unsure, select this option
 	  
-	  Unless you are building a kernel for one of the embedded processor
-	  systems, 64 bit IBM RS/6000 or an Apple G5, choose 6xx.
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
