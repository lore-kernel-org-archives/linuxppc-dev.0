Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpN1H5DshzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 08:22:11 +1100 (AEDT)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc/configs: Re-enable POWER8 crc32c
Date: Thu, 23 Mar 2017 08:22:01 +1100
Message-Id: <20170322212201.26036-3-anton@ozlabs.org>
In-Reply-To: <20170322212201.26036-1-anton@ozlabs.org>
References: <20170322212201.26036-1-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

The config option for the POWER8 crc32c recently changed from
CONFIG_CRYPT_CRC32C_VPMSUM to CONFIG_CRYPTO_CRC32C_VPMSUM. Update
the configs.

Signed-off-by: Anton Blanchard <anton@samba.org
---
 arch/powerpc/configs/powernv_defconfig | 2 +-
 arch/powerpc/configs/ppc64_defconfig   | 2 +-
 arch/powerpc/configs/pseries_defconfig | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 4926d7f..0695ce0 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -306,7 +306,7 @@ CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_CCM=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPT_CRC32C_VPMSUM=m
+CONFIG_CRYPTO_CRC32C_VPMSUM=m
 CONFIG_CRYPTO_MD5_PPC=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA256=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index dfac33c..e353168f9 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -340,7 +340,7 @@ CONFIG_PPC_EARLY_DEBUG=y
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPT_CRC32C_VPMSUM=m
+CONFIG_CRYPTO_CRC32C_VPMSUM=m
 CONFIG_CRYPTO_MD5_PPC=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA256=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 47f72c8..1a61aa2 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -303,7 +303,7 @@ CONFIG_XMON=y
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPT_CRC32C_VPMSUM=m
+CONFIG_CRYPTO_CRC32C_VPMSUM=m
 CONFIG_CRYPTO_MD5_PPC=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA256=y
-- 
2.9.3
