Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbnM6BMrzDrJS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 40/46] powerpc/configs/6xx: Reinstate CONFIG_CPU_FREQ_STAT
Date: Wed, 23 Aug 2017 15:38:00 +1000
Message-Id: <1503466686-10932-41-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
References: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 1aefc75b2449 ("cpufreq: stats: Make the stats code
non-modular"), the CPU_FREQ_STAT code was made non-modular. Our
defconfig still said =m though, which meant we no longer got the
code at all. Switch the defconfig to =y.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/ppc6xx_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 3d5ca6e8c414..de771d5e564a 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -61,7 +61,7 @@ CONFIG_SBC8641D=y
 CONFIG_MPC8610_HPCD=y
 CONFIG_GEF_SBC610=y
 CONFIG_CPU_FREQ=y
-CONFIG_CPU_FREQ_STAT=m
+CONFIG_CPU_FREQ_STAT=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=m
-- 
2.7.4
