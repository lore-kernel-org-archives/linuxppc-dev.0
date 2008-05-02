Return-Path: <afleming@ld0175-tx32.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 91D30DE0EE
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 04:03:28 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m42I3Nuq012800
	for <linuxppc-dev@ozlabs.org>; Fri, 2 May 2008 11:03:24 -0700 (MST)
Received: from ld0175-tx32.am.freescale.net (ld0175-tx32.am.freescale.net
	[10.82.19.125])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m42I3M2R014176
	for <linuxppc-dev@ozlabs.org>; Fri, 2 May 2008 13:03:23 -0500 (CDT)
From: Andy Fleming <afleming@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH v2.6.26] 85xx: Fix some sparse warnings for 85xx MDS
Date: Fri,  2 May 2008 13:03:22 -0500
Message-Id: <1209751402-25586-1-git-send-email-afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Andy Fleming <afleming@freescale.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 25f8bc7..12f68ab 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -64,7 +64,7 @@
 static void __init mpc85xx_mds_setup_arch(void)
 {
 	struct device_node *np;
-	static u8 *bcsr_regs = NULL;
+	static u8 __iomem *bcsr_regs = NULL;
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_mds_setup_arch()", 0);
-- 
1.5.4.GIT
