Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id 4C1792C0081
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:43:04 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 207/493] i2c: remove use of __devinit
Date: Mon, 19 Nov 2012 13:22:36 -0500
Message-Id: <1353349642-3677-207-git-send-email-wfp5p@virginia.edu>
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

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
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
 drivers/i2c/busses/i2c-ali1535.c            |  4 ++--
 drivers/i2c/busses/i2c-ali1563.c            |  4 ++--
 drivers/i2c/busses/i2c-ali15x3.c            |  4 ++--
 drivers/i2c/busses/i2c-amd756.c             |  2 +-
 drivers/i2c/busses/i2c-amd8111.c            |  2 +-
 drivers/i2c/busses/i2c-at91.c               |  6 +++---
 drivers/i2c/busses/i2c-au1550.c             |  2 +-
 drivers/i2c/busses/i2c-cpm.c                |  4 ++--
 drivers/i2c/busses/i2c-designware-pcidrv.c  |  2 +-
 drivers/i2c/busses/i2c-designware-platdrv.c |  2 +-
 drivers/i2c/busses/i2c-eg20t.c              |  2 +-
 drivers/i2c/busses/i2c-elektor.c            |  4 ++--
 drivers/i2c/busses/i2c-gpio.c               |  4 ++--
 drivers/i2c/busses/i2c-highlander.c         |  2 +-
 drivers/i2c/busses/i2c-hydra.c              |  2 +-
 drivers/i2c/busses/i2c-i801.c               | 14 +++++++-------
 drivers/i2c/busses/i2c-ibm_iic.c            |  4 ++--
 drivers/i2c/busses/i2c-intel-mid.c          |  2 +-
 drivers/i2c/busses/i2c-isch.c               |  2 +-
 drivers/i2c/busses/i2c-mpc.c                | 20 ++++++++++----------
 drivers/i2c/busses/i2c-mv64xxx.c            | 12 ++++++------
 drivers/i2c/busses/i2c-mxs.c                |  2 +-
 drivers/i2c/busses/i2c-nforce2.c            |  4 ++--
 drivers/i2c/busses/i2c-nuc900.c             |  2 +-
 drivers/i2c/busses/i2c-ocores.c             |  2 +-
 drivers/i2c/busses/i2c-octeon.c             |  6 +++---
 drivers/i2c/busses/i2c-omap.c               |  2 +-
 drivers/i2c/busses/i2c-parport-light.c      |  2 +-
 drivers/i2c/busses/i2c-pasemi.c             |  2 +-
 drivers/i2c/busses/i2c-pca-isa.c            |  4 ++--
 drivers/i2c/busses/i2c-pca-platform.c       |  2 +-
 drivers/i2c/busses/i2c-piix4.c              | 10 +++++-----
 drivers/i2c/busses/i2c-pmcmsp.c             |  2 +-
 drivers/i2c/busses/i2c-pnx.c                |  2 +-
 drivers/i2c/busses/i2c-powermac.c           | 12 ++++++------
 drivers/i2c/busses/i2c-puv3.c               |  2 +-
 drivers/i2c/busses/i2c-pxa-pci.c            |  2 +-
 drivers/i2c/busses/i2c-rcar.c               |  2 +-
 drivers/i2c/busses/i2c-s6000.c              |  4 ++--
 drivers/i2c/busses/i2c-sh7760.c             |  4 ++--
 drivers/i2c/busses/i2c-sirf.c               |  2 +-
 drivers/i2c/busses/i2c-sis5595.c            |  4 ++--
 drivers/i2c/busses/i2c-sis630.c             |  4 ++--
 drivers/i2c/busses/i2c-sis96x.c             |  2 +-
 drivers/i2c/busses/i2c-tegra.c              |  2 +-
 drivers/i2c/busses/i2c-via.c                |  2 +-
 drivers/i2c/busses/i2c-viapro.c             |  2 +-
 drivers/i2c/busses/i2c-xiic.c               |  2 +-
 drivers/i2c/busses/i2c-xlr.c                |  2 +-
 drivers/i2c/busses/scx200_acb.c             | 10 +++++-----
 drivers/i2c/muxes/i2c-mux-gpio.c            |  4 ++--
 drivers/i2c/muxes/i2c-mux-pinctrl.c         |  2 +-
 52 files changed, 103 insertions(+), 103 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
index cb30432..9ee96f0 100644
--- a/drivers/i2c/busses/i2c-ali1535.c
+++ b/drivers/i2c/busses/i2c-ali1535.c
@@ -139,7 +139,7 @@ static unsigned short ali1535_offset;
    Note the differences between kernels with the old PCI BIOS interface and
    newer kernels with the real PCI interface. In compat.h some things are
    defined to make the transition easier. */
-static int __devinit ali1535_setup(struct pci_dev *dev)
+static int ali1535_setup(struct pci_dev *dev)
 {
 	int retval;
 	unsigned char temp;
@@ -502,7 +502,7 @@ static DEFINE_PCI_DEVICE_TABLE(ali1535_ids) = {
 
 MODULE_DEVICE_TABLE(pci, ali1535_ids);
 
-static int __devinit ali1535_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int ali1535_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	if (ali1535_setup(dev)) {
 		dev_warn(&dev->dev,
diff --git a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
index 547a96f..55c27b9 100644
--- a/drivers/i2c/busses/i2c-ali1563.c
+++ b/drivers/i2c/busses/i2c-ali1563.c
@@ -326,7 +326,7 @@ static u32 ali1563_func(struct i2c_adapter * a)
 }
 
 
-static int __devinit ali1563_setup(struct pci_dev * dev)
+static int ali1563_setup(struct pci_dev * dev)
 {
 	u16 ctrl;
 
@@ -390,7 +390,7 @@ static struct i2c_adapter ali1563_adapter = {
 	.algo	= &ali1563_algorithm,
 };
 
-static int __devinit ali1563_probe(struct pci_dev * dev,
+static int ali1563_probe(struct pci_dev * dev,
 				const struct pci_device_id * id_table)
 {
 	int error;
diff --git a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
index 62692ec..2d32690 100644
--- a/drivers/i2c/busses/i2c-ali15x3.c
+++ b/drivers/i2c/busses/i2c-ali15x3.c
@@ -131,7 +131,7 @@ MODULE_PARM_DESC(force_addr,
 static struct pci_driver ali15x3_driver;
 static unsigned short ali15x3_smba;
 
-static int __devinit ali15x3_setup(struct pci_dev *ALI15X3_dev)
+static int ali15x3_setup(struct pci_dev *ALI15X3_dev)
 {
 	u16 a;
 	unsigned char temp;
@@ -484,7 +484,7 @@ static DEFINE_PCI_DEVICE_TABLE(ali15x3_ids) = {
 
 MODULE_DEVICE_TABLE (pci, ali15x3_ids);
 
-static int __devinit ali15x3_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int ali15x3_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	if (ali15x3_setup(dev)) {
 		dev_err(&dev->dev,
diff --git a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
index b890764..46b2d5d 100644
--- a/drivers/i2c/busses/i2c-amd756.c
+++ b/drivers/i2c/busses/i2c-amd756.c
@@ -324,7 +324,7 @@ static DEFINE_PCI_DEVICE_TABLE(amd756_ids) = {
 
 MODULE_DEVICE_TABLE (pci, amd756_ids);
 
-static int __devinit amd756_probe(struct pci_dev *pdev,
+static int amd756_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *id)
 {
 	int nforce = (id->driver_data == NFORCE);
diff --git a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
index f5e5f70..1bfeb9b 100644
--- a/drivers/i2c/busses/i2c-amd8111.c
+++ b/drivers/i2c/busses/i2c-amd8111.c
@@ -422,7 +422,7 @@ static DEFINE_PCI_DEVICE_TABLE(amd8111_ids) = {
 
 MODULE_DEVICE_TABLE (pci, amd8111_ids);
 
-static int __devinit amd8111_probe(struct pci_dev *dev,
+static int amd8111_probe(struct pci_dev *dev,
 		const struct pci_device_id *id)
 {
 	struct amd_smbus *smbus;
diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index d699e61..af29e3e 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -115,7 +115,7 @@ static void at91_init_twi_bus(struct at91_twi_dev *dev)
  * Calculate symmetric clock as stated in datasheet:
  * twi_clk = F_MAIN / (2 * (cdiv * (1 << ckdiv) + offset))
  */
-static void __devinit at91_calc_twi_clock(struct at91_twi_dev *dev, int twi_clk)
+static void at91_calc_twi_clock(struct at91_twi_dev *dev, int twi_clk)
 {
 	int ckdiv, cdiv, div;
 	struct at91_twi_pdata *pdata = dev->pdata;
@@ -405,7 +405,7 @@ MODULE_DEVICE_TABLE(of, atmel_twi_dt_ids);
 #define atmel_twi_dt_ids NULL
 #endif
 
-static struct at91_twi_pdata * __devinit at91_twi_get_driver_data(
+static struct at91_twi_pdata *at91_twi_get_driver_data(
 					struct platform_device *pdev)
 {
 	if (pdev->dev.of_node) {
@@ -418,7 +418,7 @@ static struct at91_twi_pdata * __devinit at91_twi_get_driver_data(
 	return (struct at91_twi_pdata *) platform_get_device_id(pdev)->driver_data;
 }
 
-static int __devinit at91_twi_probe(struct platform_device *pdev)
+static int at91_twi_probe(struct platform_device *pdev)
 {
 	struct at91_twi_dev *dev;
 	struct resource *mem;
diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
index 4c9cfc9..0e8595d 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -313,7 +313,7 @@ static void i2c_au1550_disable(struct i2c_au1550_data *priv)
  * Prior to calling us, the 50MHz clock frequency and routing
  * must have been set up for the PSC indicated by the adapter.
  */
-static int __devinit
+static int
 i2c_au1550_probe(struct platform_device *pdev)
 {
 	struct i2c_au1550_data *priv;
diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 8d70fd3..a7ba41d 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -426,7 +426,7 @@ static const struct i2c_adapter cpm_ops = {
 	.algo		= &cpm_i2c_algo,
 };
 
-static int __devinit cpm_i2c_setup(struct cpm_i2c *cpm)
+static int cpm_i2c_setup(struct cpm_i2c *cpm)
 {
 	struct platform_device *ofdev = cpm->ofdev;
 	const u32 *data;
@@ -634,7 +634,7 @@ static void cpm_i2c_shutdown(struct cpm_i2c *cpm)
 		cpm_muram_free(cpm->i2c_addr);
 }
 
-static int __devinit cpm_i2c_probe(struct platform_device *ofdev)
+static int cpm_i2c_probe(struct platform_device *ofdev)
 {
 	int result, len;
 	struct cpm_i2c *cpm;
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 85df062..1e14052 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -207,7 +207,7 @@ static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
 	return dev->controller->clk_khz;
 }
 
-static int __devinit i2c_dw_pci_probe(struct pci_dev *pdev,
+static int i2c_dw_pci_probe(struct pci_dev *pdev,
 const struct pci_device_id *id)
 {
 	struct dw_i2c_dev *dev;
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index ccde6ec..b6e477d 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -50,7 +50,7 @@ static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
 	return clk_get_rate(dev->clk)/1000;
 }
 
-static int __devinit dw_i2c_probe(struct platform_device *pdev)
+static int dw_i2c_probe(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev;
 	struct i2c_adapter *adap;
diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 128c98c..3a4d78e 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -758,7 +758,7 @@ static void pch_i2c_disbl_int(struct i2c_algo_pch_data *adap)
 	iowrite32(BUFFER_MODE_INTR_DISBL, p + PCH_I2CBUFMSK);
 }
 
-static int __devinit pch_i2c_probe(struct pci_dev *pdev,
+static int pch_i2c_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *id)
 {
 	void __iomem *base_addr;
diff --git a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
index 14af6b4..c13d242 100644
--- a/drivers/i2c/busses/i2c-elektor.c
+++ b/drivers/i2c/busses/i2c-elektor.c
@@ -205,7 +205,7 @@ static struct i2c_adapter pcf_isa_ops = {
 	.name		= "i2c-elektor",
 };
 
-static int __devinit elektor_match(struct device *dev, unsigned int id)
+static int elektor_match(struct device *dev, unsigned int id)
 {
 #ifdef __alpha__
 	/* check to see we have memory mapped PCF8584 connected to the
@@ -264,7 +264,7 @@ static int __devinit elektor_match(struct device *dev, unsigned int id)
 	return 1;
 }
 
-static int __devinit elektor_probe(struct device *dev, unsigned int id)
+static int elektor_probe(struct device *dev, unsigned int id)
 {
 	init_waitqueue_head(&pcf_wait);
 	if (pcf_isa_init())
diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index be8cb0d..5daac71 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -85,7 +85,7 @@ static int i2c_gpio_getscl(void *data)
 	return gpio_get_value(pdata->scl_pin);
 }
 
-static int __devinit of_i2c_gpio_probe(struct device_node *np,
+static int of_i2c_gpio_probe(struct device_node *np,
 			     struct i2c_gpio_platform_data *pdata)
 {
 	u32 reg;
@@ -117,7 +117,7 @@ static int __devinit of_i2c_gpio_probe(struct device_node *np,
 	return 0;
 }
 
-static int __devinit i2c_gpio_probe(struct platform_device *pdev)
+static int i2c_gpio_probe(struct platform_device *pdev)
 {
 	struct i2c_gpio_private_data *priv;
 	struct i2c_gpio_platform_data *pdata;
diff --git a/drivers/i2c/busses/i2c-highlander.c b/drivers/i2c/busses/i2c-highlander.c
index f2cfb34..6a9d788 100644
--- a/drivers/i2c/busses/i2c-highlander.c
+++ b/drivers/i2c/busses/i2c-highlander.c
@@ -356,7 +356,7 @@ static const struct i2c_algorithm highlander_i2c_algo = {
 	.functionality	= highlander_i2c_func,
 };
 
-static int __devinit highlander_i2c_probe(struct platform_device *pdev)
+static int highlander_i2c_probe(struct platform_device *pdev)
 {
 	struct highlander_i2c_dev *dev;
 	struct i2c_adapter *adap;
diff --git a/drivers/i2c/busses/i2c-hydra.c b/drivers/i2c/busses/i2c-hydra.c
index b24be50..d836112 100644
--- a/drivers/i2c/busses/i2c-hydra.c
+++ b/drivers/i2c/busses/i2c-hydra.c
@@ -112,7 +112,7 @@ static DEFINE_PCI_DEVICE_TABLE(hydra_ids) = {
 
 MODULE_DEVICE_TABLE (pci, hydra_ids);
 
-static int __devinit hydra_probe(struct pci_dev *dev,
+static int hydra_probe(struct pci_dev *dev,
 				 const struct pci_device_id *id)
 {
 	unsigned long base = pci_resource_start(dev, 0);
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index acaa47d..d362004 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -847,7 +847,7 @@ static struct dmi_onboard_device_info __devinitdata dmi_devices[] = {
 	{ "Hades",  DMI_DEV_TYPE_OTHER, 0x73, "fschds" },
 };
 
-static void __devinit dmi_check_onboard_device(u8 type, const char *name,
+static void dmi_check_onboard_device(u8 type, const char *name,
 					       struct i2c_adapter *adap)
 {
 	int i;
@@ -871,7 +871,7 @@ static void __devinit dmi_check_onboard_device(u8 type, const char *name,
 /* We use our own function to check for onboard devices instead of
    dmi_find_device() as some buggy BIOS's have the devices we are interested
    in marked as disabled */
-static void __devinit dmi_check_onboard_devices(const struct dmi_header *dm,
+static void dmi_check_onboard_devices(const struct dmi_header *dm,
 						void *adap)
 {
 	int i, count;
@@ -901,7 +901,7 @@ static void __devinit dmi_check_onboard_devices(const struct dmi_header *dm,
 }
 
 /* Register optional slaves */
-static void __devinit i801_probe_optional_slaves(struct i801_priv *priv)
+static void i801_probe_optional_slaves(struct i801_priv *priv)
 {
 	/* Only register slaves on main SMBus channel */
 	if (priv->features & FEATURE_IDF)
@@ -921,7 +921,7 @@ static void __devinit i801_probe_optional_slaves(struct i801_priv *priv)
 }
 #else
 static void __init input_apanel_init(void) {}
-static void __devinit i801_probe_optional_slaves(struct i801_priv *priv) {}
+static void i801_probe_optional_slaves(struct i801_priv *priv) {}
 #endif	/* CONFIG_X86 && CONFIG_DMI */
 
 #if (defined CONFIG_I2C_MUX_GPIO || defined CONFIG_I2C_MUX_GPIO_MODULE) && \
@@ -1012,7 +1012,7 @@ static struct dmi_system_id __devinitdata mux_dmi_table[] = {
 };
 
 /* Setup multiplexing if needed */
-static int __devinit i801_add_mux(struct i801_priv *priv)
+static int i801_add_mux(struct i801_priv *priv)
 {
 	struct device *dev = &priv->adapter.dev;
 	const struct i801_mux_config *mux_config;
@@ -1054,7 +1054,7 @@ static void __devexit i801_del_mux(struct i801_priv *priv)
 		platform_device_unregister(priv->mux_pdev);
 }
 
-static unsigned int __devinit i801_get_adapter_class(struct i801_priv *priv)
+static unsigned int i801_get_adapter_class(struct i801_priv *priv)
 {
 	const struct dmi_system_id *id;
 	const struct i801_mux_config *mux_config;
@@ -1084,7 +1084,7 @@ static inline unsigned int i801_get_adapter_class(struct i801_priv *priv)
 }
 #endif
 
-static int __devinit i801_probe(struct pci_dev *dev,
+static int i801_probe(struct pci_dev *dev,
 				const struct pci_device_id *id)
 {
 	unsigned char temp;
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index a10fdab..e3d3b54 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -660,7 +660,7 @@ static inline u8 iic_clckdiv(unsigned int opb)
 	return (u8)((opb + 9) / 10 - 1);
 }
 
-static int __devinit iic_request_irq(struct platform_device *ofdev,
+static int iic_request_irq(struct platform_device *ofdev,
 				     struct ibm_iic_private *dev)
 {
 	struct device_node *np = ofdev->dev.of_node;
@@ -691,7 +691,7 @@ static int __devinit iic_request_irq(struct platform_device *ofdev,
 /*
  * Register single IIC interface
  */
-static int __devinit iic_probe(struct platform_device *ofdev)
+static int iic_probe(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
 	struct ibm_iic_private *dev;
diff --git a/drivers/i2c/busses/i2c-intel-mid.c b/drivers/i2c/busses/i2c-intel-mid.c
index 7616007..e10e1e9 100644
--- a/drivers/i2c/busses/i2c-intel-mid.c
+++ b/drivers/i2c/busses/i2c-intel-mid.c
@@ -947,7 +947,7 @@ static const struct dev_pm_ops intel_mid_i2c_pm_ops = {
  * 5. Call intel_mid_i2c_hwinit() for hardware initialization
  * 6. Register I2C adapter in i2c-core
  */
-static int __devinit intel_mid_i2c_probe(struct pci_dev *dev,
+static int intel_mid_i2c_probe(struct pci_dev *dev,
 				    const struct pci_device_id *id)
 {
 	struct intel_mid_i2c_private *mrst;
diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
index 1c050a6..2b5b70e 100644
--- a/drivers/i2c/busses/i2c-isch.c
+++ b/drivers/i2c/busses/i2c-isch.c
@@ -249,7 +249,7 @@ static struct i2c_adapter sch_adapter = {
 	.algo		= &smbus_algorithm,
 };
 
-static int __devinit smbus_sch_probe(struct platform_device *dev)
+static int smbus_sch_probe(struct platform_device *dev)
 {
 	struct resource *res;
 	int retval;
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index f016eef..caede3c 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -196,7 +196,7 @@ static const struct mpc_i2c_divider mpc_i2c_dividers_52xx[] __devinitconst = {
 	{10240, 0x9d}, {12288, 0x9e}, {15360, 0x9f}
 };
 
-static int __devinit mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock,
+static int mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock,
 					  int prescaler, u32 *real_clk)
 {
 	const struct mpc_i2c_divider *div = NULL;
@@ -230,7 +230,7 @@ static int __devinit mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock,
 	return (int)div->fdr;
 }
 
-static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
+static void mpc_i2c_setup_52xx(struct device_node *node,
 					 struct mpc_i2c *i2c,
 					 u32 clock, u32 prescaler)
 {
@@ -252,7 +252,7 @@ static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
 			 fdr);
 }
 #else /* !(CONFIG_PPC_MPC52xx || CONFIG_PPC_MPC512x) */
-static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
+static void mpc_i2c_setup_52xx(struct device_node *node,
 					 struct mpc_i2c *i2c,
 					 u32 clock, u32 prescaler)
 {
@@ -260,7 +260,7 @@ static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
 #endif /* CONFIG_PPC_MPC52xx || CONFIG_PPC_MPC512x */
 
 #ifdef CONFIG_PPC_MPC512x
-static void __devinit mpc_i2c_setup_512x(struct device_node *node,
+static void mpc_i2c_setup_512x(struct device_node *node,
 					 struct mpc_i2c *i2c,
 					 u32 clock, u32 prescaler)
 {
@@ -288,7 +288,7 @@ static void __devinit mpc_i2c_setup_512x(struct device_node *node,
 	mpc_i2c_setup_52xx(node, i2c, clock, prescaler);
 }
 #else /* CONFIG_PPC_MPC512x */
-static void __devinit mpc_i2c_setup_512x(struct device_node *node,
+static void mpc_i2c_setup_512x(struct device_node *node,
 					 struct mpc_i2c *i2c,
 					 u32 clock, u32 prescaler)
 {
@@ -316,7 +316,7 @@ static const struct mpc_i2c_divider mpc_i2c_dividers_8xxx[] __devinitconst = {
 	{49152, 0x011e}, {61440, 0x011f}
 };
 
-static u32 __devinit mpc_i2c_get_sec_cfg_8xxx(void)
+static u32 mpc_i2c_get_sec_cfg_8xxx(void)
 {
 	struct device_node *node = NULL;
 	u32 __iomem *reg;
@@ -345,7 +345,7 @@ static u32 __devinit mpc_i2c_get_sec_cfg_8xxx(void)
 	return val;
 }
 
-static int __devinit mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock,
+static int mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock,
 					  u32 prescaler, u32 *real_clk)
 {
 	const struct mpc_i2c_divider *div = NULL;
@@ -383,7 +383,7 @@ static int __devinit mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock,
 	return div ? (int)div->fdr : -EINVAL;
 }
 
-static void __devinit mpc_i2c_setup_8xxx(struct device_node *node,
+static void mpc_i2c_setup_8xxx(struct device_node *node,
 					 struct mpc_i2c *i2c,
 					 u32 clock, u32 prescaler)
 {
@@ -408,7 +408,7 @@ static void __devinit mpc_i2c_setup_8xxx(struct device_node *node,
 }
 
 #else /* !CONFIG_FSL_SOC */
-static void __devinit mpc_i2c_setup_8xxx(struct device_node *node,
+static void mpc_i2c_setup_8xxx(struct device_node *node,
 					 struct mpc_i2c *i2c,
 					 u32 clock, u32 prescaler)
 {
@@ -615,7 +615,7 @@ static struct i2c_adapter mpc_ops = {
 };
 
 static const struct of_device_id mpc_i2c_of_match[];
-static int __devinit fsl_i2c_probe(struct platform_device *op)
+static int fsl_i2c_probe(struct platform_device *op)
 {
 	const struct of_device_id *match;
 	struct mpc_i2c *i2c;
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 3107c0a..06dd6aa 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -495,7 +495,7 @@ static const struct i2c_algorithm mv64xxx_i2c_algo = {
  *
  *****************************************************************************
  */
-static int __devinit
+static int
 mv64xxx_i2c_map_regs(struct platform_device *pd,
 	struct mv64xxx_i2c_data *drv_data)
 {
@@ -530,13 +530,13 @@ mv64xxx_i2c_unmap_regs(struct mv64xxx_i2c_data *drv_data)
 }
 
 #ifdef CONFIG_OF
-static int __devinit
+static int
 mv64xxx_calc_freq(const int tclk, const int n, const int m)
 {
 	return tclk / (10 * (m + 1) * (2 << n));
 }
 
-static bool __devinit
+static bool
 mv64xxx_find_baud_factors(const u32 req_freq, const u32 tclk, u32 *best_n,
 			  u32 *best_m)
 {
@@ -560,7 +560,7 @@ mv64xxx_find_baud_factors(const u32 req_freq, const u32 tclk, u32 *best_n,
 	return true;
 }
 
-static int __devinit
+static int
 mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 		  struct device_node *np)
 {
@@ -597,7 +597,7 @@ out:
 #endif
 }
 #else /* CONFIG_OF */
-static int __devinit
+static int
 mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 		  struct device_node *np)
 {
@@ -605,7 +605,7 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 }
 #endif /* CONFIG_OF */
 
-static int __devinit
+static int
 mv64xxx_i2c_probe(struct platform_device *pd)
 {
 	struct mv64xxx_i2c_data		*drv_data;
diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index e317b28..3a83303 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -430,7 +430,7 @@ static int mxs_i2c_get_ofdata(struct mxs_i2c_dev *i2c)
 	return 0;
 }
 
-static int __devinit mxs_i2c_probe(struct platform_device *pdev)
+static int mxs_i2c_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mxs_i2c_dev *i2c;
diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
index 9ed5721..d820a93 100644
--- a/drivers/i2c/busses/i2c-nforce2.c
+++ b/drivers/i2c/busses/i2c-nforce2.c
@@ -330,7 +330,7 @@ static DEFINE_PCI_DEVICE_TABLE(nforce2_ids) = {
 MODULE_DEVICE_TABLE (pci, nforce2_ids);
 
 
-static int __devinit nforce2_probe_smb (struct pci_dev *dev, int bar,
+static int nforce2_probe_smb (struct pci_dev *dev, int bar,
 	int alt_reg, struct nforce2_smbus *smbus, const char *name)
 {
 	int error;
@@ -382,7 +382,7 @@ static int __devinit nforce2_probe_smb (struct pci_dev *dev, int bar,
 }
 
 
-static int __devinit nforce2_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int nforce2_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct nforce2_smbus *smbuses;
 	int res1, res2;
diff --git a/drivers/i2c/busses/i2c-nuc900.c b/drivers/i2c/busses/i2c-nuc900.c
index 29939f2..aae1605 100644
--- a/drivers/i2c/busses/i2c-nuc900.c
+++ b/drivers/i2c/busses/i2c-nuc900.c
@@ -518,7 +518,7 @@ static const struct i2c_algorithm nuc900_i2c_algorithm = {
  * called by the bus driver when a suitable device is found
 */
 
-static int __devinit nuc900_i2c_probe(struct platform_device *pdev)
+static int nuc900_i2c_probe(struct platform_device *pdev)
 {
 	struct nuc900_i2c *i2c;
 	struct nuc900_platform_i2c *pdata;
diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 856fd5a..0ee58f2 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -263,7 +263,7 @@ static int ocores_i2c_of_probe(struct platform_device *pdev,
 #define ocores_i2c_of_probe(pdev,i2c) -ENODEV
 #endif
 
-static int __devinit ocores_i2c_probe(struct platform_device *pdev)
+static int ocores_i2c_probe(struct platform_device *pdev)
 {
 	struct ocores_i2c *i2c;
 	struct ocores_i2c_platform_data *pdata;
diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index e5015d4..6986d66 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -446,7 +446,7 @@ static struct i2c_adapter octeon_i2c_ops = {
 /**
  * octeon_i2c_setclock - Calculate and set clock divisors.
  */
-static int __devinit octeon_i2c_setclock(struct octeon_i2c *i2c)
+static int octeon_i2c_setclock(struct octeon_i2c *i2c)
 {
 	int tclk, thp_base, inc, thp_idx, mdiv_idx, ndiv_idx, foscl, diff;
 	int thp = 0x18, mdiv = 2, ndiv = 0, delta_hz = 1000000;
@@ -489,7 +489,7 @@ static int __devinit octeon_i2c_setclock(struct octeon_i2c *i2c)
 	return 0;
 }
 
-static int __devinit octeon_i2c_initlowlevel(struct octeon_i2c *i2c)
+static int octeon_i2c_initlowlevel(struct octeon_i2c *i2c)
 {
 	u8 status;
 	int tries;
@@ -510,7 +510,7 @@ static int __devinit octeon_i2c_initlowlevel(struct octeon_i2c *i2c)
 	return -EIO;
 }
 
-static int __devinit octeon_i2c_probe(struct platform_device *pdev)
+static int octeon_i2c_probe(struct platform_device *pdev)
 {
 	int irq, result = 0;
 	struct octeon_i2c *i2c;
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 8721f98..a872a35 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1069,7 +1069,7 @@ MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
 #define OMAP_I2C_SCHEME_0		0
 #define OMAP_I2C_SCHEME_1		1
 
-static int __devinit
+static int
 omap_i2c_probe(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev;
diff --git a/drivers/i2c/busses/i2c-parport-light.c b/drivers/i2c/busses/i2c-parport-light.c
index 240f724..b950d43 100644
--- a/drivers/i2c/busses/i2c-parport-light.c
+++ b/drivers/i2c/busses/i2c-parport-light.c
@@ -135,7 +135,7 @@ static struct lineop parport_ctrl_irq = {
 	.port		= PORT_CTRL,
 };
 
-static int __devinit i2c_parport_probe(struct platform_device *pdev)
+static int i2c_parport_probe(struct platform_device *pdev)
 {
 	int err;
 
diff --git a/drivers/i2c/busses/i2c-pasemi.c b/drivers/i2c/busses/i2c-pasemi.c
index dae53c3..1860252 100644
--- a/drivers/i2c/busses/i2c-pasemi.c
+++ b/drivers/i2c/busses/i2c-pasemi.c
@@ -340,7 +340,7 @@ static const struct i2c_algorithm smbus_algorithm = {
 	.functionality	= pasemi_smb_func,
 };
 
-static int __devinit pasemi_smb_probe(struct pci_dev *dev,
+static int pasemi_smb_probe(struct pci_dev *dev,
 				      const struct pci_device_id *id)
 {
 	struct pasemi_smbus *smbus;
diff --git a/drivers/i2c/busses/i2c-pca-isa.c b/drivers/i2c/busses/i2c-pca-isa.c
index 7e75a12..923f6e1 100644
--- a/drivers/i2c/busses/i2c-pca-isa.c
+++ b/drivers/i2c/busses/i2c-pca-isa.c
@@ -119,7 +119,7 @@ static struct i2c_adapter pca_isa_ops = {
 	.timeout	= HZ,
 };
 
-static int __devinit pca_isa_match(struct device *dev, unsigned int id)
+static int pca_isa_match(struct device *dev, unsigned int id)
 {
 	int match = base != 0;
 
@@ -132,7 +132,7 @@ static int __devinit pca_isa_match(struct device *dev, unsigned int id)
 	return match;
 }
 
-static int __devinit pca_isa_probe(struct device *dev, unsigned int id)
+static int pca_isa_probe(struct device *dev, unsigned int id)
 {
 	init_waitqueue_head(&pca_wait);
 
diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index bffa7d6..6e1c71f 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -131,7 +131,7 @@ static irqreturn_t i2c_pca_pf_handler(int this_irq, void *dev_id)
 }
 
 
-static int __devinit i2c_pca_pf_probe(struct platform_device *pdev)
+static int i2c_pca_pf_probe(struct platform_device *pdev)
 {
 	struct i2c_pca_pf_data *i2c;
 	struct resource *res;
diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 6253e0b..891f2b5 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -131,7 +131,7 @@ struct i2c_piix4_adapdata {
 	unsigned short smba;
 };
 
-static int __devinit piix4_setup(struct pci_dev *PIIX4_dev,
+static int piix4_setup(struct pci_dev *PIIX4_dev,
 				const struct pci_device_id *id)
 {
 	unsigned char temp;
@@ -230,7 +230,7 @@ static int __devinit piix4_setup(struct pci_dev *PIIX4_dev,
 	return piix4_smba;
 }
 
-static int __devinit piix4_setup_sb800(struct pci_dev *PIIX4_dev,
+static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 				const struct pci_device_id *id)
 {
 	unsigned short piix4_smba;
@@ -294,7 +294,7 @@ static int __devinit piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	return piix4_smba;
 }
 
-static int __devinit piix4_setup_aux(struct pci_dev *PIIX4_dev,
+static int piix4_setup_aux(struct pci_dev *PIIX4_dev,
 				const struct pci_device_id *id,
 				unsigned short base_reg_addr)
 {
@@ -540,7 +540,7 @@ MODULE_DEVICE_TABLE (pci, piix4_ids);
 static struct i2c_adapter *piix4_main_adapter;
 static struct i2c_adapter *piix4_aux_adapter;
 
-static int __devinit piix4_add_adapter(struct pci_dev *dev,
+static int piix4_add_adapter(struct pci_dev *dev,
 					unsigned short smba,
 					struct i2c_adapter **padap)
 {
@@ -588,7 +588,7 @@ static int __devinit piix4_add_adapter(struct pci_dev *dev,
 	return 0;
 }
 
-static int __devinit piix4_probe(struct pci_dev *dev,
+static int piix4_probe(struct pci_dev *dev,
 				const struct pci_device_id *id)
 {
 	int retval;
diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
index 4ef4a4c..dce9667 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -270,7 +270,7 @@ static irqreturn_t pmcmsptwi_interrupt(int irq, void *ptr)
 /*
  * Probe for and register the device and return 0 if there is one.
  */
-static int __devinit pmcmsptwi_probe(struct platform_device *pldev)
+static int pmcmsptwi_probe(struct platform_device *pldev)
 {
 	struct resource *res;
 	int rc = -ENODEV;
diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index efd2c4f..1c7844a 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -619,7 +619,7 @@ static SIMPLE_DEV_PM_OPS(i2c_pnx_pm,
 #define PNX_I2C_PM	NULL
 #endif
 
-static int __devinit i2c_pnx_probe(struct platform_device *pdev)
+static int i2c_pnx_probe(struct platform_device *pdev)
 {
 	unsigned long tmp;
 	int ret = 0;
diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index cb8ae67..c2538fb 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -227,7 +227,7 @@ static int __devexit i2c_powermac_remove(struct platform_device *dev)
 	return 0;
 }
 
-static u32 __devinit i2c_powermac_get_addr(struct i2c_adapter *adap,
+static u32 i2c_powermac_get_addr(struct i2c_adapter *adap,
 					   struct pmac_i2c_bus *bus,
 					   struct device_node *node)
 {
@@ -255,7 +255,7 @@ static u32 __devinit i2c_powermac_get_addr(struct i2c_adapter *adap,
 	return 0xffffffff;
 }
 
-static void __devinit i2c_powermac_create_one(struct i2c_adapter *adap,
+static void i2c_powermac_create_one(struct i2c_adapter *adap,
 					      const char *type,
 					      u32 addr)
 {
@@ -271,7 +271,7 @@ static void __devinit i2c_powermac_create_one(struct i2c_adapter *adap,
 			type);
 }
 
-static void __devinit i2c_powermac_add_missing(struct i2c_adapter *adap,
+static void i2c_powermac_add_missing(struct i2c_adapter *adap,
 					       struct pmac_i2c_bus *bus,
 					       bool found_onyx)
 {
@@ -297,7 +297,7 @@ static void __devinit i2c_powermac_add_missing(struct i2c_adapter *adap,
 	}
 }
 
-static bool __devinit i2c_powermac_get_type(struct i2c_adapter *adap,
+static bool i2c_powermac_get_type(struct i2c_adapter *adap,
 					    struct device_node *node,
 					    u32 addr, char *type, int type_size)
 {
@@ -336,7 +336,7 @@ static bool __devinit i2c_powermac_get_type(struct i2c_adapter *adap,
 	return false;
 }
 
-static void __devinit i2c_powermac_register_devices(struct i2c_adapter *adap,
+static void i2c_powermac_register_devices(struct i2c_adapter *adap,
 						    struct pmac_i2c_bus *bus)
 {
 	struct i2c_client *newdev;
@@ -403,7 +403,7 @@ static void __devinit i2c_powermac_register_devices(struct i2c_adapter *adap,
 	i2c_powermac_add_missing(adap, bus, found_onyx);
 }
 
-static int __devinit i2c_powermac_probe(struct platform_device *dev)
+static int i2c_powermac_probe(struct platform_device *dev)
 {
 	struct pmac_i2c_bus *bus = dev->dev.platform_data;
 	struct device_node *parent = NULL;
diff --git a/drivers/i2c/busses/i2c-puv3.c b/drivers/i2c/busses/i2c-puv3.c
index 55a9e8c..ec15a60 100644
--- a/drivers/i2c/busses/i2c-puv3.c
+++ b/drivers/i2c/busses/i2c-puv3.c
@@ -184,7 +184,7 @@ static struct i2c_algorithm puv3_i2c_algorithm = {
 /*
  * Main initialization routine.
  */
-static int __devinit puv3_i2c_probe(struct platform_device *pdev)
+static int puv3_i2c_probe(struct platform_device *pdev)
 {
 	struct i2c_adapter *adapter;
 	struct resource *mem;
diff --git a/drivers/i2c/busses/i2c-pxa-pci.c b/drivers/i2c/busses/i2c-pxa-pci.c
index 9e1f180..0a534c3 100644
--- a/drivers/i2c/busses/i2c-pxa-pci.c
+++ b/drivers/i2c/busses/i2c-pxa-pci.c
@@ -94,7 +94,7 @@ out:
 	return ERR_PTR(ret);
 }
 
-static int __devinit ce4100_i2c_probe(struct pci_dev *dev,
+static int ce4100_i2c_probe(struct pci_dev *dev,
 		const struct pci_device_id *ent)
 {
 	int ret;
diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 44a29bd..77322b6 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -613,7 +613,7 @@ static const struct i2c_algorithm rcar_i2c_algo = {
 	.functionality	= rcar_i2c_func,
 };
 
-static int __devinit rcar_i2c_probe(struct platform_device *pdev)
+static int rcar_i2c_probe(struct platform_device *pdev)
 {
 	struct i2c_rcar_platform_data *pdata = pdev->dev.platform_data;
 	struct rcar_i2c_priv *priv;
diff --git a/drivers/i2c/busses/i2c-s6000.c b/drivers/i2c/busses/i2c-s6000.c
index eebd9e1..11332bb 100644
--- a/drivers/i2c/busses/i2c-s6000.c
+++ b/drivers/i2c/busses/i2c-s6000.c
@@ -248,7 +248,7 @@ static struct i2c_algorithm s6i2c_algorithm = {
 	.functionality = s6i2c_functionality,
 };
 
-static u16 __devinit nanoseconds_on_clk(struct s6i2c_if *iface, u32 ns)
+static u16 nanoseconds_on_clk(struct s6i2c_if *iface, u32 ns)
 {
 	u32 dividend = ((clk_get_rate(iface->clk) / 1000) * ns) / 1000000;
 	if (dividend > 0xffff)
@@ -256,7 +256,7 @@ static u16 __devinit nanoseconds_on_clk(struct s6i2c_if *iface, u32 ns)
 	return dividend;
 }
 
-static int __devinit s6i2c_probe(struct platform_device *dev)
+static int s6i2c_probe(struct platform_device *dev)
 {
 	struct s6i2c_if *iface = &s6i2c_if;
 	struct i2c_adapter *p_adap;
diff --git a/drivers/i2c/busses/i2c-sh7760.c b/drivers/i2c/busses/i2c-sh7760.c
index ada2b87..75127148 100644
--- a/drivers/i2c/busses/i2c-sh7760.c
+++ b/drivers/i2c/busses/i2c-sh7760.c
@@ -390,7 +390,7 @@ static const struct i2c_algorithm sh7760_i2c_algo = {
  * iclk = mclk/(CDF + 1).  iclk must be < 20MHz.
  * scl = iclk/(SCGD*8 + 20).
  */
-static int __devinit calc_CCR(unsigned long scl_hz)
+static int calc_CCR(unsigned long scl_hz)
 {
 	struct clk *mclk;
 	unsigned long mck, m1, dff, odff, iclk;
@@ -430,7 +430,7 @@ static int __devinit calc_CCR(unsigned long scl_hz)
 	return ((scgdm << 2) | cdfm);
 }
 
-static int __devinit sh7760_i2c_probe(struct platform_device *pdev)
+static int sh7760_i2c_probe(struct platform_device *pdev)
 {
 	struct sh7760_i2c_platdata *pd;
 	struct resource *res;
diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index 87e70e5..7f81a2c 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -258,7 +258,7 @@ static const struct i2c_algorithm i2c_sirfsoc_algo = {
 	.functionality = i2c_sirfsoc_func,
 };
 
-static int __devinit i2c_sirfsoc_probe(struct platform_device *pdev)
+static int i2c_sirfsoc_probe(struct platform_device *pdev)
 {
 	struct sirfsoc_i2c *siic;
 	struct i2c_adapter *adap;
diff --git a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
index 87e5126..79fd96a 100644
--- a/drivers/i2c/busses/i2c-sis5595.c
+++ b/drivers/i2c/busses/i2c-sis5595.c
@@ -142,7 +142,7 @@ static void sis5595_write(u8 reg, u8 data)
 	outb(data, sis5595_base + SMB_DAT);
 }
 
-static int __devinit sis5595_setup(struct pci_dev *SIS5595_dev)
+static int sis5595_setup(struct pci_dev *SIS5595_dev)
 {
 	u16 a;
 	u8 val;
@@ -376,7 +376,7 @@ static DEFINE_PCI_DEVICE_TABLE(sis5595_ids) = {
 
 MODULE_DEVICE_TABLE (pci, sis5595_ids);
 
-static int __devinit sis5595_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int sis5595_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	int err;
 
diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
index ec8a4bc..9b79d37 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -389,7 +389,7 @@ static u32 sis630_func(struct i2c_adapter *adapter)
 		I2C_FUNC_SMBUS_BLOCK_DATA;
 }
 
-static int __devinit sis630_setup(struct pci_dev *sis630_dev)
+static int sis630_setup(struct pci_dev *sis630_dev)
 {
 	unsigned char b;
 	struct pci_dev *dummy = NULL;
@@ -480,7 +480,7 @@ static DEFINE_PCI_DEVICE_TABLE(sis630_ids) = {
 
 MODULE_DEVICE_TABLE (pci, sis630_ids);
 
-static int __devinit sis630_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int sis630_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	if (sis630_setup(dev)) {
 		dev_err(&dev->dev, "SIS630 comp. bus not detected, module not inserted.\n");
diff --git a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
index 8b64c17..3ca3387 100644
--- a/drivers/i2c/busses/i2c-sis96x.c
+++ b/drivers/i2c/busses/i2c-sis96x.c
@@ -252,7 +252,7 @@ static DEFINE_PCI_DEVICE_TABLE(sis96x_ids) = {
 
 MODULE_DEVICE_TABLE (pci, sis96x_ids);
 
-static int __devinit sis96x_probe(struct pci_dev *dev,
+static int sis96x_probe(struct pci_dev *dev,
 				const struct pci_device_id *id)
 {
 	u16 ww = 0;
diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index a2125b6..577887b 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -651,7 +651,7 @@ static const struct of_device_id tegra_i2c_of_match[] __devinitconst = {
 MODULE_DEVICE_TABLE(of, tegra_i2c_of_match);
 #endif
 
-static int __devinit tegra_i2c_probe(struct platform_device *pdev)
+static int tegra_i2c_probe(struct platform_device *pdev)
 {
 	struct tegra_i2c_dev *i2c_dev;
 	struct tegra_i2c_platform_data *pdata = pdev->dev.platform_data;
diff --git a/drivers/i2c/busses/i2c-via.c b/drivers/i2c/busses/i2c-via.c
index 6278780..188ef6e 100644
--- a/drivers/i2c/busses/i2c-via.c
+++ b/drivers/i2c/busses/i2c-via.c
@@ -96,7 +96,7 @@ static DEFINE_PCI_DEVICE_TABLE(vt586b_ids) = {
 
 MODULE_DEVICE_TABLE (pci, vt586b_ids);
 
-static int __devinit vt586b_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int vt586b_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	u16 base;
 	u8 rev;
diff --git a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
index 271c9a2..3426196 100644
--- a/drivers/i2c/busses/i2c-viapro.c
+++ b/drivers/i2c/busses/i2c-viapro.c
@@ -320,7 +320,7 @@ static struct i2c_adapter vt596_adapter = {
 	.algo		= &smbus_algorithm,
 };
 
-static int __devinit vt596_probe(struct pci_dev *pdev,
+static int vt596_probe(struct pci_dev *pdev,
 				 const struct pci_device_id *id)
 {
 	unsigned char temp;
diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index aac948a..f4e54a9 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -689,7 +689,7 @@ static struct i2c_adapter xiic_adapter = {
 };
 
 
-static int __devinit xiic_i2c_probe(struct platform_device *pdev)
+static int xiic_i2c_probe(struct platform_device *pdev)
 {
 	struct xiic_i2c *i2c;
 	struct xiic_i2c_platform_data *pdata;
diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c
index eb7d5f7..68aa402 100644
--- a/drivers/i2c/busses/i2c-xlr.c
+++ b/drivers/i2c/busses/i2c-xlr.c
@@ -214,7 +214,7 @@ static struct i2c_algorithm xlr_i2c_algo = {
 	.functionality	= xlr_func,
 };
 
-static int __devinit xlr_i2c_probe(struct platform_device *pdev)
+static int xlr_i2c_probe(struct platform_device *pdev)
 {
 	struct xlr_i2c_private  *priv;
 	struct resource *res;
diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index 82971a8..812a4c1 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -389,7 +389,7 @@ static const struct i2c_algorithm scx200_acb_algorithm = {
 static struct scx200_acb_iface *scx200_acb_list;
 static DEFINE_MUTEX(scx200_acb_list_mutex);
 
-static __devinit int scx200_acb_probe(struct scx200_acb_iface *iface)
+static int scx200_acb_probe(struct scx200_acb_iface *iface)
 {
 	u8 val;
 
@@ -424,7 +424,7 @@ static __devinit int scx200_acb_probe(struct scx200_acb_iface *iface)
 	return 0;
 }
 
-static __devinit struct scx200_acb_iface *scx200_create_iface(const char *text,
+static struct scx200_acb_iface *scx200_create_iface(const char *text,
 		struct device *dev, int index)
 {
 	struct scx200_acb_iface *iface;
@@ -449,7 +449,7 @@ static __devinit struct scx200_acb_iface *scx200_create_iface(const char *text,
 	return iface;
 }
 
-static int __devinit scx200_acb_create(struct scx200_acb_iface *iface)
+static int scx200_acb_create(struct scx200_acb_iface *iface)
 {
 	struct i2c_adapter *adapter;
 	int rc;
@@ -480,7 +480,7 @@ static int __devinit scx200_acb_create(struct scx200_acb_iface *iface)
 	return 0;
 }
 
-static struct scx200_acb_iface * __devinit scx200_create_dev(const char *text,
+static struct scx200_acb_iface *scx200_create_dev(const char *text,
 		unsigned long base, int index, struct device *dev)
 {
 	struct scx200_acb_iface *iface;
@@ -508,7 +508,7 @@ static struct scx200_acb_iface * __devinit scx200_create_dev(const char *text,
 	return NULL;
 }
 
-static int __devinit scx200_probe(struct platform_device *pdev)
+static int scx200_probe(struct platform_device *pdev)
 {
 	struct scx200_acb_iface *iface;
 	struct resource *res;
diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 08fd89d..4511c54 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -51,13 +51,13 @@ static int i2c_mux_gpio_deselect(struct i2c_adapter *adap, void *data, u32 chan)
 	return 0;
 }
 
-static int __devinit match_gpio_chip_by_label(struct gpio_chip *chip,
+static int match_gpio_chip_by_label(struct gpio_chip *chip,
 					      void *data)
 {
 	return !strcmp(chip->label, data);
 }
 
-static int __devinit i2c_mux_gpio_probe(struct platform_device *pdev)
+static int i2c_mux_gpio_probe(struct platform_device *pdev)
 {
 	struct gpiomux *mux;
 	struct i2c_mux_gpio_platform_data *pdata;
diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index f0b397d..a7a5584 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -129,7 +129,7 @@ static inline int i2c_mux_pinctrl_parse_dt(struct i2c_mux_pinctrl *mux,
 }
 #endif
 
-static int __devinit i2c_mux_pinctrl_probe(struct platform_device *pdev)
+static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 {
 	struct i2c_mux_pinctrl *mux;
 	int (*deselect)(struct i2c_adapter *, void *, u32);
-- 
1.8.0
