Return-Path: <a.othieno@bluewin.ch>
Received: from mail18.bluewin.ch (mail18.bluewin.ch [195.186.19.64])
	by ozlabs.org (Postfix) with ESMTP id CBCEC68110
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 09:45:20 +1000 (EST)
Date: Tue, 30 Aug 2005 19:45:17 -0400
To: akpm@osdl.org
Message-ID: <20050830234517.GC16375@mars>
References: <20050830233759.GA16375@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050830233759.GA16375@mars>
From: a.othieno@bluewin.ch (Arthur Othieno)
Cc: gc-linux-devel@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
Subject: [PATCH 2/2] ppc32: Add cputable entry for 750CXe DD2.4 ("Gekko")
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add a table entry for 750CXe DD2.4 ("Gekko") as found in the GameCube
from Nintendo:

  http://www-306.ibm.com/chips/techlib/techlib.nsf/techdocs/291C8D0EF3EAEC1687256B72005C745C#C1

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>


 cputable.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+)

diff -uprN a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- a/arch/ppc/kernel/cputable.c	2005-08-30 18:18:28.000000000 -0400
+++ b/arch/ppc/kernel/cputable.c	2005-08-30 19:21:15.000000000 -0400
@@ -240,6 +240,20 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_750cx
 	},
+	{	/* 750CXe "Gekko" (83214) */
+		.pvr_mask		= 0xffffffff,
+		.pvr_value		= 0x00083214,
+		.cpu_name		= "750CXe",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
+			CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
+			CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
+		.cpu_user_features	= COMMON_PPC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.cpu_setup		= __setup_cpu_750cx
+	},
 	{	/* 745/755 */
 		.pvr_mask		= 0xfffff000,
 		.pvr_value		= 0x00083000,
