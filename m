Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6C5EA1007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 07:05:46 +1000 (EST)
Date: Wed, 18 May 2011 16:05:38 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH 7/7] powerpc/e5500: set MMU_FTR_USE_PAIRED_MAS
Message-ID: <20110518210538.GF29524@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20110518210453.GA29500@schlenkerla.am.freescale.net>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Is there any 64-bit book3e chip that doesn't support this?  It
doesn't appear to be optional in the ISA.

 arch/powerpc/kernel/cputable.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 34d2722..a3b8eeb 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1981,7 +1981,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_features		= CPU_FTRS_E5500,
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.mmu_features		= MMU_FTR_TYPE_FSL_E | MMU_FTR_BIG_PHYS |
-			MMU_FTR_USE_TLBILX,
+			MMU_FTR_USE_TLBILX | MMU_FTR_USE_PAIRED_MAS,
 		.icache_bsize		= 64,
 		.dcache_bsize		= 64,
 		.num_pmcs		= 4,
-- 
1.7.4.1
