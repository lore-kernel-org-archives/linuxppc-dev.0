Return-Path: <jdl@jdl.com>
Received: from jdl.com (mail.jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F1B5367BB0
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Jun 2006 08:52:46 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.44)
	id 1Frjei-0004Oq-Ot
	for linuxppc-dev@ozlabs.org; Sat, 17 Jun 2006 17:52:43 -0500
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/9 v3] Add 8641 CPU table entry.
Date: Sat, 17 Jun 2006 17:52:40 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Frjei-0004Oq-Ot@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Wei Zhang <Wei.Zhang@freescale.com>
Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>

---

 arch/powerpc/kernel/cputable.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index abf7d42..1c11488 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -722,6 +722,18 @@ #if CLASSIC_PPC
 		.oprofile_type		= PPC_OPROFILE_G4,
 		.platform		= "ppc7450",
 	},
+        {       /* 8641 */
+               .pvr_mask               = 0xffffffff,
+               .pvr_value              = 0x80040010,
+               .cpu_name               = "8641",
+               .cpu_features           = CPU_FTRS_7447A,
+               .cpu_user_features      = COMMON_USER | PPC_FEATURE_HAS_ALTIVEC_COMP,
+               .icache_bsize           = 32,
+               .dcache_bsize           = 32,
+               .num_pmcs               = 6,
+               .cpu_setup              = __setup_cpu_745x
+        },
+
 	{	/* 82xx (8240, 8245, 8260 are all 603e cores) */
 		.pvr_mask		= 0x7fff0000,
 		.pvr_value		= 0x00810000,
