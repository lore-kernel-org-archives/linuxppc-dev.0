Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 245452C008F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 08:40:58 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/85xx: enable Silicon image 3132 PCIe to SATA
 controller
Date: Wed, 10 Apr 2013 17:40:49 -0500
Message-ID: <1365633649-27046-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Roy ZANG <tie-fei.zang@freescale.com>

Some 85xx board, for example, P1020RDB-PC has on board silicon image
PCIe to SATA controller and when booting up, the filesystem will auto mount
to the SATA disk. So enable silicon image 3132 pcie to sata controller
by default

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/configs/mpc85xx_defconfig     |    1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index cf815e8..75f17cf 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -106,6 +106,7 @@ CONFIG_SCSI_LOGGING=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_FSL=y
+CONFIG_SATA_SIL24=y
 CONFIG_PATA_ALI=y
 CONFIG_PATA_VIA=y
 CONFIG_NETDEVICES=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index 8d00ea5b..64ae227 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -108,6 +108,7 @@ CONFIG_SCSI_LOGGING=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_FSL=y
+CONFIG_SATA_SIL24=y
 CONFIG_PATA_ALI=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
-- 
1.7.9.5
