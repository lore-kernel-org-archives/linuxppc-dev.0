Return-Path: <richard.rojfors@mocean-labs.com>
Received: from av7-1-sn3.vrr.skanova.net (av7-1-sn3.vrr.skanova.net
	[81.228.9.181]) by ozlabs.org (Postfix) with ESMTP id E8D97B7088
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 03:33:52 +1100 (EST)
Message-ID: <4AFAE769.8040909@mocean-labs.com>
Date: Wed, 11 Nov 2009 17:33:45 +0100
From: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
MIME-Version: 1.0
To: spi-devel-general@lists.sourceforge.net
Subject: [PATCH] xilinx_spi: Add the platform driver to the Kconfig
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	dbrownell@users.sourceforge.net, John Linn <John.Linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the xilinx_spi_pltfm to the SPI Kconfig.

The xilinx_spi_pltfm was added in a previous patchset.

Signed-off-by: Richard Röjfors <richard.rojfors@mocean-labs.com>
---
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b956284..d1f8ee3 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -252,6 +252,13 @@ config SPI_XILINX_OF
 	help
 	  This is the OF driver for the SPI controller IP from the Xilinx EDK.

+config SPI_XILINX_PLTFM
+	tristate "Xilinx SPI controller platform device"
+	depends on SPI_XILINX
+	help
+	  This is the platform driver for the SPI controller IP
+	  from the Xilinx EDK.
+
 #
 # Add new SPI master controllers in alphabetical order above this line
 #
