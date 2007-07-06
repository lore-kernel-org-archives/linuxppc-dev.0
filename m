Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo3so.prod.shaw.ca (shawidc-mo1.cg.shawcable.net
	[24.71.223.10]) by ozlabs.org (Postfix) with ESMTP id 89B03DE063
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2007 09:29:19 +1000 (EST)
Received: from pd2mr1so.prod.shaw.ca
	(pd2mr1so-qfe3.prod.shaw.ca [10.0.141.110]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JKS001PC3SRIVC0@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 06 Jul 2007 16:29:15 -0600 (MDT)
Received: from pn2ml4so.prod.shaw.ca ([10.0.121.148])
	by pd2mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JKS002PZ3SOV5U0@pd2mr1so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 06 Jul 2007 16:29:13 -0600 (MDT)
Received: from trillian.secretlab.ca ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JKS00CJE3SNRBU1@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 06 Jul 2007 16:29:11 -0600 (MDT)
Date: Fri, 06 Jul 2007 16:29:09 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] Add USB support to mpc8349-mitx board port
To: paulus@samba.org, linuxppc-dev@ozlabs.org, galak@kernel.crashing.org,
	leoli@freescale.com, kim.phillips@freescale.com
Message-id: <20070706222909.19943.39455.stgit@trillian.secretlab.ca>
Content-type: text/plain; charset=utf-8; format=fixed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This patch depends on Li Yang's patch: "83xx USB platform code rework"

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/83xx/mpc834x_itx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index 40a0194..1ace7ac 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -63,6 +63,8 @@ static void __init mpc834x_itx_setup_arch(void)
 
 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
+
+	mpc834x_usb_cfg();
 }
 
 static void __init mpc834x_itx_init_IRQ(void)
