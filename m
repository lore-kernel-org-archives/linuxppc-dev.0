Return-Path: <anton@ozlabs.org>
Date: Sat, 25 Mar 2006 17:31:30 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Compile warning in hvcs driver
Message-ID: <20060325063130.GV30422@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


We ended up with an unused variable after the tty updates went in. Fix it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/drivers/char/hvcs.c
===================================================================
--- build.orig/drivers/char/hvcs.c	2006-03-25 16:26:57.000000000 +1100
+++ build/drivers/char/hvcs.c	2006-03-25 16:27:10.000000000 +1100
@@ -439,7 +439,6 @@ static int hvcs_io(struct hvcs_struct *h
 	char buf[HVCS_BUFF_LEN] __ALIGNED__;
 	unsigned long flags;
 	int got = 0;
-	int i;
 
 	spin_lock_irqsave(&hvcsd->lock, flags);
 
