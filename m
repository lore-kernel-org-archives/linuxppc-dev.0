Return-Path: <Yuantian.Tang@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F1241A083B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 14:58:22 +1100 (AEDT)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0103.outbound.protection.outlook.com [207.46.100.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 97780140161
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2015 14:58:21 +1100 (AEDT)
From: <Yuantian.Tang@freescale.com>
To: <rjw@rjwysocki.net>
Subject: [PATCH 2/2 v4] cpufreq: qoriq: rename the driver
Date: Tue, 3 Mar 2015 11:38:52 +0800
Message-ID: <1425353932-713-2-git-send-email-Yuantian.Tang@freescale.com>
In-Reply-To: <1425353932-713-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1425353932-713-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, viresh.kumar@linaro.org,
 Tang Yuantian <Yuantian.Tang@freescale.com>, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <Yuantian.Tang@freescale.com>

This driver works on all QorIQ platforms which include
ARM-based cores and PPC-based cores.
Rename it in order to represent better.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
v3, v4
	- none
v2:
	- use -C -M options when format-patch

 drivers/cpufreq/{ppc-corenet-cpufreq.c => qoriq-cpufreq.c} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename drivers/cpufreq/{ppc-corenet-cpufreq.c => qoriq-cpufreq.c} (100%)

diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
similarity index 100%
rename from drivers/cpufreq/ppc-corenet-cpufreq.c
rename to drivers/cpufreq/qoriq-cpufreq.c
-- 
2.1.0.27.g96db324
