Return-Path: <linnj@wolfgang-pc.public.xilinx.com>
Received: from IE1EHSOBE002.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 237CEDE4CA
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 02:42:16 +1000 (EST)
From: John Linn <john.linn@xilinx.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Xilinx: adding Xilinx 440 cpu support
Date: Tue, 1 Jul 2008 09:42:07 -0700
Message-ID: <20080701164211.6B71B1B70058@mail110-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following change updates the cputable to support the
440 processor in the Xilinx Virtex5 FXT FPGA.

Signed-off-by: John Linn <john.linn@xilinx.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/kernel/cputable.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index e44d553..ae3660b 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1410,6 +1410,16 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
+	{ /* 440 in Xilinx Virtex-5 FXT */
+		.pvr_mask		= 0xfffffff0,
+		.pvr_value		= 0x7ff21910,
+		.cpu_name		= "440 in Virtex-5 FXT",
+		.cpu_features		= CPU_FTRS_44X,
+		.cpu_user_features	= COMMON_USER_BOOKE,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.platform		= "ppc440",
+	},
 	{ /* 460EX */
 		.pvr_mask		= 0xffff0002,
 		.pvr_value		= 0x13020002,
-- 
1.5.2.1



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
