Return-Path: <B43644@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EC6822C00CE
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 12:35:29 +1000 (EST)
From: Po Liu <Po.Liu@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/4] powerpc/85xx: Update mpc85xx_defconfig for C293PCIE
Date: Thu, 25 Apr 2013 09:54:17 +0800
Message-ID: <1366854857-22791-4-git-send-email-Po.Liu@freescale.com>
In-Reply-To: <1366854857-22791-1-git-send-email-Po.Liu@freescale.com>
References: <1366854857-22791-1-git-send-email-Po.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mingkai Hu <Mingkai.Hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mingkai Hu <Mingkai.Hu@freescale.com>

Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
---
Base on git://git.am.freescale.net/gitolite/mirrors/linux-2.6.git
 arch/powerpc/configs/mpc85xx_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index cf815e8..ddc33a2 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -28,6 +28,7 @@ CONFIG_MPC85xx_MDS=y
 CONFIG_MPC8536_DS=y
 CONFIG_MPC85xx_DS=y
 CONFIG_MPC85xx_RDB=y
+CONFIG_C293_PCIE=y
 CONFIG_P1010_RDB=y
 CONFIG_P1022_DS=y
 CONFIG_P1022_RDK=y
-- 
1.8.0
