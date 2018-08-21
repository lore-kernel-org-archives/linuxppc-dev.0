Return-Path: <joel.stan@gmail.com>
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vZ4d5b4yzDqnw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 12:14:41 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id b11-v6so7725257pfo.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 19:14:41 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv: Don't select the cpufreq governors
Date: Tue, 21 Aug 2018 11:44:28 +0930
Message-Id: <20180821021428.23377-1-joel@jms.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Deciding wich govenors should be built into the kernel can be left to
users to configure.

Fixes: 81f359027a3a ("cpufreq: powernv: Select CPUFreq related Kconfig options for powernv")
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/platforms/powernv/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index f8dc98d3dc01..028ac941c05c 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -15,11 +15,6 @@ config PPC_POWERNV
 	select PPC_SCOM
 	select ARCH_RANDOM
 	select CPU_FREQ
-	select CPU_FREQ_GOV_PERFORMANCE
-	select CPU_FREQ_GOV_POWERSAVE
-	select CPU_FREQ_GOV_USERSPACE
-	select CPU_FREQ_GOV_ONDEMAND
-	select CPU_FREQ_GOV_CONSERVATIVE
 	select PPC_DOORBELL
 	select MMU_NOTIFIER
 	select FORCE_SMP
-- 
2.17.1
