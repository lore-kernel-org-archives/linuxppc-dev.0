Return-Path: <anton@ozlabs.org>
Date: Fri, 5 May 2006 05:44:26 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: add num_pmcs to 970MP cputable entry
Message-ID: <20060504194426.GA30251@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

The 970MP cputable entry needs a num_pmcs entry for oprofile to work.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 39e348a..f618ff4 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -230,6 +230,7 @@ struct cpu_spec	cpu_specs[] = {
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
+		.num_pmcs		= 8,
 		.cpu_setup		= __setup_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
