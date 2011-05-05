Return-Path: <shawn.guo@linaro.org>
From: Shawn Guo <shawn.guo@linaro.org>
To: linux-mmc@vger.kernel.org
Subject: [PATCH v2 7/7] ARM: mxc: remove esdhc.h and use the public one
Date: Thu,  5 May 2011 21:22:58 +0800
Message-Id: <1304601778-13837-8-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, sameo@linux.intel.com,
	Arnd Bergmann <arnd@arndb.de>, patches@linaro.org,
	Shawn Guo <shawn.guo@linaro.org>, devicetree-discuss@lists.ozlabs.org,
	Saeed Bishara <saeed@marvell.com>,
	Xiaobo Xie <X.Xie@freescale.com>, kernel@pengutronix.de,
	Mike Rapoport <mike@compulab.co.il>, Olof Johansson <olof@lixom.net>,
	Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev@lists.ozlabs.org,
	Albert Herranz <albert_herranz@yahoo.es>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |    1 -
 arch/arm/plat-mxc/include/mach/devices-common.h    |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c b/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
index 6b2940b..b401689 100644
--- a/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
+++ b/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
@@ -8,7 +8,6 @@
 
 #include <mach/hardware.h>
 #include <mach/devices-common.h>
-#include <mach/esdhc.h>
 
 #define imx_sdhci_esdhc_imx_data_entry_single(soc, _id, hwid) \
 	{								\
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 8658c9c..c95ab13 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -243,7 +243,7 @@ struct imx_mxc_w1_data {
 struct platform_device *__init imx_add_mxc_w1(
 		const struct imx_mxc_w1_data *data);
 
-#include <mach/esdhc.h>
+#include <linux/mmc/esdhc.h>
 struct imx_sdhci_esdhc_imx_data {
 	int id;
 	resource_size_t iobase;
-- 
1.7.4.1
