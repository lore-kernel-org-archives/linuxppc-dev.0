Return-Path: <joe@perches.com>
Received: from perches.com (DSL022.labridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id B4626DDDE4
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 12:49:00 +1100 (EST)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 04/59] arch/ppc: Add missing "space"
Date: Mon, 19 Nov 2007 17:47:56 -0800
Message-Id: <1195523331-15303-5-git-send-email-joe@perches.com>
In-Reply-To: <1195523331-15303-4-git-send-email-joe@perches.com>
References: 1234567 <1195523331-15303-1-git-send-email-joe@perches.com>
	<1195523331-15303-2-git-send-email-joe@perches.com>
	<1195523331-15303-3-git-send-email-joe@perches.com>
	<1195523331-15303-4-git-send-email-joe@perches.com>
Message-Id: <351afce2b8242a88389176a36d5bf75935385fdd.1195454434.git.joe@perches.com>
In-Reply-To: <ee1678e1bc8b80b7ae420059fffc7241486ea91a.1195454434.git.joe@perches.com>
References: <ee1678e1bc8b80b7ae420059fffc7241486ea91a.1195454434.git.joe@perches.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/ppc/platforms/ev64260.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/platforms/ev64260.c b/arch/ppc/platforms/ev64260.c
index 976270d..c1f77e1 100644
--- a/arch/ppc/platforms/ev64260.c
+++ b/arch/ppc/platforms/ev64260.c
@@ -336,7 +336,7 @@ ev64260_early_serial_map(void)
 #endif
 
 		if (early_serial_setup(&port) != 0)
-			printk(KERN_WARNING "Early serial init of port 0"
+			printk(KERN_WARNING "Early serial init of port 0 "
 				"failed\n");
 
 		first_time = 0;
@@ -388,7 +388,7 @@ ev64260_setup_arch(void)
 	ev64260_early_serial_map();
 #endif
 
-	printk(KERN_INFO "%s %s port (C) 2001 MontaVista Software, Inc."
+	printk(KERN_INFO "%s %s port (C) 2001 MontaVista Software, Inc. "
 		"(source@mvista.com)\n", BOARD_VENDOR, BOARD_MACHINE);
 
 	if (ppc_md.progress)
-- 
1.5.3.5.652.gf192c
