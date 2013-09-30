Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri1.pp.htv.fi (filtteri1.pp.htv.fi [213.243.153.184])
 by ozlabs.org (Postfix) with ESMTP id E35542C010A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 06:45:20 +1000 (EST)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 RESEND 3/3] cpufreq: pmac64: enable cpufreq on iMac G5
 (iSight) model
Date: Mon, 30 Sep 2013 23:44:33 +0300
Message-Id: <1380573873-14448-4-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1380573873-14448-1-git-send-email-aaro.koskinen@iki.fi>
References: <1380573873-14448-1-git-send-email-aaro.koskinen@iki.fi>
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
index 0196d60..6084f9b 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -397,7 +397,8 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
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
1.8.4.rc3
