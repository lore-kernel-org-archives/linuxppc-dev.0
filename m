Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slnyJ2hJLzDvNP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 20:40:08 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4] powerpc/configs: Enable Intel i40e on 64 bit configs
Date: Fri, 30 Sep 2016 20:39:53 +1000
Message-Id: <1475231993-20321-4-git-send-email-anton@ozlabs.org>
In-Reply-To: <1475231993-20321-1-git-send-email-anton@ozlabs.org>
References: <1475231993-20321-1-git-send-email-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

We are starting to see i40e adapters in recent machines, so enable
it in our configs.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/configs/powernv_defconfig | 1 +
 arch/powerpc/configs/ppc64_defconfig   | 1 +
 arch/powerpc/configs/pseries_defconfig | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index b4744fe..d98b6eb 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -165,6 +165,7 @@ CONFIG_E1000=y
 CONFIG_E1000E=y
 CONFIG_IXGB=m
 CONFIG_IXGBE=m
+CONFIG_I40E=m
 CONFIG_MLX4_EN=m
 CONFIG_MYRI10GE=m
 CONFIG_QLGE=m
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 447d733..58a98d4 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -167,6 +167,7 @@ CONFIG_E1000=y
 CONFIG_E1000E=y
 CONFIG_IXGB=m
 CONFIG_IXGBE=m
+CONFIG_I40E=m
 CONFIG_MLX4_EN=m
 CONFIG_MYRI10GE=m
 CONFIG_PASEMI_MAC=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index e8f950d..8a3bc01 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -168,6 +168,7 @@ CONFIG_E1000=y
 CONFIG_E1000E=y
 CONFIG_IXGB=m
 CONFIG_IXGBE=m
+CONFIG_I40E=m
 CONFIG_MLX4_EN=m
 CONFIG_MYRI10GE=m
 CONFIG_QLGE=m
-- 
2.7.4
