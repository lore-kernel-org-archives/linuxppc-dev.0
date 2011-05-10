Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE009.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B4FBA100841
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 04:02:13 +1000 (EST)
Date: Tue, 10 May 2011 13:02:06 -0500
From: Scott Wood <scottwood@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/fsl: enable verbose bug output
Message-ID: <20110510180206.GB18443@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This debug option has no overhead other than a slight increase in
kernel size, and makes bug reports more useful.  While some end users
may prefer to save the space, as a default on a kernel config aimed
primarily at development on reference boards, it should be enabled.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig  |    1 -
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig  |    1 -
 arch/powerpc/configs/85xx/mpc8540_ads_defconfig  |    1 -
 arch/powerpc/configs/85xx/mpc8560_ads_defconfig  |    1 -
 arch/powerpc/configs/85xx/mpc85xx_cds_defconfig  |    1 -
 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig |    1 -
 arch/powerpc/configs/e55xx_smp_defconfig         |    1 -
 arch/powerpc/configs/mpc85xx_defconfig           |    1 -
 arch/powerpc/configs/mpc85xx_smp_defconfig       |    1 -
 arch/powerpc/configs/mpc86xx_defconfig           |    1 -
 10 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
index c683bce..126ef1b 100644
--- a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
@@ -104,7 +104,6 @@ CONFIG_ROOT_NFS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_CRYPTO_PCBC=m
diff --git a/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
index a721cd3..abcf00a 100644
--- a/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
@@ -101,7 +101,6 @@ CONFIG_ROOT_NFS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_CRYPTO_PCBC=m
diff --git a/arch/powerpc/configs/85xx/mpc8540_ads_defconfig b/arch/powerpc/configs/85xx/mpc8540_ads_defconfig
index 55e0725..11662c2 100644
--- a/arch/powerpc/configs/85xx/mpc8540_ads_defconfig
+++ b/arch/powerpc/configs/85xx/mpc8540_ads_defconfig
@@ -58,7 +58,6 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_MUTEXES=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/mpc8560_ads_defconfig b/arch/powerpc/configs/85xx/mpc8560_ads_defconfig
index d724095..ebe9b30 100644
--- a/arch/powerpc/configs/85xx/mpc8560_ads_defconfig
+++ b/arch/powerpc/configs/85xx/mpc8560_ads_defconfig
@@ -59,7 +59,6 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_MUTEXES=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig b/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig
index 4b44bea..eb25229 100644
--- a/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig
+++ b/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig
@@ -63,7 +63,6 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_MUTEXES=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig b/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
index b614508d..f51c7eb 100644
--- a/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
+++ b/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
@@ -168,7 +168,6 @@ CONFIG_MAC_PARTITION=y
 CONFIG_CRC_T10DIF=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO=y
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
diff --git a/arch/powerpc/configs/e55xx_smp_defconfig b/arch/powerpc/configs/e55xx_smp_defconfig
index f4c5780..d322835 100644
--- a/arch/powerpc/configs/e55xx_smp_defconfig
+++ b/arch/powerpc/configs/e55xx_smp_defconfig
@@ -95,7 +95,6 @@ CONFIG_FRAME_WARN=1024
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO=y
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index c06a86c..96b89df 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -204,7 +204,6 @@ CONFIG_CRC_T10DIF=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO=y
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index 942ced9..de65841 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -206,7 +206,6 @@ CONFIG_CRC_T10DIF=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO=y
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
diff --git a/arch/powerpc/configs/mpc86xx_defconfig b/arch/powerpc/configs/mpc86xx_defconfig
index 038a308..a1cc817 100644
--- a/arch/powerpc/configs/mpc86xx_defconfig
+++ b/arch/powerpc/configs/mpc86xx_defconfig
@@ -171,7 +171,6 @@ CONFIG_MAC_PARTITION=y
 CONFIG_CRC_T10DIF=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO=y
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
-- 
1.7.4.1
