Return-Path: <opurdila@ixiacom.com>
Received: from ixro-ex1.ixiacom.com (unknown [92.87.192.98])
	by ozlabs.org (Postfix) with ESMTP id 043ECDDDB6
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 23:22:23 +1100 (EST)
From: Octavian Purdila <opurdila@ixiacom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 2/2] powerpc: oprofile: enable support for ppc750 processors
Date: Tue, 24 Feb 2009 14:09:59 +0200
Message-Id: <1235477399-20428-3-git-send-email-opurdila@ixiacom.com>
In-Reply-To: <1233724934.16867.290.camel@pasglop>
References: <1233724934.16867.290.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Octavian Purdila <opurdila@ixiacom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Octavian Purdila <opurdila@ixiacom.com>
---
 arch/powerpc/kernel/cputable.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 923f87a..4e20cfb 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -726,6 +726,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_750,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
+		.oprofile_cpu_type      = "ppc/7450",
+		.oprofile_type		= PPC_OPROFILE_G4,
 	},
 	{	/* 750FX rev 2.0 must disable HID0[DPM] */
 		.pvr_mask		= 0xffffffff,
@@ -741,6 +743,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_750,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
+		.oprofile_cpu_type      = "ppc/7450",
+		.oprofile_type		= PPC_OPROFILE_G4,
 	},
 	{	/* 750FX (All revs except 2.0) */
 		.pvr_mask		= 0xffff0000,
@@ -756,6 +760,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_750fx,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
+		.oprofile_cpu_type      = "ppc/7450",
+		.oprofile_type		= PPC_OPROFILE_G4,
 	},
 	{	/* 750GX */
 		.pvr_mask		= 0xffff0000,
-- 
1.5.6.5
