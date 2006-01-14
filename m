Return-Path: <grant@secretlab.ca>
Received: from localhost (S0106001346b91f0f.cg.shawcable.net [68.147.210.21])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B197E68A1B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Jan 2006 21:32:53 +1100 (EST)
Date: Sat, 14 Jan 2006 02:49:01 -0700
From: "Grant C. Likely" <grant.likely@secretlab.ca>
To: linuxppc-embedded@ozlabs.org, mporter@kernel.crashing.org,
	glikely@gmail.com
Subject: [PATCH 06/10] Add Virtex-4 FX to cpu table
Message-ID: <20060114094901.GA12787@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Signed-off-by: Grant C. Likely <grant.likely@secretlab.ca>

---

 arch/powerpc/kernel/cputable.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

a6e69dbf94b6864875e3239d21121402d9d58806
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 43c74a6..5268633 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -825,7 +825,7 @@ struct cpu_spec	cpu_specs[] = {
 		.dcache_bsize		= 32,
 	},
 	{	/* Xilinx Virtex-II Pro  */
-		.pvr_mask		= 0xffff0000,
+		.pvr_mask		= 0xfffff000,
 		.pvr_value		= 0x20010000,
 		.cpu_name		= "Virtex-II Pro",
 		.cpu_features		= CPU_FTRS_40X,
@@ -834,6 +834,16 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 	},
+	{	/* Xilinx Virtex-4 FX */
+		.pvr_mask		= 0xfffff000,
+		.pvr_value		= 0x20011000,
+		.cpu_name		= "Virtex-4 FX",
+		.cpu_features		= CPU_FTRS_40X,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+	},
 	{	/* 405EP */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x51210000,
-- 
1.1.2-g9e9b-dirty
