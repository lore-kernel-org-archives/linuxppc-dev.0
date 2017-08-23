Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbn917b3zDqTs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 17/46] powerpc/configs: Drop unnecessary
 CONFIG_NUMA_BALANCING_DEFAULT_ENABLED
Date: Wed, 23 Aug 2017 15:37:37 +1000
Message-Id: <1503466686-10932-18-git-send-email-mpe@ellerman.id.au>
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

In commit 9654f95a081a ("powerpc: Enable NUMA balancing in
pseries[_le]_defconfig") we added CONFIG_NUMA_BALANCING_DEFAULT_ENABLED
to our defconfigs. But it's already enabled by default, so drop it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/pseries_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 8ea2db865fa7..b5dbcaa1ec41 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -17,7 +17,6 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=18
 CONFIG_LOG_CPU_MAX_BUF_SHIFT=13
 CONFIG_NUMA_BALANCING=y
-CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
 CONFIG_CGROUPS=y
 CONFIG_MEMCG=y
 CONFIG_MEMCG_SWAP=y
-- 
2.7.4
