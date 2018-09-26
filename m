Return-Path: <pvorel@suse.cz>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42L0Gs3jC3zF3Ll
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 00:11:09 +1000 (AEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 39002AE67
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 14:11:06 +0000 (UTC)
From: Petr Vorel <pvorel@suse.cz>
To: linuxppc-dev@lists.ozlabs.org
Cc: Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 1/1] powerpc/config: Enable CONFIG_PRINTK_TIME
Date: Wed, 26 Sep 2018 16:10:56 +0200
Message-Id: <20180926141056.5111-1-pvorel@suse.cz>
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

for 64bit configs which use for CONFIG_LOG_BUF_SHIFT the same
or higher value than the default (currently 17).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 arch/powerpc/configs/g5_defconfig      | 1 +
 arch/powerpc/configs/maple_defconfig   | 1 +
 arch/powerpc/configs/powernv_defconfig | 1 +
 arch/powerpc/configs/ppc64_defconfig   | 1 +
 arch/powerpc/configs/ps3_defconfig     | 1 +
 arch/powerpc/configs/pseries_defconfig | 1 +
 6 files changed, 6 insertions(+)

diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index 67c39f4acede..f686cc1eac0b 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -262,3 +262,4 @@ CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 # CONFIG_CRYPTO_HW is not set
+CONFIG_PRINTK_TIME=y
diff --git a/arch/powerpc/configs/maple_defconfig b/arch/powerpc/configs/maple_defconfig
index 59e47ec85336..f71eddafb02f 100644
--- a/arch/powerpc/configs/maple_defconfig
+++ b/arch/powerpc/configs/maple_defconfig
@@ -112,3 +112,4 @@ CONFIG_PPC_EARLY_DEBUG=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_HW is not set
+CONFIG_PRINTK_TIME=y
diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 6ab34e60495f..75f6e78b41c7 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -350,3 +350,4 @@ CONFIG_VIRTUALIZATION=y
 CONFIG_KVM_BOOK3S_64=m
 CONFIG_KVM_BOOK3S_64_HV=m
 CONFIG_VHOST_NET=m
+CONFIG_PRINTK_TIME=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 5033e630afea..db6a0d8f525f 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -365,3 +365,4 @@ CONFIG_VIRTUALIZATION=y
 CONFIG_KVM_BOOK3S_64=m
 CONFIG_KVM_BOOK3S_64_HV=m
 CONFIG_VHOST_NET=m
+CONFIG_PRINTK_TIME=y
diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3_defconfig
index 187e2f7c12c8..cf8d55f67272 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -171,3 +171,4 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_LZO=m
+CONFIG_PRINTK_TIME=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 0dd5cf7b566d..5e09a40cbcbf 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -325,3 +325,4 @@ CONFIG_VIRTUALIZATION=y
 CONFIG_KVM_BOOK3S_64=m
 CONFIG_KVM_BOOK3S_64_HV=m
 CONFIG_VHOST_NET=m
+CONFIG_PRINTK_TIME=y
-- 
2.12.3
