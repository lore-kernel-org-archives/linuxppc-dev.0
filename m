Return-Path: <b04825@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 7D0FC67D0E
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 04:07:37 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	kB7HM2dF028334
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 10:22:02 -0700 (MST)
From: timur@freescale.com
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Remove QE header files from lite5200.c
Date: Thu,  7 Dec 2006 11:07:32 -0600
Message-Id: <11655112521223-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Timur Tabi <timur@freescale.com>

The MPC 5200 does not have a QUICCEngine (QE), so lite5200.c should not 
include the QE header files.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/platforms/52xx/lite5200.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index a375c15..eaff71e 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -40,8 +40,6 @@ #include <asm/irq.h>
 #include <asm/prom.h>
 #include <asm/udbg.h>
 #include <sysdev/fsl_soc.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
 #include <asm/of_platform.h>
 
 #include <asm/mpc52xx.h>
-- 
1.4.2.1
