Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1F3892C007B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 18:21:08 +1000 (EST)
Received: by mail-pa0-f50.google.com with SMTP id fb1so6340762pad.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 01:21:05 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: rjw@sisk.pl
Subject: [PATCH 07/11] cpufreq: powerpc: CBE_RAS: select CPU_FREQ_TABLE
Date: Wed, 12 Jun 2013 13:45:14 +0530
Message-Id: <601f678e73c3a5fbcc392ac480a2d12b155d0485.1371022830.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371022830.git.viresh.kumar@linaro.org>
References: <cover.1371022830.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371022830.git.viresh.kumar@linaro.org>
References: <cover.1371022830.git.viresh.kumar@linaro.org>
Cc: robin.randhawa@arm.com, arnd@arndb.de, linux-pm@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>, patches@linaro.org,
 Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org,
 linaro-kernel@lists.linaro.org, Steve.Bannister@arm.com,
 arvind.chauhan@arm.com, linuxppc-dev@lists.ozlabs.org,
 charles.garcia-tobin@arm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CPUFreq driver of this platform uses APIs from freq_table.c and so must select
CPU_FREQ_TABLE.

Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig.powerpc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.powerpc b/drivers/cpufreq/Kconfig.powerpc
index 9c926ca..68c1abc 100644
--- a/drivers/cpufreq/Kconfig.powerpc
+++ b/drivers/cpufreq/Kconfig.powerpc
@@ -1,6 +1,7 @@
 config CPU_FREQ_CBE
 	tristate "CBE frequency scaling"
 	depends on CBE_RAS && PPC_CELL
+	select CPU_FREQ_TABLE
 	default m
 	help
 	  This adds the cpufreq driver for Cell BE processors.
-- 
1.7.12.rc2.18.g61b472e
