Return-Path: <galak@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 3F8A468346
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Sep 2005 12:33:24 +1000 (EST)
Date: Sun, 18 Sep 2005 21:33:18 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0509182132310.19665@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH][UPDATE] ppc32: Allow user to individual select
 CHRP/PMAC/PREP config
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Made the CHRP/PMAC/PREP config options selectable by the user.
This allows us to build kernels specifically for one of the
platforms thus reducing code size.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit f827bdb6363b826d34ede1790d37dd27c28d19b5
tree 40219a80fd22a02f292b5366d6209f3f57aa1c6c
parent 6c0741fbdee5bd0f8ed13ac287c4ab18e8ba7d83
author Kumar K. Gala <kumar.gala@freescale.com> Sun, 18 Sep 2005 21:31:54 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Sun, 18 Sep 2005 21:31:54 -0500

 arch/ppc/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -747,12 +747,12 @@ config CPM2
 	  on it (826x, 827x, 8560).
 
 config PPC_CHRP
-	bool
+	bool "  Common Hardware Reference Platform (CHRP) based machines"
 	depends on PPC_MULTIPLATFORM
 	default y
 
 config PPC_PMAC
-	bool
+	bool "  Apple PowerMac based machines"
 	depends on PPC_MULTIPLATFORM
 	default y
 
@@ -762,7 +762,7 @@ config PPC_PMAC64
 	default y
 
 config PPC_PREP
-	bool
+	bool "  PowerPC Reference Platform (PReP) based machines"
 	depends on PPC_MULTIPLATFORM
 	default y
 
