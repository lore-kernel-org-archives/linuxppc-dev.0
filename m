Return-Path: <holger.brunck@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.1])
 by ozlabs.org (Postfix) with SMTP id 0A63DB6FAB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2012 00:08:34 +1000 (EST)
From: Holger Brunck <holger.brunck@keymile.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/4] powerpc/83xx: use for_each_node_by_name for km83xx.c
Date: Tue,  8 May 2012 15:57:19 +0200
Message-Id: <1336485442-24190-1-git-send-email-holger.brunck@keymile.com>
Cc: Heiko Schocher <hs@denx.de>, Holger Brunck <holger.brunck@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
cc: Heiko Schocher <hs@denx.de>
cc: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/83xx/km83xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index a266ba8..e827c6c 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -70,7 +70,7 @@ static void __init mpc83xx_km_setup_arch(void)
 		for_each_node_by_name(np, "spi")
 			par_io_of_config(np);
 
-		for (np = NULL; (np = of_find_node_by_name(np, "ucc")) != NULL;)
+		for_each_node_by_name(np, "ucc")
 			par_io_of_config(np);
 	}
 
-- 
1.7.1
