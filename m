Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 82F9C67ED5
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 09:30:54 +1100 (EST)
Date: Mon, 20 Nov 2006 16:30:50 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [POWERPC][PATCH 1/2] Revert "[POWERPC] Enable generic rtc hook for
	the MPC8349 mITX"
Message-Id: <20061120163050.1ce160b8.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: david-b@pacbell.net, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This reverts commit a8ed4f7ec3aa472134d7de6176f823b2667e450b.

As advised by David Brownell:

http://marc.theaimsgroup.com/?l=linux-kernel&m=116387226902131&w=2
---
 arch/powerpc/platforms/83xx/mpc834x_itx.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index e152d06..314c42a 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -108,10 +108,6 @@ static int __init mpc834x_itx_probe(void
 	return 1;
 }
 
-#ifdef CONFIG_RTC_CLASS
-late_initcall(rtc_class_hookup);
-#endif
-
 define_machine(mpc834x_itx) {
 	.name			= "MPC834x ITX",
 	.probe			= mpc834x_itx_probe,
-- 
1.4.2.3
