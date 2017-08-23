Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbn65cpRzDqXc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:18 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/46] powerpc/configs: Drop no longer needed
 CONFIG_CRYPTO_HMAC
Date: Wed, 23 Aug 2017 15:37:30 +1000
Message-Id: <1503466686-10932-11-git-send-email-mpe@ellerman.id.au>
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

Since commit 401e4238f35c ("crypto: rng - Make DRBG the default RNG")
we no longer need to set CONFIG_CRYPTO_HMAC in our defconfigs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/44x/eiger_defconfig   | 1 -
 arch/powerpc/configs/44x/redwood_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/powerpc/configs/44x/eiger_defconfig b/arch/powerpc/configs/44x/eiger_defconfig
index 0c4f41795d56..362e82485dd0 100644
--- a/arch/powerpc/configs/44x/eiger_defconfig
+++ b/arch/powerpc/configs/44x/eiger_defconfig
@@ -88,7 +88,6 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_LRW=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_XTS=y
-CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=y
 CONFIG_CRYPTO_MD4=y
 CONFIG_CRYPTO_MD5=y
diff --git a/arch/powerpc/configs/44x/redwood_defconfig b/arch/powerpc/configs/44x/redwood_defconfig
index 209063695115..cd14df8159d6 100644
--- a/arch/powerpc/configs/44x/redwood_defconfig
+++ b/arch/powerpc/configs/44x/redwood_defconfig
@@ -87,7 +87,6 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_LRW=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_XTS=y
-CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=y
 CONFIG_CRYPTO_MD4=y
 CONFIG_CRYPTO_MD5=y
-- 
2.7.4
