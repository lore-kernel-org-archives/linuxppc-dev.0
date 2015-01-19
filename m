Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 00F9B1A0C7E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 10:24:29 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 hbabu@us.ibm.com, nacc@linux.vnet.ibm.com
Subject: [PATCH 1/7] powerpc: regenerate ppc64 and pseries defconfigs
Date: Tue, 20 Jan 2015 10:24:19 +1100
Message-Id: <1421709865-6368-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Regenerate defconfigs using make savedefconfig.

Anton Blanchard <anton@samba.org>
---
 arch/powerpc/configs/ppc64_defconfig      | 11 +----------
 arch/powerpc/configs/pseries_defconfig    | 12 +++---------
 arch/powerpc/configs/pseries_le_defconfig | 14 +++-----------
 3 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 5830d735..f1c4342 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -1,6 +1,4 @@
 CONFIG_PPC64=y
-CONFIG_ALTIVEC=y
-CONFIG_VSX=y
 CONFIG_SMP=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
@@ -42,9 +40,6 @@ CONFIG_PPC_CELLEB=y
 CONFIG_PPC_CELL_QPACE=y
 CONFIG_RTAS_FLASH=m
 CONFIG_IBMEBUS=y
-CONFIG_CPU_FREQ=y
-CONFIG_CPU_FREQ_GOV_POWERSAVE=y
-CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_PMAC64=y
 CONFIG_HZ_100=y
 CONFIG_BINFMT_MISC=m
@@ -82,7 +77,6 @@ CONFIG_BPF_JIT=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
-CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_FD=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=m
@@ -101,7 +95,6 @@ CONFIG_CHR_DEV_ST=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_CHR_DEV_SG=y
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_FC_ATTRS=y
 CONFIG_SCSI_CXGB3_ISCSI=m
@@ -209,7 +202,6 @@ CONFIG_RAW_DRIVER=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_AMD8111=y
 CONFIG_I2C_PASEMI=y
-CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_OF=y
@@ -326,7 +318,6 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-CONFIG_CRC_T10DIF=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_STACK_USAGE=y
@@ -362,4 +353,4 @@ CONFIG_CRYPTO_DEV_NX=y
 CONFIG_CRYPTO_DEV_NX_ENCRYPT=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM_BOOK3S_64=m
-CONFIG_KVM_BOOK3S_64_HV=y
+CONFIG_KVM_BOOK3S_64_HV=m
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 1f97364..145e5b0 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -1,6 +1,4 @@
 CONFIG_PPC64=y
-CONFIG_ALTIVEC=y
-CONFIG_VSX=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2048
 CONFIG_SYSVIPC=y
@@ -40,6 +38,7 @@ CONFIG_DTL=y
 # CONFIG_PPC_PMAC is not set
 CONFIG_RTAS_FLASH=m
 CONFIG_IBMEBUS=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_HZ_100=y
 CONFIG_BINFMT_MISC=m
 CONFIG_PPC_TRANSACTIONAL_MEM=y
@@ -47,6 +46,7 @@ CONFIG_KEXEC=y
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
+CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_PPC_64K_PAGES=y
 CONFIG_PPC_SUBPAGE_PROT=y
 CONFIG_SCHED_SMT=y
@@ -72,7 +72,6 @@ CONFIG_BRIDGE=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
-CONFIG_PROC_DEVICETREE=y
 CONFIG_PARPORT=m
 CONFIG_PARPORT_PC=m
 CONFIG_BLK_DEV_FD=m
@@ -90,7 +89,6 @@ CONFIG_CHR_DEV_ST=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_CHR_DEV_SG=y
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_FC_ATTRS=y
 CONFIG_SCSI_CXGB3_ISCSI=m
@@ -270,7 +268,6 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-CONFIG_CRC_T10DIF=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_STACK_USAGE=y
@@ -304,7 +301,4 @@ CONFIG_CRYPTO_DEV_NX=y
 CONFIG_CRYPTO_DEV_NX_ENCRYPT=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM_BOOK3S_64=m
-CONFIG_KVM_BOOK3S_64_HV=y
-CONFIG_TRANSPARENT_HUGEPAGE=y
-CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
-CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_KVM_BOOK3S_64_HV=m
diff --git a/arch/powerpc/configs/pseries_le_defconfig b/arch/powerpc/configs/pseries_le_defconfig
index ac7ca58..4ff694c 100644
--- a/arch/powerpc/configs/pseries_le_defconfig
+++ b/arch/powerpc/configs/pseries_le_defconfig
@@ -1,6 +1,4 @@
 CONFIG_PPC64=y
-CONFIG_ALTIVEC=y
-CONFIG_VSX=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2048
 CONFIG_CPU_LITTLE_ENDIAN=y
@@ -41,6 +39,7 @@ CONFIG_DTL=y
 # CONFIG_PPC_PMAC is not set
 CONFIG_RTAS_FLASH=m
 CONFIG_IBMEBUS=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_HZ_100=y
 CONFIG_BINFMT_MISC=m
 CONFIG_PPC_TRANSACTIONAL_MEM=y
@@ -48,6 +47,7 @@ CONFIG_KEXEC=y
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
+CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_PPC_64K_PAGES=y
 CONFIG_PPC_SUBPAGE_PROT=y
 CONFIG_SCHED_SMT=y
@@ -73,7 +73,6 @@ CONFIG_BRIDGE=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
-CONFIG_PROC_DEVICETREE=y
 CONFIG_PARPORT=m
 CONFIG_PARPORT_PC=m
 CONFIG_BLK_DEV_FD=m
@@ -91,7 +90,6 @@ CONFIG_CHR_DEV_ST=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_CHR_DEV_SG=y
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_FC_ATTRS=y
 CONFIG_SCSI_CXGB3_ISCSI=m
@@ -271,7 +269,6 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-CONFIG_CRC_T10DIF=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_STACK_USAGE=y
@@ -300,11 +297,6 @@ CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_LZO=m
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRYPTO_DEV_NX=y
-CONFIG_CRYPTO_DEV_NX_ENCRYPT=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM_BOOK3S_64=m
-CONFIG_KVM_BOOK3S_64_HV=y
-CONFIG_TRANSPARENT_HUGEPAGE=y
-CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
-CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_KVM_BOOK3S_64_HV=m
-- 
2.1.0
