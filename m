Return-Path: <anton@samba.org>
Date: Tue, 22 Oct 2013 11:45:31 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 2/3] powerpc: Enable multipath modules on ppc64 and pseries
Message-ID: <20131022114531.029f431f@kryten>
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


Enable a few modules required to boot on a POWER multipath
box.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/configs/pseries_defconfig
===================================================================
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -152,6 +152,9 @@ CONFIG_SCSI_IPR=y
 CONFIG_SCSI_QLA_FC=m
 CONFIG_SCSI_QLA_ISCSI=m
 CONFIG_SCSI_LPFC=m
+CONFIG_SCSI_DH=m
+CONFIG_SCSI_DH_RDAC=m
+CONFIG_SCSI_DH_ALUA=m
 CONFIG_ATA=y
 # CONFIG_ATA_SFF is not set
 CONFIG_MD=y
@@ -169,6 +172,9 @@ CONFIG_DM_SNAPSHOT=m
 CONFIG_DM_MIRROR=m
 CONFIG_DM_ZERO=m
 CONFIG_DM_MULTIPATH=m
+CONFIG_DM_MULTIPATH_QL=m
+CONFIG_DM_MULTIPATH_ST=m
+CONFIG_DM_UEVENT=y
 CONFIG_BONDING=m
 CONFIG_DUMMY=m
 CONFIG_NETCONSOLE=y
Index: b/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -179,6 +179,9 @@ CONFIG_SCSI_IPR=y
 CONFIG_SCSI_QLA_FC=m
 CONFIG_SCSI_QLA_ISCSI=m
 CONFIG_SCSI_LPFC=m
+CONFIG_SCSI_DH=m
+CONFIG_SCSI_DH_RDAC=m
+CONFIG_SCSI_DH_ALUA=m
 CONFIG_ATA=y
 CONFIG_SATA_SIL24=y
 CONFIG_SATA_SVW=y
@@ -197,6 +200,9 @@ CONFIG_DM_SNAPSHOT=m
 CONFIG_DM_MIRROR=m
 CONFIG_DM_ZERO=m
 CONFIG_DM_MULTIPATH=m
+CONFIG_DM_MULTIPATH_QL=m
+CONFIG_DM_MULTIPATH_ST=m
+CONFIG_DM_UEVENT=y
 CONFIG_ADB_PMU=y
 CONFIG_PMAC_SMU=y
 CONFIG_THERM_PM72=y
