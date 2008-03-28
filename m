Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 447ECDE407
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 08:21:50 +1100 (EST)
Message-Id: <200803282121.m2SLLGkq010709@imap1.linux-foundation.org>
Subject: [patch 14/24] rapidio: add RapidIO node probing into MPC86xx_HPCN
	board id table
To: paulus@samba.org
From: akpm@linux-foundation.org
Date: Fri, 28 Mar 2008 14:21:16 -0700
Cc: akpm@linux-foundation.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Zhang Wei <wei.zhang@freescale.com>

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN arch/powerpc/platforms/86xx/mpc86xx_hpcn.c~rapidio-add-rapidio-node-probing-into-mpc86xx_hpcn-board-id-table arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c~rapidio-add-rapidio-node-probing-into-mpc86xx_hpcn-board-id-table
+++ a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -215,6 +215,7 @@ mpc86xx_time_init(void)
 
 static __initdata struct of_device_id of_bus_ids[] = {
 	{ .compatible = "simple-bus", },
+	{ .compatible = "fsl,rapidio-delta", },
 	{},
 };
 
_
