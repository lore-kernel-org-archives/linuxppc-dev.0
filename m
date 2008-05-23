Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1EF95DE156
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 16:43:31 +1000 (EST)
Date: Fri, 23 May 2008 16:42:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: wim@iguana.be
Subject: [PATCH 12/12] mpc5200_wdt: use linux/of_platform.h instead of asm
Message-Id: <20080523164256.3cd3b613.sfr@canb.auug.org.au>
In-Reply-To: <20080523161627.a75d5010.sfr@canb.auug.org.au>
References: <20080523161627.a75d5010.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Domen Puncer <domen.puncer@telargo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/watchdog/mpc5200_wdt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/mpc5200_wdt.c b/drivers/watchdog/mpc5200_wdt.c
index 80a91d4..77c1c2a 100644
--- a/drivers/watchdog/mpc5200_wdt.c
+++ b/drivers/watchdog/mpc5200_wdt.c
@@ -4,7 +4,7 @@
 #include <linux/watchdog.h>
 #include <linux/io.h>
 #include <linux/spinlock.h>
-#include <asm/of_platform.h>
+#include <linux/of_platform.h>
 #include <asm/uaccess.h>
 #include <asm/mpc52xx.h>
 
-- 
1.5.5.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
