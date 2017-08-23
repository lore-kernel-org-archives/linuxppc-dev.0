Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbn71Wh3zDqXc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:19 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 12/46] powerpc/configs: Drop no longer needed
 CONFIG_CRYPTO_SHA256
Date: Wed, 23 Aug 2017 15:37:32 +1000
Message-Id: <1503466686-10932-13-git-send-email-mpe@ellerman.id.au>
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

Since commit 826775bbf38f ("crypto: drbg - Add select on sha256") we
no longer need to set CONFIG_CRYPTO_SHA256 in our defconfigs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/44x/eiger_defconfig   | 1 -
 arch/powerpc/configs/44x/redwood_defconfig | 1 -
 arch/powerpc/configs/mpc83xx_defconfig     | 1 -
 arch/powerpc/configs/pasemi_defconfig      | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/powerpc/configs/44x/eiger_defconfig b/arch/powerpc/configs/44x/eiger_defconfig
index 6b6404501ae0..f6dc23fef683 100644
--- a/arch/powerpc/configs/44x/eiger_defconfig
+++ b/arch/powerpc/configs/44x/eiger_defconfig
@@ -91,7 +91,6 @@ CONFIG_CRYPTO_XCBC=y
 CONFIG_CRYPTO_MD4=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_SHA1=y
-CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_ARC4=y
 CONFIG_CRYPTO_BLOWFISH=y
diff --git a/arch/powerpc/configs/44x/redwood_defconfig b/arch/powerpc/configs/44x/redwood_defconfig
index 91eefcf1720f..918cfb63f0c8 100644
--- a/arch/powerpc/configs/44x/redwood_defconfig
+++ b/arch/powerpc/configs/44x/redwood_defconfig
@@ -90,7 +90,6 @@ CONFIG_CRYPTO_XCBC=y
 CONFIG_CRYPTO_MD4=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_SHA1=y
-CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_ARC4=y
 CONFIG_CRYPTO_BLOWFISH=y
diff --git a/arch/powerpc/configs/mpc83xx_defconfig b/arch/powerpc/configs/mpc83xx_defconfig
index 661e398950ee..c50d97ca622b 100644
--- a/arch/powerpc/configs/mpc83xx_defconfig
+++ b/arch/powerpc/configs/mpc83xx_defconfig
@@ -108,6 +108,5 @@ CONFIG_ROOT_NFS=y
 CONFIG_CRC_T10DIF=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
-CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_DEV_TALITOS=y
diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
index 699efb67078f..9d43214a4de4 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -173,6 +173,5 @@ CONFIG_DETECT_HUNG_TASK=y
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
 CONFIG_CRYPTO_MD4=y
-CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_BLOWFISH=y
-- 
2.7.4
