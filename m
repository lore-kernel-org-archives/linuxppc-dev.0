Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri6.pp.htv.fi (filtteri6.pp.htv.fi [213.243.153.189])
 by ozlabs.org (Postfix) with ESMTP id D335A2C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Sep 2013 03:26:13 +1000 (EST)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/3] cpufreq/ondemand support for Xserve G5 & iMac G5 iSight
Date: Sat, 31 Aug 2013 20:23:49 +0300
Message-Id: <1377969832-27699-1-git-send-email-aaro.koskinen@iki.fi>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This is a second version of the patch set sent earlier
(http://marc.info/?t=137461124900005&r=1&w=2) to enable ondemand on
Xserve G5, and also to enable cpufreq on the final iMac G5 (iSight) model.

I changed the second patch to so that it only adds the new latency value
for PowerMac7,2/PowerMac7,3/RackMac3,1.

The only other changes are ACKs from Viresh Kumar to patches 1 & 3.

A.

Aaro Koskinen (3):
  cpufreq: pmac64: speed up frequency switch
  cpufreq: pmac64: provide cpufreq transition latency for older G5
    models
  cpufreq: pmac64: enable cpufreq on iMac G5 (iSight) model

 drivers/cpufreq/pmac64-cpufreq.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

-- 
1.8.3.2
