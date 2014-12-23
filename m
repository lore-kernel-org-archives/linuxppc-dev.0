Return-Path: <shh.xie@gmail.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0094.outbound.protection.outlook.com [65.55.169.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ECA1A1A0BDC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 22:22:00 +1100 (AEDT)
From: <shh.xie@gmail.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 3/3] powerpc/config: Enable MDIO support
Date: Tue, 23 Dec 2014 18:17:56 +0800
Message-ID: <1419329876-28416-1-git-send-email-shh.xie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Andy Fleming <afleming@gmail.com>, Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andy Fleming <afleming@gmail.com>

Also, enable Vitesse PHY and fixed PHY support.

Signed-off-by: Andy Fleming <afleming@gmail.com>
Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
---
this patch is based on below patch:
http://patchwork.ozlabs.org/patch/423348/

 arch/powerpc/configs/corenet32_smp_defconfig | 1 +
 arch/powerpc/configs/corenet64_smp_defconfig | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 6577c41..14855db 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -98,6 +98,7 @@ CONFIG_SATA_SIL=y
 CONFIG_PATA_SIL680=y
 CONFIG_NETDEVICES=y
 CONFIG_FSL_PQ_MDIO=y
+CONFIG_FSL_XGMAC_MDIO=y
 CONFIG_E1000=y
 CONFIG_E1000E=y
 CONFIG_VITESSE_PHY=y
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 4016cf6..e9ccc78 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -79,7 +79,11 @@ CONFIG_SATA_FSL=y
 CONFIG_SATA_SIL24=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
+CONFIG_FSL_PQ_MDIO=y
+CONFIG_FSL_XGMAC_MDIO=y
 CONFIG_E1000E=y
+CONFIG_VITESSE_PHY=y
+CONFIG_FIXED_PHY=y
 CONFIG_MDIO_BUS_MUX=y
 CONFIG_MDIO_BUS_MUX_GPIO=y
 CONFIG_MDIO_BUS_MUX_MMIOREG=y
-- 
1.8.4.1
