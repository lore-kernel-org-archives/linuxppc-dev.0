Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8NCb1jL6zDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 17:32:42 +1000 (AEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id u7A7Wc7P014435
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 02:32:39 -0500
Message-ID: <1470814358.3015.102.camel@kernel.crashing.org>
Subject: [PATCH] powerpc: Update obsolete comment in setup_32.c about
 early_init()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Wed, 10 Aug 2016 17:32:38 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We don't identify the machine type anymore...

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index c3e861d..f10a975 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -93,10 +93,8 @@ notrace unsigned long __init early_init(unsigned long dt_ptr)
  * and we are running with enough of the MMU enabled to have our
  * proper kernel virtual addresses
  *
- * Find out what kind of machine we're on and save any data we need
- * from the early boot process (devtree is copied on pmac by prom_init()).
- * This is called very early on the boot process, after a minimal
- * MMU environment has been set up but before MMU_init is called.
+ * We do the initial parsing of the flat device-tree and prepares
+ * for the MMU to be fully initialized.
  */
 extern unsigned int memset_nocache_branch; /* Insn to be replaced by NOP */
 
