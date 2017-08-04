Return-Path: <boris.brezillon@free-electrons.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xP9zn1C7QzDqJC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Aug 2017 01:37:56 +1000 (AEST)
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: Boris Brezillon <boris.brezillon@free-electrons.com>,
 Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 Peter Pan <peterpandong@micron.com>, Jonathan Corbet <corbet@lwn.net>,
 Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 Hartley Sweeten <hsweeten@visionengravers.com>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>, Eric Miao <eric.y.miao@gmail.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
 Alexander Clouter <alex@digriz.org.uk>, Daniel Mack <daniel@zonque.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Simtec Linux Team <linux@simtec.co.uk>, Steven Miao <realmz6@gmail.com>,
 Mikael Starvik <starvik@axis.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Ralf Baechle <ralf@linux-mips.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu <rainyfeeling@outlook.com>,
 Kamal Dasu <kdasu.kdev@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, Han Xu <han.xu@nxp.com>,
 Harvey Hunt <harveyhuntnexus@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>,
 Sylvain Lemieux <slemieux.tyco@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Wan ZongShun <mcuos.com@gmail.com>,
 Neil Armstrong <narmstrong@baylibre.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Maxim Levitsky <maximlevitsky@gmail.com>,
 Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Stefan Agner <stefan@agner.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-cris-kernel@axis.com,
 linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-mediatek@lists.infradead.org,
 linux-oxnas@lists.tuxfamily.org, linuxppc-dev@lists.ozlabs.org,
 devel@driverdev.osuosl.org
Subject: [PATCH] mtd: nand: Rename nand.h into rawnand.h
Date: Fri,  4 Aug 2017 17:29:09 +0200
Message-Id: <1501860550-16506-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are planning to share more code between different NAND based
devices (SPI NAND, OneNAND and raw NANDs), but before doing that
we need to move the existing include/linux/mtd/nand.h file into
include/linux/mtd/rawnand.h so we can later create a nand.h header
containing all common structure and function prototypes.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Peter Pan <peterpandong@micron.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khalasa@piap.pl>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Alexander Clouter <alex@digriz.org.uk>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Simtec Linux Team <linux@simtec.co.uk>
Cc: Steven Miao <realmz6@gmail.com>
Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Wenyou Yang <wenyou.yang@atmel.com>
Cc: Josh Wu <rainyfeeling@outlook.com>
Cc: Kamal Dasu <kdasu.kdev@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Han Xu <han.xu@nxp.com>
Cc: Harvey Hunt <harveyhuntnexus@gmail.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Wan ZongShun <mcuos.com@gmail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: adi-buildroot-devel@lists.sourceforge.net
Cc: linux-cris-kernel@axis.com
Cc: linux-mips@linux-mips.org
Cc: linux-sh@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-mediatek@lists.infradead.org
Cc: linux-oxnas@lists.tuxfamily.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: devel@driverdev.osuosl.org
---
Hi All,

Sorry for the huge Cc list, but I'd like to collect as much acks as
possible for this patch which is actually part of a bigger series [1].

Note that there's nothing complicated here, it's just a mechanical
s/nand\.h/rawnand\.h/ replacement, but it impacts several architectures,
the doc and staging directories.

Regards,

Boris

[1]https://lwn.net/Articles/723694/
---
 Documentation/driver-api/mtdnand.rst            | 8 ++++----
 MAINTAINERS                                     | 2 +-
 arch/arm/mach-davinci/board-da850-evm.c         | 2 +-
 arch/arm/mach-davinci/board-dm355-evm.c         | 2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c     | 2 +-
 arch/arm/mach-davinci/board-dm365-evm.c         | 2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c        | 2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c        | 2 +-
 arch/arm/mach-davinci/board-sffsdr.c            | 2 +-
 arch/arm/mach-dove/dove-db-setup.c              | 2 +-
 arch/arm/mach-ep93xx/snappercl15.c              | 2 +-
 arch/arm/mach-ep93xx/ts72xx.c                   | 2 +-
 arch/arm/mach-imx/mach-qong.c                   | 2 +-
 arch/arm/mach-ixp4xx/ixdp425-setup.c            | 2 +-
 arch/arm/mach-mmp/aspenite.c                    | 2 +-
 arch/arm/mach-omap1/board-fsample.c             | 2 +-
 arch/arm/mach-omap1/board-h2.c                  | 2 +-
 arch/arm/mach-omap1/board-h3.c                  | 2 +-
 arch/arm/mach-omap1/board-nand.c                | 2 +-
 arch/arm/mach-omap1/board-perseus2.c            | 2 +-
 arch/arm/mach-orion5x/db88f5281-setup.c         | 2 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c       | 2 +-
 arch/arm/mach-orion5x/ts209-setup.c             | 2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c            | 2 +-
 arch/arm/mach-pxa/balloon3.c                    | 2 +-
 arch/arm/mach-pxa/em-x270.c                     | 2 +-
 arch/arm/mach-pxa/eseries.c                     | 2 +-
 arch/arm/mach-pxa/palmtx.c                      | 2 +-
 arch/arm/mach-pxa/tosa.c                        | 2 +-
 arch/arm/mach-s3c24xx/common-smdk.c             | 2 +-
 arch/arm/mach-s3c24xx/mach-anubis.c             | 2 +-
 arch/arm/mach-s3c24xx/mach-at2440evb.c          | 2 +-
 arch/arm/mach-s3c24xx/mach-bast.c               | 2 +-
 arch/arm/mach-s3c24xx/mach-gta02.c              | 2 +-
 arch/arm/mach-s3c24xx/mach-jive.c               | 2 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c           | 2 +-
 arch/arm/mach-s3c24xx/mach-osiris.c             | 2 +-
 arch/arm/mach-s3c24xx/mach-qt2410.c             | 2 +-
 arch/arm/mach-s3c24xx/mach-rx3715.c             | 2 +-
 arch/arm/mach-s3c24xx/mach-vstms.c              | 2 +-
 arch/blackfin/mach-bf537/boards/dnp5370.c       | 2 +-
 arch/blackfin/mach-bf537/boards/stamp.c         | 2 +-
 arch/blackfin/mach-bf561/boards/acvilon.c       | 2 +-
 arch/cris/arch-v32/drivers/mach-a3/nandflash.c  | 2 +-
 arch/cris/arch-v32/drivers/mach-fs/nandflash.c  | 2 +-
 arch/mips/alchemy/devboards/db1200.c            | 2 +-
 arch/mips/alchemy/devboards/db1300.c            | 2 +-
 arch/mips/alchemy/devboards/db1550.c            | 2 +-
 arch/mips/include/asm/mach-jz4740/jz4740_nand.h | 2 +-
 arch/mips/netlogic/xlr/platform-flash.c         | 2 +-
 arch/mips/pnx833x/common/platform.c             | 2 +-
 arch/mips/rb532/devices.c                       | 2 +-
 arch/sh/boards/mach-migor/setup.c               | 2 +-
 drivers/mtd/inftlcore.c                         | 2 +-
 drivers/mtd/nand/ams-delta.c                    | 2 +-
 drivers/mtd/nand/atmel/nand-controller.c        | 2 +-
 drivers/mtd/nand/atmel/pmecc.c                  | 2 +-
 drivers/mtd/nand/au1550nd.c                     | 2 +-
 drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h  | 2 +-
 drivers/mtd/nand/bf5xx_nand.c                   | 2 +-
 drivers/mtd/nand/brcmnand/brcmnand.c            | 2 +-
 drivers/mtd/nand/cafe_nand.c                    | 2 +-
 drivers/mtd/nand/cmx270_nand.c                  | 2 +-
 drivers/mtd/nand/cs553x_nand.c                  | 2 +-
 drivers/mtd/nand/davinci_nand.c                 | 2 +-
 drivers/mtd/nand/denali.h                       | 2 +-
 drivers/mtd/nand/diskonchip.c                   | 2 +-
 drivers/mtd/nand/docg4.c                        | 2 +-
 drivers/mtd/nand/fsl_elbc_nand.c                | 2 +-
 drivers/mtd/nand/fsl_ifc_nand.c                 | 2 +-
 drivers/mtd/nand/fsl_upm.c                      | 2 +-
 drivers/mtd/nand/fsmc_nand.c                    | 2 +-
 drivers/mtd/nand/gpio.c                         | 2 +-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h          | 2 +-
 drivers/mtd/nand/hisi504_nand.c                 | 2 +-
 drivers/mtd/nand/jz4740_nand.c                  | 2 +-
 drivers/mtd/nand/jz4780_nand.c                  | 2 +-
 drivers/mtd/nand/lpc32xx_mlc.c                  | 2 +-
 drivers/mtd/nand/lpc32xx_slc.c                  | 2 +-
 drivers/mtd/nand/mpc5121_nfc.c                  | 2 +-
 drivers/mtd/nand/mtk_nand.c                     | 2 +-
 drivers/mtd/nand/mxc_nand.c                     | 2 +-
 drivers/mtd/nand/nand_amd.c                     | 2 +-
 drivers/mtd/nand/nand_base.c                    | 2 +-
 drivers/mtd/nand/nand_bbt.c                     | 2 +-
 drivers/mtd/nand/nand_bch.c                     | 2 +-
 drivers/mtd/nand/nand_ecc.c                     | 2 +-
 drivers/mtd/nand/nand_hynix.c                   | 2 +-
 drivers/mtd/nand/nand_ids.c                     | 2 +-
 drivers/mtd/nand/nand_macronix.c                | 2 +-
 drivers/mtd/nand/nand_micron.c                  | 2 +-
 drivers/mtd/nand/nand_samsung.c                 | 2 +-
 drivers/mtd/nand/nand_timings.c                 | 2 +-
 drivers/mtd/nand/nand_toshiba.c                 | 2 +-
 drivers/mtd/nand/nandsim.c                      | 2 +-
 drivers/mtd/nand/ndfc.c                         | 2 +-
 drivers/mtd/nand/nuc900_nand.c                  | 2 +-
 drivers/mtd/nand/omap2.c                        | 2 +-
 drivers/mtd/nand/orion_nand.c                   | 2 +-
 drivers/mtd/nand/oxnas_nand.c                   | 2 +-
 drivers/mtd/nand/pasemi_nand.c                  | 2 +-
 drivers/mtd/nand/plat_nand.c                    | 2 +-
 drivers/mtd/nand/pxa3xx_nand.c                  | 2 +-
 drivers/mtd/nand/qcom_nandc.c                   | 2 +-
 drivers/mtd/nand/r852.h                         | 2 +-
 drivers/mtd/nand/s3c2410.c                      | 2 +-
 drivers/mtd/nand/sh_flctl.c                     | 2 +-
 drivers/mtd/nand/sharpsl.c                      | 2 +-
 drivers/mtd/nand/sm_common.c                    | 2 +-
 drivers/mtd/nand/socrates_nand.c                | 2 +-
 drivers/mtd/nand/sunxi_nand.c                   | 2 +-
 drivers/mtd/nand/tango_nand.c                   | 2 +-
 drivers/mtd/nand/tmio_nand.c                    | 2 +-
 drivers/mtd/nand/txx9ndfmc.c                    | 2 +-
 drivers/mtd/nand/vf610_nfc.c                    | 2 +-
 drivers/mtd/nand/xway_nand.c                    | 2 +-
 drivers/mtd/nftlcore.c                          | 2 +-
 drivers/mtd/nftlmount.c                         | 2 +-
 drivers/mtd/ssfdc.c                             | 2 +-
 drivers/mtd/tests/nandbiterrs.c                 | 2 +-
 drivers/staging/mt29f_spinand/mt29f_spinand.c   | 2 +-
 fs/jffs2/wbuf.c                                 | 2 +-
 include/linux/mtd/nand-gpio.h                   | 2 +-
 include/linux/mtd/{nand.h => rawnand.h}         | 8 +++-----
 include/linux/mtd/sh_flctl.h                    | 2 +-
 include/linux/mtd/sharpsl.h                     | 2 +-
 include/linux/platform_data/mtd-davinci.h       | 2 +-
 include/linux/platform_data/mtd-nand-s3c2410.h  | 2 +-
 128 files changed, 133 insertions(+), 135 deletions(-)
 rename include/linux/mtd/{nand.h => rawnand.h} (99%)

diff --git a/Documentation/driver-api/mtdnand.rst b/Documentation/driver-api/mtdnand.rst
index e9afa586d15e..2a5191b6d445 100644
--- a/Documentation/driver-api/mtdnand.rst
+++ b/Documentation/driver-api/mtdnand.rst
@@ -516,7 +516,7 @@ mirrored table is performed.
 
 The most important field in the nand_bbt_descr structure is the
 options field. The options define most of the table properties. Use the
-predefined constants from nand.h to define the options.
+predefined constants from rawnand.h to define the options.
 
 -  Number of bits per block
 
@@ -843,7 +843,7 @@ Chip option constants
 Constants for chip id table
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-These constants are defined in nand.h. They are OR-ed together to
+These constants are defined in rawnand.h. They are OR-ed together to
 describe the chip functionality::
 
     /* Buswitdh is 16 bit */
@@ -865,7 +865,7 @@ describe the chip functionality::
 Constants for runtime options
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-These constants are defined in nand.h. They are OR-ed together to
+These constants are defined in rawnand.h. They are OR-ed together to
 describe the functionality::
 
     /* The hw ecc generator provides a syndrome instead a ecc value on read
@@ -956,7 +956,7 @@ developer. Each struct member has a short description which is marked
 with an [XXX] identifier. See the chapter "Documentation hints" for an
 explanation.
 
-.. kernel-doc:: include/linux/mtd/nand.h
+.. kernel-doc:: include/linux/mtd/rawnand.h
    :internal:
 
 Public Functions Provided
diff --git a/MAINTAINERS b/MAINTAINERS
index 205d3977ac46..bffb38373550 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9034,7 +9034,7 @@ T:	git git://git.infradead.org/linux-mtd.git nand/fixes
 T:	git git://git.infradead.org/l2-mtd.git nand/next
 S:	Maintained
 F:	drivers/mtd/nand/
-F:	include/linux/mtd/nand*.h
+F:	include/linux/mtd/*nand*.h
 
 NATSEMI ETHERNET DRIVER (DP8381x)
 S:	Orphan
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index b5625d009288..f54410388194 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -26,7 +26,7 @@
 #include <linux/input/tps6507x-ts.h>
 #include <linux/mfd/tps6507x.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/platform_device.h>
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 18296a99c4d2..62e7bc3018f0 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -14,7 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/i2c.h>
 #include <linux/gpio.h>
 #include <linux/clk.h>
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index 284ff27c1b32..be997243447b 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -13,7 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/i2c.h>
 #include <linux/gpio.h>
 #include <linux/clk.h>
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 0464999b7137..e75741fb2c1d 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -23,7 +23,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/slab.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/input.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 70e00dbeec96..b07c9b18d427 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -17,7 +17,7 @@
 #include <linux/platform_data/pcf857x.h>
 #include <linux/platform_data/at24.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/phy.h>
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 1d76e7480a42..cb0a41e83582 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -29,7 +29,7 @@
 #include <media/i2c/adv7343.h>
 
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/clk.h>
 #include <linux/export.h>
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 41c7c9615791..d85accf7f760 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -28,7 +28,7 @@
 #include <linux/i2c.h>
 #include <linux/platform_data/at24.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-dove/dove-db-setup.c b/arch/arm/mach-dove/dove-db-setup.c
index bcb678fd2415..8971c3c0f0fe 100644
--- a/arch/arm/mach-dove/dove-db-setup.c
+++ b/arch/arm/mach-dove/dove-db-setup.c
@@ -13,7 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/irq.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/timer.h>
 #include <linux/ata_platform.h>
 #include <linux/mv643xx_eth.h>
diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index b2db791b3b38..8b29398f4dc7 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -25,7 +25,7 @@
 #include <linux/fb.h>
 
 #include <linux/mtd/partitions.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 
 #include <mach/hardware.h>
 #include <linux/platform_data/video-ep93xx.h>
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 55b186ef863a..8745162ec05d 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -16,7 +16,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-imx/mach-qong.c b/arch/arm/mach-imx/mach-qong.c
index 8c2cbd693d21..42a700053103 100644
--- a/arch/arm/mach-imx/mach-qong.c
+++ b/arch/arm/mach-imx/mach-qong.c
@@ -18,7 +18,7 @@
 #include <linux/memory.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/gpio.h>
 
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index 508c2d7786e2..93b89291c06b 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -17,7 +17,7 @@
 #include <linux/i2c-gpio.h>
 #include <linux/io.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 5db0edf716dd..d2283009a5ff 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -16,7 +16,7 @@
 #include <linux/smc91x.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/interrupt.h>
 #include <linux/platform_data/mv_usb.h>
 
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index fad95b74bb65..b93ad58b0a63 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -16,7 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/input.h>
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 675254ee4b1e..a444b139bff5 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -24,7 +24,7 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/input.h>
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index e62f9d454f10..a618a49a30b8 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -23,7 +23,7 @@
 #include <linux/workqueue.h>
 #include <linux/i2c.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/input.h>
diff --git a/arch/arm/mach-omap1/board-nand.c b/arch/arm/mach-omap1/board-nand.c
index 7684f9203474..1bffbb4e050f 100644
--- a/arch/arm/mach-omap1/board-nand.c
+++ b/arch/arm/mach-omap1/board-nand.c
@@ -16,7 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 150b57ba42bf..e994a78bdd09 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -16,7 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/input.h>
diff --git a/arch/arm/mach-orion5x/db88f5281-setup.c b/arch/arm/mach-orion5x/db88f5281-setup.c
index 12f74b46e2ff..3f5863de766a 100644
--- a/arch/arm/mach-orion5x/db88f5281-setup.c
+++ b/arch/arm/mach-orion5x/db88f5281-setup.c
@@ -16,7 +16,7 @@
 #include <linux/pci.h>
 #include <linux/irq.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/timer.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/i2c.h>
diff --git a/arch/arm/mach-orion5x/kurobox_pro-setup.c b/arch/arm/mach-orion5x/kurobox_pro-setup.c
index 9dc3f59bed9c..83d43cff4bd7 100644
--- a/arch/arm/mach-orion5x/kurobox_pro-setup.c
+++ b/arch/arm/mach-orion5x/kurobox_pro-setup.c
@@ -15,7 +15,7 @@
 #include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/i2c.h>
 #include <linux/serial_reg.h>
diff --git a/arch/arm/mach-orion5x/ts209-setup.c b/arch/arm/mach-orion5x/ts209-setup.c
index 7bd671b2854c..0c315515dd2d 100644
--- a/arch/arm/mach-orion5x/ts209-setup.c
+++ b/arch/arm/mach-orion5x/ts209-setup.c
@@ -15,7 +15,7 @@
 #include <linux/pci.h>
 #include <linux/irq.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index 7ef80a8304c0..94778739e38f 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -16,7 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/ata_platform.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/timeriomem-rng.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 1467c1d1e541..d6d92f388f14 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -29,7 +29,7 @@
 #include <linux/types.h>
 #include <linux/platform_data/pcf857x.h>
 #include <linux/i2c/pxa-i2c.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/physmap.h>
 #include <linux/regulator/max1586.h>
 
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 811a7317f3ea..6d28035ebba5 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -15,7 +15,7 @@
 
 #include <linux/dm9000.h>
 #include <linux/platform_data/rtc-v3020.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/input.h>
diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index fa9d71d194f0..91f7c3e40065 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -20,7 +20,7 @@
 #include <linux/mfd/tc6387xb.h>
 #include <linux/mfd/tc6393xb.h>
 #include <linux/mfd/t7l66xb.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/usb/gpio_vbus.h>
 #include <linux/memblock.h>
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index 36646975b5d2..47e3e38e9bec 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -28,7 +28,7 @@
 #include <linux/wm97xx.h>
 #include <linux/power_supply.h>
 #include <linux/usb/gpio_vbus.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/physmap.h>
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 13de6602966f..6a386fd6363e 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -24,7 +24,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mfd/tc6393xb.h>
 #include <linux/mfd/tmio.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/pm.h>
diff --git a/arch/arm/mach-s3c24xx/common-smdk.c b/arch/arm/mach-s3c24xx/common-smdk.c
index 9e0bc46e90ec..0e116c92bf01 100644
--- a/arch/arm/mach-s3c24xx/common-smdk.c
+++ b/arch/arm/mach-s3c24xx/common-smdk.c
@@ -23,7 +23,7 @@
 #include <linux/platform_device.h>
 
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 #include <linux/io.h>
diff --git a/arch/arm/mach-s3c24xx/mach-anubis.c b/arch/arm/mach-s3c24xx/mach-anubis.c
index 029ef1b58925..c14cab361922 100644
--- a/arch/arm/mach-s3c24xx/mach-anubis.c
+++ b/arch/arm/mach-s3c24xx/mach-anubis.c
@@ -40,7 +40,7 @@
 #include <linux/platform_data/i2c-s3c2410.h>
 
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-at2440evb.c b/arch/arm/mach-s3c24xx/mach-at2440evb.c
index 7b28eb623fc1..ebdbafb9382a 100644
--- a/arch/arm/mach-s3c24xx/mach-at2440evb.c
+++ b/arch/arm/mach-s3c24xx/mach-at2440evb.c
@@ -41,7 +41,7 @@
 #include <linux/platform_data/i2c-s3c2410.h>
 
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-bast.c b/arch/arm/mach-s3c24xx/mach-bast.c
index 5185036765db..704dc84b3480 100644
--- a/arch/arm/mach-s3c24xx/mach-bast.c
+++ b/arch/arm/mach-s3c24xx/mach-bast.c
@@ -28,7 +28,7 @@
 #include <linux/serial_8250.h>
 
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
index b0ed401da3a3..afe18baf0c84 100644
--- a/arch/arm/mach-s3c24xx/mach-gta02.c
+++ b/arch/arm/mach-s3c24xx/mach-gta02.c
@@ -50,7 +50,7 @@
 #include <linux/mfd/pcf50633/pmic.h>
 
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
diff --git a/arch/arm/mach-s3c24xx/mach-jive.c b/arch/arm/mach-s3c24xx/mach-jive.c
index f5b5c49b56ac..17821976f769 100644
--- a/arch/arm/mach-s3c24xx/mach-jive.c
+++ b/arch/arm/mach-s3c24xx/mach-jive.c
@@ -43,7 +43,7 @@
 #include <asm/mach-types.h>
 
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index 71af8d2fd320..15140d34f927 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -49,7 +49,7 @@
 #include <linux/platform_data/usb-s3c2410_udc.h>
 
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
index 70b0eb7d3134..a6657e720430 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris.c
@@ -36,7 +36,7 @@
 #include <linux/platform_data/i2c-s3c2410.h>
 
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-qt2410.c b/arch/arm/mach-s3c24xx/mach-qt2410.c
index 868c82087403..84e3a9c53184 100644
--- a/arch/arm/mach-s3c24xx/mach-qt2410.c
+++ b/arch/arm/mach-s3c24xx/mach-qt2410.c
@@ -36,7 +36,7 @@
 #include <linux/spi/spi_gpio.h>
 #include <linux/io.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-rx3715.c b/arch/arm/mach-s3c24xx/mach-rx3715.c
index a39fb9780dd3..b5ba615cf9dd 100644
--- a/arch/arm/mach-s3c24xx/mach-rx3715.c
+++ b/arch/arm/mach-s3c24xx/mach-rx3715.c
@@ -27,7 +27,7 @@
 #include <linux/serial.h>
 #include <linux/io.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-vstms.c b/arch/arm/mach-s3c24xx/mach-vstms.c
index f5e6322145fa..1adc957edf0f 100644
--- a/arch/arm/mach-s3c24xx/mach-vstms.c
+++ b/arch/arm/mach-s3c24xx/mach-vstms.c
@@ -20,7 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 #include <linux/memblock.h>
diff --git a/arch/blackfin/mach-bf537/boards/dnp5370.c b/arch/blackfin/mach-bf537/boards/dnp5370.c
index e79b3b810c39..c4a8ffb15417 100644
--- a/arch/blackfin/mach-bf537/boards/dnp5370.c
+++ b/arch/blackfin/mach-bf537/boards/dnp5370.c
@@ -17,7 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/plat-ram.h>
 #include <linux/mtd/physmap.h>
diff --git a/arch/blackfin/mach-bf537/boards/stamp.c b/arch/blackfin/mach-bf537/boards/stamp.c
index 7528148dc492..400e6693643e 100644
--- a/arch/blackfin/mach-bf537/boards/stamp.c
+++ b/arch/blackfin/mach-bf537/boards/stamp.c
@@ -12,7 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/plat-ram.h>
 #include <linux/mtd/physmap.h>
diff --git a/arch/blackfin/mach-bf561/boards/acvilon.c b/arch/blackfin/mach-bf561/boards/acvilon.c
index 37f8f25a1347..696cc9d7820a 100644
--- a/arch/blackfin/mach-bf561/boards/acvilon.c
+++ b/arch/blackfin/mach-bf561/boards/acvilon.c
@@ -38,7 +38,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/plat-ram.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
diff --git a/arch/cris/arch-v32/drivers/mach-a3/nandflash.c b/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
index 3f646c787e58..925a98eb6d68 100644
--- a/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
+++ b/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
@@ -16,7 +16,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <arch/memmap.h>
 #include <hwregs/reg_map.h>
diff --git a/arch/cris/arch-v32/drivers/mach-fs/nandflash.c b/arch/cris/arch-v32/drivers/mach-fs/nandflash.c
index a74540514bdb..53b56a429dde 100644
--- a/arch/cris/arch-v32/drivers/mach-fs/nandflash.c
+++ b/arch/cris/arch-v32/drivers/mach-fs/nandflash.c
@@ -16,7 +16,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <arch/memmap.h>
 #include <hwregs/reg_map.h>
diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index 992442a03d8b..83831002c832 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -29,7 +29,7 @@
 #include <linux/leds.h>
 #include <linux/mmc/host.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index a5504f57cb00..3e7fbdbdb3c4 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -18,7 +18,7 @@
 #include <linux/mmc/host.h>
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/platform_device.h>
 #include <linux/smsc911x.h>
diff --git a/arch/mips/alchemy/devboards/db1550.c b/arch/mips/alchemy/devboards/db1550.c
index 1c01d6eadb08..421bd5793f7e 100644
--- a/arch/mips/alchemy/devboards/db1550.c
+++ b/arch/mips/alchemy/devboards/db1550.c
@@ -12,7 +12,7 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
diff --git a/arch/mips/include/asm/mach-jz4740/jz4740_nand.h b/arch/mips/include/asm/mach-jz4740/jz4740_nand.h
index 7f7b0fc554da..f381d465e768 100644
--- a/arch/mips/include/asm/mach-jz4740/jz4740_nand.h
+++ b/arch/mips/include/asm/mach-jz4740/jz4740_nand.h
@@ -16,7 +16,7 @@
 #ifndef __ASM_MACH_JZ4740_JZ4740_NAND_H__
 #define __ASM_MACH_JZ4740_JZ4740_NAND_H__
 
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 
 #define JZ_NAND_NUM_BANKS 4
diff --git a/arch/mips/netlogic/xlr/platform-flash.c b/arch/mips/netlogic/xlr/platform-flash.c
index f03131fec41d..4d1b4c003376 100644
--- a/arch/mips/netlogic/xlr/platform-flash.c
+++ b/arch/mips/netlogic/xlr/platform-flash.c
@@ -19,7 +19,7 @@
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 
 #include <asm/netlogic/haldefs.h>
diff --git a/arch/mips/pnx833x/common/platform.c b/arch/mips/pnx833x/common/platform.c
index 7cf4eb50fc72..a7a4e9f5146d 100644
--- a/arch/mips/pnx833x/common/platform.c
+++ b/arch/mips/pnx833x/common/platform.c
@@ -30,7 +30,7 @@
 #include <linux/resource.h>
 #include <linux/serial.h>
 #include <linux/serial_pnx8xxx.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 
 #include <irq.h>
diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index 0966adccf520..32ea3e6731d6 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -20,7 +20,7 @@
 #include <linux/ctype.h>
 #include <linux/string.h>
 #include <linux/platform_device.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/gpio.h>
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 5de60a77eaa1..0bcbe58b11e9 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -15,7 +15,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mfd/tmio.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/i2c.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
diff --git a/drivers/mtd/inftlcore.c b/drivers/mtd/inftlcore.c
index 8db740d6eb08..57ef1fb42a04 100644
--- a/drivers/mtd/inftlcore.c
+++ b/drivers/mtd/inftlcore.c
@@ -33,7 +33,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nftl.h>
 #include <linux/mtd/inftl.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/uaccess.h>
 #include <asm/errno.h>
 #include <asm/io.h>
diff --git a/drivers/mtd/nand/ams-delta.c b/drivers/mtd/nand/ams-delta.c
index 5d6c26f3cf7f..dcec9cf4983f 100644
--- a/drivers/mtd/nand/ams-delta.c
+++ b/drivers/mtd/nand/ams-delta.c
@@ -20,7 +20,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/gpio.h>
 #include <linux/platform_data/gpio-omap.h>
diff --git a/drivers/mtd/nand/atmel/nand-controller.c b/drivers/mtd/nand/atmel/nand-controller.c
index d922a88e407f..6606270b9b9b 100644
--- a/drivers/mtd/nand/atmel/nand-controller.c
+++ b/drivers/mtd/nand/atmel/nand-controller.c
@@ -59,7 +59,7 @@
 #include <linux/mfd/syscon/atmel-matrix.h>
 #include <linux/mfd/syscon/atmel-smc.h>
 #include <linux/module.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
diff --git a/drivers/mtd/nand/atmel/pmecc.c b/drivers/mtd/nand/atmel/pmecc.c
index 55a8ee5306ea..27a969a8f105 100644
--- a/drivers/mtd/nand/atmel/pmecc.c
+++ b/drivers/mtd/nand/atmel/pmecc.c
@@ -47,7 +47,7 @@
 #include <linux/genalloc.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
diff --git a/drivers/mtd/nand/au1550nd.c b/drivers/mtd/nand/au1550nd.c
index 9bf6d9915694..9d4a28fa6b73 100644
--- a/drivers/mtd/nand/au1550nd.c
+++ b/drivers/mtd/nand/au1550nd.c
@@ -14,7 +14,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/platform_device.h>
 #include <asm/io.h>
diff --git a/drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h b/drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h
index 8ea75710a854..c8834767ab6d 100644
--- a/drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h
+++ b/drivers/mtd/nand/bcm47xxnflash/bcm47xxnflash.h
@@ -6,7 +6,7 @@
 #endif
 
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 
 struct bcm47xxnflash {
 	struct bcma_drv_cc *cc;
diff --git a/drivers/mtd/nand/bf5xx_nand.c b/drivers/mtd/nand/bf5xx_nand.c
index 3962f55bd034..5655dca6ce43 100644
--- a/drivers/mtd/nand/bf5xx_nand.c
+++ b/drivers/mtd/nand/bf5xx_nand.c
@@ -49,7 +49,7 @@
 #include <linux/bitops.h>
 
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index 7419c5ce63f8..e0eb51d8c012 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -29,7 +29,7 @@
 #include <linux/bitops.h>
 #include <linux/mm.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
index 2fd733eba0a3..bc558c438a57 100644
--- a/drivers/mtd/nand/cafe_nand.c
+++ b/drivers/mtd/nand/cafe_nand.c
@@ -13,7 +13,7 @@
 #include <linux/device.h>
 #undef DEBUG
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/rslib.h>
 #include <linux/pci.h>
diff --git a/drivers/mtd/nand/cmx270_nand.c b/drivers/mtd/nand/cmx270_nand.c
index 949b9400dcb7..1fc435f994e1 100644
--- a/drivers/mtd/nand/cmx270_nand.c
+++ b/drivers/mtd/nand/cmx270_nand.c
@@ -18,7 +18,7 @@
  *   CM-X270 board.
  */
 
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/slab.h>
 #include <linux/gpio.h>
diff --git a/drivers/mtd/nand/cs553x_nand.c b/drivers/mtd/nand/cs553x_nand.c
index 594b28684138..d48877540f14 100644
--- a/drivers/mtd/nand/cs553x_nand.c
+++ b/drivers/mtd/nand/cs553x_nand.c
@@ -24,7 +24,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index 7b26e53b95b1..ccc8c43abcff 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -29,7 +29,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/slab.h>
 #include <linux/of_device.h>
diff --git a/drivers/mtd/nand/denali.h b/drivers/mtd/nand/denali.h
index 237cc706b0fb..9239e6793e6e 100644
--- a/drivers/mtd/nand/denali.h
+++ b/drivers/mtd/nand/denali.h
@@ -21,7 +21,7 @@
 #define __DENALI_H__
 
 #include <linux/bitops.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 
 #define DEVICE_RESET				0x0
 #define     DEVICE_RESET__BANK(bank)			BIT(bank)
diff --git a/drivers/mtd/nand/diskonchip.c b/drivers/mtd/nand/diskonchip.c
index a023ab9e9cbf..c3aa53caab5c 100644
--- a/drivers/mtd/nand/diskonchip.c
+++ b/drivers/mtd/nand/diskonchip.c
@@ -27,7 +27,7 @@
 #include <linux/io.h>
 
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/doc2000.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/inftl.h>
diff --git a/drivers/mtd/nand/docg4.c b/drivers/mtd/nand/docg4.c
index a27a84fbfb84..2436cbc71662 100644
--- a/drivers/mtd/nand/docg4.c
+++ b/drivers/mtd/nand/docg4.c
@@ -41,7 +41,7 @@
 #include <linux/bitops.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/bch.h>
 #include <linux/bitrev.h>
 #include <linux/jiffies.h>
diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index b9ac16f05057..17db2f90aa2c 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -34,7 +34,7 @@
 #include <linux/interrupt.h>
 
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index 59408ec2c69f..9e03bac7f34c 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -26,7 +26,7 @@
 #include <linux/of_address.h>
 #include <linux/slab.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/fsl_ifc.h>
diff --git a/drivers/mtd/nand/fsl_upm.c b/drivers/mtd/nand/fsl_upm.c
index d85fa2555b68..a88e2cf66e0f 100644
--- a/drivers/mtd/nand/fsl_upm.c
+++ b/drivers/mtd/nand/fsl_upm.c
@@ -14,7 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/mtd.h>
diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index 9d8b051d3187..eac15d9bf49e 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -28,7 +28,7 @@
 #include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
diff --git a/drivers/mtd/nand/gpio.c b/drivers/mtd/nand/gpio.c
index 85294f150f4f..fd3648952b5a 100644
--- a/drivers/mtd/nand/gpio.c
+++ b/drivers/mtd/nand/gpio.c
@@ -26,7 +26,7 @@
 #include <linux/gpio.h>
 #include <linux/io.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand-gpio.h>
 #include <linux/of.h>
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
index 9df0ad64e7e0..a45e4ce13d10 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
@@ -17,7 +17,7 @@
 #ifndef __DRIVERS_MTD_NAND_GPMI_NAND_H
 #define __DRIVERS_MTD_NAND_GPMI_NAND_H
 
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
diff --git a/drivers/mtd/nand/hisi504_nand.c b/drivers/mtd/nand/hisi504_nand.c
index 530caa80b1b6..d9ee1a7e6956 100644
--- a/drivers/mtd/nand/hisi504_nand.c
+++ b/drivers/mtd/nand/hisi504_nand.c
@@ -26,7 +26,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/partitions.h>
diff --git a/drivers/mtd/nand/jz4740_nand.c b/drivers/mtd/nand/jz4740_nand.c
index 0d06a1f07d82..ad827d4af3e9 100644
--- a/drivers/mtd/nand/jz4740_nand.c
+++ b/drivers/mtd/nand/jz4740_nand.c
@@ -20,7 +20,7 @@
 #include <linux/slab.h>
 
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 
 #include <linux/gpio.h>
diff --git a/drivers/mtd/nand/jz4780_nand.c b/drivers/mtd/nand/jz4780_nand.c
index 8bc835f71b26..e69f6ae4c539 100644
--- a/drivers/mtd/nand/jz4780_nand.c
+++ b/drivers/mtd/nand/jz4780_nand.c
@@ -20,7 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 
 #include <linux/jz4780-nemc.h>
diff --git a/drivers/mtd/nand/lpc32xx_mlc.c b/drivers/mtd/nand/lpc32xx_mlc.c
index 91ee369681f0..c3bb358ef01e 100644
--- a/drivers/mtd/nand/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/lpc32xx_mlc.c
@@ -27,7 +27,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/clk.h>
 #include <linux/err.h>
diff --git a/drivers/mtd/nand/lpc32xx_slc.c b/drivers/mtd/nand/lpc32xx_slc.c
index 80c282914586..b61f28a1554d 100644
--- a/drivers/mtd/nand/lpc32xx_slc.c
+++ b/drivers/mtd/nand/lpc32xx_slc.c
@@ -23,7 +23,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/clk.h>
 #include <linux/err.h>
diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nfc.c
index 0e86fb6277c3..b6b97cc9fba6 100644
--- a/drivers/mtd/nand/mpc5121_nfc.c
+++ b/drivers/mtd/nand/mpc5121_nfc.c
@@ -33,7 +33,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
diff --git a/drivers/mtd/nand/mtk_nand.c b/drivers/mtd/nand/mtk_nand.c
index f7ae99464375..d86a7d131cc0 100644
--- a/drivers/mtd/nand/mtk_nand.c
+++ b/drivers/mtd/nand/mtk_nand.c
@@ -19,7 +19,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/mtd.h>
 #include <linux/module.h>
 #include <linux/iopoll.h>
diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 5bedf7bc3d88..53e5e0337c3e 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -22,7 +22,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
diff --git a/drivers/mtd/nand/nand_amd.c b/drivers/mtd/nand/nand_amd.c
index 170403a3bfa8..22f060f38123 100644
--- a/drivers/mtd/nand/nand_amd.c
+++ b/drivers/mtd/nand/nand_amd.c
@@ -15,7 +15,7 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 
 static void amd_nand_decode_id(struct nand_chip *chip)
 {
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 331b93cf4e6c..4f85b4817bc4 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -39,7 +39,7 @@
 #include <linux/nmi.h>
 #include <linux/types.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/nand_bch.h>
 #include <linux/interrupt.h>
diff --git a/drivers/mtd/nand/nand_bbt.c b/drivers/mtd/nand/nand_bbt.c
index 7695efea65f2..2915b6739bf8 100644
--- a/drivers/mtd/nand/nand_bbt.c
+++ b/drivers/mtd/nand/nand_bbt.c
@@ -61,7 +61,7 @@
 #include <linux/types.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/bbm.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/vmalloc.h>
diff --git a/drivers/mtd/nand/nand_bch.c b/drivers/mtd/nand/nand_bch.c
index 44763f87eae4..505441c9373b 100644
--- a/drivers/mtd/nand/nand_bch.c
+++ b/drivers/mtd/nand/nand_bch.c
@@ -25,7 +25,7 @@
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_bch.h>
 #include <linux/bch.h>
 
diff --git a/drivers/mtd/nand/nand_ecc.c b/drivers/mtd/nand/nand_ecc.c
index d1770b066396..7613a0388044 100644
--- a/drivers/mtd/nand/nand_ecc.c
+++ b/drivers/mtd/nand/nand_ecc.c
@@ -43,7 +43,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <asm/byteorder.h>
 #else
diff --git a/drivers/mtd/nand/nand_hynix.c b/drivers/mtd/nand/nand_hynix.c
index b12dc7325378..b735cc8ec104 100644
--- a/drivers/mtd/nand/nand_hynix.c
+++ b/drivers/mtd/nand/nand_hynix.c
@@ -15,7 +15,7 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 
diff --git a/drivers/mtd/nand/nand_ids.c b/drivers/mtd/nand/nand_ids.c
index 92e2cf8e9ff9..5423c3bb388e 100644
--- a/drivers/mtd/nand/nand_ids.c
+++ b/drivers/mtd/nand/nand_ids.c
@@ -6,7 +6,7 @@
  * published by the Free Software Foundation.
  *
  */
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/sizes.h>
 
 #define LP_OPTIONS 0
diff --git a/drivers/mtd/nand/nand_macronix.c b/drivers/mtd/nand/nand_macronix.c
index 84855c3e1a02..d290ff2a6d2f 100644
--- a/drivers/mtd/nand/nand_macronix.c
+++ b/drivers/mtd/nand/nand_macronix.c
@@ -15,7 +15,7 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 
 static int macronix_nand_init(struct nand_chip *chip)
 {
diff --git a/drivers/mtd/nand/nand_micron.c b/drivers/mtd/nand/nand_micron.c
index c30ab60f8e1b..abf6a3c376e8 100644
--- a/drivers/mtd/nand/nand_micron.c
+++ b/drivers/mtd/nand/nand_micron.c
@@ -15,7 +15,7 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 
 /*
  * Special Micron status bit that indicates when the block has been
diff --git a/drivers/mtd/nand/nand_samsung.c b/drivers/mtd/nand/nand_samsung.c
index 1e0755997762..d348f0129ae7 100644
--- a/drivers/mtd/nand/nand_samsung.c
+++ b/drivers/mtd/nand/nand_samsung.c
@@ -15,7 +15,7 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 
 static void samsung_nand_decode_id(struct nand_chip *chip)
 {
diff --git a/drivers/mtd/nand/nand_timings.c b/drivers/mtd/nand/nand_timings.c
index f06312df3669..90228b9735bd 100644
--- a/drivers/mtd/nand/nand_timings.c
+++ b/drivers/mtd/nand/nand_timings.c
@@ -11,7 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/err.h>
 #include <linux/export.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 
 static const struct nand_data_interface onfi_sdr_timings[] = {
 	/* Mode 0 */
diff --git a/drivers/mtd/nand/nand_toshiba.c b/drivers/mtd/nand/nand_toshiba.c
index fa787ba38dcd..57df857074e6 100644
--- a/drivers/mtd/nand/nand_toshiba.c
+++ b/drivers/mtd/nand/nand_toshiba.c
@@ -15,7 +15,7 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 
 static void toshiba_nand_decode_id(struct nand_chip *chip)
 {
diff --git a/drivers/mtd/nand/nandsim.c b/drivers/mtd/nand/nandsim.c
index 03a0d057bf2f..5ba46354bf0f 100644
--- a/drivers/mtd/nand/nandsim.c
+++ b/drivers/mtd/nand/nandsim.c
@@ -33,7 +33,7 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_bch.h>
 #include <linux/mtd/partitions.h>
 #include <linux/delay.h>
diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
index 28e6118362f7..d8a806894937 100644
--- a/drivers/mtd/nand/ndfc.c
+++ b/drivers/mtd/nand/ndfc.c
@@ -22,7 +22,7 @@
  *
  */
 #include <linux/module.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/ndfc.h>
diff --git a/drivers/mtd/nand/nuc900_nand.c b/drivers/mtd/nand/nuc900_nand.c
index 8f64011d32ef..7bb4d2ea9342 100644
--- a/drivers/mtd/nand/nuc900_nand.c
+++ b/drivers/mtd/nand/nuc900_nand.c
@@ -19,7 +19,7 @@
 #include <linux/err.h>
 
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 
 #define REG_FMICSR   	0x00
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 084934a9f19c..54540c8fa1a2 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -18,7 +18,7 @@
 #include <linux/jiffies.h>
 #include <linux/sched.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/omap-dma.h>
 #include <linux/io.h>
diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
index 41cb7acfc044..5a5aa1f07d07 100644
--- a/drivers/mtd/nand/orion_nand.c
+++ b/drivers/mtd/nand/orion_nand.c
@@ -15,7 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/clk.h>
 #include <linux/err.h>
diff --git a/drivers/mtd/nand/oxnas_nand.c b/drivers/mtd/nand/oxnas_nand.c
index 7061bb2923b4..d649d5944826 100644
--- a/drivers/mtd/nand/oxnas_nand.c
+++ b/drivers/mtd/nand/oxnas_nand.c
@@ -21,7 +21,7 @@
 #include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/of.h>
 
diff --git a/drivers/mtd/nand/pasemi_nand.c b/drivers/mtd/nand/pasemi_nand.c
index 074b8b01289e..a47a7e4bd25a 100644
--- a/drivers/mtd/nand/pasemi_nand.c
+++ b/drivers/mtd/nand/pasemi_nand.c
@@ -25,7 +25,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
diff --git a/drivers/mtd/nand/plat_nand.c b/drivers/mtd/nand/plat_nand.c
index 791de3e4bbb6..925a1323604d 100644
--- a/drivers/mtd/nand/plat_nand.c
+++ b/drivers/mtd/nand/plat_nand.c
@@ -15,7 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 
 struct plat_nand_data {
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 74dae4bbdac8..85cff68643e0 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -21,7 +21,7 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
diff --git a/drivers/mtd/nand/qcom_nandc.c b/drivers/mtd/nand/qcom_nandc.c
index 0e727d79f2ce..fe65afecb8b7 100644
--- a/drivers/mtd/nand/qcom_nandc.c
+++ b/drivers/mtd/nand/qcom_nandc.c
@@ -17,7 +17,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/module.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
diff --git a/drivers/mtd/nand/r852.h b/drivers/mtd/nand/r852.h
index d042ddb71a8b..8713c57f6207 100644
--- a/drivers/mtd/nand/r852.h
+++ b/drivers/mtd/nand/r852.h
@@ -10,7 +10,7 @@
 #include <linux/pci.h>
 #include <linux/completion.h>
 #include <linux/workqueue.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/spinlock.h>
 
 
diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index 9e0c849607b9..4c383eeec6f6 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -43,7 +43,7 @@
 #include <linux/of_device.h>
 
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 891ac7b99305..2637b9052fe7 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -38,7 +38,7 @@
 #include <linux/string.h>
 
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/sh_flctl.h>
 
diff --git a/drivers/mtd/nand/sharpsl.c b/drivers/mtd/nand/sharpsl.c
index 064ca1757589..737efe83cd36 100644
--- a/drivers/mtd/nand/sharpsl.c
+++ b/drivers/mtd/nand/sharpsl.c
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/sharpsl.h>
diff --git a/drivers/mtd/nand/sm_common.c b/drivers/mtd/nand/sm_common.c
index 5939dff253c2..c378705c6e2b 100644
--- a/drivers/mtd/nand/sm_common.c
+++ b/drivers/mtd/nand/sm_common.c
@@ -7,7 +7,7 @@
  * published by the Free Software Foundation.
  */
 #include <linux/kernel.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
 #include "sm_common.h"
diff --git a/drivers/mtd/nand/socrates_nand.c b/drivers/mtd/nand/socrates_nand.c
index 72369bd079af..575997d0ef8a 100644
--- a/drivers/mtd/nand/socrates_nand.c
+++ b/drivers/mtd/nand/socrates_nand.c
@@ -13,7 +13,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 6eb97451f485..f1cd5eb47e51 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -31,7 +31,7 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
diff --git a/drivers/mtd/nand/tango_nand.c b/drivers/mtd/nand/tango_nand.c
index 9d40b793b1c4..766906f03943 100644
--- a/drivers/mtd/nand/tango_nand.c
+++ b/drivers/mtd/nand/tango_nand.c
@@ -11,7 +11,7 @@
 #include <linux/clk.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
diff --git a/drivers/mtd/nand/tmio_nand.c b/drivers/mtd/nand/tmio_nand.c
index fc5e773f8b60..c9dd682fb353 100644
--- a/drivers/mtd/nand/tmio_nand.c
+++ b/drivers/mtd/nand/tmio_nand.c
@@ -34,7 +34,7 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 #include <linux/slab.h>
diff --git a/drivers/mtd/nand/txx9ndfmc.c b/drivers/mtd/nand/txx9ndfmc.c
index 0a14fda2e41b..b567d212fe7d 100644
--- a/drivers/mtd/nand/txx9ndfmc.c
+++ b/drivers/mtd/nand/txx9ndfmc.c
@@ -16,7 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 #include <linux/io.h>
diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
index b88a0c91b455..8037d4b48a05 100644
--- a/drivers/mtd/nand/vf610_nfc.c
+++ b/drivers/mtd/nand/vf610_nfc.c
@@ -31,7 +31,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
diff --git a/drivers/mtd/nand/xway_nand.c b/drivers/mtd/nand/xway_nand.c
index ddee4005248c..9926b4e3d69d 100644
--- a/drivers/mtd/nand/xway_nand.c
+++ b/drivers/mtd/nand/xway_nand.c
@@ -7,7 +7,7 @@
  *  Copyright © 2016 Hauke Mehrtens <hauke@hauke-m.de>
  */
 
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 
diff --git a/drivers/mtd/nftlcore.c b/drivers/mtd/nftlcore.c
index e21161353e76..1f1a61168b3d 100644
--- a/drivers/mtd/nftlcore.c
+++ b/drivers/mtd/nftlcore.c
@@ -34,7 +34,7 @@
 
 #include <linux/kmod.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nftl.h>
 #include <linux/mtd/blktrans.h>
 
diff --git a/drivers/mtd/nftlmount.c b/drivers/mtd/nftlmount.c
index a5dfbfbebfca..184c8fbfe465 100644
--- a/drivers/mtd/nftlmount.c
+++ b/drivers/mtd/nftlmount.c
@@ -25,7 +25,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nftl.h>
 
 #define SECTORSIZE 512
diff --git a/drivers/mtd/ssfdc.c b/drivers/mtd/ssfdc.c
index 41b13d1cdcc4..95f0bf95f095 100644
--- a/drivers/mtd/ssfdc.c
+++ b/drivers/mtd/ssfdc.c
@@ -16,7 +16,7 @@
 #include <linux/slab.h>
 #include <linux/hdreg.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/blktrans.h>
 
 struct ssfdcr_record {
diff --git a/drivers/mtd/tests/nandbiterrs.c b/drivers/mtd/tests/nandbiterrs.c
index f26dec896afa..5f03b8c885a9 100644
--- a/drivers/mtd/tests/nandbiterrs.c
+++ b/drivers/mtd/tests/nandbiterrs.c
@@ -47,7 +47,7 @@
 #include <linux/moduleparam.h>
 #include <linux/mtd/mtd.h>
 #include <linux/err.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/slab.h>
 #include "mtd_test.h"
 
diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index a4e3ae8f0c85..13eaf16ecd16 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -18,7 +18,7 @@
 #include <linux/delay.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/spi/spi.h>
 
 #include "mt29f_spinand.h"
diff --git a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
index b25d28a21212..48d9522e209c 100644
--- a/fs/jffs2/wbuf.c
+++ b/fs/jffs2/wbuf.c
@@ -17,7 +17,7 @@
 #include <linux/slab.h>
 #include <linux/mtd/mtd.h>
 #include <linux/crc32.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/jiffies.h>
 #include <linux/sched.h>
 #include <linux/writeback.h>
diff --git a/include/linux/mtd/nand-gpio.h b/include/linux/mtd/nand-gpio.h
index 51534e50f7fc..be4f45d89be2 100644
--- a/include/linux/mtd/nand-gpio.h
+++ b/include/linux/mtd/nand-gpio.h
@@ -1,7 +1,7 @@
 #ifndef __LINUX_MTD_NAND_GPIO_H
 #define __LINUX_MTD_NAND_GPIO_H
 
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 
 struct gpio_nand_platdata {
 	int	gpio_nce;
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/rawnand.h
similarity index 99%
rename from include/linux/mtd/nand.h
rename to include/linux/mtd/rawnand.h
index 297684013977..8fb488d586d6 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1,6 +1,4 @@
 /*
- *  linux/include/linux/mtd/nand.h
- *
  *  Copyright © 2000-2010 David Woodhouse <dwmw2@infradead.org>
  *                        Steven J. Hill <sjhill@realitydiluted.com>
  *		          Thomas Gleixner <tglx@linutronix.de>
@@ -15,8 +13,8 @@
  * Changelog:
  *	See git changelog.
  */
-#ifndef __LINUX_MTD_NAND_H
-#define __LINUX_MTD_NAND_H
+#ifndef __LINUX_MTD_RAWNAND_H
+#define __LINUX_MTD_RAWNAND_H
 
 #include <linux/wait.h>
 #include <linux/spinlock.h>
@@ -1318,4 +1316,4 @@ void nand_cleanup(struct nand_chip *chip);
 
 /* Default extended ID decoding function */
 void nand_decode_ext_id(struct nand_chip *chip);
-#endif /* __LINUX_MTD_NAND_H */
+#endif /* __LINUX_MTD_RAWNAND_H */
diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
index 2251add65fa7..c759d403cbc0 100644
--- a/include/linux/mtd/sh_flctl.h
+++ b/include/linux/mtd/sh_flctl.h
@@ -22,7 +22,7 @@
 
 #include <linux/completion.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/pm_qos.h>
 
diff --git a/include/linux/mtd/sharpsl.h b/include/linux/mtd/sharpsl.h
index 65e91d0fa981..72a79c7d0e08 100644
--- a/include/linux/mtd/sharpsl.h
+++ b/include/linux/mtd/sharpsl.h
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
diff --git a/include/linux/platform_data/mtd-davinci.h b/include/linux/platform_data/mtd-davinci.h
index 1cf555aef896..f1a2cf655bdb 100644
--- a/include/linux/platform_data/mtd-davinci.h
+++ b/include/linux/platform_data/mtd-davinci.h
@@ -28,7 +28,7 @@
 #ifndef __ARCH_ARM_DAVINCI_NAND_H
 #define __ARCH_ARM_DAVINCI_NAND_H
 
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 
 #define NANDFCR_OFFSET		0x60
 #define NANDFSR_OFFSET		0x64
diff --git a/include/linux/platform_data/mtd-nand-s3c2410.h b/include/linux/platform_data/mtd-nand-s3c2410.h
index f01659026b26..f8c553f92655 100644
--- a/include/linux/platform_data/mtd-nand-s3c2410.h
+++ b/include/linux/platform_data/mtd-nand-s3c2410.h
@@ -12,7 +12,7 @@
 #ifndef __MTD_NAND_S3C2410_H
 #define __MTD_NAND_S3C2410_H
 
-#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 
 /**
  * struct s3c2410_nand_set - define a set of one or more nand chips
-- 
2.7.4
