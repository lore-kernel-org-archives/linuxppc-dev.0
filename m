Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id 309802C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:43:00 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 431/493] usb: remove use of __devexit
Date: Mon, 19 Nov 2012 13:26:20 -0500
Message-Id: <1353349642-3677-431-git-send-email-wfp5p@virginia.edu>
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

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

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
 drivers/usb/c67x00/c67x00-drv.c      |  2 +-
 drivers/usb/chipidea/ci13xxx_imx.c   |  2 +-
 drivers/usb/chipidea/ci13xxx_msm.c   |  2 +-
 drivers/usb/chipidea/ci13xxx_pci.c   |  2 +-
 drivers/usb/chipidea/core.c          |  2 +-
 drivers/usb/chipidea/usbmisc_imx6q.c |  2 +-
 drivers/usb/dwc3/core.c              |  2 +-
 drivers/usb/dwc3/debugfs.c           |  2 +-
 drivers/usb/dwc3/dwc3-exynos.c       |  2 +-
 drivers/usb/dwc3/dwc3-omap.c         |  2 +-
 drivers/usb/dwc3/dwc3-pci.c          |  2 +-
 drivers/usb/gadget/bcm63xx_udc.c     |  2 +-
 drivers/usb/gadget/fsl_qe_udc.c      |  2 +-
 drivers/usb/gadget/hid.c             |  2 +-
 drivers/usb/gadget/lpc32xx_udc.c     |  2 +-
 drivers/usb/gadget/mv_u3d_core.c     |  2 +-
 drivers/usb/gadget/mv_udc_core.c     |  2 +-
 drivers/usb/gadget/net2272.c         | 10 +++++-----
 drivers/usb/gadget/omap_udc.c        |  2 +-
 drivers/usb/gadget/s3c-hsotg.c       |  4 ++--
 drivers/usb/host/bcma-hcd.c          |  2 +-
 drivers/usb/host/ehci-atmel.c        |  2 +-
 drivers/usb/host/ehci-msm.c          |  2 +-
 drivers/usb/host/ehci-platform.c     |  2 +-
 drivers/usb/host/ehci-s5p.c          |  2 +-
 drivers/usb/host/ehci-w90x900.c      |  2 +-
 drivers/usb/host/fhci-hcd.c          |  4 ++--
 drivers/usb/host/fsl-mph-dr-of.c     |  4 ++--
 drivers/usb/host/isp1362-hcd.c       |  2 +-
 drivers/usb/host/isp1760-if.c        |  2 +-
 drivers/usb/host/ohci-at91.c         |  6 +++---
 drivers/usb/host/ohci-exynos.c       |  2 +-
 drivers/usb/host/ohci-jz4740.c       |  2 +-
 drivers/usb/host/ohci-omap3.c        |  2 +-
 drivers/usb/host/ohci-platform.c     |  2 +-
 drivers/usb/host/ohci-s3c2410.c      |  2 +-
 drivers/usb/host/ohci-tmio.c         |  2 +-
 drivers/usb/host/r8a66597-hcd.c      |  2 +-
 drivers/usb/host/sl811-hcd.c         |  2 +-
 drivers/usb/host/ssb-hcd.c           |  4 ++--
 drivers/usb/host/u132-hcd.c          |  2 +-
 drivers/usb/musb/am35x.c             |  2 +-
 drivers/usb/musb/blackfin.c          |  2 +-
 drivers/usb/musb/da8xx.c             |  2 +-
 drivers/usb/musb/davinci.c           |  2 +-
 drivers/usb/musb/musb_core.c         |  2 +-
 drivers/usb/musb/musb_dsps.c         |  2 +-
 drivers/usb/musb/omap2430.c          |  2 +-
 drivers/usb/musb/tusb6010.c          |  2 +-
 drivers/usb/musb/ux500.c             |  2 +-
 drivers/usb/otg/ab8500-usb.c         |  2 +-
 drivers/usb/otg/fsl_otg.c            |  2 +-
 drivers/usb/otg/msm_otg.c            |  2 +-
 drivers/usb/otg/mxs-phy.c            |  2 +-
 drivers/usb/otg/nop-usb-xceiv.c      |  2 +-
 drivers/usb/phy/omap-usb2.c          |  2 +-
 drivers/usb/phy/rcar-phy.c           |  2 +-
 drivers/usb/renesas_usbhs/common.c   |  2 +-
 58 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/drivers/usb/c67x00/c67x00-drv.c b/drivers/usb/c67x00/c67x00-drv.c
index 21913dfe..fe815ec 100644
--- a/drivers/usb/c67x00/c67x00-drv.c
+++ b/drivers/usb/c67x00/c67x00-drv.c
@@ -191,7 +191,7 @@ static int c67x00_drv_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit c67x00_drv_remove(struct platform_device *pdev)
+static int c67x00_drv_remove(struct platform_device *pdev)
 {
 	struct c67x00_device *c67x00 = platform_get_drvdata(pdev);
 	struct resource *res;
diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index 1269780..8c29122 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -220,7 +220,7 @@ put_np:
 	return ret;
 }
 
-static int __devexit ci13xxx_imx_remove(struct platform_device *pdev)
+static int ci13xxx_imx_remove(struct platform_device *pdev)
 {
 	struct ci13xxx_imx_data *data = platform_get_drvdata(pdev);
 
diff --git a/drivers/usb/chipidea/ci13xxx_msm.c b/drivers/usb/chipidea/ci13xxx_msm.c
index e8a8ba3..7d16681 100644
--- a/drivers/usb/chipidea/ci13xxx_msm.c
+++ b/drivers/usb/chipidea/ci13xxx_msm.c
@@ -77,7 +77,7 @@ static int ci13xxx_msm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit ci13xxx_msm_remove(struct platform_device *pdev)
+static int ci13xxx_msm_remove(struct platform_device *pdev)
 {
 	struct platform_device *plat_ci = platform_get_drvdata(pdev);
 
diff --git a/drivers/usb/chipidea/ci13xxx_pci.c b/drivers/usb/chipidea/ci13xxx_pci.c
index cb7eb3e..9b227e3 100644
--- a/drivers/usb/chipidea/ci13xxx_pci.c
+++ b/drivers/usb/chipidea/ci13xxx_pci.c
@@ -107,7 +107,7 @@ static int ci13xxx_pci_probe(struct pci_dev *pdev,
  * first invoking the udc_remove() and then releases
  * all PCI resources allocated for this USB device controller
  */
-static void __devexit ci13xxx_pci_remove(struct pci_dev *pdev)
+static void ci13xxx_pci_remove(struct pci_dev *pdev)
 {
 	struct platform_device *plat_ci = pci_get_drvdata(pdev);
 
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 7f9c0d2..5a4a5eca 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -508,7 +508,7 @@ rm_wq:
 	return ret;
 }
 
-static int __devexit ci_hdrc_remove(struct platform_device *pdev)
+static int ci_hdrc_remove(struct platform_device *pdev)
 {
 	struct ci13xxx *ci = platform_get_drvdata(pdev);
 
diff --git a/drivers/usb/chipidea/usbmisc_imx6q.c b/drivers/usb/chipidea/usbmisc_imx6q.c
index ee6fa87..845efe2 100644
--- a/drivers/usb/chipidea/usbmisc_imx6q.c
+++ b/drivers/usb/chipidea/usbmisc_imx6q.c
@@ -127,7 +127,7 @@ static int usbmisc_imx6q_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit usbmisc_imx6q_remove(struct platform_device *pdev)
+static int usbmisc_imx6q_remove(struct platform_device *pdev)
 {
 	usbmisc_unset_ops(&imx6q_usbmisc_ops);
 	clk_disable_unprepare(usbmisc->clk);
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8dceb83..b033c71 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -547,7 +547,7 @@ err0:
 	return ret;
 }
 
-static int __devexit dwc3_remove(struct platform_device *pdev)
+static int dwc3_remove(struct platform_device *pdev)
 {
 	struct dwc3	*dwc = platform_get_drvdata(pdev);
 	struct resource	*res;
diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
index 33ae98c5..92604b4 100644
--- a/drivers/usb/dwc3/debugfs.c
+++ b/drivers/usb/dwc3/debugfs.c
@@ -703,7 +703,7 @@ err0:
 	return ret;
 }
 
-void __devexit dwc3_debugfs_exit(struct dwc3 *dwc)
+void dwc3_debugfs_exit(struct dwc3 *dwc)
 {
 	debugfs_remove_recursive(dwc->root);
 	dwc->root = NULL;
diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index d43f076..aae5328 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -170,7 +170,7 @@ err0:
 	return ret;
 }
 
-static int __devexit dwc3_exynos_remove(struct platform_device *pdev)
+static int dwc3_exynos_remove(struct platform_device *pdev)
 {
 	struct dwc3_exynos	*exynos = platform_get_drvdata(pdev);
 
diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index e114bb5..f31867f 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -421,7 +421,7 @@ err2:
 	return ret;
 }
 
-static int __devexit dwc3_omap_remove(struct platform_device *pdev)
+static int dwc3_omap_remove(struct platform_device *pdev)
 {
 	struct dwc3_omap	*omap = platform_get_drvdata(pdev);
 
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 68e389b..7d70f44 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -194,7 +194,7 @@ err1:
 	return ret;
 }
 
-static void __devexit dwc3_pci_remove(struct pci_dev *pci)
+static void dwc3_pci_remove(struct pci_dev *pci)
 {
 	struct dwc3_pci	*glue = pci_get_drvdata(pci);
 
diff --git a/drivers/usb/gadget/bcm63xx_udc.c b/drivers/usb/gadget/bcm63xx_udc.c
index 18eff74..47a4993 100644
--- a/drivers/usb/gadget/bcm63xx_udc.c
+++ b/drivers/usb/gadget/bcm63xx_udc.c
@@ -2433,7 +2433,7 @@ out_uninit:
  * bcm63xx_udc_remove - Remove the device from the system.
  * @pdev: Platform device struct from the bcm63xx BSP code.
  */
-static int __devexit bcm63xx_udc_remove(struct platform_device *pdev)
+static int bcm63xx_udc_remove(struct platform_device *pdev)
 {
 	struct bcm63xx_udc *udc = platform_get_drvdata(pdev);
 
diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index b13bc73..ec50f18 100644
--- a/drivers/usb/gadget/fsl_qe_udc.c
+++ b/drivers/usb/gadget/fsl_qe_udc.c
@@ -2651,7 +2651,7 @@ static int qe_udc_resume(struct platform_device *dev)
 }
 #endif
 
-static int __devexit qe_udc_remove(struct platform_device *ofdev)
+static int qe_udc_remove(struct platform_device *ofdev)
 {
 	struct qe_udc *udc = dev_get_drvdata(&ofdev->dev);
 	struct qe_ep *ep;
diff --git a/drivers/usb/gadget/hid.c b/drivers/usb/gadget/hid.c
index 33deed6..c36260ea 100644
--- a/drivers/usb/gadget/hid.c
+++ b/drivers/usb/gadget/hid.c
@@ -203,7 +203,7 @@ static int __init hidg_plat_driver_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit hidg_plat_driver_remove(struct platform_device *pdev)
+static int hidg_plat_driver_remove(struct platform_device *pdev)
 {
 	struct hidg_func_node *e, *n;
 
diff --git a/drivers/usb/gadget/lpc32xx_udc.c b/drivers/usb/gadget/lpc32xx_udc.c
index 52ad15c..dd1c9b1 100644
--- a/drivers/usb/gadget/lpc32xx_udc.c
+++ b/drivers/usb/gadget/lpc32xx_udc.c
@@ -3352,7 +3352,7 @@ phy_fail:
 	return retval;
 }
 
-static int __devexit lpc32xx_udc_remove(struct platform_device *pdev)
+static int lpc32xx_udc_remove(struct platform_device *pdev)
 {
 	struct lpc32xx_udc *udc = platform_get_drvdata(pdev);
 
diff --git a/drivers/usb/gadget/mv_u3d_core.c b/drivers/usb/gadget/mv_u3d_core.c
index 8cfd5b0..b5cea27 100644
--- a/drivers/usb/gadget/mv_u3d_core.c
+++ b/drivers/usb/gadget/mv_u3d_core.c
@@ -1763,7 +1763,7 @@ static void mv_u3d_gadget_release(struct device *dev)
 	dev_dbg(dev, "%s\n", __func__);
 }
 
-static __devexit int mv_u3d_remove(struct platform_device *dev)
+static int mv_u3d_remove(struct platform_device *dev)
 {
 	struct mv_u3d *u3d = platform_get_drvdata(dev);
 
diff --git a/drivers/usb/gadget/mv_udc_core.c b/drivers/usb/gadget/mv_udc_core.c
index 2419649..379aac7 100644
--- a/drivers/usb/gadget/mv_udc_core.c
+++ b/drivers/usb/gadget/mv_udc_core.c
@@ -2128,7 +2128,7 @@ static void gadget_release(struct device *_dev)
 	complete(udc->done);
 }
 
-static int __devexit mv_udc_remove(struct platform_device *dev)
+static int mv_udc_remove(struct platform_device *dev)
 {
 	struct mv_udc *udc = the_controller;
 	int clk_i;
diff --git a/drivers/usb/gadget/net2272.c b/drivers/usb/gadget/net2272.c
index a20acc1..d226058 100644
--- a/drivers/usb/gadget/net2272.c
+++ b/drivers/usb/gadget/net2272.c
@@ -2193,7 +2193,7 @@ net2272_gadget_release(struct device *_dev)
 
 /*---------------------------------------------------------------------------*/
 
-static void __devexit
+static void
 net2272_remove(struct net2272 *dev)
 {
 	usb_del_gadget_udc(&dev->gadget);
@@ -2488,7 +2488,7 @@ net2272_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ret;
 }
 
-static void __devexit
+static void
 net2272_rdk1_remove(struct pci_dev *pdev, struct net2272 *dev)
 {
 	int i;
@@ -2510,7 +2510,7 @@ net2272_rdk1_remove(struct pci_dev *pdev, struct net2272 *dev)
 	}
 }
 
-static void __devexit
+static void
 net2272_rdk2_remove(struct pci_dev *pdev, struct net2272 *dev)
 {
 	int i;
@@ -2529,7 +2529,7 @@ net2272_rdk2_remove(struct pci_dev *pdev, struct net2272 *dev)
 			pci_resource_len(pdev, i));
 }
 
-static void __devexit
+static void
 net2272_pci_remove(struct pci_dev *pdev)
 {
 	struct net2272 *dev = pci_get_drvdata(pdev);
@@ -2660,7 +2660,7 @@ net2272_plat_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit
+static int
 net2272_plat_remove(struct platform_device *pdev)
 {
 	struct net2272 *dev = platform_get_drvdata(pdev);
diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index 164526f..09699f6 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -2976,7 +2976,7 @@ cleanup0:
 	return status;
 }
 
-static int __devexit omap_udc_remove(struct platform_device *pdev)
+static int omap_udc_remove(struct platform_device *pdev)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
 
diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index 6fdb1bd..141971d 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -3460,7 +3460,7 @@ static void s3c_hsotg_create_debug(struct s3c_hsotg *hsotg)
  *
  * Cleanup (remove) the debugfs files for use on module exit.
  */
-static void __devexit s3c_hsotg_delete_debug(struct s3c_hsotg *hsotg)
+static void s3c_hsotg_delete_debug(struct s3c_hsotg *hsotg)
 {
 	unsigned epidx;
 
@@ -3675,7 +3675,7 @@ err_clk:
  * s3c_hsotg_remove - remove function for hsotg driver
  * @pdev: The platform information for the driver
  */
-static int __devexit s3c_hsotg_remove(struct platform_device *pdev)
+static int s3c_hsotg_remove(struct platform_device *pdev)
 {
 	struct s3c_hsotg *hsotg = platform_get_drvdata(pdev);
 
diff --git a/drivers/usb/host/bcma-hcd.c b/drivers/usb/host/bcma-hcd.c
index 649780b..df13d42 100644
--- a/drivers/usb/host/bcma-hcd.c
+++ b/drivers/usb/host/bcma-hcd.c
@@ -265,7 +265,7 @@ err_free_usb_dev:
 	return err;
 }
 
-static void __devexit bcma_hcd_remove(struct bcma_device *dev)
+static void bcma_hcd_remove(struct bcma_device *dev)
 {
 	struct bcma_hcd_device *usb_dev = bcma_get_drvdata(dev);
 	struct platform_device *ohci_dev = usb_dev->ohci_dev;
diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index 96bf00d..27639487 100644
--- a/drivers/usb/host/ehci-atmel.c
+++ b/drivers/usb/host/ehci-atmel.c
@@ -182,7 +182,7 @@ fail_create_hcd:
 	return retval;
 }
 
-static int __devexit ehci_atmel_drv_remove(struct platform_device *pdev)
+static int ehci_atmel_drv_remove(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 
diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
index e0acfd5..88a49c8 100644
--- a/drivers/usb/host/ehci-msm.c
+++ b/drivers/usb/host/ehci-msm.c
@@ -173,7 +173,7 @@ put_hcd:
 	return ret;
 }
 
-static int __devexit ehci_msm_remove(struct platform_device *pdev)
+static int ehci_msm_remove(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 615cba0..58fa0c9 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -126,7 +126,7 @@ err_power:
 	return err;
 }
 
-static int __devexit ehci_platform_remove(struct platform_device *dev)
+static int ehci_platform_remove(struct platform_device *dev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(dev);
 	struct usb_ehci_pdata *pdata = dev->dev.platform_data;
diff --git a/drivers/usb/host/ehci-s5p.c b/drivers/usb/host/ehci-s5p.c
index 2cf19d1..319dcfa 100644
--- a/drivers/usb/host/ehci-s5p.c
+++ b/drivers/usb/host/ehci-s5p.c
@@ -189,7 +189,7 @@ fail_clk:
 	return err;
 }
 
-static int __devexit s5p_ehci_remove(struct platform_device *pdev)
+static int s5p_ehci_remove(struct platform_device *pdev)
 {
 	struct s5p_ehci_platdata *pdata = pdev->dev.platform_data;
 	struct s5p_ehci_hcd *s5p_ehci = platform_get_drvdata(pdev);
diff --git a/drivers/usb/host/ehci-w90x900.c b/drivers/usb/host/ehci-w90x900.c
index bf8d462..59e0e24 100644
--- a/drivers/usb/host/ehci-w90x900.c
+++ b/drivers/usb/host/ehci-w90x900.c
@@ -155,7 +155,7 @@ static int ehci_w90x900_probe(struct platform_device *pdev)
 	return usb_w90x900_probe(&ehci_w90x900_hc_driver, pdev);
 }
 
-static int __devexit ehci_w90x900_remove(struct platform_device *pdev)
+static int ehci_w90x900_remove(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 
diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
index 618f143..0b4654259 100644
--- a/drivers/usb/host/fhci-hcd.c
+++ b/drivers/usb/host/fhci-hcd.c
@@ -780,7 +780,7 @@ err_regs:
 	return ret;
 }
 
-static int __devexit fhci_remove(struct device *dev)
+static int fhci_remove(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct fhci_hcd *fhci = hcd_to_fhci(hcd);
@@ -803,7 +803,7 @@ static int __devexit fhci_remove(struct device *dev)
 	return 0;
 }
 
-static int __devexit of_fhci_remove(struct platform_device *ofdev)
+static int of_fhci_remove(struct platform_device *ofdev)
 {
 	return fhci_remove(&ofdev->dev);
 }
diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
index 5faf796..5105127 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -224,13 +224,13 @@ static int fsl_usb2_mph_dr_of_probe(struct platform_device *ofdev)
 	return 0;
 }
 
-static int __devexit __unregister_subdev(struct device *dev, void *d)
+static int __unregister_subdev(struct device *dev, void *d)
 {
 	platform_device_unregister(to_platform_device(dev));
 	return 0;
 }
 
-static int __devexit fsl_usb2_mph_dr_of_remove(struct platform_device *ofdev)
+static int fsl_usb2_mph_dr_of_remove(struct platform_device *ofdev)
 {
 	device_for_each_child(&ofdev->dev, NULL, __unregister_subdev);
 	return 0;
diff --git a/drivers/usb/host/isp1362-hcd.c b/drivers/usb/host/isp1362-hcd.c
index 5f8b63c..974480c 100644
--- a/drivers/usb/host/isp1362-hcd.c
+++ b/drivers/usb/host/isp1362-hcd.c
@@ -2645,7 +2645,7 @@ static struct hc_driver isp1362_hc_driver = {
 
 /*-------------------------------------------------------------------------*/
 
-static int __devexit isp1362_remove(struct platform_device *pdev)
+static int isp1362_remove(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 	struct isp1362_hcd *isp1362_hcd = hcd_to_isp1362_hcd(hcd);
diff --git a/drivers/usb/host/isp1760-if.c b/drivers/usb/host/isp1760-if.c
index d752a4c..bbb791b 100644
--- a/drivers/usb/host/isp1760-if.c
+++ b/drivers/usb/host/isp1760-if.c
@@ -413,7 +413,7 @@ out:
 	return ret;
 }
 
-static int __devexit isp1760_plat_remove(struct platform_device *pdev)
+static int isp1760_plat_remove(struct platform_device *pdev)
 {
 	struct resource *mem_res;
 	resource_size_t mem_size;
diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 0518348..a0cb44f 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -94,7 +94,7 @@ static void at91_stop_hc(struct platform_device *pdev)
 
 /*-------------------------------------------------------------------------*/
 
-static void __devexit usb_hcd_at91_remove (struct usb_hcd *, struct platform_device *);
+static void usb_hcd_at91_remove (struct usb_hcd *, struct platform_device *);
 
 /* configure so an HC device and id are always provided */
 /* always called with process context; sleeping is OK */
@@ -203,7 +203,7 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
  * context, "rmmod" or something similar.
  *
  */
-static void __devexit usb_hcd_at91_remove(struct usb_hcd *hcd,
+static void usb_hcd_at91_remove(struct usb_hcd *hcd,
 				struct platform_device *pdev)
 {
 	usb_remove_hcd(hcd);
@@ -641,7 +641,7 @@ static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
 	return usb_hcd_at91_probe(&ohci_at91_hc_driver, pdev);
 }
 
-static int __devexit ohci_hcd_at91_drv_remove(struct platform_device *pdev)
+static int ohci_hcd_at91_drv_remove(struct platform_device *pdev)
 {
 	struct at91_usbh_data	*pdata = pdev->dev.platform_data;
 	int			i;
diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index 1288cdb..aa3b884 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -175,7 +175,7 @@ fail_clk:
 	return err;
 }
 
-static int __devexit exynos_ohci_remove(struct platform_device *pdev)
+static int exynos_ohci_remove(struct platform_device *pdev)
 {
 	struct exynos4_ohci_platdata *pdata = pdev->dev.platform_data;
 	struct exynos_ohci_hcd *exynos_ohci = platform_get_drvdata(pdev);
diff --git a/drivers/usb/host/ohci-jz4740.c b/drivers/usb/host/ohci-jz4740.c
index 59feb87..8062bb9 100644
--- a/drivers/usb/host/ohci-jz4740.c
+++ b/drivers/usb/host/ohci-jz4740.c
@@ -239,7 +239,7 @@ err_free:
 	return ret;
 }
 
-static __devexit int jz4740_ohci_remove(struct platform_device *pdev)
+static int jz4740_ohci_remove(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 	struct jz4740_ohci_hcd *jz4740_ohci = hcd_to_jz4740_hcd(hcd);
diff --git a/drivers/usb/host/ohci-omap3.c b/drivers/usb/host/ohci-omap3.c
index 41382fc..eb35d96 100644
--- a/drivers/usb/host/ohci-omap3.c
+++ b/drivers/usb/host/ohci-omap3.c
@@ -208,7 +208,7 @@ err_io:
  * the HCD's stop() method.  It is always called from a thread
  * context, normally "rmmod", "apmd", or something similar.
  */
-static int __devexit ohci_hcd_omap3_remove(struct platform_device *pdev)
+static int ohci_hcd_omap3_remove(struct platform_device *pdev)
 {
 	struct device *dev	= &pdev->dev;
 	struct usb_hcd *hcd	= dev_get_drvdata(dev);
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index c3f76fa..084503b 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -149,7 +149,7 @@ err_power:
 	return err;
 }
 
-static int __devexit ohci_platform_remove(struct platform_device *dev)
+static int ohci_platform_remove(struct platform_device *dev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(dev);
 	struct usb_ohci_pdata *pdata = dev->dev.platform_data;
diff --git a/drivers/usb/host/ohci-s3c2410.c b/drivers/usb/host/ohci-s3c2410.c
index 4f29e0b..ad0f552 100644
--- a/drivers/usb/host/ohci-s3c2410.c
+++ b/drivers/usb/host/ohci-s3c2410.c
@@ -463,7 +463,7 @@ static int ohci_hcd_s3c2410_drv_probe(struct platform_device *pdev)
 	return usb_hcd_s3c2410_probe(&ohci_s3c2410_hc_driver, pdev);
 }
 
-static int __devexit ohci_hcd_s3c2410_drv_remove(struct platform_device *pdev)
+static int ohci_hcd_s3c2410_drv_remove(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 
diff --git a/drivers/usb/host/ohci-tmio.c b/drivers/usb/host/ohci-tmio.c
index 5996a3b..d370245 100644
--- a/drivers/usb/host/ohci-tmio.c
+++ b/drivers/usb/host/ohci-tmio.c
@@ -271,7 +271,7 @@ err_usb_create_hcd:
 	return ret;
 }
 
-static int __devexit ohci_hcd_tmio_drv_remove(struct platform_device *dev)
+static int ohci_hcd_tmio_drv_remove(struct platform_device *dev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(dev);
 	struct tmio_hcd *tmio = hcd_to_tmio(hcd);
diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index e97dfad..a6fd8f53 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -2391,7 +2391,7 @@ static const struct dev_pm_ops r8a66597_dev_pm_ops = {
 #define R8A66597_DEV_PM_OPS	NULL
 #endif
 
-static int __devexit r8a66597_remove(struct platform_device *pdev)
+static int r8a66597_remove(struct platform_device *pdev)
 {
 	struct r8a66597		*r8a66597 = dev_get_drvdata(&pdev->dev);
 	struct usb_hcd		*hcd = r8a66597_to_hcd(r8a66597);
diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index 782127d..d62f040 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -1595,7 +1595,7 @@ static struct hc_driver sl811h_hc_driver = {
 
 /*-------------------------------------------------------------------------*/
 
-static int __devexit
+static int
 sl811h_remove(struct platform_device *dev)
 {
 	struct usb_hcd		*hcd = platform_get_drvdata(dev);
diff --git a/drivers/usb/host/ssb-hcd.c b/drivers/usb/host/ssb-hcd.c
index bdb9d70..74af2c6 100644
--- a/drivers/usb/host/ssb-hcd.c
+++ b/drivers/usb/host/ssb-hcd.c
@@ -206,7 +206,7 @@ err_free_usb_dev:
 	return err;
 }
 
-static void __devexit ssb_hcd_remove(struct ssb_device *dev)
+static void ssb_hcd_remove(struct ssb_device *dev)
 {
 	struct ssb_hcd_device *usb_dev = ssb_get_drvdata(dev);
 	struct platform_device *ohci_dev = usb_dev->ohci_dev;
@@ -220,7 +220,7 @@ static void __devexit ssb_hcd_remove(struct ssb_device *dev)
 	ssb_device_disable(dev, 0);
 }
 
-static void __devexit ssb_hcd_shutdown(struct ssb_device *dev)
+static void ssb_hcd_shutdown(struct ssb_device *dev)
 {
 	ssb_device_disable(dev, 0);
 }
diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
index 8bf78e6..5efdffe 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -2990,7 +2990,7 @@ static struct hc_driver u132_hc_driver = {
 * synchronously - but instead should immediately stop activity to the
 * device and asynchronously call usb_remove_hcd()
 */
-static int __devexit u132_remove(struct platform_device *pdev)
+static int u132_remove(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 	if (hcd) {
diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 2363819..c107d7c 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -559,7 +559,7 @@ err0:
 	return ret;
 }
 
-static int __devexit am35x_remove(struct platform_device *pdev)
+static int am35x_remove(struct platform_device *pdev)
 {
 	struct am35x_glue	*glue = platform_get_drvdata(pdev);
 
diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index 12beb0e..14dab9f 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -510,7 +510,7 @@ err0:
 	return ret;
 }
 
-static int __devexit bfin_remove(struct platform_device *pdev)
+static int bfin_remove(struct platform_device *pdev)
 {
 	struct bfin_glue		*glue = platform_get_drvdata(pdev);
 
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index c4fb235..97996af 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -555,7 +555,7 @@ err0:
 	return ret;
 }
 
-static int __devexit da8xx_remove(struct platform_device *pdev)
+static int da8xx_remove(struct platform_device *pdev)
 {
 	struct da8xx_glue		*glue = platform_get_drvdata(pdev);
 
diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index 8877c1a..b1c01ca 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -587,7 +587,7 @@ err0:
 	return ret;
 }
 
-static int __devexit davinci_remove(struct platform_device *pdev)
+static int davinci_remove(struct platform_device *pdev)
 {
 	struct davinci_glue		*glue = platform_get_drvdata(pdev);
 
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index a332bb8..57cc9c6 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2034,7 +2034,7 @@ static int musb_probe(struct platform_device *pdev)
 	return status;
 }
 
-static int __devexit musb_remove(struct platform_device *pdev)
+static int musb_remove(struct platform_device *pdev)
 {
 	struct device	*dev = &pdev->dev;
 	struct musb	*musb = dev_to_musb(dev);
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 3377be8..e6f2ae8 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -667,7 +667,7 @@ err1:
 err0:
 	return ret;
 }
-static int __devexit dsps_remove(struct platform_device *pdev)
+static int dsps_remove(struct platform_device *pdev)
 {
 	struct dsps_glue *glue = platform_get_drvdata(pdev);
 	const struct dsps_musb_wrapper *wrp = glue->wrp;
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 06850f2..da00af4 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -605,7 +605,7 @@ err0:
 	return ret;
 }
 
-static int __devexit omap2430_remove(struct platform_device *pdev)
+static int omap2430_remove(struct platform_device *pdev)
 {
 	struct omap2430_glue		*glue = platform_get_drvdata(pdev);
 
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index a03b7be..8bde6fc 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -1215,7 +1215,7 @@ err0:
 	return ret;
 }
 
-static int __devexit tusb_remove(struct platform_device *pdev)
+static int tusb_remove(struct platform_device *pdev)
 {
 	struct tusb6010_glue		*glue = platform_get_drvdata(pdev);
 
diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
index 6b12001..a27ca1a 100644
--- a/drivers/usb/musb/ux500.c
+++ b/drivers/usb/musb/ux500.c
@@ -163,7 +163,7 @@ err0:
 	return ret;
 }
 
-static int __devexit ux500_remove(struct platform_device *pdev)
+static int ux500_remove(struct platform_device *pdev)
 {
 	struct ux500_glue	*glue = platform_get_drvdata(pdev);
 
diff --git a/drivers/usb/otg/ab8500-usb.c b/drivers/usb/otg/ab8500-usb.c
index f0ba931..2d86f26 100644
--- a/drivers/usb/otg/ab8500-usb.c
+++ b/drivers/usb/otg/ab8500-usb.c
@@ -546,7 +546,7 @@ fail0:
 	return err;
 }
 
-static int __devexit ab8500_usb_remove(struct platform_device *pdev)
+static int ab8500_usb_remove(struct platform_device *pdev)
 {
 	struct ab8500_usb *ab = platform_get_drvdata(pdev);
 
diff --git a/drivers/usb/otg/fsl_otg.c b/drivers/usb/otg/fsl_otg.c
index 2b9a838..d16adb4 100644
--- a/drivers/usb/otg/fsl_otg.c
+++ b/drivers/usb/otg/fsl_otg.c
@@ -1144,7 +1144,7 @@ static int fsl_otg_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit fsl_otg_remove(struct platform_device *pdev)
+static int fsl_otg_remove(struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
 
diff --git a/drivers/usb/otg/msm_otg.c b/drivers/usb/otg/msm_otg.c
index eef0dd2..3b9f0d9 100644
--- a/drivers/usb/otg/msm_otg.c
+++ b/drivers/usb/otg/msm_otg.c
@@ -1606,7 +1606,7 @@ free_motg:
 	return ret;
 }
 
-static int __devexit msm_otg_remove(struct platform_device *pdev)
+static int msm_otg_remove(struct platform_device *pdev)
 {
 	struct msm_otg *motg = platform_get_drvdata(pdev);
 	struct usb_phy *phy = &motg->phy;
diff --git a/drivers/usb/otg/mxs-phy.c b/drivers/usb/otg/mxs-phy.c
index 825d860..965c8e1 100644
--- a/drivers/usb/otg/mxs-phy.c
+++ b/drivers/usb/otg/mxs-phy.c
@@ -176,7 +176,7 @@ static int mxs_phy_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit mxs_phy_remove(struct platform_device *pdev)
+static int mxs_phy_remove(struct platform_device *pdev)
 {
 	platform_set_drvdata(pdev, NULL);
 
diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
index 28f70e2..a3ce24b 100644
--- a/drivers/usb/otg/nop-usb-xceiv.c
+++ b/drivers/usb/otg/nop-usb-xceiv.c
@@ -141,7 +141,7 @@ exit:
 	return err;
 }
 
-static int __devexit nop_usb_xceiv_remove(struct platform_device *pdev)
+static int nop_usb_xceiv_remove(struct platform_device *pdev)
 {
 	struct nop_usb_xceiv *nop = platform_get_drvdata(pdev);
 
diff --git a/drivers/usb/phy/omap-usb2.c b/drivers/usb/phy/omap-usb2.c
index c10fb8b..26ae8f4 100644
--- a/drivers/usb/phy/omap-usb2.c
+++ b/drivers/usb/phy/omap-usb2.c
@@ -199,7 +199,7 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit omap_usb2_remove(struct platform_device *pdev)
+static int omap_usb2_remove(struct platform_device *pdev)
 {
 	struct omap_usb	*phy = platform_get_drvdata(pdev);
 
diff --git a/drivers/usb/phy/rcar-phy.c b/drivers/usb/phy/rcar-phy.c
index 84ac2a7..a35681b 100644
--- a/drivers/usb/phy/rcar-phy.c
+++ b/drivers/usb/phy/rcar-phy.c
@@ -196,7 +196,7 @@ static int rcar_usb_phy_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit rcar_usb_phy_remove(struct platform_device *pdev)
+static int rcar_usb_phy_remove(struct platform_device *pdev)
 {
 	struct rcar_usb_phy_priv *priv = platform_get_drvdata(pdev);
 
diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 2aa7c1a..38bce04 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -556,7 +556,7 @@ probe_end_pipe_exit:
 	return ret;
 }
 
-static int __devexit usbhs_remove(struct platform_device *pdev)
+static int usbhs_remove(struct platform_device *pdev)
 {
 	struct usbhs_priv *priv = usbhs_pdev_to_priv(pdev);
 	struct renesas_usbhs_platform_info *info = pdev->dev.platform_data;
-- 
1.8.0
