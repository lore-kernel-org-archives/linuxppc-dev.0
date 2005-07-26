Return-Path: <galak@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 63ABA67C5A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Jul 2005 15:17:14 +1000 (EST)
Date: Tue, 26 Jul 2005 00:17:08 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0507260016250.7138@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Fix building of prpmc750
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Updated prpmc750 platform code to include serial_reg.h to fix building.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit c6d47b85a4f5743a0328ab6388a085744e00ac48
tree 41a83749e10e4dc70feefcd75396c8c5385b8fb1
parent dc5a25603c1f8984f10f9e93d91b4d95b2ce6d9d
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 26 Jul 2005 00:12:37 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 26 Jul 2005 00:12:37 -0500

 arch/ppc/platforms/prpmc750.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/platforms/prpmc750.c b/arch/ppc/platforms/prpmc750.c
--- a/arch/ppc/platforms/prpmc750.c
+++ b/arch/ppc/platforms/prpmc750.c
@@ -29,6 +29,7 @@
 #include <linux/ide.h>
 #include <linux/root_dev.h>
 #include <linux/slab.h>
+#include <linux/serial_reg.h>
 
 #include <asm/byteorder.h>
 #include <asm/system.h>
