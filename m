Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id D4E8867BF8
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 05:57:09 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	kB1KJCwh004033
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Dec 2006 13:19:12 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id kB1Iv6Z6011808
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Dec 2006 12:57:07 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	kB1IfdSK002891
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Dec 2006 12:41:40 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id C90DE4B928
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Dec 2006 12:57:05 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	kB1Iv5U7019723
	for linuxppc-dev@ozlabs.org; Fri, 1 Dec 2006 12:57:05 -0600
Date: Fri, 1 Dec 2006 12:57:05 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Add the e300c3 core to the CPU table.
Message-ID: <20061201185705.GA19703@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This core is used in Freescale's 831x chips.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/cputable.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 911ac44..7174fe9 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -840,6 +840,17 @@ #if CLASSIC_PPC
 		.cpu_setup		= __setup_cpu_603,
 		.platform		= "ppc603",
 	},
+	{	/* e300c3 on 83xx  */
+		.pvr_mask		= 0x7fff0000,
+		.pvr_value		= 0x00850000,
+		.cpu_name		= "e300c3",
+		.cpu_features		= CPU_FTRS_E300,
+		.cpu_user_features	= COMMON_USER,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_603,
+		.platform		= "ppc603",
+	},
 	{	/* default match, we assume split I/D cache & TB (non-601)... */
 		.pvr_mask		= 0x00000000,
 		.pvr_value		= 0x00000000,
-- 
1.4.2.3
