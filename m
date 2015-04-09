Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD7491A04E0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 22:26:48 +1000 (AEST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH] powerpc/config: Enable bnx2x on ppc64 and pseries defconfigs
Date: Thu,  9 Apr 2015 22:26:45 +1000
Message-Id: <1428582405-5616-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/configs/ppc64_defconfig      | 1 +
 arch/powerpc/configs/pseries_defconfig    | 1 +
 arch/powerpc/configs/pseries_le_defconfig | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 3315c9f..a6ed742 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -157,6 +157,7 @@ CONFIG_ACENIC=m
 CONFIG_ACENIC_OMIT_TIGON_I=y
 CONFIG_PCNET32=y
 CONFIG_TIGON3=y
+CONFIG_BNX2X=m
 CONFIG_CHELSIO_T1=m
 CONFIG_BE2NET=m
 CONFIG_S2IO=m
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index c2e39f6..d09c723 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -154,6 +154,7 @@ CONFIG_ACENIC=m
 CONFIG_ACENIC_OMIT_TIGON_I=y
 CONFIG_PCNET32=y
 CONFIG_TIGON3=y
+CONFIG_BNX2X=m
 CONFIG_CHELSIO_T1=m
 CONFIG_BE2NET=m
 CONFIG_S2IO=m
diff --git a/arch/powerpc/configs/pseries_le_defconfig b/arch/powerpc/configs/pseries_le_defconfig
index 09bc96e..5ad0253 100644
--- a/arch/powerpc/configs/pseries_le_defconfig
+++ b/arch/powerpc/configs/pseries_le_defconfig
@@ -155,6 +155,7 @@ CONFIG_ACENIC=m
 CONFIG_ACENIC_OMIT_TIGON_I=y
 CONFIG_PCNET32=y
 CONFIG_TIGON3=y
+CONFIG_BNX2X=m
 CONFIG_CHELSIO_T1=m
 CONFIG_BE2NET=m
 CONFIG_S2IO=m
-- 
2.1.0
