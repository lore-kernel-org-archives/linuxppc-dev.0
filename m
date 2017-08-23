Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbn70FBnzDqgq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:19 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/46] powerpc/configs: Drop no longer needed CONFIG_CRYPTO_ECB
Date: Wed, 23 Aug 2017 15:37:31 +1000
Message-Id: <1503466686-10932-12-git-send-email-mpe@ellerman.id.au>
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

Since commit 12cb3a1c4184 ("crypto: xts - Add ECB dependency") we no
longer need to set CONFIG_CRYPTO_ECB in our defconfigs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/44x/eiger_defconfig   | 1 -
 arch/powerpc/configs/44x/redwood_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/powerpc/configs/44x/eiger_defconfig b/arch/powerpc/configs/44x/eiger_defconfig
index 362e82485dd0..6b6404501ae0 100644
--- a/arch/powerpc/configs/44x/eiger_defconfig
+++ b/arch/powerpc/configs/44x/eiger_defconfig
@@ -84,7 +84,6 @@ CONFIG_CRYPTO_CCM=y
 CONFIG_CRYPTO_GCM=y
 CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_CTS=y
-CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_LRW=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_XTS=y
diff --git a/arch/powerpc/configs/44x/redwood_defconfig b/arch/powerpc/configs/44x/redwood_defconfig
index cd14df8159d6..91eefcf1720f 100644
--- a/arch/powerpc/configs/44x/redwood_defconfig
+++ b/arch/powerpc/configs/44x/redwood_defconfig
@@ -83,7 +83,6 @@ CONFIG_CRYPTO_CCM=y
 CONFIG_CRYPTO_GCM=y
 CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_CTS=y
-CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_LRW=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_XTS=y
-- 
2.7.4
