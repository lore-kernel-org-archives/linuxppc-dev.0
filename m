Return-Path: <SRS0=9EYR=PC=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 8AB7EDDF1D
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 19:12:36 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] [POWERPC] Add AMCC 405EX support to cputable.c
Date: Mon, 8 Oct 2007 11:07:26 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200710081107.26634.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/kernel/cputable.c |   11 +++++++++++
 1 files changed, 11 insertions(+)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index b03a442..ea81d1e 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1103,6 +1103,17 @@ static struct cpu_spec cpu_specs[] = {
 		.dcache_bsize		= 32,
 		.platform		= "ppc405",
 	},
+	{	/* 405EX */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x12910000,
+		.cpu_name		= "405EX",
+		.cpu_features		= CPU_FTRS_40X,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.platform		= "ppc405",
+	},
 
 #endif /* CONFIG_40x */
 #ifdef CONFIG_44x
-- 
1.5.3.4
