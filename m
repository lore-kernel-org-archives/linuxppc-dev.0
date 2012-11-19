Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id 1B6CB2C009B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:38:01 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 415/493] mtd: remove use of __devexit
Date: Mon, 19 Nov 2012 13:26:04 -0500
Message-Id: <1353349642-3677-415-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: Wan ZongShun <mcuos.com@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Joern Engel <joern@lazybastard.org>, Kyungmin Park <kyungmin.park@samsung.com>,
 linux-mtd@lists.infradead.org, Olof Johansson <olof@lixom.net>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: David Woodhouse <dwmw2@infradead.org> 
Cc: Joern Engel <joern@lazybastard.org> 
Cc: Wan ZongShun <mcuos.com@gmail.com> 
Cc: Olof Johansson <olof@lixom.net> 
Cc: Kyungmin Park <kyungmin.park@samsung.com> 
Cc: linux-mtd@lists.infradead.org 
Cc: linux-arm-kernel@lists.infradead.org 
Cc: linuxppc-dev@lists.ozlabs.org 
---
 drivers/mtd/devices/bcm47xxsflash.c    | 2 +-
 drivers/mtd/devices/block2mtd.c        | 2 +-
 drivers/mtd/devices/m25p80.c           | 2 +-
 drivers/mtd/devices/mtd_dataflash.c    | 2 +-
 drivers/mtd/devices/spear_smi.c        | 2 +-
 drivers/mtd/devices/sst25l.c           | 2 +-
 drivers/mtd/maps/amd76xrom.c           | 2 +-
 drivers/mtd/maps/autcpu12-nvram.c      | 2 +-
 drivers/mtd/maps/bfin-async-flash.c    | 2 +-
 drivers/mtd/maps/ck804xrom.c           | 2 +-
 drivers/mtd/maps/esb2rom.c             | 2 +-
 drivers/mtd/maps/gpio-addr-flash.c     | 2 +-
 drivers/mtd/maps/ichxrom.c             | 2 +-
 drivers/mtd/maps/intel_vr_nor.c        | 8 ++++----
 drivers/mtd/maps/lantiq-flash.c        | 2 +-
 drivers/mtd/maps/pci.c                 | 2 +-
 drivers/mtd/maps/pismo.c               | 2 +-
 drivers/mtd/maps/pxa2xx-flash.c        | 2 +-
 drivers/mtd/maps/scb2_flash.c          | 2 +-
 drivers/mtd/maps/sun_uflash.c          | 2 +-
 drivers/mtd/maps/vmu-flash.c           | 4 ++--
 drivers/mtd/nand/ams-delta.c           | 2 +-
 drivers/mtd/nand/au1550nd.c            | 2 +-
 drivers/mtd/nand/bf5xx_nand.c          | 2 +-
 drivers/mtd/nand/cafe_nand.c           | 2 +-
 drivers/mtd/nand/denali_dt.c           | 2 +-
 drivers/mtd/nand/denali_pci.c          | 2 +-
 drivers/mtd/nand/fsl_upm.c             | 2 +-
 drivers/mtd/nand/gpio.c                | 2 +-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 2 +-
 drivers/mtd/nand/jz4740_nand.c         | 2 +-
 drivers/mtd/nand/lpc32xx_mlc.c         | 2 +-
 drivers/mtd/nand/lpc32xx_slc.c         | 2 +-
 drivers/mtd/nand/mpc5121_nfc.c         | 2 +-
 drivers/mtd/nand/mxc_nand.c            | 2 +-
 drivers/mtd/nand/ndfc.c                | 2 +-
 drivers/mtd/nand/nuc900_nand.c         | 2 +-
 drivers/mtd/nand/orion_nand.c          | 2 +-
 drivers/mtd/nand/pasemi_nand.c         | 2 +-
 drivers/mtd/nand/plat_nand.c           | 2 +-
 drivers/mtd/nand/sh_flctl.c            | 2 +-
 drivers/mtd/nand/sharpsl.c             | 2 +-
 drivers/mtd/nand/socrates_nand.c       | 2 +-
 drivers/mtd/onenand/generic.c          | 2 +-
 drivers/mtd/onenand/omap2.c            | 2 +-
 drivers/mtd/onenand/samsung.c          | 2 +-
 46 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/mtd/devices/bcm47xxsflash.c b/drivers/mtd/devices/bcm47xxsflash.c
index 113aced..4714584 100644
--- a/drivers/mtd/devices/bcm47xxsflash.c
+++ b/drivers/mtd/devices/bcm47xxsflash.c
@@ -66,7 +66,7 @@ out:
 	return err;
 }
 
-static int __devexit bcm47xxsflash_remove(struct platform_device *pdev)
+static int bcm47xxsflash_remove(struct platform_device *pdev)
 {
 	struct bcma_sflash *sflash = dev_get_platdata(&pdev->dev);
 
diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index 681e2ee..8debac9 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -433,7 +433,7 @@ static int __init block2mtd_init(void)
 }
 
 
-static void __devexit block2mtd_exit(void)
+static void block2mtd_exit(void)
 {
 	struct list_head *pos, *next;
 
diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 700f991..4064dba 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -971,7 +971,7 @@ static int m25p_probe(struct spi_device *spi)
 }
 
 
-static int __devexit m25p_remove(struct spi_device *spi)
+static int m25p_remove(struct spi_device *spi)
 {
 	struct m25p	*flash = dev_get_drvdata(&spi->dev);
 	int		status;
diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
index 0b3f173..0caefb4 100644
--- a/drivers/mtd/devices/mtd_dataflash.c
+++ b/drivers/mtd/devices/mtd_dataflash.c
@@ -897,7 +897,7 @@ static int dataflash_probe(struct spi_device *spi)
 	return status;
 }
 
-static int __devexit dataflash_remove(struct spi_device *spi)
+static int dataflash_remove(struct spi_device *spi)
 {
 	struct dataflash	*flash = dev_get_drvdata(&spi->dev);
 	int			status;
diff --git a/drivers/mtd/devices/spear_smi.c b/drivers/mtd/devices/spear_smi.c
index a30cd27..2d2c2a5 100644
--- a/drivers/mtd/devices/spear_smi.c
+++ b/drivers/mtd/devices/spear_smi.c
@@ -1016,7 +1016,7 @@ err:
  *
  * free all allocations and delete the partitions.
  */
-static int __devexit spear_smi_remove(struct platform_device *pdev)
+static int spear_smi_remove(struct platform_device *pdev)
 {
 	struct spear_smi *dev;
 	struct spear_snor_flash *flash;
diff --git a/drivers/mtd/devices/sst25l.c b/drivers/mtd/devices/sst25l.c
index e4f2339..8091b01 100644
--- a/drivers/mtd/devices/sst25l.c
+++ b/drivers/mtd/devices/sst25l.c
@@ -411,7 +411,7 @@ static int sst25l_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int __devexit sst25l_remove(struct spi_device *spi)
+static int sst25l_remove(struct spi_device *spi)
 {
 	struct sst25l_flash *flash = dev_get_drvdata(&spi->dev);
 	int ret;
diff --git a/drivers/mtd/maps/amd76xrom.c b/drivers/mtd/maps/amd76xrom.c
index 1a4f671..31ee5c8 100644
--- a/drivers/mtd/maps/amd76xrom.c
+++ b/drivers/mtd/maps/amd76xrom.c
@@ -289,7 +289,7 @@ static int amd76xrom_init_one (struct pci_dev *pdev,
 }
 
 
-static void __devexit amd76xrom_remove_one (struct pci_dev *pdev)
+static void amd76xrom_remove_one (struct pci_dev *pdev)
 {
 	struct amd76xrom_window *window = &amd76xrom_window;
 
diff --git a/drivers/mtd/maps/autcpu12-nvram.c b/drivers/mtd/maps/autcpu12-nvram.c
index b8c8589..a2dc2ae 100644
--- a/drivers/mtd/maps/autcpu12-nvram.c
+++ b/drivers/mtd/maps/autcpu12-nvram.c
@@ -105,7 +105,7 @@ static int autcpu12_nvram_probe(struct platform_device *pdev)
 	return -ENOMEM;
 }
 
-static int __devexit autcpu12_nvram_remove(struct platform_device *pdev)
+static int autcpu12_nvram_remove(struct platform_device *pdev)
 {
 	struct autcpu12_nvram_priv *priv = platform_get_drvdata(pdev);
 
diff --git a/drivers/mtd/maps/bfin-async-flash.c b/drivers/mtd/maps/bfin-async-flash.c
index 6057c64..7d484de 100644
--- a/drivers/mtd/maps/bfin-async-flash.c
+++ b/drivers/mtd/maps/bfin-async-flash.c
@@ -172,7 +172,7 @@ static int bfin_flash_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit bfin_flash_remove(struct platform_device *pdev)
+static int bfin_flash_remove(struct platform_device *pdev)
 {
 	struct async_state *state = platform_get_drvdata(pdev);
 	gpio_free(state->enet_flash_pin);
diff --git a/drivers/mtd/maps/ck804xrom.c b/drivers/mtd/maps/ck804xrom.c
index 65fedb9..0ac41f2 100644
--- a/drivers/mtd/maps/ck804xrom.c
+++ b/drivers/mtd/maps/ck804xrom.c
@@ -320,7 +320,7 @@ static int ck804xrom_init_one (struct pci_dev *pdev,
 }
 
 
-static void __devexit ck804xrom_remove_one (struct pci_dev *pdev)
+static void ck804xrom_remove_one (struct pci_dev *pdev)
 {
 	struct ck804xrom_window *window = &ck804xrom_window;
 
diff --git a/drivers/mtd/maps/esb2rom.c b/drivers/mtd/maps/esb2rom.c
index 664303f..6d6cb88 100644
--- a/drivers/mtd/maps/esb2rom.c
+++ b/drivers/mtd/maps/esb2rom.c
@@ -378,7 +378,7 @@ static int esb2rom_init_one(struct pci_dev *pdev,
 	return 0;
 }
 
-static void __devexit esb2rom_remove_one (struct pci_dev *pdev)
+static void esb2rom_remove_one (struct pci_dev *pdev)
 {
 	struct esb2rom_window *window = &esb2rom_window;
 	esb2rom_cleanup(window);
diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index 4babe04..41aa8db 100644
--- a/drivers/mtd/maps/gpio-addr-flash.c
+++ b/drivers/mtd/maps/gpio-addr-flash.c
@@ -258,7 +258,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit gpio_flash_remove(struct platform_device *pdev)
+static int gpio_flash_remove(struct platform_device *pdev)
 {
 	struct async_state *state = platform_get_drvdata(pdev);
 	size_t i = 0;
diff --git a/drivers/mtd/maps/ichxrom.c b/drivers/mtd/maps/ichxrom.c
index 9673601..03d60ef 100644
--- a/drivers/mtd/maps/ichxrom.c
+++ b/drivers/mtd/maps/ichxrom.c
@@ -315,7 +315,7 @@ static int ichxrom_init_one (struct pci_dev *pdev,
 }
 
 
-static void __devexit ichxrom_remove_one (struct pci_dev *pdev)
+static void ichxrom_remove_one (struct pci_dev *pdev)
 {
 	struct ichxrom_window *window = &ichxrom_window;
 	ichxrom_cleanup(window);
diff --git a/drivers/mtd/maps/intel_vr_nor.c b/drivers/mtd/maps/intel_vr_nor.c
index 1694c03..3ee2ad1 100644
--- a/drivers/mtd/maps/intel_vr_nor.c
+++ b/drivers/mtd/maps/intel_vr_nor.c
@@ -63,7 +63,7 @@ struct vr_nor_mtd {
 #define TIMING_BYTE_EN		(1 <<  0)	/* 8-bit vs 16-bit bus */
 #define TIMING_MASK		0x3FFF0000
 
-static void __devexit vr_nor_destroy_partitions(struct vr_nor_mtd *p)
+static void vr_nor_destroy_partitions(struct vr_nor_mtd *p)
 {
 	mtd_device_unregister(p->info);
 }
@@ -75,7 +75,7 @@ static int vr_nor_init_partitions(struct vr_nor_mtd *p)
 	return mtd_device_parse_register(p->info, NULL, NULL, NULL, 0);
 }
 
-static void __devexit vr_nor_destroy_mtd_setup(struct vr_nor_mtd *p)
+static void vr_nor_destroy_mtd_setup(struct vr_nor_mtd *p)
 {
 	map_destroy(p->info);
 }
@@ -96,7 +96,7 @@ static int vr_nor_mtd_setup(struct vr_nor_mtd *p)
 	return 0;
 }
 
-static void __devexit vr_nor_destroy_maps(struct vr_nor_mtd *p)
+static void vr_nor_destroy_maps(struct vr_nor_mtd *p)
 {
 	unsigned int exp_timing_cs0;
 
@@ -176,7 +176,7 @@ static struct pci_device_id vr_nor_pci_ids[] = {
 	{0,}
 };
 
-static void __devexit vr_nor_pci_remove(struct pci_dev *dev)
+static void vr_nor_pci_remove(struct pci_dev *dev)
 {
 	struct vr_nor_mtd *p = pci_get_drvdata(dev);
 
diff --git a/drivers/mtd/maps/lantiq-flash.c b/drivers/mtd/maps/lantiq-flash.c
index 0cf6c73..3c3c791 100644
--- a/drivers/mtd/maps/lantiq-flash.c
+++ b/drivers/mtd/maps/lantiq-flash.c
@@ -185,7 +185,7 @@ err_out:
 	return err;
 }
 
-static int __devexit
+static int
 ltq_mtd_remove(struct platform_device *pdev)
 {
 	struct ltq_mtd *ltq_mtd = platform_get_drvdata(pdev);
diff --git a/drivers/mtd/maps/pci.c b/drivers/mtd/maps/pci.c
index 81a8caf..ed82914 100644
--- a/drivers/mtd/maps/pci.c
+++ b/drivers/mtd/maps/pci.c
@@ -308,7 +308,7 @@ out:
 	return err;
 }
 
-static void __devexit
+static void
 mtd_pci_remove(struct pci_dev *dev)
 {
 	struct mtd_info *mtd = pci_get_drvdata(dev);
diff --git a/drivers/mtd/maps/pismo.c b/drivers/mtd/maps/pismo.c
index 01db0d0..afea93b 100644
--- a/drivers/mtd/maps/pismo.c
+++ b/drivers/mtd/maps/pismo.c
@@ -197,7 +197,7 @@ static void pismo_add_one(struct pismo_data *pismo, int i,
 	}
 }
 
-static int __devexit pismo_remove(struct i2c_client *client)
+static int pismo_remove(struct i2c_client *client)
 {
 	struct pismo_data *pismo = i2c_get_clientdata(client);
 	int i;
diff --git a/drivers/mtd/maps/pxa2xx-flash.c b/drivers/mtd/maps/pxa2xx-flash.c
index b5120f9..43e3dbb 100644
--- a/drivers/mtd/maps/pxa2xx-flash.c
+++ b/drivers/mtd/maps/pxa2xx-flash.c
@@ -105,7 +105,7 @@ static int pxa2xx_flash_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit pxa2xx_flash_remove(struct platform_device *dev)
+static int pxa2xx_flash_remove(struct platform_device *dev)
 {
 	struct pxa2xx_flash_info *info = platform_get_drvdata(dev);
 
diff --git a/drivers/mtd/maps/scb2_flash.c b/drivers/mtd/maps/scb2_flash.c
index bb1857f..71796137 100644
--- a/drivers/mtd/maps/scb2_flash.c
+++ b/drivers/mtd/maps/scb2_flash.c
@@ -197,7 +197,7 @@ scb2_flash_probe(struct pci_dev *dev, const struct pci_device_id *ent)
 	return 0;
 }
 
-static void __devexit
+static void
 scb2_flash_remove(struct pci_dev *dev)
 {
 	if (!scb2_mtd)
diff --git a/drivers/mtd/maps/sun_uflash.c b/drivers/mtd/maps/sun_uflash.c
index 2618e4d..d467f3b 100644
--- a/drivers/mtd/maps/sun_uflash.c
+++ b/drivers/mtd/maps/sun_uflash.c
@@ -121,7 +121,7 @@ static int uflash_probe(struct platform_device *op)
 	return uflash_devinit(op, dp);
 }
 
-static int __devexit uflash_remove(struct platform_device *op)
+static int uflash_remove(struct platform_device *op)
 {
 	struct uflash_dev *up = dev_get_drvdata(&op->dev);
 
diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index 84c3f5a..6b223cf 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -690,7 +690,7 @@ fail_nomem:
 	return error;
 }
 
-static void __devexit vmu_disconnect(struct maple_device *mdev)
+static void vmu_disconnect(struct maple_device *mdev)
 {
 	struct memcard *card;
 	struct mdev_part *mpart;
@@ -789,7 +789,7 @@ static int probe_maple_vmu(struct device *dev)
 	return 0;
 }
 
-static int __devexit remove_maple_vmu(struct device *dev)
+static int remove_maple_vmu(struct device *dev)
 {
 	struct maple_device *mdev = to_maple_dev(dev);
 
diff --git a/drivers/mtd/nand/ams-delta.c b/drivers/mtd/nand/ams-delta.c
index 703e373..f1d71cd 100644
--- a/drivers/mtd/nand/ams-delta.c
+++ b/drivers/mtd/nand/ams-delta.c
@@ -270,7 +270,7 @@ out_free:
 /*
  * Clean up routine
  */
-static int __devexit ams_delta_cleanup(struct platform_device *pdev)
+static int ams_delta_cleanup(struct platform_device *pdev)
 {
 	void __iomem *io_base = platform_get_drvdata(pdev);
 
diff --git a/drivers/mtd/nand/au1550nd.c b/drivers/mtd/nand/au1550nd.c
index 73d6423..217459d 100644
--- a/drivers/mtd/nand/au1550nd.c
+++ b/drivers/mtd/nand/au1550nd.c
@@ -491,7 +491,7 @@ out1:
 	return ret;
 }
 
-static int __devexit au1550nd_remove(struct platform_device *pdev)
+static int au1550nd_remove(struct platform_device *pdev)
 {
 	struct au1550nd_ctx *ctx = platform_get_drvdata(pdev);
 	struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/mtd/nand/bf5xx_nand.c b/drivers/mtd/nand/bf5xx_nand.c
index 56de9b6..4271e94 100644
--- a/drivers/mtd/nand/bf5xx_nand.c
+++ b/drivers/mtd/nand/bf5xx_nand.c
@@ -667,7 +667,7 @@ static int bf5xx_nand_add_partition(struct bf5xx_nand_info *info)
 	return mtd_device_register(mtd, parts, nr);
 }
 
-static int __devexit bf5xx_nand_remove(struct platform_device *pdev)
+static int bf5xx_nand_remove(struct platform_device *pdev)
 {
 	struct bf5xx_nand_info *info = to_nand_info(pdev);
 
diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
index 480834a..010d612 100644
--- a/drivers/mtd/nand/cafe_nand.c
+++ b/drivers/mtd/nand/cafe_nand.c
@@ -821,7 +821,7 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 	return err;
 }
 
-static void __devexit cafe_nand_remove(struct pci_dev *pdev)
+static void cafe_nand_remove(struct pci_dev *pdev)
 {
 	struct mtd_info *mtd = pci_get_drvdata(pdev);
 	struct cafe_priv *cafe = mtd->priv;
diff --git a/drivers/mtd/nand/denali_dt.c b/drivers/mtd/nand/denali_dt.c
index f9b593c..546f8cb 100644
--- a/drivers/mtd/nand/denali_dt.c
+++ b/drivers/mtd/nand/denali_dt.c
@@ -129,7 +129,7 @@ out_disable_clk:
 	return ret;
 }
 
-static int __devexit denali_dt_remove(struct platform_device *ofdev)
+static int denali_dt_remove(struct platform_device *ofdev)
 {
 	struct denali_dt *dt = platform_get_drvdata(ofdev);
 
diff --git a/drivers/mtd/nand/denali_pci.c b/drivers/mtd/nand/denali_pci.c
index f1f8f89..e3e4662 100644
--- a/drivers/mtd/nand/denali_pci.c
+++ b/drivers/mtd/nand/denali_pci.c
@@ -137,7 +137,7 @@ static int denali_init_pci(void)
 }
 module_init(denali_init_pci);
 
-static void __devexit denali_exit_pci(void)
+static void denali_exit_pci(void)
 {
 	pci_unregister_driver(&denali_pci_driver);
 }
diff --git a/drivers/mtd/nand/fsl_upm.c b/drivers/mtd/nand/fsl_upm.c
index a564325..5a8f5c4 100644
--- a/drivers/mtd/nand/fsl_upm.c
+++ b/drivers/mtd/nand/fsl_upm.c
@@ -318,7 +318,7 @@ err1:
 	return ret;
 }
 
-static int __devexit fun_remove(struct platform_device *ofdev)
+static int fun_remove(struct platform_device *ofdev)
 {
 	struct fsl_upm_nand *fun = dev_get_drvdata(&ofdev->dev);
 	int i;
diff --git a/drivers/mtd/nand/gpio.c b/drivers/mtd/nand/gpio.c
index 45f1a24..7aec569 100644
--- a/drivers/mtd/nand/gpio.c
+++ b/drivers/mtd/nand/gpio.c
@@ -231,7 +231,7 @@ gpio_nand_get_io_sync(struct platform_device *pdev)
 	return platform_get_resource(pdev, IORESOURCE_MEM, 1);
 }
 
-static int __devexit gpio_nand_remove(struct platform_device *dev)
+static int gpio_nand_remove(struct platform_device *dev)
 {
 	struct gpiomtd *gpiomtd = platform_get_drvdata(dev);
 	struct resource *res;
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 2a251c9..5cd141f 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1675,7 +1675,7 @@ exit_acquire_resources:
 	return ret;
 }
 
-static int __devexit gpmi_nand_remove(struct platform_device *pdev)
+static int gpmi_nand_remove(struct platform_device *pdev)
 {
 	struct gpmi_nand_data *this = platform_get_drvdata(pdev);
 
diff --git a/drivers/mtd/nand/jz4740_nand.c b/drivers/mtd/nand/jz4740_nand.c
index 5396b6c..72ac26e 100644
--- a/drivers/mtd/nand/jz4740_nand.c
+++ b/drivers/mtd/nand/jz4740_nand.c
@@ -541,7 +541,7 @@ err_free:
 	return ret;
 }
 
-static int __devexit jz_nand_remove(struct platform_device *pdev)
+static int jz_nand_remove(struct platform_device *pdev)
 {
 	struct jz_nand *nand = platform_get_drvdata(pdev);
 	struct jz_nand_platform_data *pdata = pdev->dev.platform_data;
diff --git a/drivers/mtd/nand/lpc32xx_mlc.c b/drivers/mtd/nand/lpc32xx_mlc.c
index bb83daf..f182bef 100644
--- a/drivers/mtd/nand/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/lpc32xx_mlc.c
@@ -845,7 +845,7 @@ err_exit1:
 /*
  * Remove NAND device
  */
-static int __devexit lpc32xx_nand_remove(struct platform_device *pdev)
+static int lpc32xx_nand_remove(struct platform_device *pdev)
 {
 	struct lpc32xx_nand_host *host = platform_get_drvdata(pdev);
 	struct mtd_info *mtd = &host->mtd;
diff --git a/drivers/mtd/nand/lpc32xx_slc.c b/drivers/mtd/nand/lpc32xx_slc.c
index 17267f2..030b78c 100644
--- a/drivers/mtd/nand/lpc32xx_slc.c
+++ b/drivers/mtd/nand/lpc32xx_slc.c
@@ -949,7 +949,7 @@ err_exit1:
 /*
  * Remove NAND device.
  */
-static int __devexit lpc32xx_nand_remove(struct platform_device *pdev)
+static int lpc32xx_nand_remove(struct platform_device *pdev)
 {
 	uint32_t tmp;
 	struct lpc32xx_nand_host *host = platform_get_drvdata(pdev);
diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nfc.c
index 09f75a5..3c9cdcb 100644
--- a/drivers/mtd/nand/mpc5121_nfc.c
+++ b/drivers/mtd/nand/mpc5121_nfc.c
@@ -827,7 +827,7 @@ error:
 	return retval;
 }
 
-static int __devexit mpc5121_nfc_remove(struct platform_device *op)
+static int mpc5121_nfc_remove(struct platform_device *op)
 {
 	struct device *dev = &op->dev;
 	struct mtd_info *mtd = dev_get_drvdata(dev);
diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 0887c2c..d316324 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -1561,7 +1561,7 @@ escan:
 	return err;
 }
 
-static int __devexit mxcnd_remove(struct platform_device *pdev)
+static int mxcnd_remove(struct platform_device *pdev)
 {
 	struct mxc_nand_host *host = platform_get_drvdata(pdev);
 
diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
index 6fa4588..8e148f1 100644
--- a/drivers/mtd/nand/ndfc.c
+++ b/drivers/mtd/nand/ndfc.c
@@ -256,7 +256,7 @@ static int ndfc_probe(struct platform_device *ofdev)
 	return 0;
 }
 
-static int __devexit ndfc_remove(struct platform_device *ofdev)
+static int ndfc_remove(struct platform_device *ofdev)
 {
 	struct ndfc_controller *ndfc = dev_get_drvdata(&ofdev->dev);
 
diff --git a/drivers/mtd/nand/nuc900_nand.c b/drivers/mtd/nand/nuc900_nand.c
index 00766df..a619119 100644
--- a/drivers/mtd/nand/nuc900_nand.c
+++ b/drivers/mtd/nand/nuc900_nand.c
@@ -317,7 +317,7 @@ fail1:	kfree(nuc900_nand);
 	return retval;
 }
 
-static int __devexit nuc900_nand_remove(struct platform_device *pdev)
+static int nuc900_nand_remove(struct platform_device *pdev)
 {
 	struct nuc900_nand *nuc900_nand = platform_get_drvdata(pdev);
 	struct resource *res;
diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
index e6b296d..cd72b92 100644
--- a/drivers/mtd/nand/orion_nand.c
+++ b/drivers/mtd/nand/orion_nand.c
@@ -194,7 +194,7 @@ no_res:
 	return ret;
 }
 
-static int __devexit orion_nand_remove(struct platform_device *pdev)
+static int orion_nand_remove(struct platform_device *pdev)
 {
 	struct mtd_info *mtd = platform_get_drvdata(pdev);
 	struct nand_chip *nc = mtd->priv;
diff --git a/drivers/mtd/nand/pasemi_nand.c b/drivers/mtd/nand/pasemi_nand.c
index 2e477cb..5a67082 100644
--- a/drivers/mtd/nand/pasemi_nand.c
+++ b/drivers/mtd/nand/pasemi_nand.c
@@ -184,7 +184,7 @@ static int pasemi_nand_probe(struct platform_device *ofdev)
 	return err;
 }
 
-static int __devexit pasemi_nand_remove(struct platform_device *ofdev)
+static int pasemi_nand_remove(struct platform_device *ofdev)
 {
 	struct nand_chip *chip;
 
diff --git a/drivers/mtd/nand/plat_nand.c b/drivers/mtd/nand/plat_nand.c
index 32e2996..c004566 100644
--- a/drivers/mtd/nand/plat_nand.c
+++ b/drivers/mtd/nand/plat_nand.c
@@ -134,7 +134,7 @@ out_free:
 /*
  * Remove a NAND device.
  */
-static int __devexit plat_nand_remove(struct platform_device *pdev)
+static int plat_nand_remove(struct platform_device *pdev)
 {
 	struct plat_nand_data *data = platform_get_drvdata(pdev);
 	struct platform_nand_data *pdata = pdev->dev.platform_data;
diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 607e6bd..57b3971 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -1200,7 +1200,7 @@ err_iomap:
 	return ret;
 }
 
-static int __devexit flctl_remove(struct platform_device *pdev)
+static int flctl_remove(struct platform_device *pdev)
 {
 	struct sh_flctl *flctl = platform_get_drvdata(pdev);
 
diff --git a/drivers/mtd/nand/sharpsl.c b/drivers/mtd/nand/sharpsl.c
index 870f0ff..127bc42 100644
--- a/drivers/mtd/nand/sharpsl.c
+++ b/drivers/mtd/nand/sharpsl.c
@@ -205,7 +205,7 @@ err_get_res:
 /*
  * Clean up routine
  */
-static int __devexit sharpsl_nand_remove(struct platform_device *pdev)
+static int sharpsl_nand_remove(struct platform_device *pdev)
 {
 	struct sharpsl_nand *sharpsl = platform_get_drvdata(pdev);
 
diff --git a/drivers/mtd/nand/socrates_nand.c b/drivers/mtd/nand/socrates_nand.c
index c9791fd..09dde7d 100644
--- a/drivers/mtd/nand/socrates_nand.c
+++ b/drivers/mtd/nand/socrates_nand.c
@@ -220,7 +220,7 @@ out:
 /*
  * Remove a NAND device.
  */
-static int __devexit socrates_nand_remove(struct platform_device *ofdev)
+static int socrates_nand_remove(struct platform_device *ofdev)
 {
 	struct socrates_nand_host *host = dev_get_drvdata(&ofdev->dev);
 	struct mtd_info *mtd = &host->mtd;
diff --git a/drivers/mtd/onenand/generic.c b/drivers/mtd/onenand/generic.c
index 03e6af3..9f11562 100644
--- a/drivers/mtd/onenand/generic.c
+++ b/drivers/mtd/onenand/generic.c
@@ -88,7 +88,7 @@ out_free_info:
 	return err;
 }
 
-static int __devexit generic_onenand_remove(struct platform_device *pdev)
+static int generic_onenand_remove(struct platform_device *pdev)
 {
 	struct onenand_info *info = platform_get_drvdata(pdev);
 	struct resource *res = pdev->resource;
diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 0c75bcc..5ca4dcd 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -799,7 +799,7 @@ err_kfree:
 	return r;
 }
 
-static int __devexit omap2_onenand_remove(struct platform_device *pdev)
+static int omap2_onenand_remove(struct platform_device *pdev)
 {
 	struct omap2_onenand *c = dev_get_drvdata(&pdev->dev);
 
diff --git a/drivers/mtd/onenand/samsung.c b/drivers/mtd/onenand/samsung.c
index 3d462cb..33f2a8f 100644
--- a/drivers/mtd/onenand/samsung.c
+++ b/drivers/mtd/onenand/samsung.c
@@ -1053,7 +1053,7 @@ onenand_fail:
 	return err;
 }
 
-static int __devexit s3c_onenand_remove(struct platform_device *pdev)
+static int s3c_onenand_remove(struct platform_device *pdev)
 {
 	struct mtd_info *mtd = platform_get_drvdata(pdev);
 
-- 
1.8.0
