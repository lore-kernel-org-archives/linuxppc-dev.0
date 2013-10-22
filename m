Return-Path: <anton@samba.org>
Date: Tue, 22 Oct 2013 11:46:15 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 3/3] powerpc: Enable virtio on ppc64 and pseries configs
Message-ID: <20131022114615.5371528c@kryten>
In-Reply-To: <20131022114450.296ae01d@kryten>
References: <20131022114450.296ae01d@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/configs/pseries_defconfig
===================================================================
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -127,6 +127,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
+CONFIG_VIRTIO_BLK=m
 CONFIG_IDE=y
 CONFIG_BLK_DEV_IDECD=y
 CONFIG_BLK_DEV_GENERIC=y
@@ -152,6 +153,7 @@ CONFIG_SCSI_IPR=y
 CONFIG_SCSI_QLA_FC=m
 CONFIG_SCSI_QLA_ISCSI=m
 CONFIG_SCSI_LPFC=m
+CONFIG_SCSI_VIRTIO=m
 CONFIG_SCSI_DH=m
 CONFIG_SCSI_DH_RDAC=m
 CONFIG_SCSI_DH_ALUA=m
@@ -180,6 +182,7 @@ CONFIG_DUMMY=m
 CONFIG_NETCONSOLE=y
 CONFIG_NETPOLL_TRAP=y
 CONFIG_TUN=m
+CONFIG_VIRTIO_NET=m
 CONFIG_VHOST_NET=m
 CONFIG_VORTEX=y
 CONFIG_ACENIC=m
@@ -218,6 +221,7 @@ CONFIG_SERIAL_JSM=m
 CONFIG_HVC_CONSOLE=y
 CONFIG_HVC_RTAS=y
 CONFIG_HVCS=m
+CONFIG_VIRTIO_CONSOLE=m
 CONFIG_IBM_BSR=m
 CONFIG_GEN_RTC=y
 CONFIG_RAW_DRIVER=y
@@ -259,6 +263,8 @@ CONFIG_INFINIBAND_IPOIB=m
 CONFIG_INFINIBAND_IPOIB_CM=y
 CONFIG_INFINIBAND_SRP=m
 CONFIG_INFINIBAND_ISER=m
+CONFIG_VIRTIO_PCI=m
+CONFIG_VIRTIO_BALLOON=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
Index: b/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -151,6 +151,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
+CONFIG_VIRTIO_BLK=m
 CONFIG_IDE=y
 CONFIG_BLK_DEV_IDECD=y
 CONFIG_BLK_DEV_GENERIC=y
@@ -179,6 +180,7 @@ CONFIG_SCSI_IPR=y
 CONFIG_SCSI_QLA_FC=m
 CONFIG_SCSI_QLA_ISCSI=m
 CONFIG_SCSI_LPFC=m
+CONFIG_SCSI_VIRTIO=m
 CONFIG_SCSI_DH=m
 CONFIG_SCSI_DH_RDAC=m
 CONFIG_SCSI_DH_ALUA=m
@@ -216,6 +218,7 @@ CONFIG_DUMMY=m
 CONFIG_NETCONSOLE=y
 CONFIG_NETPOLL_TRAP=y
 CONFIG_TUN=m
+CONFIG_VIRTIO_NET=m
 CONFIG_VHOST_NET=m
 CONFIG_VORTEX=y
 CONFIG_ACENIC=m
@@ -263,6 +266,7 @@ CONFIG_HVC_CONSOLE=y
 CONFIG_HVC_RTAS=y
 CONFIG_HVC_BEAT=y
 CONFIG_HVCS=m
+CONFIG_VIRTIO_CONSOLE=m
 CONFIG_IBM_BSR=m
 CONFIG_RAW_DRIVER=y
 CONFIG_I2C_CHARDEV=y
@@ -328,6 +332,8 @@ CONFIG_EDAC_MM_EDAC=y
 CONFIG_EDAC_PASEMI=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
+CONFIG_VIRTIO_PCI=m
+CONFIG_VIRTIO_BALLOON=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
