Return-Path: <anton@samba.org>
Message-Id: <20110706231337.250013897@samba.org>
Date: Thu, 07 Jul 2011 09:13:16 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 3/4] powerpc: Add mpt2sas driver to pseries and ppc64 defconfig
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

Add mpt2sas driver to pseries and ppc64 defconfig.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- linux-powerpc.orig/arch/powerpc/configs/ppc64_defconfig	2011-07-07 09:07:29.932959288 +1000
+++ linux-powerpc/arch/powerpc/configs/ppc64_defconfig	2011-07-07 09:07:31.242982461 +1000
@@ -181,6 +181,7 @@ CONFIG_SCSI_CXGB3_ISCSI=m
 CONFIG_SCSI_CXGB4_ISCSI=m
 CONFIG_SCSI_BNX2_ISCSI=m
 CONFIG_BE2ISCSI=m
+CONFIG_SCSI_MPT2SAS=m
 CONFIG_SCSI_IBMVSCSI=y
 CONFIG_SCSI_IBMVFC=m
 CONFIG_SCSI_SYM53C8XX_2=y
Index: linux-powerpc/arch/powerpc/configs/pseries_defconfig
===================================================================
--- linux-powerpc.orig/arch/powerpc/configs/pseries_defconfig	2011-07-05 14:23:08.098773438 +1000
+++ linux-powerpc/arch/powerpc/configs/pseries_defconfig	2011-07-07 09:07:31.242982461 +1000
@@ -149,6 +149,7 @@ CONFIG_SCSI_CXGB3_ISCSI=m
 CONFIG_SCSI_CXGB4_ISCSI=m
 CONFIG_SCSI_BNX2_ISCSI=m
 CONFIG_BE2ISCSI=m
+CONFIG_SCSI_MPT2SAS=m
 CONFIG_SCSI_IBMVSCSI=y
 CONFIG_SCSI_IBMVFC=m
 CONFIG_SCSI_SYM53C8XX_2=y
