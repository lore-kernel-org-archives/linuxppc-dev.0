Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbnC09K6zDqYs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 19/46] powerpc/configs: Drop no longer needed CONFIG_SMP for
 pseries/ppc64/powernv
Date: Wed, 23 Aug 2017 15:37:39 +1000
Message-Id: <1503466686-10932-20-git-send-email-mpe@ellerman.id.au>
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

In commit 40e275653e2c ("powerpc/powernv: Always enable SMP when
building powernv") and 270e2dc9b803 ("powerpc/pseries: Always enable
SMP when building pseries") we forced CONFIG_SMP on for some configs.
Therefore we don't need to set it in those configs anymore.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/powernv_defconfig | 1 -
 arch/powerpc/configs/ppc64_defconfig   | 1 -
 arch/powerpc/configs/pseries_defconfig | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index e10e57b5c7e2..48c69c75136b 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -1,5 +1,4 @@
 CONFIG_PPC64=y
-CONFIG_SMP=y
 CONFIG_NR_CPUS=2048
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYSVIPC=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index ee626d3c5ba8..a5bd462bc61f 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -1,5 +1,4 @@
 CONFIG_PPC64=y
-CONFIG_SMP=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_IRQ_DOMAIN_DEBUG=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 7f8f9f7314c2..08cf7bb14233 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -1,5 +1,4 @@
 CONFIG_PPC64=y
-CONFIG_SMP=y
 CONFIG_NR_CPUS=2048
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-- 
2.7.4
