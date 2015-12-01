Return-Path: <Pengbo.Li@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0148.outbound.protection.outlook.com [65.55.169.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 992321A1BE6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 16:18:55 +1100 (AEDT)
From: Pengbo Li <Pengbo.Li@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
CC: Pengbo Li <Pengbo.Li@freescale.com>
Subject: [PATCH] powerpc/85xx: Enable TWR_P102x option by default in
 mpc85xx_basic_defconfig
Date: Tue, 1 Dec 2015 13:11:28 +0800
Message-ID: <1448946688-8135-1-git-send-email-Pengbo.Li@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable TWR_P102x option by default in mpc85xx_basic_defconfig to support
p1025twr board.

Signed-off-by: Pengbo Li <Pengbo.Li@freescale.com>
---
 arch/powerpc/configs/mpc85xx_basic_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/mpc85xx_basic_defconfig b/arch/powerpc/configs/mpc85xx_basic_defconfig
index 850bd19..b1593fe 100644
--- a/arch/powerpc/configs/mpc85xx_basic_defconfig
+++ b/arch/powerpc/configs/mpc85xx_basic_defconfig
@@ -12,6 +12,7 @@ CONFIG_P1010_RDB=y
 CONFIG_P1022_DS=y
 CONFIG_P1022_RDK=y
 CONFIG_P1023_RDB=y
+CONFIG_TWR_P102x=y
 CONFIG_SBC8548=y
 CONFIG_SOCRATES=y
 CONFIG_STX_GP3=y
-- 
2.1.0.27.g96db324
