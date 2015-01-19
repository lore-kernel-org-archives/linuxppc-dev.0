Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A46771A0CD9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 10:24:32 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 hbabu@us.ibm.com, nacc@linux.vnet.ibm.com
Subject: [PATCH 3/7] powerpc: Enable CONFIG_SATA_AHCI on pseries and ppc64
 defconfigs
Date: Tue, 20 Jan 2015 10:24:21 +1100
Message-Id: <1421709865-6368-3-git-send-email-anton@samba.org>
In-Reply-To: <1421709865-6368-1-git-send-email-anton@samba.org>
References: <1421709865-6368-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are starting to see ppc64 boxes with SATA AHCI adapters in it,
so enable it in our defconfigs.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/configs/ppc64_defconfig      | 1 +
 arch/powerpc/configs/pseries_defconfig    | 1 +
 arch/powerpc/configs/pseries_le_defconfig | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index d657ad3..4ef6b8ca 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -116,6 +116,7 @@ CONFIG_SCSI_DH=m
 CONFIG_SCSI_DH_RDAC=m
 CONFIG_SCSI_DH_ALUA=m
 CONFIG_ATA=y
+CONFIG_SATA_AHCI=y
 CONFIG_SATA_SIL24=y
 CONFIG_SATA_MV=y
 CONFIG_SATA_SVW=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 145e5b0..ffd4bbd 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -109,6 +109,7 @@ CONFIG_SCSI_DH=m
 CONFIG_SCSI_DH_RDAC=m
 CONFIG_SCSI_DH_ALUA=m
 CONFIG_ATA=y
+CONFIG_SATA_AHCI=y
 # CONFIG_ATA_SFF is not set
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=y
diff --git a/arch/powerpc/configs/pseries_le_defconfig b/arch/powerpc/configs/pseries_le_defconfig
index 4ff694c..66db64a 100644
--- a/arch/powerpc/configs/pseries_le_defconfig
+++ b/arch/powerpc/configs/pseries_le_defconfig
@@ -110,6 +110,7 @@ CONFIG_SCSI_DH=m
 CONFIG_SCSI_DH_RDAC=m
 CONFIG_SCSI_DH_ALUA=m
 CONFIG_ATA=y
+CONFIG_SATA_AHCI=y
 # CONFIG_ATA_SFF is not set
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=y
-- 
2.1.0
