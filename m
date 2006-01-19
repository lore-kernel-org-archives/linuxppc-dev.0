Return-Path: <grant@secretlab.ca>
Received: from localhost.secretlab.ca (S0106001346b91f0f.cg.shawcable.net
	[68.147.210.21]) by ozlabs.org (Postfix) with ESMTP id 0EAE168A19
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Jan 2006 19:13:21 +1100 (EST)
Date: Thu, 19 Jan 2006 01:13:20 -0700
From: "Grant C. Likely" <grant.likely@secretlab.ca>
To: linuxppc-embedded@ozlabs.org, akonovalov@ru.mvista.com,
	peter.ryser@xilinx.com
Subject: [PATCH 6/9] Add Virtex-4 FX to cpu table
Message-ID: <20060119081320.GA24919@weasley-twins.secretlab.ca>
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

68d663762e61cbe9c1a9ab170e5288f44d1721f1
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 1069645..3191be7 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -891,7 +891,7 @@ struct cpu_spec	cpu_specs[] = {
 		.platform		= "ppc405",
 	},
 	{	/* Xilinx Virtex-II Pro  */
-		.pvr_mask		= 0xffff0000,
+		.pvr_mask		= 0xfffff000,
 		.pvr_value		= 0x20010000,
 		.cpu_name		= "Virtex-II Pro",
 		.cpu_features		= CPU_FTRS_40X,
@@ -901,6 +901,16 @@ struct cpu_spec	cpu_specs[] = {
 		.dcache_bsize		= 32,
 		.platform		= "ppc405",
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
1.1.GIT
