Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9A08DE671
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 08:10:39 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m6VMAPXJ014261
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 17:10:25 -0500
Date: Thu, 31 Jul 2008 17:10:25 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix whitespace merge in mpc8641 hpcn device tree
Message-ID: <Pine.LNX.4.64.0807311709530.10954@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When we coverted the .dts to v1 we lost a space between the irq
and its polarity/sense information.  This causes a bit of chaos
as the reset of the blob is off by one cell.

This was noticed by booting and getting errors w/ATA due to
lock of interrupts.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

in my for-2.6.27 branch

 arch/powerpc/boot/dts/mpc8641_hpcn.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index ae08761..d665e76 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -411,7 +411,7 @@
 			0xe000 0 0 1 &i8259 12 2
 			0xe100 0 0 2 &i8259 9 2
 			0xe200 0 0 3 &i8259 10 2
-			0xe300 0 0 4 &i8259 112
+			0xe300 0 0 4 &i8259 11 2

 			// IDSEL 0x1d  Audio
 			0xe800 0 0 1 &i8259 6 2
-- 
1.5.5.1
