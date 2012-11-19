Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id 12E9F2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:43:01 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 404/493] i2c: remove use of __devexit
Date: Mon, 19 Nov 2012 13:25:53 -0500
Message-Id: <1353349642-3677-404-git-send-email-wfp5p@virginia.edu>
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

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

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
 drivers/i2c/busses/i2c-i801.c               | 4 ++--
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
 drivers/i2c/busses/i2c-piix4.c              | 4 ++--
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
 drivers/i2c/busses/scx200_acb.c             | 4 ++--
 drivers/i2c/muxes/i2c-mux-gpio.c            | 2 +-
 drivers/i2c/muxes/i2c-mux-pinctrl.c         | 2 +-
 50 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
index 9ee96f0..3f49181 100644
--- a/drivers/i2c/busses/i2c-ali1535.c
+++ b/drivers/i2c/busses/i2c-ali1535.c
@@ -518,7 +518,7 @@ static int ali1535_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	return i2c_add_adapter(&ali1535_adapter);
 }
 
-static void __devexit ali1535_remove(struct pci_dev *dev)
+static void ali1535_remove(struct pci_dev *dev)
 {
 	i2c_del_adapter(&ali1535_adapter);
 	release_region(ali1535_smba, ALI1535_SMB_IOSIZE);
diff --git a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
index 55c27b9..5b17c9f 100644
--- a/drivers/i2c/busses/i2c-ali1563.c
+++ b/drivers/i2c/busses/i2c-ali1563.c
@@ -411,7 +411,7 @@ exit:
 	return error;
 }
 
-static void __devexit ali1563_remove(struct pci_dev * dev)
+static void ali1563_remove(struct pci_dev * dev)
 {
 	i2c_del_adapter(&ali1563_adapter);
 	ali1563_shutdown(dev);
diff --git a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
index 2d32690..26bcc61 100644
--- a/drivers/i2c/busses/i2c-ali15x3.c
+++ b/drivers/i2c/busses/i2c-ali15x3.c
@@ -500,7 +500,7 @@ static int ali15x3_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	return i2c_add_adapter(&ali15x3_adapter);
 }
 
-static void __devexit ali15x3_remove(struct pci_dev *dev)
+static void ali15x3_remove(struct pci_dev *dev)
 {
 	i2c_del_adapter(&ali15x3_adapter);
 	release_region(ali15x3_smba, ALI15X3_SMB_IOSIZE);
diff --git a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
index 46b2d5d..c98af91 100644
--- a/drivers/i2c/busses/i2c-amd756.c
+++ b/drivers/i2c/busses/i2c-amd756.c
@@ -397,7 +397,7 @@ static int amd756_probe(struct pci_dev *pdev,
 	return error;
 }
 
-static void __devexit amd756_remove(struct pci_dev *dev)
+static void amd756_remove(struct pci_dev *dev)
 {
 	i2c_del_adapter(&amd756_smbus);
 	release_region(amd756_ioport, SMB_IOSIZE);
diff --git a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
index 1bfeb9b..b5c86c0 100644
--- a/drivers/i2c/busses/i2c-amd8111.c
+++ b/drivers/i2c/busses/i2c-amd8111.c
@@ -475,7 +475,7 @@ static int amd8111_probe(struct pci_dev *dev,
 	return error;
 }
 
-static void __devexit amd8111_remove(struct pci_dev *dev)
+static void amd8111_remove(struct pci_dev *dev)
 {
 	struct amd_smbus *smbus = pci_get_drvdata(dev);
 
diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index af29e3e..f8292eb 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -489,7 +489,7 @@ static int at91_twi_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit at91_twi_remove(struct platform_device *pdev)
+static int at91_twi_remove(struct platform_device *pdev)
 {
 	struct at91_twi_dev *dev = platform_get_drvdata(pdev);
 	int rc;
diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
index 0e8595d..b278298 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -372,7 +372,7 @@ out:
 	return ret;
 }
 
-static int __devexit i2c_au1550_remove(struct platform_device *pdev)
+static int i2c_au1550_remove(struct platform_device *pdev)
 {
 	struct i2c_au1550_data *priv = platform_get_drvdata(pdev);
 
diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index a7ba41d..2e79c10 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -688,7 +688,7 @@ out_free:
 	return result;
 }
 
-static int __devexit cpm_i2c_remove(struct platform_device *ofdev)
+static int cpm_i2c_remove(struct platform_device *ofdev)
 {
 	struct cpm_i2c *cpm = dev_get_drvdata(&ofdev->dev);
 
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 1e14052..6add851 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -328,7 +328,7 @@ exit:
 	return r;
 }
 
-static void __devexit i2c_dw_pci_remove(struct pci_dev *pdev)
+static void i2c_dw_pci_remove(struct pci_dev *pdev)
 {
 	struct dw_i2c_dev *dev = pci_get_drvdata(pdev);
 
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index b6e477d..343357a 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -169,7 +169,7 @@ err_release_region:
 	return r;
 }
 
-static int __devexit dw_i2c_remove(struct platform_device *pdev)
+static int dw_i2c_remove(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
 	struct resource *mem;
diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 3a4d78e..5e7886e7 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -851,7 +851,7 @@ err_pci_enable:
 	return ret;
 }
 
-static void __devexit pch_i2c_remove(struct pci_dev *pdev)
+static void pch_i2c_remove(struct pci_dev *pdev)
 {
 	int i;
 	struct adapter_info *adap_info = pci_get_drvdata(pdev);
diff --git a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
index c13d242..4854970 100644
--- a/drivers/i2c/busses/i2c-elektor.c
+++ b/drivers/i2c/busses/i2c-elektor.c
@@ -293,7 +293,7 @@ static int elektor_probe(struct device *dev, unsigned int id)
 	return -ENODEV;
 }
 
-static int __devexit elektor_remove(struct device *dev, unsigned int id)
+static int elektor_remove(struct device *dev, unsigned int id)
 {
 	i2c_del_adapter(&pcf_isa_ops);
 
diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index 5daac71..f3fa433 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -218,7 +218,7 @@ err_request_sda:
 	return ret;
 }
 
-static int __devexit i2c_gpio_remove(struct platform_device *pdev)
+static int i2c_gpio_remove(struct platform_device *pdev)
 {
 	struct i2c_gpio_private_data *priv;
 	struct i2c_gpio_platform_data *pdata;
diff --git a/drivers/i2c/busses/i2c-highlander.c b/drivers/i2c/busses/i2c-highlander.c
index 6a9d788..3351cc7 100644
--- a/drivers/i2c/busses/i2c-highlander.c
+++ b/drivers/i2c/busses/i2c-highlander.c
@@ -441,7 +441,7 @@ err:
 	return ret;
 }
 
-static int __devexit highlander_i2c_remove(struct platform_device *pdev)
+static int highlander_i2c_remove(struct platform_device *pdev)
 {
 	struct highlander_i2c_dev *dev = platform_get_drvdata(pdev);
 
diff --git a/drivers/i2c/busses/i2c-hydra.c b/drivers/i2c/busses/i2c-hydra.c
index d836112..79c3d90 100644
--- a/drivers/i2c/busses/i2c-hydra.c
+++ b/drivers/i2c/busses/i2c-hydra.c
@@ -139,7 +139,7 @@ static int hydra_probe(struct pci_dev *dev,
 	return 0;
 }
 
-static void __devexit hydra_remove(struct pci_dev *dev)
+static void hydra_remove(struct pci_dev *dev)
 {
 	pdregw(hydra_bit_data.data, 0);		/* clear SCLK_OE and SDAT_OE */
 	i2c_del_adapter(&hydra_adap);
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 5971441..6c5a732 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1048,7 +1048,7 @@ static int i801_add_mux(struct i801_priv *priv)
 	return 0;
 }
 
-static void __devexit i801_del_mux(struct i801_priv *priv)
+static void i801_del_mux(struct i801_priv *priv)
 {
 	if (priv->mux_pdev)
 		platform_device_unregister(priv->mux_pdev);
@@ -1226,7 +1226,7 @@ exit:
 	return err;
 }
 
-static void __devexit i801_remove(struct pci_dev *dev)
+static void i801_remove(struct pci_dev *dev)
 {
 	struct i801_priv *priv = pci_get_drvdata(dev);
 
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index e3d3b54..33a2abb 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -781,7 +781,7 @@ error_cleanup:
 /*
  * Cleanup initialized IIC interface
  */
-static int __devexit iic_remove(struct platform_device *ofdev)
+static int iic_remove(struct platform_device *ofdev)
 {
 	struct ibm_iic_private *dev = dev_get_drvdata(&ofdev->dev);
 
diff --git a/drivers/i2c/busses/i2c-intel-mid.c b/drivers/i2c/busses/i2c-intel-mid.c
index e10e1e9..de3736b 100644
--- a/drivers/i2c/busses/i2c-intel-mid.c
+++ b/drivers/i2c/busses/i2c-intel-mid.c
@@ -1079,7 +1079,7 @@ exit:
 	return err;
 }
 
-static void __devexit intel_mid_i2c_remove(struct pci_dev *dev)
+static void intel_mid_i2c_remove(struct pci_dev *dev)
 {
 	struct intel_mid_i2c_private *mrst = pci_get_drvdata(dev);
 	intel_mid_i2c_disable(&mrst->adap);
diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
index 2b5b70e..4099f79 100644
--- a/drivers/i2c/busses/i2c-isch.c
+++ b/drivers/i2c/busses/i2c-isch.c
@@ -284,7 +284,7 @@ static int smbus_sch_probe(struct platform_device *dev)
 	return retval;
 }
 
-static int __devexit smbus_sch_remove(struct platform_device *pdev)
+static int smbus_sch_remove(struct platform_device *pdev)
 {
 	struct resource *res;
 	if (sch_smba) {
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 4327dba..a69459e 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -706,7 +706,7 @@ static int fsl_i2c_probe(struct platform_device *op)
 	return result;
 };
 
-static int __devexit fsl_i2c_remove(struct platform_device *op)
+static int fsl_i2c_remove(struct platform_device *op)
 {
 	struct mpc_i2c *i2c = dev_get_drvdata(&op->dev);
 
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 39a0a78..8b20ef8 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -697,7 +697,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 	return rc;
 }
 
-static int __devexit
+static int
 mv64xxx_i2c_remove(struct platform_device *dev)
 {
 	struct mv64xxx_i2c_data		*drv_data = platform_get_drvdata(dev);
diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 3a83303..f113e68 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -513,7 +513,7 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit mxs_i2c_remove(struct platform_device *pdev)
+static int mxs_i2c_remove(struct platform_device *pdev)
 {
 	struct mxs_i2c_dev *i2c = platform_get_drvdata(pdev);
 	int ret;
diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
index 1012183..fbea3cf 100644
--- a/drivers/i2c/busses/i2c-nforce2.c
+++ b/drivers/i2c/busses/i2c-nforce2.c
@@ -430,7 +430,7 @@ static int nforce2_probe(struct pci_dev *dev, const struct pci_device_id *id)
 }
 
 
-static void __devexit nforce2_remove(struct pci_dev *dev)
+static void nforce2_remove(struct pci_dev *dev)
 {
 	struct nforce2_smbus *smbuses = pci_get_drvdata(dev);
 
diff --git a/drivers/i2c/busses/i2c-nuc900.c b/drivers/i2c/busses/i2c-nuc900.c
index aae1605..b1206dc 100644
--- a/drivers/i2c/busses/i2c-nuc900.c
+++ b/drivers/i2c/busses/i2c-nuc900.c
@@ -663,7 +663,7 @@ static int nuc900_i2c_probe(struct platform_device *pdev)
  * called when device is removed from the bus
 */
 
-static int __devexit nuc900_i2c_remove(struct platform_device *pdev)
+static int nuc900_i2c_remove(struct platform_device *pdev)
 {
 	struct nuc900_i2c *i2c = platform_get_drvdata(pdev);
 
diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 0ee58f2..7892257 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -336,7 +336,7 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit ocores_i2c_remove(struct platform_device *pdev)
+static int ocores_i2c_remove(struct platform_device *pdev)
 {
 	struct ocores_i2c *i2c = platform_get_drvdata(pdev);
 
diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 6986d66..484ca77 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -609,7 +609,7 @@ out:
 	return result;
 };
 
-static int __devexit octeon_i2c_remove(struct platform_device *pdev)
+static int octeon_i2c_remove(struct platform_device *pdev)
 {
 	struct octeon_i2c *i2c = platform_get_drvdata(pdev);
 
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a872a35..9764ec0 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1267,7 +1267,7 @@ err_free_mem:
 	return r;
 }
 
-static int __devexit omap_i2c_remove(struct platform_device *pdev)
+static int omap_i2c_remove(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev = platform_get_drvdata(pdev);
 	int ret;
diff --git a/drivers/i2c/busses/i2c-parport-light.c b/drivers/i2c/busses/i2c-parport-light.c
index b950d43..aa95778 100644
--- a/drivers/i2c/busses/i2c-parport-light.c
+++ b/drivers/i2c/busses/i2c-parport-light.c
@@ -169,7 +169,7 @@ static int i2c_parport_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit i2c_parport_remove(struct platform_device *pdev)
+static int i2c_parport_remove(struct platform_device *pdev)
 {
 	if (ara) {
 		line_set(0, &parport_ctrl_irq);
diff --git a/drivers/i2c/busses/i2c-pasemi.c b/drivers/i2c/busses/i2c-pasemi.c
index 1860252..615f632 100644
--- a/drivers/i2c/busses/i2c-pasemi.c
+++ b/drivers/i2c/busses/i2c-pasemi.c
@@ -392,7 +392,7 @@ static int pasemi_smb_probe(struct pci_dev *dev,
 	return error;
 }
 
-static void __devexit pasemi_smb_remove(struct pci_dev *dev)
+static void pasemi_smb_remove(struct pci_dev *dev)
 {
 	struct pasemi_smbus *smbus = pci_get_drvdata(dev);
 
diff --git a/drivers/i2c/busses/i2c-pca-isa.c b/drivers/i2c/busses/i2c-pca-isa.c
index 923f6e1..323f061 100644
--- a/drivers/i2c/busses/i2c-pca-isa.c
+++ b/drivers/i2c/busses/i2c-pca-isa.c
@@ -174,7 +174,7 @@ static int pca_isa_probe(struct device *dev, unsigned int id)
 	return -ENODEV;
 }
 
-static int __devexit pca_isa_remove(struct device *dev, unsigned int id)
+static int pca_isa_remove(struct device *dev, unsigned int id)
 {
 	i2c_del_adapter(&pca_isa_ops);
 
diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index 6e1c71f..a30d2f6 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -257,7 +257,7 @@ e_print:
 	return ret;
 }
 
-static int __devexit i2c_pca_pf_remove(struct platform_device *pdev)
+static int i2c_pca_pf_remove(struct platform_device *pdev)
 {
 	struct i2c_pca_pf_data *i2c = platform_get_drvdata(pdev);
 	platform_set_drvdata(pdev, NULL);
diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 1cce916..80c5d9e 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -626,7 +626,7 @@ static int piix4_probe(struct pci_dev *dev,
 	return 0;
 }
 
-static void __devexit piix4_adap_remove(struct i2c_adapter *adap)
+static void piix4_adap_remove(struct i2c_adapter *adap)
 {
 	struct i2c_piix4_adapdata *adapdata = i2c_get_adapdata(adap);
 
@@ -638,7 +638,7 @@ static void __devexit piix4_adap_remove(struct i2c_adapter *adap)
 	}
 }
 
-static void __devexit piix4_remove(struct pci_dev *dev)
+static void piix4_remove(struct pci_dev *dev)
 {
 	if (piix4_main_adapter) {
 		piix4_adap_remove(piix4_main_adapter);
diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
index dce9667..083d68c 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -368,7 +368,7 @@ ret_err:
 /*
  * Release the device and return 0 if there is one.
  */
-static int __devexit pmcmsptwi_remove(struct platform_device *pldev)
+static int pmcmsptwi_remove(struct platform_device *pldev)
 {
 	struct resource *res;
 
diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 1c7844a..ce40970 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -765,7 +765,7 @@ err_kzalloc:
 	return ret;
 }
 
-static int __devexit i2c_pnx_remove(struct platform_device *pdev)
+static int i2c_pnx_remove(struct platform_device *pdev)
 {
 	struct i2c_pnx_algo_data *alg_data = platform_get_drvdata(pdev);
 
diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index c2538fb..0dd5b33 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -210,7 +210,7 @@ static const struct i2c_algorithm i2c_powermac_algorithm = {
 };
 
 
-static int __devexit i2c_powermac_remove(struct platform_device *dev)
+static int i2c_powermac_remove(struct platform_device *dev)
 {
 	struct i2c_adapter	*adapter = platform_get_drvdata(dev);
 	int			rc;
diff --git a/drivers/i2c/busses/i2c-puv3.c b/drivers/i2c/busses/i2c-puv3.c
index ec15a60..d7c512d 100644
--- a/drivers/i2c/busses/i2c-puv3.c
+++ b/drivers/i2c/busses/i2c-puv3.c
@@ -231,7 +231,7 @@ fail_nomem:
 	return rc;
 }
 
-static int __devexit puv3_i2c_remove(struct platform_device *pdev)
+static int puv3_i2c_remove(struct platform_device *pdev)
 {
 	struct i2c_adapter *adapter = platform_get_drvdata(pdev);
 	struct resource *mem;
diff --git a/drivers/i2c/busses/i2c-pxa-pci.c b/drivers/i2c/busses/i2c-pxa-pci.c
index 0a534c3..3d49856 100644
--- a/drivers/i2c/busses/i2c-pxa-pci.c
+++ b/drivers/i2c/busses/i2c-pxa-pci.c
@@ -135,7 +135,7 @@ err_mem:
 	return ret;
 }
 
-static void __devexit ce4100_i2c_remove(struct pci_dev *dev)
+static void ce4100_i2c_remove(struct pci_dev *dev)
 {
 	struct ce4100_devices *sds;
 	unsigned int i;
diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 77322b6..9bd4d73 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -682,7 +682,7 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit rcar_i2c_remove(struct platform_device *pdev)
+static int rcar_i2c_remove(struct platform_device *pdev)
 {
 	struct rcar_i2c_priv *priv = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
diff --git a/drivers/i2c/busses/i2c-s6000.c b/drivers/i2c/busses/i2c-s6000.c
index 11332bb..0088364 100644
--- a/drivers/i2c/busses/i2c-s6000.c
+++ b/drivers/i2c/busses/i2c-s6000.c
@@ -361,7 +361,7 @@ err_out:
 	return rc;
 }
 
-static int __devexit s6i2c_remove(struct platform_device *pdev)
+static int s6i2c_remove(struct platform_device *pdev)
 {
 	struct s6i2c_if *iface = platform_get_drvdata(pdev);
 	i2c_wr16(iface, S6_I2C_ENABLE, 0);
diff --git a/drivers/i2c/busses/i2c-sh7760.c b/drivers/i2c/busses/i2c-sh7760.c
index 75127148..3a2253e 100644
--- a/drivers/i2c/busses/i2c-sh7760.c
+++ b/drivers/i2c/busses/i2c-sh7760.c
@@ -536,7 +536,7 @@ out0:
 	return ret;
 }
 
-static int __devexit sh7760_i2c_remove(struct platform_device *pdev)
+static int sh7760_i2c_remove(struct platform_device *pdev)
 {
 	struct cami2c *id = platform_get_drvdata(pdev);
 
diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index 65de4aa..3f1818b 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -385,7 +385,7 @@ err_get_clk:
 	return err;
 }
 
-static int __devexit i2c_sirfsoc_remove(struct platform_device *pdev)
+static int i2c_sirfsoc_remove(struct platform_device *pdev)
 {
 	struct i2c_adapter *adapter = platform_get_drvdata(pdev);
 	struct sirfsoc_i2c *siic = adapter->algo_data;
diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
index 9b79d37..de6dddb 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -496,7 +496,7 @@ static int sis630_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	return i2c_add_adapter(&sis630_adapter);
 }
 
-static void __devexit sis630_remove(struct pci_dev *dev)
+static void sis630_remove(struct pci_dev *dev)
 {
 	if (acpi_base) {
 		i2c_del_adapter(&sis630_adapter);
diff --git a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
index 3ca3387..b9faf9b 100644
--- a/drivers/i2c/busses/i2c-sis96x.c
+++ b/drivers/i2c/busses/i2c-sis96x.c
@@ -308,7 +308,7 @@ static int sis96x_probe(struct pci_dev *dev,
 	return retval;
 }
 
-static void __devexit sis96x_remove(struct pci_dev *dev)
+static void sis96x_remove(struct pci_dev *dev)
 {
 	if (sis96x_smbus_base) {
 		i2c_del_adapter(&sis96x_adapter);
diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index c658daa..7b38877 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -769,7 +769,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit tegra_i2c_remove(struct platform_device *pdev)
+static int tegra_i2c_remove(struct platform_device *pdev)
 {
 	struct tegra_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
 	i2c_del_adapter(&i2c_dev->adapter);
diff --git a/drivers/i2c/busses/i2c-via.c b/drivers/i2c/busses/i2c-via.c
index 188ef6e..be66251 100644
--- a/drivers/i2c/busses/i2c-via.c
+++ b/drivers/i2c/busses/i2c-via.c
@@ -146,7 +146,7 @@ static int vt586b_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	return 0;
 }
 
-static void __devexit vt586b_remove(struct pci_dev *dev)
+static void vt586b_remove(struct pci_dev *dev)
 {
 	i2c_del_adapter(&vt586b_adapter);
 	release_region(I2C_DIR, IOSPACE);
diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index bb72d00..9aa8837 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -774,7 +774,7 @@ resource_missing:
 	return -ENOENT;
 }
 
-static int __devexit xiic_i2c_remove(struct platform_device* pdev)
+static int xiic_i2c_remove(struct platform_device* pdev)
 {
 	struct xiic_i2c *i2c = platform_get_drvdata(pdev);
 	struct resource *res;
diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c
index 68aa402..a005265 100644
--- a/drivers/i2c/busses/i2c-xlr.c
+++ b/drivers/i2c/busses/i2c-xlr.c
@@ -251,7 +251,7 @@ static int xlr_i2c_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit xlr_i2c_remove(struct platform_device *pdev)
+static int xlr_i2c_remove(struct platform_device *pdev)
 {
 	struct xlr_i2c_private *priv;
 
diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index 812a4c1..3862a95 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -530,14 +530,14 @@ static int scx200_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void __devexit scx200_cleanup_iface(struct scx200_acb_iface *iface)
+static void scx200_cleanup_iface(struct scx200_acb_iface *iface)
 {
 	i2c_del_adapter(&iface->adapter);
 	release_region(iface->base, 8);
 	kfree(iface);
 }
 
-static int __devexit scx200_remove(struct platform_device *pdev)
+static int scx200_remove(struct platform_device *pdev)
 {
 	struct scx200_acb_iface *iface;
 
diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 4511c54..0f68f1f 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -163,7 +163,7 @@ alloc_failed:
 	return ret;
 }
 
-static int __devexit i2c_mux_gpio_remove(struct platform_device *pdev)
+static int i2c_mux_gpio_remove(struct platform_device *pdev)
 {
 	struct gpiomux *mux = platform_get_drvdata(pdev);
 	int i;
diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index c6b70b5..1e44d04 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -241,7 +241,7 @@ err:
 	return ret;
 }
 
-static int __devexit i2c_mux_pinctrl_remove(struct platform_device *pdev)
+static int i2c_mux_pinctrl_remove(struct platform_device *pdev)
 {
 	struct i2c_mux_pinctrl *mux = platform_get_drvdata(pdev);
 	int i;
-- 
1.8.0
