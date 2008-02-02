Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C6701DDED9
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 11:10:10 +1100 (EST)
Date: Fri, 1 Feb 2008 18:10:03 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/3] powerpc: mpc83xx_defconfig: enable math emulation and
	ucc_geth
Message-Id: <20080201181003.a3daf6ed.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

and some PHYs mpc83xx boards use.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/configs/mpc83xx_defconfig |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/configs/mpc83xx_defconfig b/arch/powerpc/configs/mpc83xx_defconfig
index 31bdbf3..a9807f0 100644
--- a/arch/powerpc/configs/mpc83xx_defconfig
+++ b/arch/powerpc/configs/mpc83xx_defconfig
@@ -186,7 +186,7 @@ CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT is not set
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_MATH_EMULATION is not set
+CONFIG_MATH_EMULATION=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_POPULATES_NODE_MAP=y
@@ -416,14 +416,14 @@ CONFIG_PHYLIB=y
 # MII PHY device drivers
 #
 CONFIG_MARVELL_PHY=y
-# CONFIG_DAVICOM_PHY is not set
+CONFIG_DAVICOM_PHY=y
 # CONFIG_QSEMI_PHY is not set
 # CONFIG_LXT_PHY is not set
 # CONFIG_CICADA_PHY is not set
-# CONFIG_VITESSE_PHY is not set
+CONFIG_VITESSE_PHY=y
 # CONFIG_SMSC_PHY is not set
 # CONFIG_BROADCOM_PHY is not set
-# CONFIG_ICPLUS_PHY is not set
+CONFIG_ICPLUS_PHY=y
 # CONFIG_FIXED_PHY is not set
 # CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
@@ -436,7 +436,7 @@ CONFIG_MII=y
 CONFIG_NETDEV_1000=y
 CONFIG_GIANFAR=y
 # CONFIG_GFAR_NAPI is not set
-# CONFIG_UCC_GETH is not set
+CONFIG_UCC_GETH=y
 CONFIG_NETDEV_10000=y
 
 #
-- 
1.5.2.2
