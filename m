Return-Path: <galak@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 784B1679E8
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Jun 2005 03:36:20 +1000 (EST)
Date: Wed, 1 Jun 2005 12:36:11 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0506011235330.1682@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Removed dependency on CONFIG_CPM2 for building
 mpc85xx_device.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Previously we needed CONFIG_CPM2 enabled to get the proper IRQ
ifdef's for CPM interrupts.  Recent changes have caused that to
be no longer necessary.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 22774efc1bef9f9a0fd9b34d44bf10da787e3d91
tree 115c991f9030418e78a7aa0f23d678d0141e0746
parent 6e7c21f278abb17a9bbdc6fd1f1b1b96e6677fdb
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 01 Jun 2005 12:34:30 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 01 Jun 2005 12:34:30 -0500

 arch/ppc/syslib/mpc85xx_devices.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/syslib/mpc85xx_devices.c b/arch/ppc/syslib/mpc85xx_devices.c
--- a/arch/ppc/syslib/mpc85xx_devices.c
+++ b/arch/ppc/syslib/mpc85xx_devices.c
@@ -321,7 +321,6 @@ struct platform_device ppc_sys_platform_
 			},
 		},
 	},
-#ifdef CONFIG_CPM2
 	[MPC85xx_CPM_FCC1] = {
 		.name = "fsl-cpm-fcc",
 		.id	= 1,
@@ -575,7 +574,6 @@ struct platform_device ppc_sys_platform_
 			},
 		},
 	},
-#endif /* CONFIG_CPM2 */
 	[MPC85xx_eTSEC1] = {
 		.name = "fsl-gianfar",
 		.id	= 1,
