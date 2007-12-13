Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C8440DDF77
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 04:16:41 +1100 (EST)
Date: Thu, 13 Dec 2007 11:16:32 -0600
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 1/4] mpc8313erdb: Fix whitespace.
Message-ID: <20071213171632.GA4491@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
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
 arch/powerpc/platforms/83xx/mpc8313_rdb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc8313_rdb.c b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
index 33766b8..6fb8299 100644
--- a/arch/powerpc/platforms/83xx/mpc8313_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
@@ -70,9 +70,9 @@ void __init mpc8313_rdb_init_IRQ(void)
  */
 static int __init mpc8313_rdb_probe(void)
 {
-        unsigned long root = of_get_flat_dt_root();
+	unsigned long root = of_get_flat_dt_root();
 
-        return of_flat_dt_is_compatible(root, "MPC8313ERDB");
+	return of_flat_dt_is_compatible(root, "MPC8313ERDB");
 }
 
 define_machine(mpc8313_rdb) {
-- 
1.5.3.7
