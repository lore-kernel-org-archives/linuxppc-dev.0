Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id BA0B72C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:37:59 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 119/493] usb: remove use of __devexit_p
Date: Mon, 19 Nov 2012 13:21:08 -0500
Message-Id: <1353349642-3677-119-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Wan ZongShun <mcuos.com@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>,
 linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 Alan Stern <stern@rowland.harvard.edu>, Ben Dooks <ben-linux@fluff.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
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
Cc: Peter Korsgaard <jacmet@sunsite.dk> 
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com> 
Cc: Felipe Balbi <balbi@ti.com> 
Cc: Li Yang <leoli@freescale.com> 
Cc: Alan Stern <stern@rowland.harvard.edu> 
Cc: Wan ZongShun <mcuos.com@gmail.com> 
Cc: Ben Dooks <ben-linux@fluff.org> 
Cc: Kukjin Kim <kgene.kim@samsung.com> 
Cc: linux-usb@vger.kernel.org 
Cc: linux-omap@vger.kernel.org 
Cc: linuxppc-dev@lists.ozlabs.org 
Cc: linux-arm-kernel@lists.infradead.org 
Cc: linux-samsung-soc@vger.kernel.org 
---
 drivers/usb/c67x00/c67x00-drv.c      | 2 +-
 drivers/usb/chipidea/ci13xxx_imx.c   | 2 +-
 drivers/usb/chipidea/ci13xxx_msm.c   | 2 +-
 drivers/usb/chipidea/ci13xxx_pci.c   | 2 +-
 drivers/usb/chipidea/core.c          | 2 +-
 drivers/usb/chipidea/usbmisc_imx6q.c | 2 +-
 drivers/usb/dwc3/core.c              | 2 +-
 drivers/usb/dwc3/dwc3-exynos.c       | 2 +-
 drivers/usb/dwc3/dwc3-omap.c         | 2 +-
 drivers/usb/dwc3/dwc3-pci.c          | 2 +-
 drivers/usb/gadget/bcm63xx_udc.c     | 2 +-
 drivers/usb/gadget/fsl_qe_udc.c      | 2 +-
 drivers/usb/gadget/hid.c             | 2 +-
 drivers/usb/gadget/lpc32xx_udc.c     | 2 +-
 drivers/usb/gadget/net2272.c         | 4 ++--
 drivers/usb/gadget/omap_udc.c        | 2 +-
 drivers/usb/gadget/s3c-hsotg.c       | 2 +-
 drivers/usb/host/bcma-hcd.c          | 2 +-
 drivers/usb/host/ehci-atmel.c        | 2 +-
 drivers/usb/host/ehci-msm.c          | 2 +-
 drivers/usb/host/ehci-platform.c     | 2 +-
 drivers/usb/host/ehci-s5p.c          | 2 +-
 drivers/usb/host/ehci-w90x900.c      | 2 +-
 drivers/usb/host/fhci-hcd.c          | 2 +-
 drivers/usb/host/fsl-mph-dr-of.c     | 2 +-
 drivers/usb/host/isp1362-hcd.c       | 2 +-
 drivers/usb/host/isp1760-if.c        | 2 +-
 drivers/usb/host/ohci-at91.c         | 2 +-
 drivers/usb/host/ohci-exynos.c       | 2 +-
 drivers/usb/host/ohci-jz4740.c       | 2 +-
 drivers/usb/host/ohci-omap3.c        | 2 +-
 drivers/usb/host/ohci-platform.c     | 2 +-
 drivers/usb/host/ohci-s3c2410.c      | 2 +-
 drivers/usb/host/ohci-tmio.c         | 2 +-
 drivers/usb/host/r8a66597-hcd.c      | 2 +-
 drivers/usb/host/sl811-hcd.c         | 2 +-
 drivers/usb/host/ssb-hcd.c           | 2 +-
 drivers/usb/host/u132-hcd.c          | 2 +-
 drivers/usb/musb/am35x.c             | 2 +-
 drivers/usb/musb/da8xx.c             | 2 +-
 drivers/usb/musb/davinci.c           | 2 +-
 drivers/usb/musb/musb_core.c         | 2 +-
 drivers/usb/musb/musb_dsps.c         | 2 +-
 drivers/usb/musb/omap2430.c          | 2 +-
 drivers/usb/musb/tusb6010.c          | 2 +-
 drivers/usb/musb/ux500.c             | 2 +-
 drivers/usb/otg/ab8500-usb.c         | 2 +-
 drivers/usb/otg/fsl_otg.c            | 2 +-
 drivers/usb/otg/msm_otg.c            | 2 +-
 drivers/usb/otg/mxs-phy.c            | 2 +-
 drivers/usb/otg/nop-usb-xceiv.c      | 2 +-
 drivers/usb/phy/mv_u3d_phy.c         | 2 +-
 drivers/usb/phy/omap-usb2.c          | 2 +-
 drivers/usb/phy/rcar-phy.c           | 2 +-
 drivers/usb/renesas_usbhs/common.c   | 2 +-
 55 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/usb/c67x00/c67x00-drv.c b/drivers/usb/c67x00/c67x00-drv.c
index 6f3b6e2..855d538 100644
--- a/drivers/usb/c67x00/c67x00-drv.c
+++ b/drivers/usb/c67x00/c67x00-drv.c
@@ -219,7 +219,7 @@ static int __devexit c67x00_drv_remove(struct platform_device *pdev)
 
 static struct platform_driver c67x00_driver = {
 	.probe	= c67x00_drv_probe,
-	.remove	= __devexit_p(c67x00_drv_remove),
+	.remove	= c67x00_drv_remove,
 	.driver	= {
 		.owner = THIS_MODULE,
 		.name = "c67x00",
diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index 0f5ca4b..5659730 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -252,7 +252,7 @@ MODULE_DEVICE_TABLE(of, ci13xxx_imx_dt_ids);
 
 static struct platform_driver ci13xxx_imx_driver = {
 	.probe = ci13xxx_imx_probe,
-	.remove = __devexit_p(ci13xxx_imx_remove),
+	.remove = ci13xxx_imx_remove,
 	.driver = {
 		.name = "imx_usb",
 		.owner = THIS_MODULE,
diff --git a/drivers/usb/chipidea/ci13xxx_msm.c b/drivers/usb/chipidea/ci13xxx_msm.c
index b01feb3..406c5af 100644
--- a/drivers/usb/chipidea/ci13xxx_msm.c
+++ b/drivers/usb/chipidea/ci13xxx_msm.c
@@ -89,7 +89,7 @@ static int __devexit ci13xxx_msm_remove(struct platform_device *pdev)
 
 static struct platform_driver ci13xxx_msm_driver = {
 	.probe = ci13xxx_msm_probe,
-	.remove = __devexit_p(ci13xxx_msm_remove),
+	.remove = ci13xxx_msm_remove,
 	.driver = { .name = "msm_hsusb", },
 };
 
diff --git a/drivers/usb/chipidea/ci13xxx_pci.c b/drivers/usb/chipidea/ci13xxx_pci.c
index 918e149..e1cb2fb 100644
--- a/drivers/usb/chipidea/ci13xxx_pci.c
+++ b/drivers/usb/chipidea/ci13xxx_pci.c
@@ -147,7 +147,7 @@ static struct pci_driver ci13xxx_pci_driver = {
 	.name         =	UDC_DRIVER_NAME,
 	.id_table     =	ci13xxx_pci_id_table,
 	.probe        =	ci13xxx_pci_probe,
-	.remove       =	__devexit_p(ci13xxx_pci_remove),
+	.remove       =	ci13xxx_pci_remove,
 };
 
 module_pci_driver(ci13xxx_pci_driver);
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index f69d029..46f23f2 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -523,7 +523,7 @@ static int __devexit ci_hdrc_remove(struct platform_device *pdev)
 
 static struct platform_driver ci_hdrc_driver = {
 	.probe	= ci_hdrc_probe,
-	.remove	= __devexit_p(ci_hdrc_remove),
+	.remove	= ci_hdrc_remove,
 	.driver	= {
 		.name	= "ci_hdrc",
 	},
diff --git a/drivers/usb/chipidea/usbmisc_imx6q.c b/drivers/usb/chipidea/usbmisc_imx6q.c
index 416e3fc..81238a4 100644
--- a/drivers/usb/chipidea/usbmisc_imx6q.c
+++ b/drivers/usb/chipidea/usbmisc_imx6q.c
@@ -136,7 +136,7 @@ static int __devexit usbmisc_imx6q_remove(struct platform_device *pdev)
 
 static struct platform_driver usbmisc_imx6q_driver = {
 	.probe = usbmisc_imx6q_probe,
-	.remove = __devexit_p(usbmisc_imx6q_remove),
+	.remove = usbmisc_imx6q_remove,
 	.driver = {
 		.name = "usbmisc_imx6q",
 		.owner = THIS_MODULE,
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index e71a62a..1a02442 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -583,7 +583,7 @@ static int __devexit dwc3_remove(struct platform_device *pdev)
 
 static struct platform_driver dwc3_driver = {
 	.probe		= dwc3_probe,
-	.remove		= __devexit_p(dwc3_remove),
+	.remove		= dwc3_remove,
 	.driver		= {
 		.name	= "dwc3",
 	},
diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index dc35c54..19a9818 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -196,7 +196,7 @@ MODULE_DEVICE_TABLE(of, exynos_dwc3_match);
 
 static struct platform_driver dwc3_exynos_driver = {
 	.probe		= dwc3_exynos_probe,
-	.remove		= __devexit_p(dwc3_exynos_remove),
+	.remove		= dwc3_exynos_remove,
 	.driver		= {
 		.name	= "exynos-dwc3",
 		.of_match_table = of_match_ptr(exynos_dwc3_match),
diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 900d435f..afbc6e9 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -441,7 +441,7 @@ MODULE_DEVICE_TABLE(of, of_dwc3_matach);
 
 static struct platform_driver dwc3_omap_driver = {
 	.probe		= dwc3_omap_probe,
-	.remove		= __devexit_p(dwc3_omap_remove),
+	.remove		= dwc3_omap_remove,
 	.driver		= {
 		.name	= "omap-dwc3",
 		.of_match_table	= of_dwc3_matach,
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 1396259..b3eeec7 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -218,7 +218,7 @@ static struct pci_driver dwc3_pci_driver = {
 	.name		= "dwc3-pci",
 	.id_table	= dwc3_pci_id_table,
 	.probe		= dwc3_pci_probe,
-	.remove		= __devexit_p(dwc3_pci_remove),
+	.remove		= dwc3_pci_remove,
 };
 
 MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
diff --git a/drivers/usb/gadget/bcm63xx_udc.c b/drivers/usb/gadget/bcm63xx_udc.c
index 9ca7922..b44e436 100644
--- a/drivers/usb/gadget/bcm63xx_udc.c
+++ b/drivers/usb/gadget/bcm63xx_udc.c
@@ -2450,7 +2450,7 @@ static int __devexit bcm63xx_udc_remove(struct platform_device *pdev)
 
 static struct platform_driver bcm63xx_udc_driver = {
 	.probe		= bcm63xx_udc_probe,
-	.remove		= __devexit_p(bcm63xx_udc_remove),
+	.remove		= bcm63xx_udc_remove,
 	.driver		= {
 		.name	= DRV_MODULE_NAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index b09452d..21db1f7 100644
--- a/drivers/usb/gadget/fsl_qe_udc.c
+++ b/drivers/usb/gadget/fsl_qe_udc.c
@@ -2735,7 +2735,7 @@ static struct platform_driver udc_driver = {
 		.of_match_table = qe_udc_match,
 	},
 	.probe          = qe_udc_probe,
-	.remove         = __devexit_p(qe_udc_remove),
+	.remove         = qe_udc_remove,
 #ifdef CONFIG_PM
 	.suspend        = qe_udc_suspend,
 	.resume         = qe_udc_resume,
diff --git a/drivers/usb/gadget/hid.c b/drivers/usb/gadget/hid.c
index 74130f6..33deed6 100644
--- a/drivers/usb/gadget/hid.c
+++ b/drivers/usb/gadget/hid.c
@@ -229,7 +229,7 @@ static __refdata struct usb_composite_driver hidg_driver = {
 };
 
 static struct platform_driver hidg_plat_driver = {
-	.remove		= __devexit_p(hidg_plat_driver_remove),
+	.remove		= hidg_plat_driver_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "hidg",
diff --git a/drivers/usb/gadget/lpc32xx_udc.c b/drivers/usb/gadget/lpc32xx_udc.c
index d1cf1f4..52ad15c 100644
--- a/drivers/usb/gadget/lpc32xx_udc.c
+++ b/drivers/usb/gadget/lpc32xx_udc.c
@@ -3447,7 +3447,7 @@ MODULE_DEVICE_TABLE(of, lpc32xx_udc_of_match);
 #endif
 
 static struct platform_driver lpc32xx_udc_driver = {
-	.remove		= __devexit_p(lpc32xx_udc_remove),
+	.remove		= lpc32xx_udc_remove,
 	.shutdown	= lpc32xx_udc_shutdown,
 	.suspend	= lpc32xx_udc_suspend,
 	.resume		= lpc32xx_udc_resume,
diff --git a/drivers/usb/gadget/net2272.c b/drivers/usb/gadget/net2272.c
index c009263..26c3053 100644
--- a/drivers/usb/gadget/net2272.c
+++ b/drivers/usb/gadget/net2272.c
@@ -2575,7 +2575,7 @@ static struct pci_driver net2272_pci_driver = {
 	.id_table = pci_ids,
 
 	.probe    = net2272_pci_probe,
-	.remove   = __devexit_p(net2272_pci_remove),
+	.remove   = net2272_pci_remove,
 };
 
 static int net2272_pci_register(void)
@@ -2678,7 +2678,7 @@ net2272_plat_remove(struct platform_device *pdev)
 
 static struct platform_driver net2272_plat_driver = {
 	.probe   = net2272_plat_probe,
-	.remove  = __devexit_p(net2272_plat_remove),
+	.remove  = net2272_plat_remove,
 	.driver  = {
 		.name  = driver_name,
 		.owner = THIS_MODULE,
diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index 23afa06..650fa23 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -3062,7 +3062,7 @@ static int omap_udc_resume(struct platform_device *dev)
 
 static struct platform_driver udc_driver = {
 	.probe		= omap_udc_probe,
-	.remove		= __devexit_p(omap_udc_remove),
+	.remove		= omap_udc_remove,
 	.suspend	= omap_udc_suspend,
 	.resume		= omap_udc_resume,
 	.driver		= {
diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index 6f696ee..9fd6e5f 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -3708,7 +3708,7 @@ static struct platform_driver s3c_hsotg_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= s3c_hsotg_probe,
-	.remove		= __devexit_p(s3c_hsotg_remove),
+	.remove		= s3c_hsotg_remove,
 	.suspend	= s3c_hsotg_suspend,
 	.resume		= s3c_hsotg_resume,
 };
diff --git a/drivers/usb/host/bcma-hcd.c b/drivers/usb/host/bcma-hcd.c
index 443da21..f5143a0 100644
--- a/drivers/usb/host/bcma-hcd.c
+++ b/drivers/usb/host/bcma-hcd.c
@@ -316,7 +316,7 @@ static struct bcma_driver bcma_hcd_driver = {
 	.name		= KBUILD_MODNAME,
 	.id_table	= bcma_hcd_table,
 	.probe		= bcma_hcd_probe,
-	.remove		= __devexit_p(bcma_hcd_remove),
+	.remove		= bcma_hcd_remove,
 	.shutdown	= bcma_hcd_shutdown,
 	.suspend	= bcma_hcd_suspend,
 	.resume		= bcma_hcd_resume,
diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index d23321e..33f798e 100644
--- a/drivers/usb/host/ehci-atmel.c
+++ b/drivers/usb/host/ehci-atmel.c
@@ -207,7 +207,7 @@ MODULE_DEVICE_TABLE(of, atmel_ehci_dt_ids);
 
 static struct platform_driver ehci_atmel_driver = {
 	.probe		= ehci_atmel_drv_probe,
-	.remove		= __devexit_p(ehci_atmel_drv_remove),
+	.remove		= ehci_atmel_drv_remove,
 	.shutdown	= usb_hcd_platform_shutdown,
 	.driver		= {
 		.name	= "atmel-ehci",
diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
index 7fa1ba4..e0acfd5 100644
--- a/drivers/usb/host/ehci-msm.c
+++ b/drivers/usb/host/ehci-msm.c
@@ -220,7 +220,7 @@ static const struct dev_pm_ops ehci_msm_dev_pm_ops = {
 
 static struct platform_driver ehci_msm_driver = {
 	.probe	= ehci_msm_probe,
-	.remove	= __devexit_p(ehci_msm_remove),
+	.remove	= ehci_msm_remove,
 	.driver = {
 		   .name = "msm_hsusb_host",
 		   .pm = &ehci_msm_dev_pm_ops,
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index f14c542..b807648 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -196,7 +196,7 @@ static const struct dev_pm_ops ehci_platform_pm_ops = {
 static struct platform_driver ehci_platform_driver = {
 	.id_table	= ehci_platform_table,
 	.probe		= ehci_platform_probe,
-	.remove		= __devexit_p(ehci_platform_remove),
+	.remove		= ehci_platform_remove,
 	.shutdown	= usb_hcd_platform_shutdown,
 	.driver		= {
 		.owner	= THIS_MODULE,
diff --git a/drivers/usb/host/ehci-s5p.c b/drivers/usb/host/ehci-s5p.c
index abc178d..f90a881 100644
--- a/drivers/usb/host/ehci-s5p.c
+++ b/drivers/usb/host/ehci-s5p.c
@@ -274,7 +274,7 @@ MODULE_DEVICE_TABLE(of, exynos_ehci_match);
 
 static struct platform_driver s5p_ehci_driver = {
 	.probe		= s5p_ehci_probe,
-	.remove		= __devexit_p(s5p_ehci_remove),
+	.remove		= s5p_ehci_remove,
 	.shutdown	= s5p_ehci_shutdown,
 	.driver = {
 		.name	= "s5p-ehci",
diff --git a/drivers/usb/host/ehci-w90x900.c b/drivers/usb/host/ehci-w90x900.c
index fdd7c48..7bcb8b2 100644
--- a/drivers/usb/host/ehci-w90x900.c
+++ b/drivers/usb/host/ehci-w90x900.c
@@ -166,7 +166,7 @@ static int __devexit ehci_w90x900_remove(struct platform_device *pdev)
 
 static struct platform_driver ehci_hcd_w90x900_driver = {
 	.probe  = ehci_w90x900_probe,
-	.remove = __devexit_p(ehci_w90x900_remove),
+	.remove = ehci_w90x900_remove,
 	.driver = {
 		.name = "w90x900-ehci",
 		.owner = THIS_MODULE,
diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
index 7da1a26..92f4b99 100644
--- a/drivers/usb/host/fhci-hcd.c
+++ b/drivers/usb/host/fhci-hcd.c
@@ -821,7 +821,7 @@ static struct platform_driver of_fhci_driver = {
 		.of_match_table = of_fhci_match,
 	},
 	.probe		= of_fhci_probe,
-	.remove		= __devexit_p(of_fhci_remove),
+	.remove		= of_fhci_remove,
 };
 
 module_platform_driver(of_fhci_driver);
diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
index 1e77129..3a5c82f 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -336,7 +336,7 @@ static struct platform_driver fsl_usb2_mph_dr_driver = {
 		.of_match_table = fsl_usb2_mph_dr_of_match,
 	},
 	.probe	= fsl_usb2_mph_dr_of_probe,
-	.remove	= __devexit_p(fsl_usb2_mph_dr_of_remove),
+	.remove	= fsl_usb2_mph_dr_of_remove,
 };
 
 module_platform_driver(fsl_usb2_mph_dr_driver);
diff --git a/drivers/usb/host/isp1362-hcd.c b/drivers/usb/host/isp1362-hcd.c
index 2563263..1ad9d20 100644
--- a/drivers/usb/host/isp1362-hcd.c
+++ b/drivers/usb/host/isp1362-hcd.c
@@ -2856,7 +2856,7 @@ static int isp1362_resume(struct platform_device *pdev)
 
 static struct platform_driver isp1362_driver = {
 	.probe = isp1362_probe,
-	.remove = __devexit_p(isp1362_remove),
+	.remove = isp1362_remove,
 
 	.suspend = isp1362_suspend,
 	.resume = isp1362_resume,
diff --git a/drivers/usb/host/isp1760-if.c b/drivers/usb/host/isp1760-if.c
index 958379f..5fb3cae 100644
--- a/drivers/usb/host/isp1760-if.c
+++ b/drivers/usb/host/isp1760-if.c
@@ -432,7 +432,7 @@ static int __devexit isp1760_plat_remove(struct platform_device *pdev)
 
 static struct platform_driver isp1760_plat_driver = {
 	.probe	= isp1760_plat_probe,
-	.remove	= __devexit_p(isp1760_plat_remove),
+	.remove	= isp1760_plat_remove,
 	.driver	= {
 		.name	= "isp1760",
 	},
diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 1c0a042..51de2f9 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -717,7 +717,7 @@ MODULE_ALIAS("platform:at91_ohci");
 
 static struct platform_driver ohci_hcd_at91_driver = {
 	.probe		= ohci_hcd_at91_drv_probe,
-	.remove		= __devexit_p(ohci_hcd_at91_drv_remove),
+	.remove		= ohci_hcd_at91_drv_remove,
 	.shutdown	= usb_hcd_platform_shutdown,
 	.suspend	= ohci_hcd_at91_drv_suspend,
 	.resume		= ohci_hcd_at91_drv_resume,
diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index 6a30fc5..2f673e8 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -275,7 +275,7 @@ MODULE_DEVICE_TABLE(of, exynos_ohci_match);
 
 static struct platform_driver exynos_ohci_driver = {
 	.probe		= exynos_ohci_probe,
-	.remove		= __devexit_p(exynos_ohci_remove),
+	.remove		= exynos_ohci_remove,
 	.shutdown	= exynos_ohci_shutdown,
 	.driver = {
 		.name	= "exynos-ohci",
diff --git a/drivers/usb/host/ohci-jz4740.c b/drivers/usb/host/ohci-jz4740.c
index 931d588..b4921b7 100644
--- a/drivers/usb/host/ohci-jz4740.c
+++ b/drivers/usb/host/ohci-jz4740.c
@@ -266,7 +266,7 @@ static __devexit int jz4740_ohci_remove(struct platform_device *pdev)
 
 static struct platform_driver ohci_hcd_jz4740_driver = {
 	.probe = jz4740_ohci_probe,
-	.remove = __devexit_p(jz4740_ohci_remove),
+	.remove = jz4740_ohci_remove,
 	.driver = {
 		.name = "jz4740-ohci",
 		.owner = THIS_MODULE,
diff --git a/drivers/usb/host/ohci-omap3.c b/drivers/usb/host/ohci-omap3.c
index bd7803d..002c812 100644
--- a/drivers/usb/host/ohci-omap3.c
+++ b/drivers/usb/host/ohci-omap3.c
@@ -231,7 +231,7 @@ static void ohci_hcd_omap3_shutdown(struct platform_device *pdev)
 
 static struct platform_driver ohci_hcd_omap3_driver = {
 	.probe		= ohci_hcd_omap3_probe,
-	.remove		= __devexit_p(ohci_hcd_omap3_remove),
+	.remove		= ohci_hcd_omap3_remove,
 	.shutdown	= ohci_hcd_omap3_shutdown,
 	.driver		= {
 		.name	= "ohci-omap3",
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index bda4e0b..ffe6c98 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -214,7 +214,7 @@ static const struct dev_pm_ops ohci_platform_pm_ops = {
 static struct platform_driver ohci_platform_driver = {
 	.id_table	= ohci_platform_table,
 	.probe		= ohci_platform_probe,
-	.remove		= __devexit_p(ohci_platform_remove),
+	.remove		= ohci_platform_remove,
 	.shutdown	= usb_hcd_platform_shutdown,
 	.driver		= {
 		.owner	= THIS_MODULE,
diff --git a/drivers/usb/host/ohci-s3c2410.c b/drivers/usb/host/ohci-s3c2410.c
index e84190f..5c5c017 100644
--- a/drivers/usb/host/ohci-s3c2410.c
+++ b/drivers/usb/host/ohci-s3c2410.c
@@ -524,7 +524,7 @@ static const struct dev_pm_ops ohci_hcd_s3c2410_pm_ops = {
 
 static struct platform_driver ohci_hcd_s3c2410_driver = {
 	.probe		= ohci_hcd_s3c2410_drv_probe,
-	.remove		= __devexit_p(ohci_hcd_s3c2410_drv_remove),
+	.remove		= ohci_hcd_s3c2410_drv_remove,
 	.shutdown	= usb_hcd_platform_shutdown,
 	.driver		= {
 		.owner	= THIS_MODULE,
diff --git a/drivers/usb/host/ohci-tmio.c b/drivers/usb/host/ohci-tmio.c
index 2c9ab8f..94c6c55 100644
--- a/drivers/usb/host/ohci-tmio.c
+++ b/drivers/usb/host/ohci-tmio.c
@@ -363,7 +363,7 @@ static int ohci_hcd_tmio_drv_resume(struct platform_device *dev)
 
 static struct platform_driver ohci_hcd_tmio_driver = {
 	.probe		= ohci_hcd_tmio_drv_probe,
-	.remove		= __devexit_p(ohci_hcd_tmio_drv_remove),
+	.remove		= ohci_hcd_tmio_drv_remove,
 	.shutdown	= usb_hcd_platform_shutdown,
 	.suspend	= ohci_hcd_tmio_drv_suspend,
 	.resume		= ohci_hcd_tmio_drv_resume,
diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index b3eea0b..4e0436f 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -2532,7 +2532,7 @@ clean_up:
 
 static struct platform_driver r8a66597_driver = {
 	.probe =	r8a66597_probe,
-	.remove =	__devexit_p(r8a66597_remove),
+	.remove =	r8a66597_remove,
 	.driver		= {
 		.name = (char *) hcd_name,
 		.owner	= THIS_MODULE,
diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index 619b05f..15f20de 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -1808,7 +1808,7 @@ sl811h_resume(struct platform_device *dev)
 /* this driver is exported so sl811_cs can depend on it */
 struct platform_driver sl811h_driver = {
 	.probe =	sl811h_probe,
-	.remove =	__devexit_p(sl811h_remove),
+	.remove =	sl811h_remove,
 
 	.suspend =	sl811h_suspend,
 	.resume =	sl811h_resume,
diff --git a/drivers/usb/host/ssb-hcd.c b/drivers/usb/host/ssb-hcd.c
index c2a29fa..4dc9a09 100644
--- a/drivers/usb/host/ssb-hcd.c
+++ b/drivers/usb/host/ssb-hcd.c
@@ -261,7 +261,7 @@ static struct ssb_driver ssb_hcd_driver = {
 	.name		= KBUILD_MODNAME,
 	.id_table	= ssb_hcd_table,
 	.probe		= ssb_hcd_probe,
-	.remove		= __devexit_p(ssb_hcd_remove),
+	.remove		= ssb_hcd_remove,
 	.shutdown	= ssb_hcd_shutdown,
 	.suspend	= ssb_hcd_suspend,
 	.resume		= ssb_hcd_resume,
diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
index dbbd1ba..8836898 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -3212,7 +3212,7 @@ static int u132_resume(struct platform_device *pdev)
 */
 static struct platform_driver u132_platform_driver = {
 	.probe = u132_probe,
-	.remove = __devexit_p(u132_remove),
+	.remove = u132_remove,
 	.suspend = u132_suspend,
 	.resume = u132_resume,
 	.driver = {
diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index dfb7b73..35d94ac 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -628,7 +628,7 @@ static struct dev_pm_ops am35x_pm_ops = {
 
 static struct platform_driver am35x_driver = {
 	.probe		= am35x_probe,
-	.remove		= __devexit_p(am35x_remove),
+	.remove		= am35x_remove,
 	.driver		= {
 		.name	= "musb-am35x",
 		.pm	= DEV_PM_OPS,
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 67b8ae7..51ace9b 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -569,7 +569,7 @@ static int __devexit da8xx_remove(struct platform_device *pdev)
 
 static struct platform_driver da8xx_driver = {
 	.probe		= da8xx_probe,
-	.remove		= __devexit_p(da8xx_remove),
+	.remove		= da8xx_remove,
 	.driver		= {
 		.name	= "musb-da8xx",
 	},
diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index b3c0a94..e01087b 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -601,7 +601,7 @@ static int __devexit davinci_remove(struct platform_device *pdev)
 
 static struct platform_driver davinci_driver = {
 	.probe		= davinci_probe,
-	.remove		= __devexit_p(davinci_remove),
+	.remove		= davinci_remove,
 	.driver		= {
 		.name	= "musb-davinci",
 	},
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 774d815..69cfa18 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2288,7 +2288,7 @@ static struct platform_driver musb_driver = {
 		.pm		= MUSB_DEV_PM_OPS,
 	},
 	.probe		= musb_probe,
-	.remove		= __devexit_p(musb_remove),
+	.remove		= musb_remove,
 	.shutdown	= musb_shutdown,
 };
 
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 7185eb0..5daea65 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -766,7 +766,7 @@ MODULE_DEVICE_TABLE(of, musb_dsps_of_match);
 
 static struct platform_driver dsps_usbss_driver = {
 	.probe		= dsps_probe,
-	.remove         = __devexit_p(dsps_remove),
+	.remove         = dsps_remove,
 	.driver         = {
 		.name   = "musb-dsps",
 		.pm	= &dsps_pm_ops,
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 32f531e..1150b4b 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -674,7 +674,7 @@ MODULE_DEVICE_TABLE(of, omap2430_id_table);
 
 static struct platform_driver omap2430_driver = {
 	.probe		= omap2430_probe,
-	.remove		= __devexit_p(omap2430_remove),
+	.remove		= omap2430_remove,
 	.driver		= {
 		.name	= "musb-omap2430",
 		.pm	= DEV_PM_OPS,
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 812719b..b816517 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -1227,7 +1227,7 @@ static int __devexit tusb_remove(struct platform_device *pdev)
 
 static struct platform_driver tusb_driver = {
 	.probe		= tusb_probe,
-	.remove		= __devexit_p(tusb_remove),
+	.remove		= tusb_remove,
 	.driver		= {
 		.name	= "musb-tusb",
 	},
diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
index 286f1be..1d81557 100644
--- a/drivers/usb/musb/ux500.c
+++ b/drivers/usb/musb/ux500.c
@@ -216,7 +216,7 @@ static const struct dev_pm_ops ux500_pm_ops = {
 
 static struct platform_driver ux500_driver = {
 	.probe		= ux500_probe,
-	.remove		= __devexit_p(ux500_remove),
+	.remove		= ux500_remove,
 	.driver		= {
 		.name	= "musb-ux500",
 		.pm	= DEV_PM_OPS,
diff --git a/drivers/usb/otg/ab8500-usb.c b/drivers/usb/otg/ab8500-usb.c
index ae8ad56..62ea0c2 100644
--- a/drivers/usb/otg/ab8500-usb.c
+++ b/drivers/usb/otg/ab8500-usb.c
@@ -571,7 +571,7 @@ static int __devexit ab8500_usb_remove(struct platform_device *pdev)
 
 static struct platform_driver ab8500_usb_driver = {
 	.probe		= ab8500_usb_probe,
-	.remove		= __devexit_p(ab8500_usb_remove),
+	.remove		= ab8500_usb_remove,
 	.driver		= {
 		.name	= "ab8500-usb",
 		.owner	= THIS_MODULE,
diff --git a/drivers/usb/otg/fsl_otg.c b/drivers/usb/otg/fsl_otg.c
index c19d1d7..77dad18 100644
--- a/drivers/usb/otg/fsl_otg.c
+++ b/drivers/usb/otg/fsl_otg.c
@@ -1169,7 +1169,7 @@ static int __devexit fsl_otg_remove(struct platform_device *pdev)
 
 struct platform_driver fsl_otg_driver = {
 	.probe = fsl_otg_probe,
-	.remove = __devexit_p(fsl_otg_remove),
+	.remove = fsl_otg_remove,
 	.driver = {
 		.name = driver_name,
 		.owner = THIS_MODULE,
diff --git a/drivers/usb/otg/msm_otg.c b/drivers/usb/otg/msm_otg.c
index 9f5fc90..eef0dd2 100644
--- a/drivers/usb/otg/msm_otg.c
+++ b/drivers/usb/otg/msm_otg.c
@@ -1746,7 +1746,7 @@ static const struct dev_pm_ops msm_otg_dev_pm_ops = {
 #endif
 
 static struct platform_driver msm_otg_driver = {
-	.remove = __devexit_p(msm_otg_remove),
+	.remove = msm_otg_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.owner = THIS_MODULE,
diff --git a/drivers/usb/otg/mxs-phy.c b/drivers/usb/otg/mxs-phy.c
index 88db976..825d860 100644
--- a/drivers/usb/otg/mxs-phy.c
+++ b/drivers/usb/otg/mxs-phy.c
@@ -191,7 +191,7 @@ MODULE_DEVICE_TABLE(of, mxs_phy_dt_ids);
 
 static struct platform_driver mxs_phy_driver = {
 	.probe = mxs_phy_probe,
-	.remove = __devexit_p(mxs_phy_remove),
+	.remove = mxs_phy_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
index e52e35e..0502c24 100644
--- a/drivers/usb/otg/nop-usb-xceiv.c
+++ b/drivers/usb/otg/nop-usb-xceiv.c
@@ -156,7 +156,7 @@ static int __devexit nop_usb_xceiv_remove(struct platform_device *pdev)
 
 static struct platform_driver nop_usb_xceiv_driver = {
 	.probe		= nop_usb_xceiv_probe,
-	.remove		= __devexit_p(nop_usb_xceiv_remove),
+	.remove		= nop_usb_xceiv_remove,
 	.driver		= {
 		.name	= "nop_usb_xceiv",
 		.owner	= THIS_MODULE,
diff --git a/drivers/usb/phy/mv_u3d_phy.c b/drivers/usb/phy/mv_u3d_phy.c
index 9f1c5d3..80cf57e 100644
--- a/drivers/usb/phy/mv_u3d_phy.c
+++ b/drivers/usb/phy/mv_u3d_phy.c
@@ -331,7 +331,7 @@ static int __exit mv_u3d_phy_remove(struct platform_device *pdev)
 
 static struct platform_driver mv_u3d_phy_driver = {
 	.probe		= mv_u3d_phy_probe,
-	.remove		= __devexit_p(mv_u3d_phy_remove),
+	.remove		= mv_u3d_phy_remove,
 	.driver		= {
 		.name	= "mv-u3d-phy",
 		.owner	= THIS_MODULE,
diff --git a/drivers/usb/phy/omap-usb2.c b/drivers/usb/phy/omap-usb2.c
index 15ab3d6..f1ed872 100644
--- a/drivers/usb/phy/omap-usb2.c
+++ b/drivers/usb/phy/omap-usb2.c
@@ -254,7 +254,7 @@ MODULE_DEVICE_TABLE(of, omap_usb2_id_table);
 
 static struct platform_driver omap_usb2_driver = {
 	.probe		= omap_usb2_probe,
-	.remove		= __devexit_p(omap_usb2_remove),
+	.remove		= omap_usb2_remove,
 	.driver		= {
 		.name	= "omap-usb2",
 		.owner	= THIS_MODULE,
diff --git a/drivers/usb/phy/rcar-phy.c b/drivers/usb/phy/rcar-phy.c
index 792f505..703a295 100644
--- a/drivers/usb/phy/rcar-phy.c
+++ b/drivers/usb/phy/rcar-phy.c
@@ -210,7 +210,7 @@ static struct platform_driver rcar_usb_phy_driver = {
 		.name	= "rcar_usb_phy",
 	},
 	.probe		= rcar_usb_phy_probe,
-	.remove		= __devexit_p(rcar_usb_phy_remove),
+	.remove		= rcar_usb_phy_remove,
 };
 
 module_platform_driver(rcar_usb_phy_driver);
diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 3bf922ab..2aa7c1a 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -636,7 +636,7 @@ static struct platform_driver renesas_usbhs_driver = {
 		.pm	= &usbhsc_pm_ops,
 	},
 	.probe		= usbhs_probe,
-	.remove		= __devexit_p(usbhs_remove),
+	.remove		= usbhs_remove,
 };
 
 module_platform_driver(renesas_usbhs_driver);
-- 
1.8.0
