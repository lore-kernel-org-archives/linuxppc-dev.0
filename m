Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbn81cBXzDqgq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 14/46] powerpc/configs: Drop no longer needed
 CONFIG_CRYPTO_NULL in g5 / c2k
Date: Wed, 23 Aug 2017 15:37:34 +1000
Message-Id: <1503466686-10932-15-git-send-email-mpe@ellerman.id.au>
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

Since commit 3491244c6298 ("crypto: echainiv - Set Kconfig default to
m") we no longer need to set CONFIG_CRYPTO_NULL in our defconfigs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/c2k_defconfig | 1 -
 arch/powerpc/configs/g5_defconfig  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/powerpc/configs/c2k_defconfig b/arch/powerpc/configs/c2k_defconfig
index 5419d3eb852a..d23507223ab4 100644
--- a/arch/powerpc/configs/c2k_defconfig
+++ b/arch/powerpc/configs/c2k_defconfig
@@ -389,7 +389,6 @@ CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
 CONFIG_SECURITY_SELINUX_DISABLE=y
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA1=y
diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index 75f97c20f171..e084fa548d73 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -258,7 +258,6 @@ CONFIG_DEBUG_MUTEXES=y
 CONFIG_LATENCYTOP=y
 CONFIG_BOOTX_TEXT=y
 CONFIG_PPC_EARLY_DEBUG=y
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
-- 
2.7.4
