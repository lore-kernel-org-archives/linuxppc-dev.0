Return-Path: <Yuantian.Tang@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EA98C1A000B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 20:20:03 +1100 (AEDT)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0119.outbound.protection.outlook.com [207.46.100.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4C0EC140187
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2014 20:20:03 +1100 (AEDT)
From: Tang Yuantian <Yuantian.Tang@freescale.com>
To: <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>
Subject: [PATCH v2 2/2] cpufreq: qoriq: rename the driver
Date: Fri, 21 Nov 2014 17:18:38 +0800
Message-ID: <1416561518-24835-2-git-send-email-Yuantian.Tang@freescale.com>
In-Reply-To: <1416561518-24835-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1416561518-24835-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: r64188@freescale.com, linuxppc-dev@ozlabs.org,
 Tang Yuantian <Yuantian.Tang@freescale.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This driver works on all QorIQ platforms which include
ARM-based cores and PPC-based cores.
Rename it in order to represent better.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
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
