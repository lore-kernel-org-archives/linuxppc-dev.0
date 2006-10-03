Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 72C0867C23
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 03:48:23 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k93J8Pxw011398
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Oct 2006 13:08:25 -0600 (MDT)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k93HmGne009534
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Oct 2006 12:48:17 -0500 (CDT)
Message-ID: <4522A260.8000801@freescale.com>
Date: Tue, 03 Oct 2006 12:48:16 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Add DOS partition support to mpc834x_itx_defconfig
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(resending because the signed-off line was missing)

The default configuration file for the MPC8349E-mITX reference board,
mpc834x_itx_defconfig, did not include support for DOS partition table types.
This support is necessary because the hard drive that comes with the ITX
is formatted with this partition table type.  Without this config option,
the drive cannot be mounted.

Signed-off-by: Timur Tabi <timur@freescale.com>

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
