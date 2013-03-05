Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DFCE22C038B
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Mar 2013 10:16:08 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r25NG62Y024151
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Mar 2013 17:16:06 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 8/8] powerpc/85xx: Update corenet64_smp_defconfig for T4240
Date: Tue,  5 Mar 2013 17:16:00 -0600
Message-Id: <1362525360-23136-8-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1362525360-23136-7-git-send-email-galak@kernel.crashing.org>
References: <1362525360-23136-1-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-2-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-3-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-4-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-5-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-6-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-7-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Add support for up to 24 cores on T4240 (includes threads)
* Enable AltiVec support (on T4240)
* Add T4240QDS board into build
* Other changes are due to general kernel update of defconfig

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/configs/corenet64_smp_defconfig |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 3d139fa..c3da860 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -1,14 +1,13 @@
 CONFIG_PPC64=y
 CONFIG_PPC_BOOK3E_64=y
-# CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not set
+CONFIG_ALTIVEC=y
 CONFIG_SMP=y
-CONFIG_NR_CPUS=2
-CONFIG_EXPERIMENTAL=y
+CONFIG_NR_CPUS=24
 CONFIG_SYSVIPC=y
-CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IRQ_DOMAIN_DEBUG=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -24,6 +23,7 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_MAC_PARTITION=y
 CONFIG_P5020_DS=y
 CONFIG_P5040_DS=y
+CONFIG_T4240_QDS=y
 # CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
 CONFIG_BINFMT_MISC=m
 CONFIG_PCIEPORTBUS=y
@@ -140,6 +140,5 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MD4=y
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
-CONFIG_CRYPTO_AES=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_FSL_CAAM=y
-- 
1.7.9.7
