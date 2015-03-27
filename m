Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0131.outbound.protection.outlook.com [207.46.100.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 873941A02AC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 21:48:59 +1100 (AEDT)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH] powerpc/defconfig: enable CONFIG_I2C_MUX and
 CONFIG_I2C_MUX_PCA954x
Date: Fri, 27 Mar 2015 18:45:35 +0800
Message-ID: <1427453135-11319-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

By default we enable CONFIG_I2C_MUX and CONFIG_I2C_MUX_PCA954x,
which are needed on T2080QDS, T4240QDS, B4860QDS, etc.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
against 'next' branch of git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git

 arch/powerpc/configs/corenet32_smp_defconfig | 2 ++
 arch/powerpc/configs/corenet64_smp_defconfig | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 51866f1..6cf323f 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -114,6 +114,8 @@ CONFIG_NVRAM=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MPC=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
 CONFIG_SPI=y
 CONFIG_SPI_GPIO=y
 CONFIG_SPI_FSL_SPI=y
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index d6c0c81..9d8ca81 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -99,6 +99,8 @@ CONFIG_SERIAL_8250_RSA=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MPC=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
 CONFIG_SPI=y
 CONFIG_SPI_GPIO=y
 CONFIG_SPI_FSL_SPI=y
-- 
2.1.0.27.g96db324
