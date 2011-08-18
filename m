Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 24CE5B6EE8
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Aug 2011 04:12:16 +1000 (EST)
Received: from mail23-db3 (localhost.localdomain [127.0.0.1])	by
	mail23-db3-R.bigfish.com (Postfix) with ESMTP id 9E46C4D81DD	for
	<linuxppc-dev@ozlabs.org>; Thu, 18 Aug 2011 18:12:11 +0000 (UTC)
Received: from DB3EHSMHS009.bigfish.com (unknown [10.3.81.244])	by
	mail23-db3.bigfish.com (Postfix) with ESMTP id 7B0D6185804C	for
	<linuxppc-dev@ozlabs.org>; Thu, 18 Aug 2011 18:12:11 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/85xx: remove left-over printks in p1022_ds.c
Date: Thu, 18 Aug 2011 14:12:06 -0400
Message-ID: <1313691126-6906-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Two debugging prinkts were accidentally included in the last patch to
arch/powerpc/platforms/85xx/p1022_ds.c.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/platforms/85xx/p1022_ds.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index a13d3cc..9d5dd8c 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -147,13 +147,11 @@ static void p1022ds_set_monitor_port(enum fsl_diu_monitor_port port)
 
 	switch (port) {
 	case FSL_DIU_PORT_DVI:
-		printk(KERN_INFO "%s:%u\n", __func__, __LINE__);
 		/* Enable the DVI port, disable the DFP and the backlight */
 		clrsetbits_8(brdcfg1, PX_BRDCFG1_DFPEN | PX_BRDCFG1_BACKLIGHT,
 			     PX_BRDCFG1_DVIEN);
 		break;
 	case FSL_DIU_PORT_LVDS:
-		printk(KERN_INFO "%s:%u\n", __func__, __LINE__);
 		/* Enable the DFP port, disable the DVI and the backlight */
 		clrsetbits_8(brdcfg1, PX_BRDCFG1_DVIEN | PX_BRDCFG1_BACKLIGHT,
 			     PX_BRDCFG1_DFPEN);
-- 
1.7.4.4
