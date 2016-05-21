Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x243.google.com (mail-lb0-x243.google.com
 [IPv6:2a00:1450:4010:c04::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk7v4JqhzDqWX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:07:23 +1000 (AEST)
Received: by mail-lb0-x243.google.com with SMTP id mx9so6880460lbb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:07:23 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, agust@denx.de, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0235/1529] Fix typo
Date: Sat, 21 May 2016 14:07:15 +0200
Message-Id: <20160521120715.12244-1-andrea.gelmini@gelma.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/powerpc/platforms/512x/clock-commonclk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index c50ea76..d56e1a7 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -719,7 +719,7 @@ static void mpc512x_clk_setup_clock_tree(struct device_node *np, int busfreq)
 	 *   most one of a mux, div, and gate each into one 'struct clk'
 	 *   item
 	 * - PSC/MSCAN/SPDIF clock generation OTOH already is very
-	 *   specific and cannot get mapped to componsites (at least not
+	 *   specific and cannot get mapped to composites (at least not
 	 *   a single one, maybe two of them, but then some of these
 	 *   intermediate clock signals get referenced elsewhere (e.g.
 	 *   in the clock frequency measurement, CFM) and thus need
-- 
2.8.2.534.g1f66975
