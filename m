Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id 1B8102C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:38:02 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 065/493] i2c: remove use of __devexit_p
Date: Mon, 19 Nov 2012 13:20:14 -0500
Message-Id: <1353349642-3677-65-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: Rudolf Marek <r.marek@assembler.cz>, Tony Lindgren <tony@atomide.com>,
 Wolfram Sang <w.sang@pengutronix.de>, Olof Johansson <olof@lixom.net>,
 linux-omap@vger.kernel.org, "Mark M. Hoffman" <mhoffman@lightlink.com>,
 linux-i2c@vger.kernel.org, Ben Dooks  <ben-linux@fluff.org>,
 Barry Song <baohua.song@csr.com>, Jean Delvare <khali@linux-fr.org>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Jean Delvare <khali@linux-fr.org> 
Cc: Wolfram Sang <w.sang@pengutronix.de> 
Cc: "Ben Dooks " <ben-linux@fluff.org> 
Cc: Rudolf Marek <r.marek@assembler.cz> 
Cc: Jochen Friedrich <jochen@scram.de> 
Cc: Peter Korsgaard <jacmet@sunsite.dk> 
Cc: Tony Lindgren <tony@atomide.com> 
Cc: Olof Johansson <olof@lixom.net> 
Cc: Vitaly Wool <vitalywool@gmail.com> 
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn> 
Cc: Barry Song <baohua.song@csr.com> 
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com> 
Cc: linux-i2c@vger.kernel.org 
Cc: linuxppc-dev@lists.ozlabs.org 
Cc: linux-omap@vger.kernel.org 
Cc: linux-arm-kernel@lists.infradead.org 
---
 drivers/i2c/busses/i2c-ali1535.c            | 2 +-
 drivers/i2c/busses/i2c-ali1563.c            | 2 +-
 drivers/i2c/busses/i2c-ali15x3.c            | 2 +-
 drivers/i2c/busses/i2c-amd756.c             | 2 +-
 drivers/i2c/busses/i2c-amd8111.c            | 2 +-
 drivers/i2c/busses/i2c-at91.c               | 2 +-
 drivers/i2c/busses/i2c-au1550.c             | 2 +-
 drivers/i2c/busses/i2c-cpm.c                | 2 +-
 drivers/i2c/busses/i2c-designware-pcidrv.c  | 2 +-
 drivers/i2c/busses/i2c-designware-platdrv.c | 2 +-
 drivers/i2c/busses/i2c-eg20t.c              | 2 +-
 drivers/i2c/busses/i2c-elektor.c            | 2 +-
 drivers/i2c/busses/i2c-gpio.c               | 2 +-
 drivers/i2c/busses/i2c-highlander.c         | 2 +-
 drivers/i2c/busses/i2c-hydra.c              | 2 +-
 drivers/i2c/busses/i2c-i801.c               | 2 +-
 drivers/i2c/busses/i2c-ibm_iic.c            | 2 +-
 drivers/i2c/busses/i2c-intel-mid.c          | 2 +-
 drivers/i2c/busses/i2c-isch.c               | 2 +-
 drivers/i2c/busses/i2c-mpc.c                | 2 +-
 drivers/i2c/busses/i2c-mv64xxx.c            | 2 +-
 drivers/i2c/busses/i2c-mxs.c                | 2 +-
 drivers/i2c/busses/i2c-nforce2.c            | 2 +-
 drivers/i2c/busses/i2c-nuc900.c             | 2 +-
 drivers/i2c/busses/i2c-ocores.c             | 2 +-
 drivers/i2c/busses/i2c-octeon.c             | 2 +-
 drivers/i2c/busses/i2c-omap.c               | 2 +-
 drivers/i2c/busses/i2c-parport-light.c      | 2 +-
 drivers/i2c/busses/i2c-pasemi.c             | 2 +-
 drivers/i2c/busses/i2c-pca-isa.c            | 2 +-
 drivers/i2c/busses/i2c-pca-platform.c       | 2 +-
 drivers/i2c/busses/i2c-piix4.c              | 2 +-
 drivers/i2c/busses/i2c-pmcmsp.c             | 2 +-
 drivers/i2c/busses/i2c-pnx.c                | 2 +-
 drivers/i2c/busses/i2c-powermac.c           | 2 +-
 drivers/i2c/busses/i2c-puv3.c               | 2 +-
 drivers/i2c/busses/i2c-pxa-pci.c            | 2 +-
 drivers/i2c/busses/i2c-rcar.c               | 2 +-
 drivers/i2c/busses/i2c-s6000.c              | 2 +-
 drivers/i2c/busses/i2c-sh7760.c             | 2 +-
 drivers/i2c/busses/i2c-sirf.c               | 2 +-
 drivers/i2c/busses/i2c-sis630.c             | 2 +-
 drivers/i2c/busses/i2c-sis96x.c             | 2 +-
 drivers/i2c/busses/i2c-tegra.c              | 2 +-
 drivers/i2c/busses/i2c-via.c                | 2 +-
 drivers/i2c/busses/i2c-xiic.c               | 2 +-
 drivers/i2c/busses/i2c-xlr.c                | 2 +-
 drivers/i2c/busses/scx200_acb.c             | 2 +-
 drivers/i2c/muxes/i2c-mux-gpio.c            | 2 +-
 drivers/i2c/muxes/i2c-mux-pinctrl.c         | 2 +-
 50 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
index 125cd8e..cb30432 100644
--- a/drivers/i2c/busses/i2c-ali1535.c
+++ b/drivers/i2c/busses/i2c-ali1535.c
@@ -528,7 +528,7 @@ static struct pci_driver ali1535_driver = {
 	.name		= "ali1535_smbus",
 	.id_table	= ali1535_ids,
 	.probe		= ali1535_probe,
-	.remove		= __devexit_p(ali1535_remove),
+	.remove		= ali1535_remove,
 };
 
 module_pci_driver(ali1535_driver);
diff --git a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
index e02d9f8..547a96f 100644
--- a/drivers/i2c/busses/i2c-ali1563.c
+++ b/drivers/i2c/busses/i2c-ali1563.c
@@ -428,7 +428,7 @@ static struct pci_driver ali1563_pci_driver = {
  	.name		= "ali1563_smbus",
 	.id_table	= ali1563_id_table,
  	.probe		= ali1563_probe,
-	.remove		= __devexit_p(ali1563_remove),
+	.remove		= ali1563_remove,
 };
 
 module_pci_driver(ali1563_pci_driver);
diff --git a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
index ce8d26d..62692ec 100644
--- a/drivers/i2c/busses/i2c-ali15x3.c
+++ b/drivers/i2c/busses/i2c-ali15x3.c
@@ -510,7 +510,7 @@ static struct pci_driver ali15x3_driver = {
 	.name		= "ali15x3_smbus",
 	.id_table	= ali15x3_ids,
 	.probe		= ali15x3_probe,
-	.remove		= __devexit_p(ali15x3_remove),
+	.remove		= ali15x3_remove,
 };
 
 module_pci_driver(ali15x3_driver);
diff --git a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
index 304aa03..b890764 100644
--- a/drivers/i2c/busses/i2c-amd756.c
+++ b/drivers/i2c/busses/i2c-amd756.c
@@ -407,7 +407,7 @@ static struct pci_driver amd756_driver = {
 	.name		= "amd756_smbus",
 	.id_table	= amd756_ids,
 	.probe		= amd756_probe,
-	.remove		= __devexit_p(amd756_remove),
+	.remove		= amd756_remove,
 };
 
 module_pci_driver(amd756_driver);
diff --git a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
index 0919ac1..f5e5f70 100644
--- a/drivers/i2c/busses/i2c-amd8111.c
+++ b/drivers/i2c/busses/i2c-amd8111.c
@@ -488,7 +488,7 @@ static struct pci_driver amd8111_driver = {
 	.name		= "amd8111_smbus2",
 	.id_table	= amd8111_ids,
 	.probe		= amd8111_probe,
-	.remove		= __devexit_p(amd8111_remove),
+	.remove		= amd8111_remove,
 };
 
 module_pci_driver(amd8111_driver);
diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index c02bf20..d699e61 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -530,7 +530,7 @@ static const struct dev_pm_ops at91_twi_pm = {
 
 static struct platform_driver at91_twi_driver = {
 	.probe		= at91_twi_probe,
-	.remove		= __devexit_p(at91_twi_remove),
+	.remove		= at91_twi_remove,
 	.id_table	= at91_twi_devtypes,
 	.driver		= {
 		.name	= "at91_i2c",
diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
index 582d616..4c9cfc9 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -423,7 +423,7 @@ static struct platform_driver au1xpsc_smbus_driver = {
 		.pm	= AU1XPSC_SMBUS_PMOPS,
 	},
 	.probe		= i2c_au1550_probe,
-	.remove		= __devexit_p(i2c_au1550_remove),
+	.remove		= i2c_au1550_remove,
 };
 
 module_platform_driver(au1xpsc_smbus_driver);
diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index c1e1096..8d70fd3 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -716,7 +716,7 @@ MODULE_DEVICE_TABLE(of, cpm_i2c_match);
 
 static struct platform_driver cpm_i2c_driver = {
 	.probe		= cpm_i2c_probe,
-	.remove		= __devexit_p(cpm_i2c_remove),
+	.remove		= cpm_i2c_remove,
 	.driver = {
 		.name = "fsl-i2c-cpm",
 		.owner = THIS_MODULE,
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 92a1e2c..85df062 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -368,7 +368,7 @@ static struct pci_driver dw_i2c_driver = {
 	.name		= DRIVER_NAME,
 	.id_table	= i2_designware_pci_ids,
 	.probe		= i2c_dw_pci_probe,
-	.remove		= __devexit_p(i2c_dw_pci_remove),
+	.remove		= i2c_dw_pci_remove,
 	.driver         = {
 		.pm     = &i2c_dw_pm_ops,
 	},
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 0506fef..ccde6ec 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -228,7 +228,7 @@ static SIMPLE_DEV_PM_OPS(dw_i2c_dev_pm_ops, dw_i2c_suspend, dw_i2c_resume);
 MODULE_ALIAS("platform:i2c_designware");
 
 static struct platform_driver dw_i2c_driver = {
-	.remove		= __devexit_p(dw_i2c_remove),
+	.remove		= dw_i2c_remove,
 	.driver		= {
 		.name	= "i2c_designware",
 		.owner	= THIS_MODULE,
diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 259f769..128c98c 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -948,7 +948,7 @@ static struct pci_driver pch_pcidriver = {
 	.name = KBUILD_MODNAME,
 	.id_table = pch_pcidev_id,
 	.probe = pch_i2c_probe,
-	.remove = __devexit_p(pch_i2c_remove),
+	.remove = pch_i2c_remove,
 	.suspend = pch_i2c_suspend,
 	.resume = pch_i2c_resume
 };
diff --git a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
index 37e2e82..14af6b4 100644
--- a/drivers/i2c/busses/i2c-elektor.c
+++ b/drivers/i2c/busses/i2c-elektor.c
@@ -316,7 +316,7 @@ static int __devexit elektor_remove(struct device *dev, unsigned int id)
 static struct isa_driver i2c_elektor_driver = {
 	.match		= elektor_match,
 	.probe		= elektor_probe,
-	.remove		= __devexit_p(elektor_remove),
+	.remove		= elektor_remove,
 	.driver = {
 		.owner	= THIS_MODULE,
 		.name	= "i2c-elektor",
diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index 257299a..be8cb0d 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -251,7 +251,7 @@ static struct platform_driver i2c_gpio_driver = {
 		.of_match_table	= of_match_ptr(i2c_gpio_dt_ids),
 	},
 	.probe		= i2c_gpio_probe,
-	.remove		= __devexit_p(i2c_gpio_remove),
+	.remove		= i2c_gpio_remove,
 };
 
 static int __init i2c_gpio_init(void)
diff --git a/drivers/i2c/busses/i2c-highlander.c b/drivers/i2c/busses/i2c-highlander.c
index 19515df..f2cfb34 100644
--- a/drivers/i2c/busses/i2c-highlander.c
+++ b/drivers/i2c/busses/i2c-highlander.c
@@ -465,7 +465,7 @@ static struct platform_driver highlander_i2c_driver = {
 	},
 
 	.probe		= highlander_i2c_probe,
-	.remove		= __devexit_p(highlander_i2c_remove),
+	.remove		= highlander_i2c_remove,
 };
 
 module_platform_driver(highlander_i2c_driver);
diff --git a/drivers/i2c/busses/i2c-hydra.c b/drivers/i2c/busses/i2c-hydra.c
index c9f95e1..b24be50 100644
--- a/drivers/i2c/busses/i2c-hydra.c
+++ b/drivers/i2c/busses/i2c-hydra.c
@@ -153,7 +153,7 @@ static struct pci_driver hydra_driver = {
 	.name		= "hydra_smbus",
 	.id_table	= hydra_ids,
 	.probe		= hydra_probe,
-	.remove		= __devexit_p(hydra_remove),
+	.remove		= hydra_remove,
 };
 
 module_pci_driver(hydra_driver);
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 1e73638..acaa47d 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1272,7 +1272,7 @@ static struct pci_driver i801_driver = {
 	.name		= "i801_smbus",
 	.id_table	= i801_ids,
 	.probe		= i801_probe,
-	.remove		= __devexit_p(i801_remove),
+	.remove		= i801_remove,
 	.suspend	= i801_suspend,
 	.resume		= i801_resume,
 };
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 806e225..a10fdab 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -812,7 +812,7 @@ static struct platform_driver ibm_iic_driver = {
 		.of_match_table = ibm_iic_match,
 	},
 	.probe	= iic_probe,
-	.remove	= __devexit_p(iic_remove),
+	.remove	= iic_remove,
 };
 
 module_platform_driver(ibm_iic_driver);
diff --git a/drivers/i2c/busses/i2c-intel-mid.c b/drivers/i2c/busses/i2c-intel-mid.c
index 7c28f10..7616007 100644
--- a/drivers/i2c/busses/i2c-intel-mid.c
+++ b/drivers/i2c/busses/i2c-intel-mid.c
@@ -1113,7 +1113,7 @@ static struct pci_driver intel_mid_i2c_driver = {
 	.name		= DRIVER_NAME,
 	.id_table	= intel_mid_i2c_ids,
 	.probe		= intel_mid_i2c_probe,
-	.remove		= __devexit_p(intel_mid_i2c_remove),
+	.remove		= intel_mid_i2c_remove,
 };
 
 module_pci_driver(intel_mid_i2c_driver);
diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
index f90a605..1c050a6 100644
--- a/drivers/i2c/busses/i2c-isch.c
+++ b/drivers/i2c/busses/i2c-isch.c
@@ -303,7 +303,7 @@ static struct platform_driver smbus_sch_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe		= smbus_sch_probe,
-	.remove		= __devexit_p(smbus_sch_remove),
+	.remove		= smbus_sch_remove,
 };
 
 module_platform_driver(smbus_sch_driver);
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index ca86430..f016eef 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -785,7 +785,7 @@ MODULE_DEVICE_TABLE(of, mpc_i2c_of_match);
 /* Structure for a device driver */
 static struct platform_driver mpc_i2c_driver = {
 	.probe		= fsl_i2c_probe,
-	.remove		= __devexit_p(fsl_i2c_remove),
+	.remove		= fsl_i2c_remove,
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = DRV_NAME,
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 2e9d567..3107c0a 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -726,7 +726,7 @@ MODULE_DEVICE_TABLE(of, mv64xxx_i2c_of_match_table);
 
 static struct platform_driver mv64xxx_i2c_driver = {
 	.probe	= mv64xxx_i2c_probe,
-	.remove	= __devexit_p(mv64xxx_i2c_remove),
+	.remove	= mv64xxx_i2c_remove,
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= MV64XXX_I2C_CTLR_NAME,
diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 286ca19..e317b28 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -544,7 +544,7 @@ static struct platform_driver mxs_i2c_driver = {
 		   .owner = THIS_MODULE,
 		   .of_match_table = mxs_i2c_dt_ids,
 		   },
-	.remove = __devexit_p(mxs_i2c_remove),
+	.remove = mxs_i2c_remove,
 };
 
 static int __init mxs_i2c_init(void)
diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
index 392303b..9ed5721 100644
--- a/drivers/i2c/busses/i2c-nforce2.c
+++ b/drivers/i2c/busses/i2c-nforce2.c
@@ -450,7 +450,7 @@ static struct pci_driver nforce2_driver = {
 	.name		= "nForce2_smbus",
 	.id_table	= nforce2_ids,
 	.probe		= nforce2_probe,
-	.remove		= __devexit_p(nforce2_remove),
+	.remove		= nforce2_remove,
 };
 
 module_pci_driver(nforce2_driver);
diff --git a/drivers/i2c/busses/i2c-nuc900.c b/drivers/i2c/busses/i2c-nuc900.c
index f41502e..29939f2 100644
--- a/drivers/i2c/busses/i2c-nuc900.c
+++ b/drivers/i2c/busses/i2c-nuc900.c
@@ -684,7 +684,7 @@ static int __devexit nuc900_i2c_remove(struct platform_device *pdev)
 
 static struct platform_driver nuc900_i2c_driver = {
 	.probe		= nuc900_i2c_probe,
-	.remove		= __devexit_p(nuc900_i2c_remove),
+	.remove		= nuc900_i2c_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "nuc900-i2c0",
diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 1fad4ae..856fd5a 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -386,7 +386,7 @@ MODULE_DEVICE_TABLE(of, ocores_i2c_match);
 
 static struct platform_driver ocores_i2c_driver = {
 	.probe   = ocores_i2c_probe,
-	.remove  = __devexit_p(ocores_i2c_remove),
+	.remove  = ocores_i2c_remove,
 	.driver  = {
 		.owner = THIS_MODULE,
 		.name = "ocores-i2c",
diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index f44c835..e5015d4 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -628,7 +628,7 @@ MODULE_DEVICE_TABLE(of, octeon_i2c_match);
 
 static struct platform_driver octeon_i2c_driver = {
 	.probe		= octeon_i2c_probe,
-	.remove		= __devexit_p(octeon_i2c_remove),
+	.remove		= octeon_i2c_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= DRV_NAME,
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 482c63d..8721f98 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1334,7 +1334,7 @@ static struct dev_pm_ops omap_i2c_pm_ops = {
 
 static struct platform_driver omap_i2c_driver = {
 	.probe		= omap_i2c_probe,
-	.remove		= __devexit_p(omap_i2c_remove),
+	.remove		= omap_i2c_remove,
 	.driver		= {
 		.name	= "omap_i2c",
 		.owner	= THIS_MODULE,
diff --git a/drivers/i2c/busses/i2c-parport-light.c b/drivers/i2c/busses/i2c-parport-light.c
index 4b95f7a..240f724 100644
--- a/drivers/i2c/busses/i2c-parport-light.c
+++ b/drivers/i2c/busses/i2c-parport-light.c
@@ -191,7 +191,7 @@ static struct platform_driver i2c_parport_driver = {
 		.name	= DRVNAME,
 	},
 	.probe		= i2c_parport_probe,
-	.remove		= __devexit_p(i2c_parport_remove),
+	.remove		= i2c_parport_remove,
 };
 
 static int __init i2c_parport_device_add(u16 address)
diff --git a/drivers/i2c/busses/i2c-pasemi.c b/drivers/i2c/busses/i2c-pasemi.c
index 12edefd..dae53c3 100644
--- a/drivers/i2c/busses/i2c-pasemi.c
+++ b/drivers/i2c/busses/i2c-pasemi.c
@@ -412,7 +412,7 @@ static struct pci_driver pasemi_smb_driver = {
 	.name		= "i2c-pasemi",
 	.id_table	= pasemi_smb_ids,
 	.probe		= pasemi_smb_probe,
-	.remove		= __devexit_p(pasemi_smb_remove),
+	.remove		= pasemi_smb_remove,
 };
 
 module_pci_driver(pasemi_smb_driver);
diff --git a/drivers/i2c/busses/i2c-pca-isa.c b/drivers/i2c/busses/i2c-pca-isa.c
index 29933f8..7e75a12 100644
--- a/drivers/i2c/busses/i2c-pca-isa.c
+++ b/drivers/i2c/busses/i2c-pca-isa.c
@@ -190,7 +190,7 @@ static int __devexit pca_isa_remove(struct device *dev, unsigned int id)
 static struct isa_driver pca_isa_driver = {
 	.match		= pca_isa_match,
 	.probe		= pca_isa_probe,
-	.remove		= __devexit_p(pca_isa_remove),
+	.remove		= pca_isa_remove,
 	.driver = {
 		.owner	= THIS_MODULE,
 		.name	= DRIVER,
diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index 675878f..bffa7d6 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -279,7 +279,7 @@ static int __devexit i2c_pca_pf_remove(struct platform_device *pdev)
 
 static struct platform_driver i2c_pca_pf_driver = {
 	.probe = i2c_pca_pf_probe,
-	.remove = __devexit_p(i2c_pca_pf_remove),
+	.remove = i2c_pca_pf_remove,
 	.driver = {
 		.name = "i2c-pca-platform",
 		.owner = THIS_MODULE,
diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index f7216ed..6253e0b 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -655,7 +655,7 @@ static struct pci_driver piix4_driver = {
 	.name		= "piix4_smbus",
 	.id_table	= piix4_ids,
 	.probe		= piix4_probe,
-	.remove		= __devexit_p(piix4_remove),
+	.remove		= piix4_remove,
 };
 
 module_pci_driver(piix4_driver);
diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
index 3d71395..4ef4a4c 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -628,7 +628,7 @@ static struct i2c_adapter pmcmsptwi_adapter = {
 
 static struct platform_driver pmcmsptwi_driver = {
 	.probe  = pmcmsptwi_probe,
-	.remove	= __devexit_p(pmcmsptwi_remove),
+	.remove	= pmcmsptwi_remove,
 	.driver = {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 8488bdd..efd2c4f 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -797,7 +797,7 @@ static struct platform_driver i2c_pnx_driver = {
 		.pm = PNX_I2C_PM,
 	},
 	.probe = i2c_pnx_probe,
-	.remove = __devexit_p(i2c_pnx_remove),
+	.remove = i2c_pnx_remove,
 };
 
 static int __init i2c_adap_pnx_init(void)
diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index 5285f85..cb8ae67 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -467,7 +467,7 @@ static int __devinit i2c_powermac_probe(struct platform_device *dev)
 
 static struct platform_driver i2c_powermac_driver = {
 	.probe = i2c_powermac_probe,
-	.remove = __devexit_p(i2c_powermac_remove),
+	.remove = i2c_powermac_remove,
 	.driver = {
 		.name = "i2c-powermac",
 		.bus = &platform_bus_type,
diff --git a/drivers/i2c/busses/i2c-puv3.c b/drivers/i2c/busses/i2c-puv3.c
index d8515be..55a9e8c 100644
--- a/drivers/i2c/busses/i2c-puv3.c
+++ b/drivers/i2c/busses/i2c-puv3.c
@@ -276,7 +276,7 @@ static SIMPLE_DEV_PM_OPS(puv3_i2c_pm, puv3_i2c_suspend, NULL);
 
 static struct platform_driver puv3_i2c_driver = {
 	.probe		= puv3_i2c_probe,
-	.remove		= __devexit_p(puv3_i2c_remove),
+	.remove		= puv3_i2c_remove,
 	.driver		= {
 		.name	= "PKUnity-v3-I2C",
 		.owner	= THIS_MODULE,
diff --git a/drivers/i2c/busses/i2c-pxa-pci.c b/drivers/i2c/busses/i2c-pxa-pci.c
index 4dc9bef..9e1f180 100644
--- a/drivers/i2c/busses/i2c-pxa-pci.c
+++ b/drivers/i2c/busses/i2c-pxa-pci.c
@@ -160,7 +160,7 @@ static struct pci_driver ce4100_i2c_driver = {
 	.name           = "ce4100_i2c",
 	.id_table       = ce4100_i2c_devices,
 	.probe          = ce4100_i2c_probe,
-	.remove         = __devexit_p(ce4100_i2c_remove),
+	.remove         = ce4100_i2c_remove,
 };
 
 module_pci_driver(ce4100_i2c_driver);
diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 72a8071..44a29bd 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -699,7 +699,7 @@ static struct platform_driver rcar_i2c_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= rcar_i2c_probe,
-	.remove		= __devexit_p(rcar_i2c_remove),
+	.remove		= rcar_i2c_remove,
 };
 
 module_platform_driver(rcar_i2c_driver);
diff --git a/drivers/i2c/busses/i2c-s6000.c b/drivers/i2c/busses/i2c-s6000.c
index b76a29d..eebd9e1 100644
--- a/drivers/i2c/busses/i2c-s6000.c
+++ b/drivers/i2c/busses/i2c-s6000.c
@@ -378,7 +378,7 @@ static int __devexit s6i2c_remove(struct platform_device *pdev)
 
 static struct platform_driver s6i2c_driver = {
 	.probe		= s6i2c_probe,
-	.remove		= __devexit_p(s6i2c_remove),
+	.remove		= s6i2c_remove,
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/i2c/busses/i2c-sh7760.c b/drivers/i2c/busses/i2c-sh7760.c
index c0c9dff..ada2b87 100644
--- a/drivers/i2c/busses/i2c-sh7760.c
+++ b/drivers/i2c/busses/i2c-sh7760.c
@@ -557,7 +557,7 @@ static struct platform_driver sh7760_i2c_drv = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= sh7760_i2c_probe,
-	.remove		= __devexit_p(sh7760_i2c_remove),
+	.remove		= sh7760_i2c_remove,
 };
 
 module_platform_driver(sh7760_i2c_drv);
diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index 5574a47..87e70e5 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -449,7 +449,7 @@ static struct platform_driver i2c_sirfsoc_driver = {
 		.of_match_table = sirfsoc_i2c_of_match,
 	},
 	.probe = i2c_sirfsoc_probe,
-	.remove = __devexit_p(i2c_sirfsoc_remove),
+	.remove = i2c_sirfsoc_remove,
 };
 module_platform_driver(i2c_sirfsoc_driver);
 
diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
index 5d6723b..ec8a4bc 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -510,7 +510,7 @@ static struct pci_driver sis630_driver = {
 	.name		= "sis630_smbus",
 	.id_table	= sis630_ids,
 	.probe		= sis630_probe,
-	.remove		= __devexit_p(sis630_remove),
+	.remove		= sis630_remove,
 };
 
 module_pci_driver(sis630_driver);
diff --git a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
index 7b72614..8b64c17 100644
--- a/drivers/i2c/busses/i2c-sis96x.c
+++ b/drivers/i2c/busses/i2c-sis96x.c
@@ -321,7 +321,7 @@ static struct pci_driver sis96x_driver = {
 	.name		= "sis96x_smbus",
 	.id_table	= sis96x_ids,
 	.probe		= sis96x_probe,
-	.remove		= __devexit_p(sis96x_remove),
+	.remove		= sis96x_remove,
 };
 
 module_pci_driver(sis96x_driver);
diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index dcea77b..a2125b6 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -817,7 +817,7 @@ static SIMPLE_DEV_PM_OPS(tegra_i2c_pm, tegra_i2c_suspend, tegra_i2c_resume);
 
 static struct platform_driver tegra_i2c_driver = {
 	.probe   = tegra_i2c_probe,
-	.remove  = __devexit_p(tegra_i2c_remove),
+	.remove  = tegra_i2c_remove,
 	.driver  = {
 		.name  = "tegra-i2c",
 		.owner = THIS_MODULE,
diff --git a/drivers/i2c/busses/i2c-via.c b/drivers/i2c/busses/i2c-via.c
index 7ffee71..6278780 100644
--- a/drivers/i2c/busses/i2c-via.c
+++ b/drivers/i2c/busses/i2c-via.c
@@ -158,7 +158,7 @@ static struct pci_driver vt586b_driver = {
 	.name		= "vt586b_smbus",
 	.id_table	= vt586b_ids,
 	.probe		= vt586b_probe,
-	.remove		= __devexit_p(vt586b_remove),
+	.remove		= vt586b_remove,
 };
 
 module_pci_driver(vt586b_driver);
diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 641d0e5..aac948a 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -809,7 +809,7 @@ MODULE_DEVICE_TABLE(of, xiic_of_match);
 
 static struct platform_driver xiic_i2c_driver = {
 	.probe   = xiic_i2c_probe,
-	.remove  = __devexit_p(xiic_i2c_remove),
+	.remove  = xiic_i2c_remove,
 	.driver  = {
 		.owner = THIS_MODULE,
 		.name = DRIVER_NAME,
diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c
index 96d3fab..eb7d5f7 100644
--- a/drivers/i2c/busses/i2c-xlr.c
+++ b/drivers/i2c/busses/i2c-xlr.c
@@ -263,7 +263,7 @@ static int __devexit xlr_i2c_remove(struct platform_device *pdev)
 
 static struct platform_driver xlr_i2c_driver = {
 	.probe  = xlr_i2c_probe,
-	.remove = __devexit_p(xlr_i2c_remove),
+	.remove = xlr_i2c_remove,
 	.driver = {
 		.name   = "xlr-i2cbus",
 		.owner  = THIS_MODULE,
diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index 08aab57..82971a8 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -554,7 +554,7 @@ static struct platform_driver scx200_pci_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = scx200_probe,
-	.remove = __devexit_p(scx200_remove),
+	.remove = scx200_remove,
 };
 
 static DEFINE_PCI_DEVICE_TABLE(scx200_isa) = {
diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 566a675..08fd89d 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -182,7 +182,7 @@ static int __devexit i2c_mux_gpio_remove(struct platform_device *pdev)
 
 static struct platform_driver i2c_mux_gpio_driver = {
 	.probe	= i2c_mux_gpio_probe,
-	.remove	= __devexit_p(i2c_mux_gpio_remove),
+	.remove	= i2c_mux_gpio_remove,
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= "i2c-mux-gpio",
diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index 7fa5b24..f0b397d 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -269,7 +269,7 @@ static struct platform_driver i2c_mux_pinctrl_driver = {
 		.of_match_table = of_match_ptr(i2c_mux_pinctrl_of_match),
 	},
 	.probe	= i2c_mux_pinctrl_probe,
-	.remove	= __devexit_p(i2c_mux_pinctrl_remove),
+	.remove	= i2c_mux_pinctrl_remove,
 };
 module_platform_driver(i2c_mux_pinctrl_driver);
 
-- 
1.8.0
