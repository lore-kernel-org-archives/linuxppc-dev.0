Return-Path: <anton@samba.org>
Date: Fri, 13 May 2011 08:23:13 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc/pseries: Enable iSCSI support for a number of cards
Message-ID: <20110513082313.2af9cc47@kryten>
In-Reply-To: <20110509091930.2e784e54@kryten>
References: <20110509091930.2e784e54@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Enable iSCSI support for a number of cards. We had the base
networking devices enabled but forgot to enable iSCSI.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

v2: I added the bnx2 iscsi twice.

Index: junk/arch/powerpc/configs/pseries_defconfig
===================================================================
--- junk.orig/arch/powerpc/configs/pseries_defconfig	2011-05-13 08:03:17.122419568 +1000
+++ junk/arch/powerpc/configs/pseries_defconfig	2011-05-13 08:03:43.962869252 +1000
@@ -146,12 +146,17 @@ CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_FC_ATTRS=y
 CONFIG_SCSI_SAS_ATTRS=m
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
 # CONFIG_ATA_SFF is not set
