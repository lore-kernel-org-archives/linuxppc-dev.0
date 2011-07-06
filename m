Return-Path: <anton@samba.org>
Message-Id: <20110706231337.090002111@samba.org>
Date: Thu, 07 Jul 2011 09:13:14 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 1/4] powerpc: Sync pseries and ppc64 defconfigs
References: <20110706231313.260037641@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pseries defconfig had a number of drivers enabled and we may
as well add them to the ppc64 defconfig.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- linux-powerpc.orig/arch/powerpc/configs/ppc64_defconfig	2011-07-05 15:05:59.903893167 +1000
+++ linux-powerpc/arch/powerpc/configs/ppc64_defconfig	2011-07-07 09:07:26.482898262 +1000
@@ -176,12 +176,18 @@ CONFIG_CHR_DEV_SG=y
 CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_FC_ATTRS=y
+CONFIG_SCSI_SAS_ATTRS=m
+CONFIG_SCSI_CXGB3_ISCSI=m
+CONFIG_SCSI_CXGB4_ISCSI=m
+CONFIG_SCSI_BNX2_ISCSI=m
+CONFIG_BE2ISCSI=m
 CONFIG_SCSI_IBMVSCSI=y
 CONFIG_SCSI_IBMVFC=m
 CONFIG_SCSI_SYM53C8XX_2=y
 CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
 CONFIG_SCSI_IPR=y
 CONFIG_SCSI_QLA_FC=m
+CONFIG_SCSI_QLA_ISCSI=m
 CONFIG_SCSI_LPFC=m
 CONFIG_ATA=y
 CONFIG_SATA_SIL24=y
@@ -235,11 +241,13 @@ CONFIG_ACENIC_OMIT_TIGON_I=y
 CONFIG_E1000=y
 CONFIG_E1000E=y
 CONFIG_TIGON3=y
+CONFIG_BNX2=m
 CONFIG_SPIDER_NET=m
 CONFIG_GELIC_NET=m
 CONFIG_GELIC_WIRELESS=y
 CONFIG_CHELSIO_T1=m
 CONFIG_CHELSIO_T3=m
+CONFIG_CHELSIO_T4=m
 CONFIG_EHEA=m
 CONFIG_IXGBE=m
 CONFIG_IXGB=m
@@ -248,6 +256,8 @@ CONFIG_MYRI10GE=m
 CONFIG_NETXEN_NIC=m
 CONFIG_PASEMI_MAC=y
 CONFIG_MLX4_EN=m
+CONFIG_QLGE=m
+CONFIG_BE2NET=m
 CONFIG_ISERIES_VETH=m
 CONFIG_PPP=m
 CONFIG_PPP_ASYNC=m
@@ -330,6 +340,8 @@ CONFIG_INFINIBAND_USER_MAD=m
 CONFIG_INFINIBAND_USER_ACCESS=m
 CONFIG_INFINIBAND_MTHCA=m
 CONFIG_INFINIBAND_EHCA=m
+CONFIG_INFINIBAND_CXGB3=m
+CONFIG_INFINIBAND_CXGB4=m
 CONFIG_MLX4_INFINIBAND=m
 CONFIG_INFINIBAND_IPOIB=m
 CONFIG_INFINIBAND_IPOIB_CM=y
