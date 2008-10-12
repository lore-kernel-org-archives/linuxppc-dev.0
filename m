Return-Path: <bigeasy@Chamillionaire.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 76CB9DDDFD
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 01:08:24 +1100 (EST)
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: reflect the used arguments in machine_init()
	prototype
Date: Sun, 12 Oct 2008 16:08:14 +0200
Message-Id: <1223820494-7822-3-git-send-email-sebastian@breakpoint.cc>
In-Reply-To: <1223820494-7822-1-git-send-email-sebastian@breakpoint.cc>
References: <1223820494-7822-1-git-send-email-sebastian@breakpoint.cc>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

phys arg isn't used. Kill it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/kernel/setup_32.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 1e0df16..c1a2762 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -111,7 +111,7 @@ notrace unsigned long __init early_init(unsigned long dt_ptr)
  * This is called very early on the boot process, after a minimal
  * MMU environment has been set up but before MMU_init is called.
  */
-notrace void __init machine_init(unsigned long dt_ptr, unsigned long phys)
+notrace void __init machine_init(unsigned long dt_ptr)
 {
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
-- 
1.5.6.5
