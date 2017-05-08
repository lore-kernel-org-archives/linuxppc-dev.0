Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wLslJ5mjDzDqFW
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 May 2017 16:18:52 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	mikey@neuling.org
Subject: [PATCH] powerpc/tm: Fix comment
Date: Mon,  8 May 2017 16:18:31 +1000
Message-Id: <20170508061831.4335-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update to real function name.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/tm.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index 3a2d04134d..c4ba37822b 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -313,8 +313,8 @@ dont_backup_fp:
 	blr
 
 
-	/* void tm_recheckpoint(struct thread_struct *thread,
-	 *			unsigned long orig_msr)
+	/* void __tm_recheckpoint(struct thread_struct *thread,
+	 *			  unsigned long orig_msr)
 	 *	- Restore the checkpointed register state saved by tm_reclaim
 	 *	  when we switch_to a process.
 	 *
-- 
2.11.0
