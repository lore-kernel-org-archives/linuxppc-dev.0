Return-Path: <galak@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 254BE67D76
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jul 2005 09:44:38 +1000 (EST)
Date: Tue, 26 Jul 2005 18:44:29 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0507261843440.9846@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Fix building of TQM8260 board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Added missing include of cpm2.h in correct order to allow TQM8260 to build

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 2fd8dd75c93a89c465a08d1d0085772cad225927
tree b322bf8a4e146fe7c88e39eac88bc923ac1a567e
parent ca451627946729719d17b7e6c1376ec273a501b5
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 26 Jul 2005 18:43:16 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 26 Jul 2005 18:43:16 -0500

 arch/ppc/platforms/tqm8260_setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/platforms/tqm8260_setup.c b/arch/ppc/platforms/tqm8260_setup.c
--- a/arch/ppc/platforms/tqm8260_setup.c
+++ b/arch/ppc/platforms/tqm8260_setup.c
@@ -16,8 +16,8 @@
 
 #include <linux/init.h>
 
-#include <asm/immap_cpm2.h>
 #include <asm/mpc8260.h>
+#include <asm/cpm2.h>
 #include <asm/machdep.h>
 
 static int
