Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri1.pp.htv.fi (filtteri1.pp.htv.fi [213.243.153.184])
 by ozlabs.org (Postfix) with ESMTP id 63D182C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 06:25:01 +1000 (EST)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Nick Piggin <npiggin@suse.de>, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] cpufreq: pmac64: enable cpufreq on iMac G5 (iSight) model
Date: Tue, 23 Jul 2013 23:24:39 +0300
Message-Id: <1374611079-28091-3-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1374611079-28091-1-git-send-email-aaro.koskinen@iki.fi>
References: <1374611079-28091-1-git-send-email-aaro.koskinen@iki.fi>
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
---
 drivers/cpufreq/pmac64-cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
index f9e399b..1f352e5 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -399,7 +399,8 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpus)
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
