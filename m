Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0A1FADEE17
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:35:40 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1ZZB9027608
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:35:36 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1ZZT0001473
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:35 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1AsER007914
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:10:54 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 5E752AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:34 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1ZYHt015366
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:35:34 -0500
Date: Tue, 17 Jul 2007 20:35:34 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 27/61] cpm2: Fix whitespace in cpm2_clk_setup().
Message-ID: <20070718013534.GY15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/cpm2_common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/sysdev/cpm2_common.c
index 4e840bd..7e3a983 100644
--- a/arch/powerpc/sysdev/cpm2_common.c
+++ b/arch/powerpc/sysdev/cpm2_common.c
@@ -233,7 +233,7 @@ int cpm2_clk_setup(enum cpm_clk_target target, int clock, int mode)
 	}
 
 	if (mode == CPM_CLK_RX)
-		shift +=3;
+		shift += 3;
 
 	for (i = 0; i < ARRAY_SIZE(clk_map); i++) {
 		if (clk_map[i][0] == target && clk_map[i][1] == clock) {
-- 
1.5.0.3
