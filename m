Return-Path: <b04825@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 39ADB67BCE
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 07:42:30 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k8TN2TQD000608
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 17:02:29 -0600 (MDT)
From: timur@freescale.com
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Add DOS partition support to mpc834x_itx_defconfig
Date: Fri, 29 Sep 2006 16:42:26 -0500
Message-Id: <11595661462812-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Timur Tabi <timur@freescale.com>

The default configuration file for the MPC8349E-mITX reference board,
mpc834x_itx_defconfig, did not include support for DOS partition types.
This support is necessary because the hard drive that comes with the ITX
is formatted with this partition type.  Without this config option,
the drive cannot be mounted.

---
 arch/powerpc/configs/mpc834x_itx_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/configs/mpc834x_itx_defconfig b/arch/powerpc/configs/mpc834x_itx_defconfig
index cd3535e..0561b73 100644
--- a/arch/powerpc/configs/mpc834x_itx_defconfig
+++ b/arch/powerpc/configs/mpc834x_itx_defconfig
@@ -1248,7 +1248,7 @@ # CONFIG_OSF_PARTITION is not set
 # CONFIG_AMIGA_PARTITION is not set
 # CONFIG_ATARI_PARTITION is not set
 # CONFIG_MAC_PARTITION is not set
-# CONFIG_MSDOS_PARTITION is not set
+CONFIG_MSDOS_PARTITION=y
 # CONFIG_LDM_PARTITION is not set
 # CONFIG_SGI_PARTITION is not set
 # CONFIG_ULTRIX_PARTITION is not set
-- 
1.4.2.1
