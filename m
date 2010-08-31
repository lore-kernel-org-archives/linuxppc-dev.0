Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 66241B70FC
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:15:27 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: Linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/3] PPC: Fix compilation of mpc85xx_mds.c
Date: Tue, 31 Aug 2010 04:15:22 +0200
Message-Id: <1283220922-20369-4-git-send-email-agraf@suse.de>
In-Reply-To: <1283220922-20369-1-git-send-email-agraf@suse.de>
References: <1283220922-20369-1-git-send-email-agraf@suse.de>
Cc: Anton Vorontsov <avorontsov@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 99d8238f berobbed the for_each loop of its iterator! Let's be
nice and give it back, so it compiles for us.

CC: Anton Vorontsov <avorontsov@mvista.com>
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index da64be1..aa34cac 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -357,6 +357,7 @@ static void __init mpc85xx_mds_setup_arch(void)
 {
 #ifdef CONFIG_PCI
 	struct pci_controller *hose;
+	struct device_node *np;
 #endif
 	dma_addr_t max = 0xffffffff;
 
-- 
1.6.0.2
