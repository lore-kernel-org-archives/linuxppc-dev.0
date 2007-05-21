Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 18A75DDE1D
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 15:05:37 +1000 (EST)
Date: Mon, 21 May 2007 15:05:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Some extra via-pmu exports
Message-Id: <20070521150531.e498340a.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

pmu_battery_count, pmu_batteries, pmu_power_flags were only exported
for 32 bit builds but are now needed for 64 bit as well.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/macintosh/via-pmu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 157080b..07c189c 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -2841,10 +2841,10 @@ EXPORT_SYMBOL(pmu_wait_complete);
 EXPORT_SYMBOL(pmu_suspend);
 EXPORT_SYMBOL(pmu_resume);
 EXPORT_SYMBOL(pmu_unlock);
-#if defined(CONFIG_PM) && defined(CONFIG_PPC32)
-EXPORT_SYMBOL(pmu_enable_irled);
 EXPORT_SYMBOL(pmu_battery_count);
 EXPORT_SYMBOL(pmu_batteries);
 EXPORT_SYMBOL(pmu_power_flags);
+#if defined(CONFIG_PM) && defined(CONFIG_PPC32)
+EXPORT_SYMBOL(pmu_enable_irled);
 #endif /* CONFIG_PM && CONFIG_PPC32 */
 
-- 
1.5.1.4
