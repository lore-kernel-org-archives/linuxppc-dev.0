Return-Path: <jotken@softadvances.com>
Received: from elasmtp-spurfowl.atl.sa.earthlink.net
	(elasmtp-spurfowl.atl.sa.earthlink.net [209.86.89.66])
	by ozlabs.org (Postfix) with ESMTP id 568FC679A6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 May 2006 08:40:46 +1000 (EST)
Message-ID: <445FC705.4060208@softadvances.com>
Date: Mon, 08 May 2006 17:32:37 -0500
From: John Otken <jotken@softadvances.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] Add PVR for new Rev C 440EP
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stefan Roese <sr@denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Here's a patch to add the PVR for the AMCC 440EP Rev C:



diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index e4e8137..a2967b6 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -938,6 +938,16 @@ struct cpu_spec	cpu_specs[] = {
  		.dcache_bsize		= 32,
  		.platform		= "ppc440",
  	},
+	{
+		.pvr_mask		= 0xf0000fff,
+		.pvr_value		= 0x400008d4,
+		.cpu_name		= "440EP Rev. C",
+		.cpu_features		= CPU_FTRS_44X,
+		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.platform		= "ppc440",
+	},
  	{	/* 440GP Rev. B */
  		.pvr_mask		= 0xf0000fff,
  		.pvr_value		= 0x40000440,
