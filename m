Return-Path: <jwboyer@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.232])
	by ozlabs.org (Postfix) with ESMTP id 0F0A6DE6B7
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 23:38:27 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id s6so234303wxc.15
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 05:38:26 -0700 (PDT)
Message-Id: <e380d3eb20ec0791a9a07ce8c102b5ea5953fec9.1223642006.git.jwboyer@linux.vnet.ibm.com>
In-Reply-To: <cover.1223642006.git.jwboyer@linux.vnet.ibm.com>
References: <cover.1223642006.git.jwboyer@linux.vnet.ibm.com>
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Date: Thu, 9 Oct 2008 08:56:38 -0400
Subject: [PATCH 3/5] powerpc/40x: Add AMCC PowerPC 405EZ to cputable
To: linuxppc-dev@ozlabs.org
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds the AMCC PowerPC 405EZ chip to the cputable

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/cputable.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index e70d048..b1eb834 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1277,6 +1277,19 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_4xx,
 		.platform		= "ppc405",
 	},
+	{
+		/* 405EZ */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x41510000,
+		.cpu_name		= "405EZ",
+		.cpu_features		= CPU_FTRS_40X,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
+		.platform		= "ppc405",
+	},
 	{	/* default match */
 		.pvr_mask		= 0x00000000,
 		.pvr_value		= 0x00000000,
-- 
1.5.5.1
