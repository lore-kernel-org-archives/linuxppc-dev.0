Return-Path: <r61911@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7D04E2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 18:41:17 +1100 (EST)
Received: from mail46-ch1 (localhost [127.0.0.1])	by mail46-ch1-R.bigfish.com
 (Postfix) with ESMTP id 070142A0228	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,
 14 Mar 2013 07:41:12 +0000 (UTC)
Received: from CH1EHSMHS022.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.250])	by mail46-ch1.bigfish.com (Postfix) with ESMTP id
 D1ADD260045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 07:41:10 +0000 (UTC)
From: Roy Zang <tie-fei.zang@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: enable E1000 NIC to mpc85xx_defconfig
Date: Thu, 14 Mar 2013 23:40:22 +0800
Message-ID: <1363275622-1412-1-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: b36666@freescale.com, B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

E1000 NIC is a common used Ethernet card. Enable it as default
for mpc85xx platform.

other change is due to make savedefconfig

Reported-by: Fu Jiwei <b36666@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
tested on P1010rdb board
 arch/powerpc/configs/mpc85xx_defconfig |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index cf815e8..e12146f 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -1,13 +1,12 @@
 CONFIG_PPC_85xx=y
 CONFIG_PHYS_64BIT=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_AUDIT=y
 CONFIG_IRQ_DOMAIN_DEBUG=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -113,6 +112,9 @@ CONFIG_DUMMY=y
 CONFIG_FS_ENET=y
 CONFIG_UCC_GETH=y
 CONFIG_GIANFAR=y
+CONFIG_E1000=y
+CONFIG_E1000E=y
+CONFIG_IGB=y
 CONFIG_MARVELL_PHY=y
 CONFIG_DAVICOM_PHY=y
 CONFIG_CICADA_PHY=y
@@ -132,7 +134,6 @@ CONFIG_SERIAL_8250_DETECT_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_QE=m
 CONFIG_NVRAM=y
-CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_CPM=m
 CONFIG_I2C_MPC=y
@@ -230,7 +231,6 @@ CONFIG_DEBUG_INFO=y
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
-CONFIG_CRYPTO_AES=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_FSL_CAAM=y
 CONFIG_CRYPTO_DEV_TALITOS=y
-- 
1.7.9.5
