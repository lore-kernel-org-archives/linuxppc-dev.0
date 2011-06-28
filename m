Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc/pseries: remove duplicate SCSI_BNX2_ISCSI in
	pseries_defconfig
Date: Tue, 28 Jun 2011 15:55:30 +1000
Message-ID: <18285.1309240530@neuling.org>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove duplicate assignment of SCSI_BNX2_ISCSI in pseries_defconfig
introduced by:
  37e0c21e powerpc/pseries: Enable iSCSI support for a number of cards

causes warning:
arch/powerpc/configs/pseries_defconfig:151:warning: override: reassigning to symbol SCSI_BNX2_ISCSI

Signed-off-by: Michael Neuling <mikey@neuling.org>

diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index c9f212b..80bc5de 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -148,7 +148,6 @@ CONFIG_SCSI_SAS_ATTRS=m
 CONFIG_SCSI_CXGB3_ISCSI=m
 CONFIG_SCSI_CXGB4_ISCSI=m
 CONFIG_SCSI_BNX2_ISCSI=m
-CONFIG_SCSI_BNX2_ISCSI=m
 CONFIG_BE2ISCSI=m
 CONFIG_SCSI_IBMVSCSI=y
 CONFIG_SCSI_IBMVFC=m
