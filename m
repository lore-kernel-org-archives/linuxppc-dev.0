Return-Path: <ericvh@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E59F9B6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 07:25:13 +1000 (EST)
Received: by yxp4 with SMTP id 4so780924yxp.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 May 2011 14:25:10 -0700 (PDT)
From: Eric Van Hensbergen <ericvh@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] [RFC] add bluegene entry to cputable
Date: Wed, 18 May 2011 16:24:50 -0500
Message-Id: <1305753895-24845-2-git-send-email-ericvh@gmail.com>
In-Reply-To: <1305753895-24845-1-git-send-email-ericvh@gmail.com>
References: <1305753895-24845-1-git-send-email-ericvh@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, bg-linux@lists.anl-external.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>
---
 arch/powerpc/kernel/cputable.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index b9602ee..0eb245e 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1732,6 +1732,20 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
+	{ /* Blue Gene/P */
+		.pvr_mask		= 0xfffffff0,
+		.pvr_value		= 0x52131880,
+		.cpu_name		= "450 Blue Gene/P",
+		.cpu_features		= CPU_FTRS_440x6,
+		.cpu_user_features	= COMMON_USER_BOOKE |
+						PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_44x,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_460gt,
+		.machine_check		= machine_check_440A,
+		.platform		= "ppc440",
+	},
 	{ /* 460EX */
 		.pvr_mask		= 0xffff0006,
 		.pvr_value		= 0x13020002,
-- 
1.7.4.1
