Return-Path: <hongtao.jia@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0147.outbound.protection.outlook.com [65.55.169.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 889061A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 18:03:25 +1100 (AEDT)
From: Jia Hongtao <hongtao.jia@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <B07421@freescale.com>
Subject: [PATCH 2/2] powerpc: Enable power monitor feature in defconfig for
 supported platforms
Date: Thu, 12 Mar 2015 15:00:14 +0800
Message-ID: <1426143614-24958-2-git-send-email-hongtao.jia@freescale.com>
In-Reply-To: <1426143614-24958-1-git-send-email-hongtao.jia@freescale.com>
References: <1426143614-24958-1-git-send-email-hongtao.jia@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: hongtao.jia@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
---
 arch/powerpc/configs/corenet32_smp_defconfig | 1 +
 arch/powerpc/configs/corenet64_smp_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 7370990..36970c8 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -119,6 +119,7 @@ CONFIG_SPI_GPIO=y
 CONFIG_SPI_FSL_SPI=y
 CONFIG_SPI_FSL_ESPI=y
 CONFIG_SENSORS_LM90=y
+CONFIG_SENSORS_INA2XX=y
 CONFIG_USB_HID=m
 CONFIG_USB=y
 CONFIG_USB_MON=y
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 4cfc3e8..6194a11 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -104,6 +104,7 @@ CONFIG_SPI_GPIO=y
 CONFIG_SPI_FSL_SPI=y
 CONFIG_SPI_FSL_ESPI=y
 CONFIG_SENSORS_LM90=y
+CONFIG_SENSORS_INA2XX=y
 CONFIG_USB_HID=m
 CONFIG_USB=y
 CONFIG_USB_MON=y
-- 
2.1.0.27.g96db324
