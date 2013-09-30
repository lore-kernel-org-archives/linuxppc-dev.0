Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri6.pp.htv.fi (filtteri6.pp.htv.fi [213.243.153.189])
 by ozlabs.org (Postfix) with ESMTP id 179CC2C0146
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 06:45:21 +1000 (EST)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 RESEND 0/3] cpufreq/ondemand support for Xserve G5 & iMac
 G5 iSight
Date: Mon, 30 Sep 2013 23:44:30 +0300
Message-Id: <1380573873-14448-1-git-send-email-aaro.koskinen@iki.fi>
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

This is a resend of the v2 patchset:

	http://marc.info/?t=137797013200001&r=1&w=2

No changes except rebasing. Any chance to get these into v3.13?

Aaro Koskinen (3):
  cpufreq: pmac64: speed up frequency switch
  cpufreq: pmac64: provide cpufreq transition latency for older G5
    models
  cpufreq: pmac64: enable cpufreq on iMac G5 (iSight) model

 drivers/cpufreq/pmac64-cpufreq.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

-- 
1.8.4.rc3
