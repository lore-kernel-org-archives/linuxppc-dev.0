Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slnyG6RYmzDvN5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 20:40:06 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] powerpc/configs: Change a few things from built in to
 modules
Date: Fri, 30 Sep 2016 20:39:52 +1000
Message-Id: <1475231993-20321-3-git-send-email-anton@ozlabs.org>
In-Reply-To: <1475231993-20321-1-git-send-email-anton@ozlabs.org>
References: <1475231993-20321-1-git-send-email-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

Change a few devices and filesystems that are seldom used any more
from built in to modules. This reduces our vmlinux about 500kB.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/configs/powernv_defconfig | 14 +++++++-------
 arch/powerpc/configs/ppc64_defconfig   | 14 +++++++-------
 arch/powerpc/configs/pseries_defconfig | 14 +++++++-------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 95b52b4..b4744fe 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -97,7 +97,7 @@ CONFIG_BLK_DEV_IDECD=y
 CONFIG_BLK_DEV_GENERIC=y
 CONFIG_BLK_DEV_AMD74XX=y
 CONFIG_BLK_DEV_SD=y
-CONFIG_CHR_DEV_ST=y
+CONFIG_CHR_DEV_ST=m
 CONFIG_BLK_DEV_SR=y
 CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_CHR_DEV_SG=y
@@ -109,7 +109,7 @@ CONFIG_SCSI_CXGB4_ISCSI=m
 CONFIG_SCSI_BNX2_ISCSI=m
 CONFIG_BE2ISCSI=m
 CONFIG_SCSI_MPT2SAS=m
-CONFIG_SCSI_SYM53C8XX_2=y
+CONFIG_SCSI_SYM53C8XX_2=m
 CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
 CONFIG_SCSI_IPR=y
 CONFIG_SCSI_QLA_FC=m
@@ -151,10 +151,10 @@ CONFIG_TUN=m
 CONFIG_VETH=m
 CONFIG_VIRTIO_NET=m
 CONFIG_VHOST_NET=m
-CONFIG_VORTEX=y
+CONFIG_VORTEX=m
 CONFIG_ACENIC=m
 CONFIG_ACENIC_OMIT_TIGON_I=y
-CONFIG_PCNET32=y
+CONFIG_PCNET32=m
 CONFIG_TIGON3=y
 CONFIG_BNX2X=m
 CONFIG_CHELSIO_T1=m
@@ -240,7 +240,7 @@ CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
-CONFIG_REISERFS_FS=y
+CONFIG_REISERFS_FS=m
 CONFIG_REISERFS_FS_XATTR=y
 CONFIG_REISERFS_FS_POSIX_ACL=y
 CONFIG_REISERFS_FS_SECURITY=y
@@ -255,10 +255,10 @@ CONFIG_NILFS2_FS=m
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_OVERLAY_FS=m
-CONFIG_ISO9660_FS=y
+CONFIG_ISO9660_FS=m
 CONFIG_UDF_FS=m
 CONFIG_MSDOS_FS=y
-CONFIG_VFAT_FS=y
+CONFIG_VFAT_FS=m
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 886b237..447d733 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -92,7 +92,7 @@ CONFIG_BLK_DEV_AMD74XX=y
 CONFIG_BLK_DEV_IDE_PMAC=y
 CONFIG_BLK_DEV_IDE_PMAC_ATA100FIRST=y
 CONFIG_BLK_DEV_SD=y
-CONFIG_CHR_DEV_ST=y
+CONFIG_CHR_DEV_ST=m
 CONFIG_BLK_DEV_SR=y
 CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_CHR_DEV_SG=y
@@ -105,7 +105,7 @@ CONFIG_BE2ISCSI=m
 CONFIG_SCSI_MPT2SAS=m
 CONFIG_SCSI_IBMVSCSI=y
 CONFIG_SCSI_IBMVFC=m
-CONFIG_SCSI_SYM53C8XX_2=y
+CONFIG_SCSI_SYM53C8XX_2=m
 CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
 CONFIG_SCSI_IPR=y
 CONFIG_SCSI_QLA_FC=m
@@ -151,10 +151,10 @@ CONFIG_NETCONSOLE=y
 CONFIG_TUN=m
 CONFIG_VIRTIO_NET=m
 CONFIG_VHOST_NET=m
-CONFIG_VORTEX=y
+CONFIG_VORTEX=m
 CONFIG_ACENIC=m
 CONFIG_ACENIC_OMIT_TIGON_I=y
-CONFIG_PCNET32=y
+CONFIG_PCNET32=m
 CONFIG_TIGON3=y
 CONFIG_BNX2X=m
 CONFIG_CHELSIO_T1=m
@@ -271,7 +271,7 @@ CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
-CONFIG_REISERFS_FS=y
+CONFIG_REISERFS_FS=m
 CONFIG_REISERFS_FS_XATTR=y
 CONFIG_REISERFS_FS_POSIX_ACL=y
 CONFIG_REISERFS_FS_SECURITY=y
@@ -286,10 +286,10 @@ CONFIG_NILFS2_FS=m
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_OVERLAY_FS=m
-CONFIG_ISO9660_FS=y
+CONFIG_ISO9660_FS=m
 CONFIG_UDF_FS=m
 CONFIG_MSDOS_FS=y
-CONFIG_VFAT_FS=y
+CONFIG_VFAT_FS=m
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 2a5dac7..e8f950d 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -97,7 +97,7 @@ CONFIG_BLK_DEV_IDECD=y
 CONFIG_BLK_DEV_GENERIC=y
 CONFIG_BLK_DEV_AMD74XX=y
 CONFIG_BLK_DEV_SD=y
-CONFIG_CHR_DEV_ST=y
+CONFIG_CHR_DEV_ST=m
 CONFIG_BLK_DEV_SR=y
 CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_CHR_DEV_SG=y
@@ -110,7 +110,7 @@ CONFIG_BE2ISCSI=m
 CONFIG_SCSI_MPT2SAS=m
 CONFIG_SCSI_IBMVSCSI=y
 CONFIG_SCSI_IBMVFC=m
-CONFIG_SCSI_SYM53C8XX_2=y
+CONFIG_SCSI_SYM53C8XX_2=m
 CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
 CONFIG_SCSI_IPR=y
 CONFIG_SCSI_QLA_FC=m
@@ -152,10 +152,10 @@ CONFIG_TUN=m
 CONFIG_VETH=m
 CONFIG_VIRTIO_NET=m
 CONFIG_VHOST_NET=m
-CONFIG_VORTEX=y
+CONFIG_VORTEX=m
 CONFIG_ACENIC=m
 CONFIG_ACENIC_OMIT_TIGON_I=y
-CONFIG_PCNET32=y
+CONFIG_PCNET32=m
 CONFIG_TIGON3=y
 CONFIG_BNX2X=m
 CONFIG_CHELSIO_T1=m
@@ -243,7 +243,7 @@ CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
-CONFIG_REISERFS_FS=y
+CONFIG_REISERFS_FS=m
 CONFIG_REISERFS_FS_XATTR=y
 CONFIG_REISERFS_FS_POSIX_ACL=y
 CONFIG_REISERFS_FS_SECURITY=y
@@ -258,10 +258,10 @@ CONFIG_NILFS2_FS=m
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_OVERLAY_FS=m
-CONFIG_ISO9660_FS=y
+CONFIG_ISO9660_FS=m
 CONFIG_UDF_FS=m
 CONFIG_MSDOS_FS=y
-CONFIG_VFAT_FS=y
+CONFIG_VFAT_FS=m
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
-- 
2.7.4
