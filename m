Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id BAD86DDEDA
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 05:15:16 +1100 (EST)
Message-Id: <20071218175104.009469000@arndb.de>
References: <20071218174852.112644000@arndb.de>
Date: Tue, 18 Dec 2007 18:48:55 +0100
From: arnd@arndb.de
To: paulus@samba.org
Subject: [POWERPC 03/18] cell: add missing \n
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Two printk() calls were missing the terminating '\n'.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/spu_manage.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6-new/arch/powerpc/platforms/cell/spu_manage.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/spu_manage.c
+++ linux-2.6-new/arch/powerpc/platforms/cell/spu_manage.c
@@ -345,7 +345,7 @@ static int __init of_create_spu(struct s
 		}
 		ret = spu_map_interrupts_old(spu, spe);
 		if (ret) {
-			printk(KERN_ERR "%s: could not map interrupts",
+			printk(KERN_ERR "%s: could not map interrupts\n",
 				spu->name);
 			goto out_unmap;
 		}
@@ -525,7 +525,7 @@ static int __init init_affinity(void)
 		if (of_flat_dt_is_compatible(root, "IBM,CPBW-1.0"))
 			init_affinity_qs20_harcoded();
 		else
-			printk("No affinity configuration found");
+			printk("No affinity configuration found\n");
 	}
 
 	return 0;

-- 
