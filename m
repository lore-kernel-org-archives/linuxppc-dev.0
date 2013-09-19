Return-Path: <B32579@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EA46A2C029F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2013 19:00:46 +1000 (EST)
Received: from mail155-co9 (localhost [127.0.0.1])	by
 mail155-co9-R.bigfish.com (Postfix) with ESMTP id 01B9A180171	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2013 09:00:41 +0000 (UTC)
Received: from CO9EHSMHS012.bigfish.com (unknown [10.236.132.246])	by
 mail155-co9.bigfish.com (Postfix) with ESMTP id D0A5920054	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2013 09:00:30 +0000 (UTC)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2][v3] powerpc/configs: Enable T1040QDS by default in corenet
Date: Thu, 19 Sep 2013 14:30:21 +0530
Message-ID: <1379581221-24458-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

T1040 supports both 32 & 64 bit kernel.
so enable T1040QDS by default in the config files.

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
 Based upon git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
 Branch next

 Changes for v2: Sending as it is
 Changes for v3: Sending as it is
 	
 arch/powerpc/configs/corenet32_smp_defconfig |    1 +
 arch/powerpc/configs/corenet64_smp_defconfig |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 3dfab4c..19d1d31 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -28,6 +28,7 @@ CONFIG_P3041_DS=y
 CONFIG_P4080_DS=y
 CONFIG_P5020_DS=y
 CONFIG_P5040_DS=y
+CONFIG_T104x_QDS=y
 CONFIG_HIGHMEM=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_BINFMT_MISC=m
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index fa94fb3..d23ee10 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -24,6 +24,7 @@ CONFIG_MAC_PARTITION=y
 CONFIG_B4_QDS=y
 CONFIG_P5020_DS=y
 CONFIG_P5040_DS=y
+CONFIG_T104x_QDS=y
 CONFIG_T4240_QDS=y
 # CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
 CONFIG_BINFMT_MISC=m
-- 
1.7.9.5
