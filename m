Return-Path: <moilanen@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B641567C24
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 05:29:44 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k93JTfUv001750
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Oct 2006 15:29:41 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k93JTeXv304074
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Oct 2006 13:29:40 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k93JTeBP003363
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Oct 2006 13:29:40 -0600
Subject: [PATCH] 750CL cputable entry
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 14:29:34 -0500
Message-Id: <1159903774.4997.202.camel@goblue>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

750CL cputable entry from Steve Winiecki.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

 arch/powerpc/kernel/cputable.c |   12 ++++++++++++
 1 files changed, 12 insertions(+)

Index: merge/arch/powerpc/kernel/cputable.c
===================================================================
--- merge.orig/arch/powerpc/kernel/cputable.c
+++ merge/arch/powerpc/kernel/cputable.c
@@ -466,6 +466,18 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_750cx,
 		.platform		= "ppc750",
 	},
+	{	/* 750CL */
+		.pvr_mask		= 0xfffffff0,
+		.pvr_value		= 0x00087100,
+		.cpu_name		= "750CL",
+		.cpu_features		= CPU_FTRS_750,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.cpu_setup		= __setup_cpu_750cx,
+		.platform		= "ppc750",
+	},
 	{	/* 745/755 */
 		.pvr_mask		= 0xfffff000,
 		.pvr_value		= 0x00083000,
