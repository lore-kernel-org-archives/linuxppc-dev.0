Return-Path: <kim.phillips@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4DF1FDDE11
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 09:34:30 +1000 (EST)
Date: Tue, 7 Aug 2007 18:34:15 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] turn on icplus phy in mpc8323rdb defconfig
Message-Id: <20070807183415.b8926f30.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

support for the MPC8323E RDB's ICPlus PHY was recently added to the
kernel, so now we can have it turned on by default.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/configs/mpc832x_rdb_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/mpc832x_rdb_defconfig b/arch/powerpc/configs/mpc832x_rdb_defconfig
index 6a83b66..4064d05 100644
--- a/arch/powerpc/configs/mpc832x_rdb_defconfig
+++ b/arch/powerpc/configs/mpc832x_rdb_defconfig
@@ -497,6 +497,7 @@ CONFIG_PHYLIB=y
 # CONFIG_VITESSE_PHY is not set
 # CONFIG_SMSC_PHY is not set
 # CONFIG_BROADCOM_PHY is not set
+CONFIG_ICPLUS_PHY=y
 # CONFIG_FIXED_PHY is not set
 
 #
-- 
1.5.2.2
