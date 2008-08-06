Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B1E2EDDF32
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 16:50:03 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m766nvp2028135
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 23:49:57 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m766nrIU000135
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Aug 2008 01:49:56 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH 2/6] powerpc: export cpm2_immr symbol for CPM2 drivers to
	compile as module
Date: Wed,  6 Aug 2008 15:04:41 +0800
Message-Id: <1218006285-27138-2-git-send-email-leoli@freescale.com>
In-Reply-To: <1218006285-27138-1-git-send-email-leoli@freescale.com>
References: <1218006285-27138-1-git-send-email-leoli@freescale.com>
Cc: Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/cpm2.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm2.c b/arch/powerpc/sysdev/cpm2.c
index f1c3395..021480e 100644
--- a/arch/powerpc/sysdev/cpm2.c
+++ b/arch/powerpc/sysdev/cpm2.c
@@ -52,6 +52,7 @@ cpm_cpm2_t __iomem *cpmp; /* Pointer to comm processor space */
  * the communication processor devices.
  */
 cpm2_map_t __iomem *cpm2_immr;
+EXPORT_SYMBOL(cpm2_immr);
 
 #define CPM_MAP_SIZE	(0x40000)	/* 256k - the PQ3 reserve this amount
 					   of space for CPM as it is larger
-- 
1.5.5.1.248.g4b17
