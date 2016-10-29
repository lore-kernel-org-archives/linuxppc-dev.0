Return-Path: <mchehab@osg.samsung.com>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t5q8W4H3LzDvW3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Oct 2016 05:36:26 +1100 (AEDT)
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
 Mauro Carvalho Chehab <mchehab@infradead.org>, linux-edac@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 Aristeu Rozanski <arozansk@redhat.com>,
 Thor Thayer <tthayer@opensource.altera.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Mark Gross <mark.gross@intel.com>, York Sun <york.sun@nxp.com>,
 Robert Richter <rric@kernel.org>, Tim Small <tim@buttersideup.com>,
 Ranganathan Desikan <ravi@jetztechnologies.com>,
 "Arvind R." <arvino55@gmail.com>, Jason Baron <jbaron@akamai.com>,
 Johannes Thumshirn <morbidrsa@gmail.com>,
 Ralf Baechle <ralf@linux-mips.org>, David Daney <david.daney@cavium.com>,
 Egor Martovetsky <egor@pasemi.com>, Michal Simek <michal.simek@xilinx.com>,
 =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
 Chris Metcalf <cmetcalf@mellanox.com>, Loc Ho <lho@apm.com>,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 11/19] edac: rename edac_core.h to edac_mc.h
Date: Sat, 29 Oct 2016 16:34:09 -0200
Message-Id: <20e115c475d7bd447b6b8ad47048794b105b2c7a.1477765574.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1477765574.git.mchehab@s-opensource.com>
References: <cover.1477765574.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1477765574.git.mchehab@s-opensource.com>
References: <cover.1477765574.git.mchehab@s-opensource.com>
Sender: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now, all left at edac_core.h are at drivers/edac/edac_mc.c,
so rename it to edac_mc.h.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/edac/altera_edac.c              |  1 -
 drivers/edac/amd64_edac.h               |  2 +-
 drivers/edac/amd76x_edac.c              |  2 +-
 drivers/edac/amd8111_edac.c             |  1 -
 drivers/edac/amd8131_edac.c             |  1 -
 drivers/edac/cell_edac.c                |  2 +-
 drivers/edac/cpc925_edac.c              |  1 -
 drivers/edac/e752x_edac.c               |  2 +-
 drivers/edac/e7xxx_edac.c               |  2 +-
 drivers/edac/edac_mc.c                  |  2 +-
 drivers/edac/{edac_core.h => edac_mc.h} | 11 ++++-------
 drivers/edac/edac_mc_sysfs.c            |  2 +-
 drivers/edac/edac_module.c              |  2 +-
 drivers/edac/edac_module.h              |  4 +++-
 drivers/edac/fsl_ddr_edac.c             |  1 -
 drivers/edac/ghes_edac.c                |  2 +-
 drivers/edac/highbank_l2_edac.c         |  1 -
 drivers/edac/highbank_mc_edac.c         |  1 -
 drivers/edac/i3000_edac.c               |  2 +-
 drivers/edac/i3200_edac.c               |  2 +-
 drivers/edac/i5000_edac.c               |  2 +-
 drivers/edac/i5100_edac.c               |  1 -
 drivers/edac/i5400_edac.c               |  2 +-
 drivers/edac/i7300_edac.c               |  2 +-
 drivers/edac/i7core_edac.c              |  2 +-
 drivers/edac/i82443bxgx_edac.c          |  2 +-
 drivers/edac/i82860_edac.c              |  2 +-
 drivers/edac/i82875p_edac.c             |  2 +-
 drivers/edac/i82975x_edac.c             |  2 +-
 drivers/edac/ie31200_edac.c             |  2 +-
 drivers/edac/layerscape_edac.c          |  2 +-
 drivers/edac/mpc85xx_edac.c             |  1 -
 drivers/edac/mv64x60_edac.c             |  1 -
 drivers/edac/octeon_edac-l2c.c          |  1 -
 drivers/edac/octeon_edac-lmc.c          |  1 -
 drivers/edac/octeon_edac-pc.c           |  1 -
 drivers/edac/octeon_edac-pci.c          |  1 -
 drivers/edac/pasemi_edac.c              |  2 +-
 drivers/edac/ppc4xx_edac.c              |  2 +-
 drivers/edac/r82600_edac.c              |  2 +-
 drivers/edac/sb_edac.c                  |  2 +-
 drivers/edac/skx_edac.c                 |  2 +-
 drivers/edac/synopsys_edac.c            |  2 +-
 drivers/edac/tile_edac.c                |  2 +-
 drivers/edac/x38_edac.c                 |  2 +-
 drivers/edac/xgene_edac.c               |  1 -
 46 files changed, 36 insertions(+), 52 deletions(-)
 rename drivers/edac/{edac_core.h => edac_mc.h} (95%)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 58d3e2b39b5b..798e9440d338 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -35,7 +35,6 @@
 #include <linux/uaccess.h>
 
 #include "altera_edac.h"
-#include "edac_core.h"
 #include "edac_module.h"
 
 #define EDAC_MOD_STR		"altera_edac"
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index c08870479054..35e1f9e14777 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -17,7 +17,7 @@
 #include <linux/mmzone.h>
 #include <linux/edac.h>
 #include <asm/msr.h>
-#include "edac_core.h"
+#include "edac_module.h"
 #include "mce_amd.h"
 
 #define amd64_debug(fmt, arg...) \
diff --git a/drivers/edac/amd76x_edac.c b/drivers/edac/amd76x_edac.c
index 3a501b530e11..a7450275ad28 100644
--- a/drivers/edac/amd76x_edac.c
+++ b/drivers/edac/amd76x_edac.c
@@ -17,7 +17,7 @@
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include <linux/edac.h>
-#include "edac_core.h"
+#include "edac_module.h"
 
 #define AMD76X_REVISION	" Ver: 2.0.2"
 #define EDAC_MOD_STR	"amd76x_edac"
diff --git a/drivers/edac/amd8111_edac.c b/drivers/edac/amd8111_edac.c
index 2b63f7c2d6d2..b5786cfded3a 100644
--- a/drivers/edac/amd8111_edac.c
+++ b/drivers/edac/amd8111_edac.c
@@ -29,7 +29,6 @@
 #include <linux/pci_ids.h>
 #include <asm/io.h>
 
-#include "edac_core.h"
 #include "edac_module.h"
 #include "amd8111_edac.h"
 
diff --git a/drivers/edac/amd8131_edac.c b/drivers/edac/amd8131_edac.c
index a5c680561c73..8851c33d7d24 100644
--- a/drivers/edac/amd8131_edac.c
+++ b/drivers/edac/amd8131_edac.c
@@ -29,7 +29,6 @@
 #include <linux/edac.h>
 #include <linux/pci_ids.h>
 
-#include "edac_core.h"
 #include "edac_module.h"
 #include "amd8131_edac.h"
 
diff --git a/drivers/edac/cell_edac.c b/drivers/edac/cell_edac.c
index a9259b069dcd..bc1f3416400e 100644
--- a/drivers/edac/cell_edac.c
+++ b/drivers/edac/cell_edac.c
@@ -19,7 +19,7 @@
 #include <asm/machdep.h>
 #include <asm/cell-regs.h>
 
-#include "edac_core.h"
+#include "edac_module.h"
 
 struct cell_edac_priv
 {
diff --git a/drivers/edac/cpc925_edac.c b/drivers/edac/cpc925_edac.c
index 682288ced4ac..837b62c4993d 100644
--- a/drivers/edac/cpc925_edac.c
+++ b/drivers/edac/cpc925_edac.c
@@ -27,7 +27,6 @@
 #include <linux/platform_device.h>
 #include <linux/gfp.h>
 
-#include "edac_core.h"
 #include "edac_module.h"
 
 #define CPC925_EDAC_REVISION	" Ver: 1.0.0"
diff --git a/drivers/edac/e752x_edac.c b/drivers/edac/e752x_edac.c
index b2d71388172b..1a352cae1f52 100644
--- a/drivers/edac/e752x_edac.c
+++ b/drivers/edac/e752x_edac.c
@@ -24,7 +24,7 @@
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include <linux/edac.h>
-#include "edac_core.h"
+#include "edac_module.h"
 
 #define E752X_REVISION	" Ver: 2.0.2"
 #define EDAC_MOD_STR	"e752x_edac"
diff --git a/drivers/edac/e7xxx_edac.c b/drivers/edac/e7xxx_edac.c
index ece3aef16bb1..67ef07aed923 100644
--- a/drivers/edac/e7xxx_edac.c
+++ b/drivers/edac/e7xxx_edac.c
@@ -30,7 +30,7 @@
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include <linux/edac.h>
-#include "edac_core.h"
+#include "edac_module.h"
 
 #define	E7XXX_REVISION " Ver: 2.0.2"
 #define	EDAC_MOD_STR	"e7xxx_edac"
diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index c3ee3ad98a63..6f08dfa18e5e 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -30,7 +30,7 @@
 #include <linux/bitops.h>
 #include <asm/uaccess.h>
 #include <asm/page.h>
-#include "edac_core.h"
+#include "edac_mc.h"
 #include "edac_module.h"
 #include <ras/ras_event.h>
 
diff --git a/drivers/edac/edac_core.h b/drivers/edac/edac_mc.h
similarity index 95%
rename from drivers/edac/edac_core.h
rename to drivers/edac/edac_mc.h
index 3e11d9d85462..b62d9bad9859 100644
--- a/drivers/edac/edac_core.h
+++ b/drivers/edac/edac_mc.h
@@ -1,5 +1,5 @@
 /*
- * Defines, structures, APIs for edac_core module
+ * Defines, structures, APIs for edac_mc module
  *
  * (C) 2007 Linux Networx (http://lnxi.com)
  * This file may be distributed under the terms of the
@@ -17,8 +17,8 @@
  *
  */
 
-#ifndef _EDAC_CORE_H_
-#define _EDAC_CORE_H_
+#ifndef _EDAC_MC_H_
+#define _EDAC_MC_H_
 
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -35,9 +35,6 @@
 #include <linux/workqueue.h>
 #include <linux/edac.h>
 
-#include "edac_pci.h"
-#include "edac_device.h"
-
 #if PAGE_SHIFT < 20
 #define PAGES_TO_MiB(pages)	((pages) >> (20 - PAGE_SHIFT))
 #define MiB_TO_PAGES(mb)	((mb) << (20 - PAGE_SHIFT))
@@ -131,4 +128,4 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
  */
 extern char *edac_op_state_to_string(int op_state);
 
-#endif				/* _EDAC_CORE_H_ */
+#endif				/* _EDAC_MC_H_ */
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 4e0f8e720ad9..39dbab7d62f1 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -19,7 +19,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/uaccess.h>
 
-#include "edac_core.h"
+#include "edac_mc.h"
 #include "edac_module.h"
 
 /* MC EDAC Controls, setable by module parameter, and sysfs */
diff --git a/drivers/edac/edac_module.c b/drivers/edac/edac_module.c
index 5f8543be995a..172598a27d7d 100644
--- a/drivers/edac/edac_module.c
+++ b/drivers/edac/edac_module.c
@@ -12,7 +12,7 @@
  */
 #include <linux/edac.h>
 
-#include "edac_core.h"
+#include "edac_mc.h"
 #include "edac_module.h"
 
 #define EDAC_VERSION "Ver: 3.0.0"
diff --git a/drivers/edac/edac_module.h b/drivers/edac/edac_module.h
index cfaacb99c973..014871e169cc 100644
--- a/drivers/edac/edac_module.h
+++ b/drivers/edac/edac_module.h
@@ -10,7 +10,9 @@
 #ifndef	__EDAC_MODULE_H__
 #define	__EDAC_MODULE_H__
 
-#include "edac_core.h"
+#include "edac_mc.h"
+#include "edac_pci.h"
+#include "edac_device.h"
 
 /*
  * INTERNAL EDAC MODULE:
diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index 9774f52f0c3e..4e9608a958e7 100644
--- a/drivers/edac/fsl_ddr_edac.c
+++ b/drivers/edac/fsl_ddr_edac.c
@@ -28,7 +28,6 @@
 #include <linux/of_device.h>
 #include <linux/of_address.h>
 #include "edac_module.h"
-#include "edac_core.h"
 #include "fsl_ddr_edac.h"
 
 #define EDAC_MOD_STR	"fsl_ddr_edac"
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index e3fa4390f846..4e61a6229dd2 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -14,7 +14,7 @@
 #include <acpi/ghes.h>
 #include <linux/edac.h>
 #include <linux/dmi.h>
-#include "edac_core.h"
+#include "edac_module.h"
 #include <ras/ras_event.h>
 
 #define GHES_EDAC_REVISION " Ver: 1.0.0"
diff --git a/drivers/edac/highbank_l2_edac.c b/drivers/edac/highbank_l2_edac.c
index 2f193668ebc7..cd9a2bb7c548 100644
--- a/drivers/edac/highbank_l2_edac.c
+++ b/drivers/edac/highbank_l2_edac.c
@@ -21,7 +21,6 @@
 #include <linux/platform_device.h>
 #include <linux/of_platform.h>
 
-#include "edac_core.h"
 #include "edac_module.h"
 
 #define SR_CLR_SB_ECC_INTR	0x0
diff --git a/drivers/edac/highbank_mc_edac.c b/drivers/edac/highbank_mc_edac.c
index 11260cc3360e..0e7e0a404d89 100644
--- a/drivers/edac/highbank_mc_edac.c
+++ b/drivers/edac/highbank_mc_edac.c
@@ -22,7 +22,6 @@
 #include <linux/of_platform.h>
 #include <linux/uaccess.h>
 
-#include "edac_core.h"
 #include "edac_module.h"
 
 /* DDR Ctrlr Error Registers */
diff --git a/drivers/edac/i3000_edac.c b/drivers/edac/i3000_edac.c
index 5cb36a6022cc..5306240570d7 100644
--- a/drivers/edac/i3000_edac.c
+++ b/drivers/edac/i3000_edac.c
@@ -14,7 +14,7 @@
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include <linux/edac.h>
-#include "edac_core.h"
+#include "edac_module.h"
 
 #define I3000_REVISION		"1.1"
 
diff --git a/drivers/edac/i3200_edac.c b/drivers/edac/i3200_edac.c
index 1f453382258a..77c58d201a30 100644
--- a/drivers/edac/i3200_edac.c
+++ b/drivers/edac/i3200_edac.c
@@ -13,7 +13,7 @@
 #include <linux/pci_ids.h>
 #include <linux/edac.h>
 #include <linux/io.h>
-#include "edac_core.h"
+#include "edac_module.h"
 
 #include <linux/io-64-nonatomic-lo-hi.h>
 
diff --git a/drivers/edac/i5000_edac.c b/drivers/edac/i5000_edac.c
index 72e07e3cf718..1670d27bcac8 100644
--- a/drivers/edac/i5000_edac.c
+++ b/drivers/edac/i5000_edac.c
@@ -22,7 +22,7 @@
 #include <linux/edac.h>
 #include <asm/mmzone.h>
 
-#include "edac_core.h"
+#include "edac_module.h"
 
 /*
  * Alter this version for the I5000 module when modifications are made
diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
index c655162caf08..a8334c4acea7 100644
--- a/drivers/edac/i5100_edac.c
+++ b/drivers/edac/i5100_edac.c
@@ -29,7 +29,6 @@
 #include <linux/mmzone.h>
 #include <linux/debugfs.h>
 
-#include "edac_core.h"
 #include "edac_module.h"
 
 /* register addresses */
diff --git a/drivers/edac/i5400_edac.c b/drivers/edac/i5400_edac.c
index 6ef6ad1ba16e..abf6ef22e220 100644
--- a/drivers/edac/i5400_edac.c
+++ b/drivers/edac/i5400_edac.c
@@ -32,7 +32,7 @@
 #include <linux/edac.h>
 #include <linux/mmzone.h>
 
-#include "edac_core.h"
+#include "edac_module.h"
 
 /*
  * Alter this version for the I5400 module when modifications are made
diff --git a/drivers/edac/i7300_edac.c b/drivers/edac/i7300_edac.c
index dcac982fdc7a..0a912bf6de00 100644
--- a/drivers/edac/i7300_edac.c
+++ b/drivers/edac/i7300_edac.c
@@ -26,7 +26,7 @@
 #include <linux/edac.h>
 #include <linux/mmzone.h>
 
-#include "edac_core.h"
+#include "edac_module.h"
 
 /*
  * Alter this version for the I7300 module when modifications are made
diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index 8a68a5e943ea..69b5adead0ad 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -39,7 +39,7 @@
 #include <asm/processor.h>
 #include <asm/div64.h>
 
-#include "edac_core.h"
+#include "edac_module.h"
 
 /* Static vars */
 static LIST_HEAD(i7core_edac_list);
diff --git a/drivers/edac/i82443bxgx_edac.c b/drivers/edac/i82443bxgx_edac.c
index 4d4110364f02..cb61a5b7d080 100644
--- a/drivers/edac/i82443bxgx_edac.c
+++ b/drivers/edac/i82443bxgx_edac.c
@@ -29,7 +29,7 @@
 
 
 #include <linux/edac.h>
-#include "edac_core.h"
+#include "edac_module.h"
 
 #define I82443_REVISION	"0.1"
 
diff --git a/drivers/edac/i82860_edac.c b/drivers/edac/i82860_edac.c
index ee1078cd3b96..236c813227fc 100644
--- a/drivers/edac/i82860_edac.c
+++ b/drivers/edac/i82860_edac.c
@@ -14,7 +14,7 @@
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include <linux/edac.h>
-#include "edac_core.h"
+#include "edac_module.h"
 
 #define  I82860_REVISION " Ver: 2.0.2"
 #define EDAC_MOD_STR	"i82860_edac"
diff --git a/drivers/edac/i82875p_edac.c b/drivers/edac/i82875p_edac.c
index c26a513f8869..e286b7e74c7a 100644
--- a/drivers/edac/i82875p_edac.c
+++ b/drivers/edac/i82875p_edac.c
@@ -18,7 +18,7 @@
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include <linux/edac.h>
-#include "edac_core.h"
+#include "edac_module.h"
 
 #define I82875P_REVISION	" Ver: 2.0.2"
 #define EDAC_MOD_STR		"i82875p_edac"
diff --git a/drivers/edac/i82975x_edac.c b/drivers/edac/i82975x_edac.c
index 35ab66c623a3..7baa8ace267b 100644
--- a/drivers/edac/i82975x_edac.c
+++ b/drivers/edac/i82975x_edac.c
@@ -14,7 +14,7 @@
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include <linux/edac.h>
-#include "edac_core.h"
+#include "edac_module.h"
 
 #define I82975X_REVISION	" Ver: 1.0.0"
 #define EDAC_MOD_STR		"i82975x_edac"
diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 1c88d9707495..2733fb5938a4 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -41,7 +41,7 @@
 #include <linux/edac.h>
 
 #include <linux/io-64-nonatomic-lo-hi.h>
-#include "edac_core.h"
+#include "edac_module.h"
 
 #define IE31200_REVISION "1.0"
 #define EDAC_MOD_STR "ie31200_edac"
diff --git a/drivers/edac/layerscape_edac.c b/drivers/edac/layerscape_edac.c
index 6c59d897ad12..94cac7686a56 100644
--- a/drivers/edac/layerscape_edac.c
+++ b/drivers/edac/layerscape_edac.c
@@ -16,7 +16,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include "edac_core.h"
+#include "edac_module.h"
 #include "fsl_ddr_edac.h"
 
 static const struct of_device_id fsl_ddr_mc_err_of_match[] = {
diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index ff0567526ee3..ab51ce0aae0a 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -25,7 +25,6 @@
 #include <linux/of_platform.h>
 #include <linux/of_device.h>
 #include "edac_module.h"
-#include "edac_core.h"
 #include "mpc85xx_edac.h"
 #include "fsl_ddr_edac.h"
 
diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c
index cb9b8577acbc..14b7e7b71eaa 100644
--- a/drivers/edac/mv64x60_edac.c
+++ b/drivers/edac/mv64x60_edac.c
@@ -17,7 +17,6 @@
 #include <linux/edac.h>
 #include <linux/gfp.h>
 
-#include "edac_core.h"
 #include "edac_module.h"
 #include "mv64x60_edac.h"
 
diff --git a/drivers/edac/octeon_edac-l2c.c b/drivers/edac/octeon_edac-l2c.c
index afea7fc625cc..c33059e9b0be 100644
--- a/drivers/edac/octeon_edac-l2c.c
+++ b/drivers/edac/octeon_edac-l2c.c
@@ -16,7 +16,6 @@
 
 #include <asm/octeon/cvmx.h>
 
-#include "edac_core.h"
 #include "edac_module.h"
 
 #define EDAC_MOD_STR "octeon-l2c"
diff --git a/drivers/edac/octeon_edac-lmc.c b/drivers/edac/octeon_edac-lmc.c
index cda6dab5067a..9c1ffe3e912b 100644
--- a/drivers/edac/octeon_edac-lmc.c
+++ b/drivers/edac/octeon_edac-lmc.c
@@ -19,7 +19,6 @@
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-lmcx-defs.h>
 
-#include "edac_core.h"
 #include "edac_module.h"
 
 #define OCTEON_MAX_MC 4
diff --git a/drivers/edac/octeon_edac-pc.c b/drivers/edac/octeon_edac-pc.c
index 2ab6cf24c959..754eced59c32 100644
--- a/drivers/edac/octeon_edac-pc.c
+++ b/drivers/edac/octeon_edac-pc.c
@@ -15,7 +15,6 @@
 #include <linux/io.h>
 #include <linux/edac.h>
 
-#include "edac_core.h"
 #include "edac_module.h"
 
 #include <asm/octeon/cvmx.h>
diff --git a/drivers/edac/octeon_edac-pci.c b/drivers/edac/octeon_edac-pci.c
index 9ca73cec74e7..28b238eecefc 100644
--- a/drivers/edac/octeon_edac-pci.c
+++ b/drivers/edac/octeon_edac-pci.c
@@ -18,7 +18,6 @@
 #include <asm/octeon/cvmx-pci-defs.h>
 #include <asm/octeon/octeon.h>
 
-#include "edac_core.h"
 #include "edac_module.h"
 
 static void octeon_pci_poll(struct edac_pci_ctl_info *pci)
diff --git a/drivers/edac/pasemi_edac.c b/drivers/edac/pasemi_edac.c
index 9c971b575530..199f2c80480d 100644
--- a/drivers/edac/pasemi_edac.c
+++ b/drivers/edac/pasemi_edac.c
@@ -26,7 +26,7 @@
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include <linux/edac.h>
-#include "edac_core.h"
+#include "edac_module.h"
 
 #define MODULE_NAME "pasemi_edac"
 
diff --git a/drivers/edac/ppc4xx_edac.c b/drivers/edac/ppc4xx_edac.c
index 691ce25e9010..e55e92590106 100644
--- a/drivers/edac/ppc4xx_edac.c
+++ b/drivers/edac/ppc4xx_edac.c
@@ -21,7 +21,7 @@
 
 #include <asm/dcr.h>
 
-#include "edac_core.h"
+#include "edac_module.h"
 #include "ppc4xx_edac.h"
 
 /*
diff --git a/drivers/edac/r82600_edac.c b/drivers/edac/r82600_edac.c
index 8f936bc7a010..978916625ced 100644
--- a/drivers/edac/r82600_edac.c
+++ b/drivers/edac/r82600_edac.c
@@ -20,7 +20,7 @@
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include <linux/edac.h>
-#include "edac_core.h"
+#include "edac_module.h"
 
 #define R82600_REVISION	" Ver: 2.0.2"
 #define EDAC_MOD_STR	"r82600_edac"
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 54775221a01f..2d4256bb2ac6 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -26,7 +26,7 @@
 #include <asm/processor.h>
 #include <asm/mce.h>
 
-#include "edac_core.h"
+#include "edac_module.h"
 
 /* Static vars */
 static LIST_HEAD(sbridge_edac_list);
diff --git a/drivers/edac/skx_edac.c b/drivers/edac/skx_edac.c
index 0ff4878c2aa1..db46514e4c13 100644
--- a/drivers/edac/skx_edac.c
+++ b/drivers/edac/skx_edac.c
@@ -28,7 +28,7 @@
 #include <asm/processor.h>
 #include <asm/mce.h>
 
-#include "edac_core.h"
+#include "edac_module.h"
 
 #define SKX_REVISION    " Ver: 1.0 "
 
diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index fc153aea2f6c..1c01dec78ec3 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -23,7 +23,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
-#include "edac_core.h"
+#include "edac_module.h"
 
 /* Number of cs_rows needed per memory controller */
 #define SYNPS_EDAC_NR_CSROWS	1
diff --git a/drivers/edac/tile_edac.c b/drivers/edac/tile_edac.c
index 71381642ce2a..8a33a87e67f1 100644
--- a/drivers/edac/tile_edac.c
+++ b/drivers/edac/tile_edac.c
@@ -30,7 +30,7 @@
 #include <hv/hypervisor.h>
 #include <hv/drv_mshim_intf.h>
 
-#include "edac_core.h"
+#include "edac_module.h"
 
 #define DRV_NAME	"tile-edac"
 
diff --git a/drivers/edac/x38_edac.c b/drivers/edac/x38_edac.c
index 314cf5cf268c..03c97a4bf590 100644
--- a/drivers/edac/x38_edac.c
+++ b/drivers/edac/x38_edac.c
@@ -16,7 +16,7 @@
 #include <linux/edac.h>
 
 #include <linux/io-64-nonatomic-lo-hi.h>
-#include "edac_core.h"
+#include "edac_module.h"
 
 #define X38_REVISION		"1.1"
 
diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index bf19b6e3bd12..54acb8fcb2fc 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -28,7 +28,6 @@
 #include <linux/of_address.h>
 #include <linux/regmap.h>
 
-#include "edac_core.h"
 #include "edac_module.h"
 
 #define EDAC_MOD_STR			"xgene_edac"
-- 
2.7.4
