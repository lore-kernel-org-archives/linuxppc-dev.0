Return-Path: <grant.likely@secretlab.ca>
Received: from localhost.localdomain (S0106001346b91f0f.cg.shawcable.net
	[68.147.210.21]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD29D689EB
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Jan 2006 19:33:09 +1100 (EST)
In-Reply-To: <11367955793438-git-send-email-grant.likely@secretlab.ca>
Date: Mon, 9 Jan 2006 01:33:00 -0700
Message-Id: <11367955801305-git-send-email-grant.likely@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: glikely@gmail.com, mporter@kernel.crashing.org,
	linuxppc-embedded@ozlabs.org, gnathita@gmail.com, dhlii@dlasys.net
From: grant.likely@secretlab.ca
Subject: [PATCH 05/10] Add Virtex-4 FX to cpu table
Reply-To: grant.likely@secretlab.ca
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

d088bba0280dacb277ec257287a83fec30b6be28
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 1d85ced..3992c42 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -829,7 +829,7 @@ struct cpu_spec	cpu_specs[] = {
 		.dcache_bsize		= 32,
 	},
 	{	/* Xilinx Virtex-II Pro  */
-		.pvr_mask		= 0xffff0000,
+		.pvr_mask		= 0xfffff000,
 		.pvr_value		= 0x20010000,
 		.cpu_name		= "Virtex-II Pro",
 		.cpu_features		= CPU_FTRS_40X,
@@ -838,6 +838,16 @@ struct cpu_spec	cpu_specs[] = {
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
1.0.6-g58e3
