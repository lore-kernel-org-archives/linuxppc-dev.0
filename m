Return-Path: <galak@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id A2F3967A72
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Mar 2005 02:33:40 +1000 (EST)
Date: Tue, 29 Mar 2005 10:33:25 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0503291027540.15390@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Fix MPC8555 & MPC8555E device lists
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrew,

Removed the FCC3 device from the lists of devices on MPC8555 & MPC8555E 
since it does not exist on these processors.

Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

diff -Nru a/arch/ppc/syslib/mpc85xx_sys.c b/arch/ppc/syslib/mpc85xx_sys.c
--- a/arch/ppc/syslib/mpc85xx_sys.c	2005-03-29 10:26:41 -06:00
+++ b/arch/ppc/syslib/mpc85xx_sys.c	2005-03-29 10:26:41 -06:00
@@ -88,7 +88,7 @@
 			MPC85xx_PERFMON, MPC85xx_DUART,
 			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C, MPC85xx_CPM_SCC1,
 			MPC85xx_CPM_SCC2, MPC85xx_CPM_SCC3,
-			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2, MPC85xx_CPM_FCC3,
+			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2,
 			MPC85xx_CPM_SMC1, MPC85xx_CPM_SMC2,
 			MPC85xx_CPM_USB,
 		},
@@ -105,7 +105,7 @@
 			MPC85xx_PERFMON, MPC85xx_DUART, MPC85xx_SEC2,
 			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C, MPC85xx_CPM_SCC1,
 			MPC85xx_CPM_SCC2, MPC85xx_CPM_SCC3,
-			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2, MPC85xx_CPM_FCC3,
+			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2,
 			MPC85xx_CPM_SMC1, MPC85xx_CPM_SMC2,
 			MPC85xx_CPM_USB,
 		},
