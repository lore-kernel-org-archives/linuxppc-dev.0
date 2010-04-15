Return-Path: <R1AAHA@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6C417B7D1B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Apr 2010 09:48:57 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3FNmcul006964 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Apr 2010 16:48:48 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3FNubTU002562
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Apr 2010 18:56:37 -0500 (CDT)
Date: Thu, 15 Apr 2010 18:59:13 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: 83xx: configure SIL SATA driver in 83xx-wide
	defconfig
Message-Id: <20100415185913.2a52e1b3.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

to enable the storage controller on earlier rev. mpc834x itx boards.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/configs/mpc83xx_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/configs/mpc83xx_defconfig b/arch/powerpc/configs/mpc83xx_defconfig
index 05bec48..c6f80fa 100644
--- a/arch/powerpc/configs/mpc83xx_defconfig
+++ b/arch/powerpc/configs/mpc83xx_defconfig
@@ -712,7 +712,7 @@ CONFIG_ATA_SFF=y
 # CONFIG_SATA_QSTOR is not set
 # CONFIG_SATA_PROMISE is not set
 # CONFIG_SATA_SX4 is not set
-# CONFIG_SATA_SIL is not set
+CONFIG_SATA_SIL=y
 # CONFIG_SATA_SIS is not set
 # CONFIG_SATA_ULI is not set
 # CONFIG_SATA_VIA is not set
-- 
1.7.0.5
