Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri1.pp.htv.fi (filtteri1.pp.htv.fi [213.243.153.184])
 by ozlabs.org (Postfix) with ESMTP id D560E2C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Sep 2013 03:26:12 +1000 (EST)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/3] cpufreq: pmac64: enable cpufreq on iMac G5 (iSight)
 model
Date: Sat, 31 Aug 2013 20:23:52 +0300
Message-Id: <1377969832-27699-4-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1377969832-27699-1-git-send-email-aaro.koskinen@iki.fi>
References: <1377969832-27699-1-git-send-email-aaro.koskinen@iki.fi>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable cpufreq on iMac G5 (iSight) model. Tested with the 2.1 GHz version.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pmac64-cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
index d3d1995..699e0a5 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -398,7 +398,8 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpus)
 	/* Check supported platforms */
 	if (of_machine_is_compatible("PowerMac8,1") ||
 	    of_machine_is_compatible("PowerMac8,2") ||
-	    of_machine_is_compatible("PowerMac9,1"))
+	    of_machine_is_compatible("PowerMac9,1") ||
+	    of_machine_is_compatible("PowerMac12,1"))
 		use_volts_smu = 1;
 	else if (of_machine_is_compatible("PowerMac11,2"))
 		use_volts_vdnap = 1;
-- 
1.8.3.2
