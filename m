Return-Path: <wfp5p@viridian.itc.virginia.edu>
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 159/493] usb: remove use of __devinit
Date: Mon, 19 Nov 2012 13:21:48 -0500
Message-Id: <1353349642-3677-159-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: cbe-oss-dev@lists.ozlabs.org, Kukjin Kim <kgene.kim@samsung.com>,
 Wan ZongShun <mcuos.com@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 Felipe Balbi <balbi@ti.com>, Geoff Levand <geoff@infradead.org>,
 linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 Alan Stern <stern@rowland.harvard.edu>, Ben Dooks <ben-linux@fluff.org>,
 Olav Kongas <ok@artecdesign.ee>, Lennert Buytenhek <kernel@wantstofly.org>,
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
Cc: Peter Korsgaard <jacmet@sunsite.dk> 
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com> 
Cc: Felipe Balbi <balbi@ti.com> 
Cc: Li Yang <leoli@freescale.com> 
Cc: Alan Stern <stern@rowland.harvard.edu> 
Cc: Geoff Levand <geoff@infradead.org> 
Cc: Wan ZongShun <mcuos.com@gmail.com> 
Cc: Olav Kongas <ok@artecdesign.ee> 
Cc: Lennert Buytenhek <kernel@wantstofly.org> 
Cc: Ben Dooks <ben-linux@fluff.org> 
Cc: Kukjin Kim <kgene.kim@samsung.com> 
Cc: linux-usb@vger.kernel.org 
Cc: linux-omap@vger.kernel.org 
Cc: linuxppc-dev@lists.ozlabs.org 
Cc: cbe-oss-dev@lists.ozlabs.org 
Cc: linux-arm-kernel@lists.infradead.org 
Cc: linux-samsung-soc@vger.kernel.org 
---
 drivers/usb/c67x00/c67x00-drv.c      |  2 +-
 drivers/usb/chipidea/ci13xxx_imx.c   |  2 +-
 drivers/usb/chipidea/ci13xxx_msm.c   |  2 +-
 drivers/usb/chipidea/ci13xxx_pci.c   |  2 +-
 drivers/usb/chipidea/core.c          |  2 +-
 drivers/usb/chipidea/usbmisc_imx6q.c |  2 +-
 drivers/usb/dwc3/core.c              | 11 +++++------
 drivers/usb/dwc3/debugfs.c           |  2 +-
 drivers/usb/dwc3/dwc3-exynos.c       |  4 ++--
 drivers/usb/dwc3/dwc3-omap.c         |  4 ++--
 drivers/usb/dwc3/dwc3-pci.c          |  4 ++--
 drivers/usb/dwc3/gadget.c            |  4 ++--
 drivers/usb/gadget/at91_udc.c        |  4 ++--
 drivers/usb/gadget/bcm63xx_udc.c     |  2 +-
 drivers/usb/gadget/f_uac2.c          |  2 +-
 drivers/usb/gadget/fsl_qe_udc.c      |  8 ++++----
 drivers/usb/gadget/mv_udc_core.c     |  2 +-
 drivers/usb/gadget/net2272.c         | 13 ++++++-------
 drivers/usb/gadget/omap_udc.c        |  6 +++---
 drivers/usb/gadget/s3c-hsotg.c       |  6 +++---
 drivers/usb/gadget/s3c-hsudc.c       |  2 +-
 drivers/usb/host/bcma-hcd.c          |  9 ++++-----
 drivers/usb/host/ehci-atmel.c        |  2 +-
 drivers/usb/host/ehci-grlib.c        |  2 +-
 drivers/usb/host/ehci-orion.c        |  4 ++--
 drivers/usb/host/ehci-platform.c     |  2 +-
 drivers/usb/host/ehci-ppc-of.c       |  4 ++--
 drivers/usb/host/ehci-ps3.c          |  2 +-
 drivers/usb/host/ehci-s5p.c          |  2 +-
 drivers/usb/host/ehci-w90x900.c      |  4 ++--
 drivers/usb/host/ehci-xilinx-of.c    |  2 +-
 drivers/usb/host/fhci-hcd.c          |  2 +-
 drivers/usb/host/fsl-mph-dr-of.c     |  8 ++++----
 drivers/usb/host/imx21-hcd.c         |  2 +-
 drivers/usb/host/isp116x-hcd.c       |  2 +-
 drivers/usb/host/isp1362-hcd.c       |  2 +-
 drivers/usb/host/isp1760-if.c        |  4 ++--
 drivers/usb/host/ohci-at91.c         | 12 ++++++------
 drivers/usb/host/ohci-ep93xx.c       |  2 +-
 drivers/usb/host/ohci-exynos.c       |  2 +-
 drivers/usb/host/ohci-jz4740.c       |  2 +-
 drivers/usb/host/ohci-nxp.c          |  4 ++--
 drivers/usb/host/ohci-octeon.c       |  2 +-
 drivers/usb/host/ohci-omap3.c        |  2 +-
 drivers/usb/host/ohci-pci.c          |  2 +-
 drivers/usb/host/ohci-platform.c     |  2 +-
 drivers/usb/host/ohci-ppc-of.c       |  4 ++--
 drivers/usb/host/ohci-ps3.c          |  4 ++--
 drivers/usb/host/ohci-pxa27x.c       |  6 +++---
 drivers/usb/host/ohci-s3c2410.c      |  2 +-
 drivers/usb/host/ohci-sa1111.c       |  2 +-
 drivers/usb/host/ohci-spear.c        |  2 +-
 drivers/usb/host/ohci-tmio.c         |  2 +-
 drivers/usb/host/pci-quirks.c        | 14 +++++++-------
 drivers/usb/host/r8a66597-hcd.c      |  2 +-
 drivers/usb/host/sl811-hcd.c         |  2 +-
 drivers/usb/host/ssb-hcd.c           | 11 +++++------
 drivers/usb/host/u132-hcd.c          |  2 +-
 drivers/usb/host/uhci-grlib.c        |  2 +-
 drivers/usb/host/uhci-platform.c     |  2 +-
 drivers/usb/musb/am35x.c             |  2 +-
 drivers/usb/musb/blackfin.c          |  2 +-
 drivers/usb/musb/cppi_dma.c          |  3 +--
 drivers/usb/musb/da8xx.c             |  2 +-
 drivers/usb/musb/davinci.c           |  2 +-
 drivers/usb/musb/musb_core.c         | 15 +++++++--------
 drivers/usb/musb/musb_debugfs.c      |  2 +-
 drivers/usb/musb/musb_dma.h          |  3 +--
 drivers/usb/musb/musb_dsps.c         |  4 ++--
 drivers/usb/musb/musb_gadget.c       |  6 +++---
 drivers/usb/musb/musbhsdma.c         |  3 +--
 drivers/usb/musb/omap2430.c          |  2 +-
 drivers/usb/musb/tusb6010.c          |  2 +-
 drivers/usb/musb/tusb6010_omap.c     |  3 +--
 drivers/usb/musb/ux500.c             |  2 +-
 drivers/usb/musb/ux500_dma.c         |  3 +--
 drivers/usb/otg/ab8500-usb.c         |  2 +-
 drivers/usb/otg/fsl_otg.c            |  2 +-
 drivers/usb/otg/isp1301_omap.c       |  2 +-
 drivers/usb/otg/nop-usb-xceiv.c      |  2 +-
 drivers/usb/otg/twl4030-usb.c        |  2 +-
 drivers/usb/otg/twl6030-usb.c        |  2 +-
 drivers/usb/phy/mv_u3d_phy.c         |  2 +-
 drivers/usb/phy/omap-usb2.c          |  2 +-
 drivers/usb/phy/rcar-phy.c           |  2 +-
 85 files changed, 145 insertions(+), 155 deletions(-)

diff --git a/drivers/usb/c67x00/c67x00-drv.c b/drivers/usb/c67x00/c67x00-drv.c
index 855d538..21913dfe 100644
--- a/drivers/usb/c67x00/c67x00-drv.c
+++ b/drivers/usb/c67x00/c67x00-drv.c
@@ -116,7 +116,7 @@ static irqreturn_t c67x00_irq(int irq, void *__dev)
 
 /* ------------------------------------------------------------------------- */
 
-static int __devinit c67x00_drv_probe(struct platform_device *pdev)
+static int c67x00_drv_probe(struct platform_device *pdev)
 {
 	struct c67x00_device *c67x00;
 	struct c67x00_platform_data *pdata;
diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index 5659730..424bff9 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -93,7 +93,7 @@ static struct ci13xxx_platform_data ci13xxx_imx_platdata __devinitdata  = {
 	.capoffset		= DEF_CAPOFFSET,
 };
 
-static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
+static int ci13xxx_imx_probe(struct platform_device *pdev)
 {
 	struct ci13xxx_imx_data *data;
 	struct platform_device *plat_ci, *phy_pdev;
diff --git a/drivers/usb/chipidea/ci13xxx_msm.c b/drivers/usb/chipidea/ci13xxx_msm.c
index 406c5af..e8a8ba3 100644
--- a/drivers/usb/chipidea/ci13xxx_msm.c
+++ b/drivers/usb/chipidea/ci13xxx_msm.c
@@ -55,7 +55,7 @@ static struct ci13xxx_platform_data ci13xxx_msm_platdata = {
 	.notify_event		= ci13xxx_msm_notify_event,
 };
 
-static int __devinit ci13xxx_msm_probe(struct platform_device *pdev)
+static int ci13xxx_msm_probe(struct platform_device *pdev)
 {
 	struct platform_device *plat_ci;
 
diff --git a/drivers/usb/chipidea/ci13xxx_pci.c b/drivers/usb/chipidea/ci13xxx_pci.c
index e1cb2fb..cb7eb3e 100644
--- a/drivers/usb/chipidea/ci13xxx_pci.c
+++ b/drivers/usb/chipidea/ci13xxx_pci.c
@@ -48,7 +48,7 @@ struct ci13xxx_platform_data penwell_pci_platdata = {
  * Allocates basic PCI resources for this USB device controller, and then
  * invokes the udc_probe() method to start the UDC associated with it
  */
-static int __devinit ci13xxx_pci_probe(struct pci_dev *pdev,
+static int ci13xxx_pci_probe(struct pci_dev *pdev,
 				       const struct pci_device_id *id)
 {
 	struct ci13xxx_platform_data *platdata = (void *)id->driver_data;
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 46f23f2..7f9c0d2 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -390,7 +390,7 @@ void ci13xxx_remove_device(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(ci13xxx_remove_device);
 
-static int __devinit ci_hdrc_probe(struct platform_device *pdev)
+static int ci_hdrc_probe(struct platform_device *pdev)
 {
 	struct device	*dev = &pdev->dev;
 	struct ci13xxx	*ci;
diff --git a/drivers/usb/chipidea/usbmisc_imx6q.c b/drivers/usb/chipidea/usbmisc_imx6q.c
index 81238a4..ee6fa87 100644
--- a/drivers/usb/chipidea/usbmisc_imx6q.c
+++ b/drivers/usb/chipidea/usbmisc_imx6q.c
@@ -82,7 +82,7 @@ static const struct of_device_id usbmisc_imx6q_dt_ids[] = {
 	{ /* sentinel */ }
 };
 
-static int __devinit usbmisc_imx6q_probe(struct platform_device *pdev)
+static int usbmisc_imx6q_probe(struct platform_device *pdev)
 {
 	struct resource	*res;
 	struct imx6q_usbmisc *data;
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1a02442..8dceb83 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -140,8 +140,7 @@ static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
  * Returns a pointer to the allocated event buffer structure on success
  * otherwise ERR_PTR(errno).
  */
-static struct dwc3_event_buffer *__devinit
-dwc3_alloc_one_event_buffer(struct dwc3 *dwc, unsigned length)
+static struct dwc3_event_buffer *dwc3_alloc_one_event_buffer(struct dwc3 *dwc, unsigned length)
 {
 	struct dwc3_event_buffer	*evt;
 
@@ -183,7 +182,7 @@ static void dwc3_free_event_buffers(struct dwc3 *dwc)
  * Returns 0 on success otherwise negative errno. In the error case, dwc
  * may contain some buffers allocated but not all which were requested.
  */
-static int __devinit dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned length)
+static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned length)
 {
 	int			num;
 	int			i;
@@ -260,7 +259,7 @@ static void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
 	}
 }
 
-static void __devinit dwc3_cache_hwparams(struct dwc3 *dwc)
+static void dwc3_cache_hwparams(struct dwc3 *dwc)
 {
 	struct dwc3_hwparams	*parms = &dwc->hwparams;
 
@@ -281,7 +280,7 @@ static void __devinit dwc3_cache_hwparams(struct dwc3 *dwc)
  *
  * Returns 0 on success otherwise negative errno.
  */
-static int __devinit dwc3_core_init(struct dwc3 *dwc)
+static int dwc3_core_init(struct dwc3 *dwc)
 {
 	unsigned long		timeout;
 	u32			reg;
@@ -362,7 +361,7 @@ static void dwc3_core_exit(struct dwc3 *dwc)
 
 #define DWC3_ALIGN_MASK		(16 - 1)
 
-static int __devinit dwc3_probe(struct platform_device *pdev)
+static int dwc3_probe(struct platform_device *pdev)
 {
 	struct device_node	*node = pdev->dev.of_node;
 	struct resource		*res;
diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
index d4a30f1..33ae98c5 100644
--- a/drivers/usb/dwc3/debugfs.c
+++ b/drivers/usb/dwc3/debugfs.c
@@ -652,7 +652,7 @@ static const struct file_operations dwc3_link_state_fops = {
 	.release		= single_release,
 };
 
-int __devinit dwc3_debugfs_init(struct dwc3 *dwc)
+int dwc3_debugfs_init(struct dwc3 *dwc)
 {
 	struct dentry		*root;
 	struct dentry		*file;
diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 19a9818..d43f076 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -34,7 +34,7 @@ struct dwc3_exynos {
 	struct clk		*clk;
 };
 
-static int __devinit dwc3_exynos_register_phys(struct dwc3_exynos *exynos)
+static int dwc3_exynos_register_phys(struct dwc3_exynos *exynos)
 {
 	struct nop_usb_xceiv_platform_data pdata;
 	struct platform_device	*pdev;
@@ -90,7 +90,7 @@ err1:
 
 static u64 dwc3_exynos_dma_mask = DMA_BIT_MASK(32);
 
-static int __devinit dwc3_exynos_probe(struct platform_device *pdev)
+static int dwc3_exynos_probe(struct platform_device *pdev)
 {
 	struct platform_device	*dwc3;
 	struct dwc3_exynos	*exynos;
diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index afbc6e9..e114bb5 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -157,7 +157,7 @@ static inline void dwc3_omap_writel(void __iomem *base, u32 offset, u32 value)
 	writel(value, base + offset);
 }
 
-static int __devinit dwc3_omap_register_phys(struct dwc3_omap *omap)
+static int dwc3_omap_register_phys(struct dwc3_omap *omap)
 {
 	struct nop_usb_xceiv_platform_data pdata;
 	struct platform_device	*pdev;
@@ -262,7 +262,7 @@ static irqreturn_t dwc3_omap_interrupt(int irq, void *_omap)
 	return IRQ_HANDLED;
 }
 
-static int __devinit dwc3_omap_probe(struct platform_device *pdev)
+static int dwc3_omap_probe(struct platform_device *pdev)
 {
 	struct dwc3_omap_data	*pdata = pdev->dev.platform_data;
 	struct device_node	*node = pdev->dev.of_node;
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index b3eeec7..68e389b 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -58,7 +58,7 @@ struct dwc3_pci {
 	struct platform_device	*usb3_phy;
 };
 
-static int __devinit dwc3_pci_register_phys(struct dwc3_pci *glue)
+static int dwc3_pci_register_phys(struct dwc3_pci *glue)
 {
 	struct nop_usb_xceiv_platform_data pdata;
 	struct platform_device	*pdev;
@@ -112,7 +112,7 @@ err1:
 	return ret;
 }
 
-static int __devinit dwc3_pci_probe(struct pci_dev *pci,
+static int dwc3_pci_probe(struct pci_dev *pci,
 		const struct pci_device_id *id)
 {
 	struct resource		res[2];
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 7b7dedd..2e43b33 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1579,7 +1579,7 @@ static const struct usb_gadget_ops dwc3_gadget_ops = {
 
 /* -------------------------------------------------------------------------- */
 
-static int __devinit dwc3_gadget_init_endpoints(struct dwc3 *dwc)
+static int dwc3_gadget_init_endpoints(struct dwc3 *dwc)
 {
 	struct dwc3_ep			*dep;
 	u8				epnum;
@@ -2374,7 +2374,7 @@ static irqreturn_t dwc3_interrupt(int irq, void *_dwc)
  *
  * Returns 0 on success otherwise negative errno.
  */
-int __devinit dwc3_gadget_init(struct dwc3 *dwc)
+int dwc3_gadget_init(struct dwc3 *dwc)
 {
 	u32					reg;
 	int					ret;
diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index a7b042b..59dcea2 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -1673,7 +1673,7 @@ static void at91udc_shutdown(struct platform_device *dev)
 	spin_unlock_irqrestore(&udc->lock, flags);
 }
 
-static void __devinit at91udc_of_init(struct at91_udc *udc,
+static void at91udc_of_init(struct at91_udc *udc,
 				     struct device_node *np)
 {
 	struct at91_udc_data *board = &udc->board;
@@ -1693,7 +1693,7 @@ static void __devinit at91udc_of_init(struct at91_udc *udc,
 	board->pullup_active_low = (flags & OF_GPIO_ACTIVE_LOW) ? 1 : 0;
 }
 
-static int __devinit at91udc_probe(struct platform_device *pdev)
+static int at91udc_probe(struct platform_device *pdev)
 {
 	struct device	*dev = &pdev->dev;
 	struct at91_udc	*udc;
diff --git a/drivers/usb/gadget/bcm63xx_udc.c b/drivers/usb/gadget/bcm63xx_udc.c
index b44e436..18eff74 100644
--- a/drivers/usb/gadget/bcm63xx_udc.c
+++ b/drivers/usb/gadget/bcm63xx_udc.c
@@ -2323,7 +2323,7 @@ static void bcm63xx_udc_gadget_release(struct device *dev)
  * Note that platform data is required, because pd.port_no varies from chip
  * to chip and is used to switch the correct USB port to device mode.
  */
-static int __devinit bcm63xx_udc_probe(struct platform_device *pdev)
+static int bcm63xx_udc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct bcm63xx_usbd_platform_data *pd = dev->platform_data;
diff --git a/drivers/usb/gadget/f_uac2.c b/drivers/usb/gadget/f_uac2.c
index 91396a1..d7da258 100644
--- a/drivers/usb/gadget/f_uac2.c
+++ b/drivers/usb/gadget/f_uac2.c
@@ -402,7 +402,7 @@ static struct snd_pcm_ops uac2_pcm_ops = {
 	.prepare = uac2_pcm_null,
 };
 
-static int __devinit snd_uac2_probe(struct platform_device *pdev)
+static int snd_uac2_probe(struct platform_device *pdev)
 {
 	struct snd_uac2_chip *uac2 = pdev_to_uac2(pdev);
 	struct snd_card *card;
diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index 21db1f7..8ad04a0 100644
--- a/drivers/usb/gadget/fsl_qe_udc.c
+++ b/drivers/usb/gadget/fsl_qe_udc.c
@@ -2347,7 +2347,7 @@ static int fsl_qe_stop(struct usb_gadget *gadget,
 }
 
 /* udc structure's alloc and setup, include ep-param alloc */
-static struct qe_udc __devinit *qe_udc_config(struct platform_device *ofdev)
+static struct qe_udc *qe_udc_config(struct platform_device *ofdev)
 {
 	struct qe_udc *udc;
 	struct device_node *np = ofdev->dev.of_node;
@@ -2402,7 +2402,7 @@ cleanup:
 }
 
 /* USB Controller register init */
-static int __devinit qe_udc_reg_init(struct qe_udc *udc)
+static int qe_udc_reg_init(struct qe_udc *udc)
 {
 	struct usb_ctlr __iomem *qe_usbregs;
 	qe_usbregs = udc->usb_regs;
@@ -2420,7 +2420,7 @@ static int __devinit qe_udc_reg_init(struct qe_udc *udc)
 	return 0;
 }
 
-static int __devinit qe_ep_config(struct qe_udc *udc, unsigned char pipe_num)
+static int qe_ep_config(struct qe_udc *udc, unsigned char pipe_num)
 {
 	struct qe_ep *ep = &udc->eps[pipe_num];
 
@@ -2473,7 +2473,7 @@ static void qe_udc_release(struct device *dev)
 
 /* Driver probe functions */
 static const struct of_device_id qe_udc_match[];
-static int __devinit qe_udc_probe(struct platform_device *ofdev)
+static int qe_udc_probe(struct platform_device *ofdev)
 {
 	struct qe_udc *udc;
 	const struct of_device_id *match;
diff --git a/drivers/usb/gadget/mv_udc_core.c b/drivers/usb/gadget/mv_udc_core.c
index ea45224..2419649 100644
--- a/drivers/usb/gadget/mv_udc_core.c
+++ b/drivers/usb/gadget/mv_udc_core.c
@@ -2188,7 +2188,7 @@ static int __devexit mv_udc_remove(struct platform_device *dev)
 	return 0;
 }
 
-static int __devinit mv_udc_probe(struct platform_device *dev)
+static int mv_udc_probe(struct platform_device *dev)
 {
 	struct mv_usb_platform_data *pdata = dev->dev.platform_data;
 	struct mv_udc *udc;
diff --git a/drivers/usb/gadget/net2272.c b/drivers/usb/gadget/net2272.c
index 26c3053..f0103dd 100644
--- a/drivers/usb/gadget/net2272.c
+++ b/drivers/usb/gadget/net2272.c
@@ -2215,8 +2215,7 @@ net2272_remove(struct net2272 *dev)
 	dev_info(dev->dev, "unbind\n");
 }
 
-static struct net2272 * __devinit
-net2272_probe_init(struct device *dev, unsigned int irq)
+static struct net2272 *net2272_probe_init(struct device *dev, unsigned int irq)
 {
 	struct net2272 *ret;
 
@@ -2246,7 +2245,7 @@ net2272_probe_init(struct device *dev, unsigned int irq)
 	return ret;
 }
 
-static int __devinit
+static int
 net2272_probe_fin(struct net2272 *dev, unsigned int irqflags)
 {
 	int ret;
@@ -2306,7 +2305,7 @@ err_add_udc:
  * don't respond over USB until a gadget driver binds to us
  */
 
-static int __devinit
+static int
 net2272_rdk1_probe(struct pci_dev *pdev, struct net2272 *dev)
 {
 	unsigned long resource, len, tmp;
@@ -2389,7 +2388,7 @@ net2272_rdk1_probe(struct pci_dev *pdev, struct net2272 *dev)
 	return ret;
 }
 
-static int __devinit
+static int
 net2272_rdk2_probe(struct pci_dev *pdev, struct net2272 *dev)
 {
 	unsigned long resource, len;
@@ -2447,7 +2446,7 @@ net2272_rdk2_probe(struct pci_dev *pdev, struct net2272 *dev)
 	return ret;
 }
 
-static int __devinit
+static int
 net2272_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct net2272 *dev;
@@ -2595,7 +2594,7 @@ static inline void net2272_pci_unregister(void) { }
 
 /*---------------------------------------------------------------------------*/
 
-static int __devinit
+static int
 net2272_plat_probe(struct platform_device *pdev)
 {
 	struct net2272 *dev;
diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index 650fa23..164526f 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -2508,7 +2508,7 @@ static inline void remove_proc_file(void) {}
  * UDC_SYSCON_1.CFG_LOCK is set can now work.  We won't use that
  * capability yet though.
  */
-static unsigned __devinit
+static unsigned
 omap_ep_setup(char *name, u8 addr, u8 type,
 		unsigned buf, unsigned maxp, int dbuf)
 {
@@ -2626,7 +2626,7 @@ static void omap_udc_release(struct device *dev)
 	udc = NULL;
 }
 
-static int __devinit
+static int
 omap_udc_setup(struct platform_device *odev, struct usb_phy *xceiv)
 {
 	unsigned	tmp, buf;
@@ -2763,7 +2763,7 @@ omap_udc_setup(struct platform_device *odev, struct usb_phy *xceiv)
 	return 0;
 }
 
-static int __devinit omap_udc_probe(struct platform_device *pdev)
+static int omap_udc_probe(struct platform_device *pdev)
 {
 	int			status = -ENODEV;
 	int			hmc;
diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index 9fd6e5f..6fdb1bd 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -3072,7 +3072,7 @@ static struct usb_gadget_ops s3c_hsotg_gadget_ops = {
  * creation) to give to the gadget driver. Setup the endpoint name, any
  * direction information and other state that may be required.
  */
-static void __devinit s3c_hsotg_initep(struct s3c_hsotg *hsotg,
+static void s3c_hsotg_initep(struct s3c_hsotg *hsotg,
 				       struct s3c_hsotg_ep *hs_ep,
 				       int epnum)
 {
@@ -3414,7 +3414,7 @@ static const struct file_operations ep_fops = {
  * with the same name as the device itself, in case we end up
  * with multiple blocks in future systems.
  */
-static void __devinit s3c_hsotg_create_debug(struct s3c_hsotg *hsotg)
+static void s3c_hsotg_create_debug(struct s3c_hsotg *hsotg)
 {
 	struct dentry *root;
 	unsigned epidx;
@@ -3490,7 +3490,7 @@ static void s3c_hsotg_release(struct device *dev)
  * @pdev: The platform information for the driver
  */
 
-static int __devinit s3c_hsotg_probe(struct platform_device *pdev)
+static int s3c_hsotg_probe(struct platform_device *pdev)
 {
 	struct s3c_hsotg_plat *plat = pdev->dev.platform_data;
 	struct device *dev = &pdev->dev;
diff --git a/drivers/usb/gadget/s3c-hsudc.c b/drivers/usb/gadget/s3c-hsudc.c
index d8e785d..52379b1 100644
--- a/drivers/usb/gadget/s3c-hsudc.c
+++ b/drivers/usb/gadget/s3c-hsudc.c
@@ -1261,7 +1261,7 @@ static struct usb_gadget_ops s3c_hsudc_gadget_ops = {
 	.vbus_draw	= s3c_hsudc_vbus_draw,
 };
 
-static int __devinit s3c_hsudc_probe(struct platform_device *pdev)
+static int s3c_hsudc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res;
diff --git a/drivers/usb/host/bcma-hcd.c b/drivers/usb/host/bcma-hcd.c
index f5143a0..8c83ed9 100644
--- a/drivers/usb/host/bcma-hcd.c
+++ b/drivers/usb/host/bcma-hcd.c
@@ -54,7 +54,7 @@ static int bcma_wait_bits(struct bcma_device *dev, u16 reg, u32 bitmask,
 	return -ETIMEDOUT;
 }
 
-static void __devinit bcma_hcd_4716wa(struct bcma_device *dev)
+static void bcma_hcd_4716wa(struct bcma_device *dev)
 {
 #ifdef CONFIG_BCMA_DRIVER_MIPS
 	/* Work around for 4716 failures. */
@@ -88,7 +88,7 @@ static void __devinit bcma_hcd_4716wa(struct bcma_device *dev)
 }
 
 /* based on arch/mips/brcm-boards/bcm947xx/pcibios.c */
-static void __devinit bcma_hcd_init_chip(struct bcma_device *dev)
+static void bcma_hcd_init_chip(struct bcma_device *dev)
 {
 	u32 tmp;
 
@@ -165,8 +165,7 @@ static const struct usb_ehci_pdata ehci_pdata = {
 static const struct usb_ohci_pdata ohci_pdata = {
 };
 
-static struct platform_device * __devinit
-bcma_hcd_create_pdev(struct bcma_device *dev, bool ohci, u32 addr)
+static struct platform_device *bcma_hcd_create_pdev(struct bcma_device *dev, bool ohci, u32 addr)
 {
 	struct platform_device *hci_dev;
 	struct resource hci_res[2];
@@ -212,7 +211,7 @@ err_alloc:
 	return ERR_PTR(ret);
 }
 
-static int __devinit bcma_hcd_probe(struct bcma_device *dev)
+static int bcma_hcd_probe(struct bcma_device *dev)
 {
 	int err;
 	u16 chipid_top;
diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index 33f798e..96bf00d 100644
--- a/drivers/usb/host/ehci-atmel.c
+++ b/drivers/usb/host/ehci-atmel.c
@@ -97,7 +97,7 @@ static const struct hc_driver ehci_atmel_hc_driver = {
 
 static u64 at91_ehci_dma_mask = DMA_BIT_MASK(32);
 
-static int __devinit ehci_atmel_drv_probe(struct platform_device *pdev)
+static int ehci_atmel_drv_probe(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd;
 	const struct hc_driver *driver = &ehci_atmel_hc_driver;
diff --git a/drivers/usb/host/ehci-grlib.c b/drivers/usb/host/ehci-grlib.c
index da42695..1fc8929 100644
--- a/drivers/usb/host/ehci-grlib.c
+++ b/drivers/usb/host/ehci-grlib.c
@@ -82,7 +82,7 @@ static const struct hc_driver ehci_grlib_hc_driver = {
 };
 
 
-static int __devinit ehci_hcd_grlib_probe(struct platform_device *op)
+static int ehci_hcd_grlib_probe(struct platform_device *op)
 {
 	struct device_node *dn = op->dev.of_node;
 	struct usb_hcd *hcd;
diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index 96da679..f74794c 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -146,7 +146,7 @@ static const struct hc_driver ehci_orion_hc_driver = {
 	.clear_tt_buffer_complete = ehci_clear_tt_buffer_complete,
 };
 
-static void __devinit
+static void
 ehci_orion_conf_mbus_windows(struct usb_hcd *hcd,
 			     const struct mbus_dram_target_info *dram)
 {
@@ -167,7 +167,7 @@ ehci_orion_conf_mbus_windows(struct usb_hcd *hcd,
 	}
 }
 
-static int __devinit ehci_orion_drv_probe(struct platform_device *pdev)
+static int ehci_orion_drv_probe(struct platform_device *pdev)
 {
 	struct orion_ehci_data *pd = pdev->dev.platform_data;
 	const struct mbus_dram_target_info *dram;
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index b807648..615cba0 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -61,7 +61,7 @@ static const struct ehci_driver_overrides platform_overrides __initdata = {
 	.reset =	ehci_platform_reset,
 };
 
-static int __devinit ehci_platform_probe(struct platform_device *dev)
+static int ehci_platform_probe(struct platform_device *dev)
 {
 	struct usb_hcd *hcd;
 	struct resource *res_mem;
diff --git a/drivers/usb/host/ehci-ppc-of.c b/drivers/usb/host/ehci-ppc-of.c
index fa937d0..45aceef 100644
--- a/drivers/usb/host/ehci-ppc-of.c
+++ b/drivers/usb/host/ehci-ppc-of.c
@@ -71,7 +71,7 @@ static const struct hc_driver ehci_ppc_of_hc_driver = {
  * Fix: Enable Break Memory Transfer (BMT) in INSNREG3
  */
 #define PPC440EPX_EHCI0_INSREG_BMT	(0x1 << 0)
-static int __devinit
+static int
 ppc44x_enable_bmt(struct device_node *dn)
 {
 	__iomem u32 *insreg_virt;
@@ -87,7 +87,7 @@ ppc44x_enable_bmt(struct device_node *dn)
 }
 
 
-static int __devinit ehci_hcd_ppc_of_probe(struct platform_device *op)
+static int ehci_hcd_ppc_of_probe(struct platform_device *op)
 {
 	struct device_node *dn = op->dev.of_node;
 	struct usb_hcd *hcd;
diff --git a/drivers/usb/host/ehci-ps3.c b/drivers/usb/host/ehci-ps3.c
index 45a356e..df5925a 100644
--- a/drivers/usb/host/ehci-ps3.c
+++ b/drivers/usb/host/ehci-ps3.c
@@ -93,7 +93,7 @@ static const struct hc_driver ps3_ehci_hc_driver = {
 	.clear_tt_buffer_complete	= ehci_clear_tt_buffer_complete,
 };
 
-static int __devinit ps3_ehci_probe(struct ps3_system_bus_device *dev)
+static int ps3_ehci_probe(struct ps3_system_bus_device *dev)
 {
 	int result;
 	struct usb_hcd *hcd;
diff --git a/drivers/usb/host/ehci-s5p.c b/drivers/usb/host/ehci-s5p.c
index f90a881..2cf19d1 100644
--- a/drivers/usb/host/ehci-s5p.c
+++ b/drivers/usb/host/ehci-s5p.c
@@ -85,7 +85,7 @@ static void s5p_setup_vbus_gpio(struct platform_device *pdev)
 
 static u64 ehci_s5p_dma_mask = DMA_BIT_MASK(32);
 
-static int __devinit s5p_ehci_probe(struct platform_device *pdev)
+static int s5p_ehci_probe(struct platform_device *pdev)
 {
 	struct s5p_ehci_platdata *pdata;
 	struct s5p_ehci_hcd *s5p_ehci;
diff --git a/drivers/usb/host/ehci-w90x900.c b/drivers/usb/host/ehci-w90x900.c
index 7bcb8b2..bf8d462 100644
--- a/drivers/usb/host/ehci-w90x900.c
+++ b/drivers/usb/host/ehci-w90x900.c
@@ -18,7 +18,7 @@
 #define PHY0_CTR	(0xA4)
 #define PHY1_CTR	(0xA8)
 
-static int __devinit usb_w90x900_probe(const struct hc_driver *driver,
+static int usb_w90x900_probe(const struct hc_driver *driver,
 		      struct platform_device *pdev)
 {
 	struct usb_hcd *hcd;
@@ -147,7 +147,7 @@ static const struct hc_driver ehci_w90x900_hc_driver = {
 	.clear_tt_buffer_complete = ehci_clear_tt_buffer_complete,
 };
 
-static int __devinit ehci_w90x900_probe(struct platform_device *pdev)
+static int ehci_w90x900_probe(struct platform_device *pdev)
 {
 	if (usb_disabled())
 		return -ENODEV;
diff --git a/drivers/usb/host/ehci-xilinx-of.c b/drivers/usb/host/ehci-xilinx-of.c
index 6a3f921..4f285e8 100644
--- a/drivers/usb/host/ehci-xilinx-of.c
+++ b/drivers/usb/host/ehci-xilinx-of.c
@@ -125,7 +125,7 @@ static const struct hc_driver ehci_xilinx_of_hc_driver = {
  * as HS only or HS/FS only, it checks the configuration in the device tree
  * entry, and sets an appropriate value for hcd->has_tt.
  */
-static int __devinit ehci_hcd_xilinx_of_probe(struct platform_device *op)
+static int ehci_hcd_xilinx_of_probe(struct platform_device *op)
 {
 	struct device_node *dn = op->dev.of_node;
 	struct usb_hcd *hcd;
diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
index 92f4b99..618f143 100644
--- a/drivers/usb/host/fhci-hcd.c
+++ b/drivers/usb/host/fhci-hcd.c
@@ -561,7 +561,7 @@ static const struct hc_driver fhci_driver = {
 	.hub_control = fhci_hub_control,
 };
 
-static int __devinit of_fhci_probe(struct platform_device *ofdev)
+static int of_fhci_probe(struct platform_device *ofdev)
 {
 	struct device *dev = &ofdev->dev;
 	struct device_node *node = dev->of_node;
diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
index 3a5c82f..dc0aeba 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -42,7 +42,7 @@ struct fsl_usb2_dev_data dr_mode_data[] __devinitdata = {
 	},
 };
 
-struct fsl_usb2_dev_data * __devinit get_dr_mode_data(struct device_node *np)
+struct fsl_usb2_dev_data *get_dr_mode_data(struct device_node *np)
 {
 	const unsigned char *prop;
 	int i;
@@ -59,7 +59,7 @@ struct fsl_usb2_dev_data * __devinit get_dr_mode_data(struct device_node *np)
 	return &dr_mode_data[0]; /* mode not specified, use host */
 }
 
-static enum fsl_usb2_phy_modes __devinit determine_usb_phy(const char *phy_type)
+static enum fsl_usb2_phy_modes determine_usb_phy(const char *phy_type)
 {
 	if (!phy_type)
 		return FSL_USB2_PHY_NONE;
@@ -75,7 +75,7 @@ static enum fsl_usb2_phy_modes __devinit determine_usb_phy(const char *phy_type)
 	return FSL_USB2_PHY_NONE;
 }
 
-struct platform_device * __devinit fsl_usb2_device_register(
+struct platform_device *fsl_usb2_device_register(
 					struct platform_device *ofdev,
 					struct fsl_usb2_platform_data *pdata,
 					const char *name, int id)
@@ -154,7 +154,7 @@ static int usb_get_ver_info(struct device_node *np)
 	return ver;
 }
 
-static int __devinit fsl_usb2_mph_dr_of_probe(struct platform_device *ofdev)
+static int fsl_usb2_mph_dr_of_probe(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
 	struct platform_device *usb_dev;
diff --git a/drivers/usb/host/imx21-hcd.c b/drivers/usb/host/imx21-hcd.c
index f19e269..bd6a744 100644
--- a/drivers/usb/host/imx21-hcd.c
+++ b/drivers/usb/host/imx21-hcd.c
@@ -1680,7 +1680,7 @@ static int imx21_hc_reset(struct usb_hcd *hcd)
 	return 0;
 }
 
-static int __devinit imx21_hc_start(struct usb_hcd *hcd)
+static int imx21_hc_start(struct usb_hcd *hcd)
 {
 	struct imx21 *imx21 = hcd_to_imx21(hcd);
 	unsigned long flags;
diff --git a/drivers/usb/host/isp116x-hcd.c b/drivers/usb/host/isp116x-hcd.c
index 9e65e30..b64e661 100644
--- a/drivers/usb/host/isp116x-hcd.c
+++ b/drivers/usb/host/isp116x-hcd.c
@@ -1557,7 +1557,7 @@ static int isp116x_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devinit isp116x_probe(struct platform_device *pdev)
+static int isp116x_probe(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd;
 	struct isp116x *isp116x;
diff --git a/drivers/usb/host/isp1362-hcd.c b/drivers/usb/host/isp1362-hcd.c
index 1ad9d20..5f8b63c 100644
--- a/drivers/usb/host/isp1362-hcd.c
+++ b/drivers/usb/host/isp1362-hcd.c
@@ -2680,7 +2680,7 @@ static int __devexit isp1362_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devinit isp1362_probe(struct platform_device *pdev)
+static int isp1362_probe(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd;
 	struct isp1362_hcd *isp1362_hcd;
diff --git a/drivers/usb/host/isp1760-if.c b/drivers/usb/host/isp1760-if.c
index 5fb3cae..d752a4c 100644
--- a/drivers/usb/host/isp1760-if.c
+++ b/drivers/usb/host/isp1760-if.c
@@ -172,7 +172,7 @@ static struct platform_driver isp1760_of_driver = {
 #endif
 
 #ifdef CONFIG_PCI
-static int __devinit isp1761_pci_probe(struct pci_dev *dev,
+static int isp1761_pci_probe(struct pci_dev *dev,
 		const struct pci_device_id *id)
 {
 	u8 latency, limit;
@@ -346,7 +346,7 @@ static struct pci_driver isp1761_pci_driver = {
 };
 #endif
 
-static int __devinit isp1760_plat_probe(struct platform_device *pdev)
+static int isp1760_plat_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 	struct usb_hcd *hcd;
diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 51de2f9..0518348 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -108,7 +108,7 @@ static void __devexit usb_hcd_at91_remove (struct usb_hcd *, struct platform_dev
  * then invokes the start() method for the HCD associated with it
  * through the hotplug entry's driver_data.
  */
-static int __devinit usb_hcd_at91_probe(const struct hc_driver *driver,
+static int usb_hcd_at91_probe(const struct hc_driver *driver,
 			struct platform_device *pdev)
 {
 	int retval;
@@ -222,7 +222,7 @@ static void __devexit usb_hcd_at91_remove(struct usb_hcd *hcd,
 
 /*-------------------------------------------------------------------------*/
 
-static int __devinit
+static int
 ohci_at91_reset (struct usb_hcd *hcd)
 {
 	struct at91_usbh_data	*board = hcd->self.controller->platform_data;
@@ -236,7 +236,7 @@ ohci_at91_reset (struct usb_hcd *hcd)
 	return 0;
 }
 
-static int __devinit
+static int
 ohci_at91_start (struct usb_hcd *hcd)
 {
 	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
@@ -506,7 +506,7 @@ MODULE_DEVICE_TABLE(of, at91_ohci_dt_ids);
 
 static u64 at91_ohci_dma_mask = DMA_BIT_MASK(32);
 
-static int __devinit ohci_at91_of_init(struct platform_device *pdev)
+static int ohci_at91_of_init(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	int i, gpio;
@@ -548,7 +548,7 @@ static int __devinit ohci_at91_of_init(struct platform_device *pdev)
 	return 0;
 }
 #else
-static int __devinit ohci_at91_of_init(struct platform_device *pdev)
+static int ohci_at91_of_init(struct platform_device *pdev)
 {
 	return 0;
 }
@@ -556,7 +556,7 @@ static int __devinit ohci_at91_of_init(struct platform_device *pdev)
 
 /*-------------------------------------------------------------------------*/
 
-static int __devinit ohci_hcd_at91_drv_probe(struct platform_device *pdev)
+static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
 {
 	struct at91_usbh_data	*pdata;
 	int			i;
diff --git a/drivers/usb/host/ohci-ep93xx.c b/drivers/usb/host/ohci-ep93xx.c
index a982f04..8704e9fa 100644
--- a/drivers/usb/host/ohci-ep93xx.c
+++ b/drivers/usb/host/ohci-ep93xx.c
@@ -107,7 +107,7 @@ static void usb_hcd_ep93xx_remove(struct usb_hcd *hcd,
 	usb_put_hcd(hcd);
 }
 
-static int __devinit ohci_ep93xx_start(struct usb_hcd *hcd)
+static int ohci_ep93xx_start(struct usb_hcd *hcd)
 {
 	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
 	int ret;
diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index 2f673e8..1288cdb 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -76,7 +76,7 @@ static const struct hc_driver exynos_ohci_hc_driver = {
 
 static u64 ohci_exynos_dma_mask = DMA_BIT_MASK(32);
 
-static int __devinit exynos_ohci_probe(struct platform_device *pdev)
+static int exynos_ohci_probe(struct platform_device *pdev)
 {
 	struct exynos4_ohci_platdata *pdata;
 	struct exynos_ohci_hcd *exynos_ohci;
diff --git a/drivers/usb/host/ohci-jz4740.c b/drivers/usb/host/ohci-jz4740.c
index b4921b7..59feb87 100644
--- a/drivers/usb/host/ohci-jz4740.c
+++ b/drivers/usb/host/ohci-jz4740.c
@@ -145,7 +145,7 @@ static const struct hc_driver ohci_jz4740_hc_driver = {
 };
 
 
-static __devinit int jz4740_ohci_probe(struct platform_device *pdev)
+static int jz4740_ohci_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct usb_hcd *hcd;
diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
index e068f03..2344040 100644
--- a/drivers/usb/host/ohci-nxp.c
+++ b/drivers/usb/host/ohci-nxp.c
@@ -147,7 +147,7 @@ static void nxp_stop_hc(void)
 	__raw_writel(tmp, USB_OTG_STAT_CONTROL);
 }
 
-static int __devinit ohci_nxp_start(struct usb_hcd *hcd)
+static int ohci_nxp_start(struct usb_hcd *hcd)
 {
 	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
 	int ret;
@@ -205,7 +205,7 @@ static const struct hc_driver ohci_nxp_hc_driver = {
 	.start_port_reset = ohci_start_port_reset,
 };
 
-static int __devinit usb_hcd_nxp_probe(struct platform_device *pdev)
+static int usb_hcd_nxp_probe(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = 0;
 	struct ohci_hcd *ohci;
diff --git a/drivers/usb/host/ohci-octeon.c b/drivers/usb/host/ohci-octeon.c
index d469bf9..d44430d 100644
--- a/drivers/usb/host/ohci-octeon.c
+++ b/drivers/usb/host/ohci-octeon.c
@@ -42,7 +42,7 @@ static void ohci_octeon_hw_stop(void)
 	octeon2_usb_clocks_stop();
 }
 
-static int __devinit ohci_octeon_start(struct usb_hcd *hcd)
+static int ohci_octeon_start(struct usb_hcd *hcd)
 {
 	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
 	int ret;
diff --git a/drivers/usb/host/ohci-omap3.c b/drivers/usb/host/ohci-omap3.c
index 002c812..41382fc 100644
--- a/drivers/usb/host/ohci-omap3.c
+++ b/drivers/usb/host/ohci-omap3.c
@@ -124,7 +124,7 @@ static const struct hc_driver ohci_omap3_hc_driver = {
  * then invokes the start() method for the HCD associated with it
  * through the hotplug entry's driver_data.
  */
-static int __devinit ohci_hcd_omap3_probe(struct platform_device *pdev)
+static int ohci_hcd_omap3_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
 	struct usb_hcd		*hcd = NULL;
diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
index 6afa7dc..951514e 100644
--- a/drivers/usb/host/ohci-pci.c
+++ b/drivers/usb/host/ohci-pci.c
@@ -270,7 +270,7 @@ static int ohci_pci_reset (struct usb_hcd *hcd)
 }
 
 
-static int __devinit ohci_pci_start (struct usb_hcd *hcd)
+static int ohci_pci_start (struct usb_hcd *hcd)
 {
 	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
 	int		ret;
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index ffe6c98..c3f76fa 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -83,7 +83,7 @@ static const struct hc_driver ohci_platform_hc_driver = {
 	.start_port_reset	= ohci_start_port_reset,
 };
 
-static int __devinit ohci_platform_probe(struct platform_device *dev)
+static int ohci_platform_probe(struct platform_device *dev)
 {
 	struct usb_hcd *hcd;
 	struct resource *res_mem;
diff --git a/drivers/usb/host/ohci-ppc-of.c b/drivers/usb/host/ohci-ppc-of.c
index e27d5ae..64c2ed9f 100644
--- a/drivers/usb/host/ohci-ppc-of.c
+++ b/drivers/usb/host/ohci-ppc-of.c
@@ -19,7 +19,7 @@
 #include <asm/prom.h>
 
 
-static int __devinit
+static int
 ohci_ppc_of_start(struct usb_hcd *hcd)
 {
 	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
@@ -81,7 +81,7 @@ static const struct hc_driver ohci_ppc_of_hc_driver = {
 };
 
 
-static int __devinit ohci_hcd_ppc_of_probe(struct platform_device *op)
+static int ohci_hcd_ppc_of_probe(struct platform_device *op)
 {
 	struct device_node *dn = op->dev.of_node;
 	struct usb_hcd *hcd;
diff --git a/drivers/usb/host/ohci-ps3.c b/drivers/usb/host/ohci-ps3.c
index 2ee1d8d..7d35cd9 100644
--- a/drivers/usb/host/ohci-ps3.c
+++ b/drivers/usb/host/ohci-ps3.c
@@ -30,7 +30,7 @@ static int ps3_ohci_hc_reset(struct usb_hcd *hcd)
 	return ohci_init(ohci);
 }
 
-static int __devinit ps3_ohci_hc_start(struct usb_hcd *hcd)
+static int ps3_ohci_hc_start(struct usb_hcd *hcd)
 {
 	int result;
 	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
@@ -76,7 +76,7 @@ static const struct hc_driver ps3_ohci_hc_driver = {
 #endif
 };
 
-static int __devinit ps3_ohci_probe(struct ps3_system_bus_device *dev)
+static int ps3_ohci_probe(struct ps3_system_bus_device *dev)
 {
 	int result;
 	struct usb_hcd *hcd;
diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
index 156d289..efe71f3 100644
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -284,7 +284,7 @@ MODULE_DEVICE_TABLE(of, pxa_ohci_dt_ids);
 
 static u64 pxa_ohci_dma_mask = DMA_BIT_MASK(32);
 
-static int __devinit ohci_pxa_of_init(struct platform_device *pdev)
+static int ohci_pxa_of_init(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct pxaohci_platform_data *pdata;
@@ -330,7 +330,7 @@ static int __devinit ohci_pxa_of_init(struct platform_device *pdev)
 	return 0;
 }
 #else
-static int __devinit ohci_pxa_of_init(struct platform_device *pdev)
+static int ohci_pxa_of_init(struct platform_device *pdev)
 {
 	return 0;
 }
@@ -471,7 +471,7 @@ void usb_hcd_pxa27x_remove (struct usb_hcd *hcd, struct platform_device *pdev)
 
 /*-------------------------------------------------------------------------*/
 
-static int __devinit
+static int
 ohci_pxa27x_start (struct usb_hcd *hcd)
 {
 	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
diff --git a/drivers/usb/host/ohci-s3c2410.c b/drivers/usb/host/ohci-s3c2410.c
index 5c5c017..4f29e0b 100644
--- a/drivers/usb/host/ohci-s3c2410.c
+++ b/drivers/usb/host/ohci-s3c2410.c
@@ -458,7 +458,7 @@ static const struct hc_driver ohci_s3c2410_hc_driver = {
 
 /* device driver */
 
-static int __devinit ohci_hcd_s3c2410_drv_probe(struct platform_device *pdev)
+static int ohci_hcd_s3c2410_drv_probe(struct platform_device *pdev)
 {
 	return usb_hcd_s3c2410_probe(&ohci_s3c2410_hc_driver, pdev);
 }
diff --git a/drivers/usb/host/ohci-sa1111.c b/drivers/usb/host/ohci-sa1111.c
index b6cc925..17b2a7d 100644
--- a/drivers/usb/host/ohci-sa1111.c
+++ b/drivers/usb/host/ohci-sa1111.c
@@ -63,7 +63,7 @@ static int ohci_sa1111_reset(struct usb_hcd *hcd)
 	return ohci_init(ohci);
 }
 
-static int __devinit ohci_sa1111_start(struct usb_hcd *hcd)
+static int ohci_sa1111_start(struct usb_hcd *hcd)
 {
 	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
 	int ret;
diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
index c69725d..b7fc2fc 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -33,7 +33,7 @@ static void spear_stop_ohci(struct spear_ohci *ohci)
 	clk_disable_unprepare(ohci->clk);
 }
 
-static int __devinit ohci_spear_start(struct usb_hcd *hcd)
+static int ohci_spear_start(struct usb_hcd *hcd)
 {
 	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
 	int ret;
diff --git a/drivers/usb/host/ohci-tmio.c b/drivers/usb/host/ohci-tmio.c
index 94c6c55..5996a3b 100644
--- a/drivers/usb/host/ohci-tmio.c
+++ b/drivers/usb/host/ohci-tmio.c
@@ -184,7 +184,7 @@ static const struct hc_driver ohci_tmio_hc_driver = {
 /*-------------------------------------------------------------------------*/
 static struct platform_driver ohci_hcd_tmio_driver;
 
-static int __devinit ohci_hcd_tmio_drv_probe(struct platform_device *dev)
+static int ohci_hcd_tmio_drv_probe(struct platform_device *dev)
 {
 	const struct mfd_cell *cell = mfd_get_cell(dev);
 	struct resource *regs = platform_get_resource(dev, IORESOURCE_MEM, 0);
diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 39f9e4a..a018e70 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -443,7 +443,7 @@ static inline int io_type_enabled(struct pci_dev *pdev, unsigned int mask)
 #define pio_enabled(dev) io_type_enabled(dev, PCI_COMMAND_IO)
 #define mmio_enabled(dev) io_type_enabled(dev, PCI_COMMAND_MEMORY)
 
-static void __devinit quirk_usb_handoff_uhci(struct pci_dev *pdev)
+static void quirk_usb_handoff_uhci(struct pci_dev *pdev)
 {
 	unsigned long base = 0;
 	int i;
@@ -461,12 +461,12 @@ static void __devinit quirk_usb_handoff_uhci(struct pci_dev *pdev)
 		uhci_check_and_reset_hc(pdev, base);
 }
 
-static int __devinit mmio_resource_enabled(struct pci_dev *pdev, int idx)
+static int mmio_resource_enabled(struct pci_dev *pdev, int idx)
 {
 	return pci_resource_start(pdev, idx) && mmio_enabled(pdev);
 }
 
-static void __devinit quirk_usb_handoff_ohci(struct pci_dev *pdev)
+static void quirk_usb_handoff_ohci(struct pci_dev *pdev)
 {
 	void __iomem *base;
 	u32 control;
@@ -558,7 +558,7 @@ static const struct dmi_system_id __devinitconst ehci_dmi_nohandoff_table[] = {
 	{ }
 };
 
-static void __devinit ehci_bios_handoff(struct pci_dev *pdev,
+static void ehci_bios_handoff(struct pci_dev *pdev,
 					void __iomem *op_reg_base,
 					u32 cap, u8 offset)
 {
@@ -626,7 +626,7 @@ static void __devinit ehci_bios_handoff(struct pci_dev *pdev,
 		writel(0, op_reg_base + EHCI_CONFIGFLAG);
 }
 
-static void __devinit quirk_usb_disable_ehci(struct pci_dev *pdev)
+static void quirk_usb_disable_ehci(struct pci_dev *pdev)
 {
 	void __iomem *base, *op_reg_base;
 	u32	hcc_params, cap, val;
@@ -841,7 +841,7 @@ EXPORT_SYMBOL_GPL(usb_disable_xhci_ports);
  * and then waits 5 seconds for the BIOS to hand over control.
  * If we timeout, assume the BIOS is broken and take control anyway.
  */
-static void __devinit quirk_usb_handoff_xhci(struct pci_dev *pdev)
+static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
 {
 	void __iomem *base;
 	int ext_cap_offset;
@@ -941,7 +941,7 @@ hc_init:
 	iounmap(base);
 }
 
-static void __devinit quirk_usb_early_handoff(struct pci_dev *pdev)
+static void quirk_usb_early_handoff(struct pci_dev *pdev)
 {
 	/* Skip Netlogic mips SoC's internal PCI USB controller.
 	 * This device does not need/support EHCI/OHCI handoff
diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index 4e0436f..e97dfad 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -2405,7 +2405,7 @@ static int __devexit r8a66597_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devinit r8a66597_probe(struct platform_device *pdev)
+static int r8a66597_probe(struct platform_device *pdev)
 {
 	char clk_name[8];
 	struct resource *res = NULL, *ires;
diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index 15f20de..782127d 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -1618,7 +1618,7 @@ sl811h_remove(struct platform_device *dev)
 	return 0;
 }
 
-static int __devinit
+static int
 sl811h_probe(struct platform_device *dev)
 {
 	struct usb_hcd		*hcd;
diff --git a/drivers/usb/host/ssb-hcd.c b/drivers/usb/host/ssb-hcd.c
index 4dc9a09..79aa958 100644
--- a/drivers/usb/host/ssb-hcd.c
+++ b/drivers/usb/host/ssb-hcd.c
@@ -39,7 +39,7 @@ struct ssb_hcd_device {
 	u32 enable_flags;
 };
 
-static void __devinit ssb_hcd_5354wa(struct ssb_device *dev)
+static void ssb_hcd_5354wa(struct ssb_device *dev)
 {
 #ifdef CONFIG_SSB_DRIVER_MIPS
 	/* Work around for 5354 failures */
@@ -53,7 +53,7 @@ static void __devinit ssb_hcd_5354wa(struct ssb_device *dev)
 #endif
 }
 
-static void __devinit ssb_hcd_usb20wa(struct ssb_device *dev)
+static void ssb_hcd_usb20wa(struct ssb_device *dev)
 {
 	if (dev->id.coreid == SSB_DEV_USB20_HOST) {
 		/*
@@ -80,7 +80,7 @@ static void __devinit ssb_hcd_usb20wa(struct ssb_device *dev)
 }
 
 /* based on arch/mips/brcm-boards/bcm947xx/pcibios.c */
-static u32 __devinit ssb_hcd_init_chip(struct ssb_device *dev)
+static u32 ssb_hcd_init_chip(struct ssb_device *dev)
 {
 	u32 flags = 0;
 
@@ -101,8 +101,7 @@ static const struct usb_ehci_pdata ehci_pdata = {
 static const struct usb_ohci_pdata ohci_pdata = {
 };
 
-static struct platform_device * __devinit
-ssb_hcd_create_pdev(struct ssb_device *dev, bool ohci, u32 addr, u32 len)
+static struct platform_device *ssb_hcd_create_pdev(struct ssb_device *dev, bool ohci, u32 addr, u32 len)
 {
 	struct platform_device *hci_dev;
 	struct resource hci_res[2];
@@ -148,7 +147,7 @@ err_alloc:
 	return ERR_PTR(ret);
 }
 
-static int __devinit ssb_hcd_probe(struct ssb_device *dev,
+static int ssb_hcd_probe(struct ssb_device *dev,
 				   const struct ssb_device_id *id)
 {
 	int err, tmp;
diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
index 8836898..8bf78e6 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -3084,7 +3084,7 @@ static void u132_initialise(struct u132 *u132, struct platform_device *pdev)
 	mutex_unlock(&u132->sw_lock);
 }
 
-static int __devinit u132_probe(struct platform_device *pdev)
+static int u132_probe(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd;
 	int retval;
diff --git a/drivers/usb/host/uhci-grlib.c b/drivers/usb/host/uhci-grlib.c
index f7a6213..511bfc4 100644
--- a/drivers/usb/host/uhci-grlib.c
+++ b/drivers/usb/host/uhci-grlib.c
@@ -85,7 +85,7 @@ static const struct hc_driver uhci_grlib_hc_driver = {
 };
 
 
-static int __devinit uhci_hcd_grlib_probe(struct platform_device *op)
+static int uhci_hcd_grlib_probe(struct platform_device *op)
 {
 	struct device_node *dn = op->dev.of_node;
 	struct usb_hcd *hcd;
diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
index 68ebf20..8c4dace 100644
--- a/drivers/usb/host/uhci-platform.c
+++ b/drivers/usb/host/uhci-platform.c
@@ -62,7 +62,7 @@ static const struct hc_driver uhci_platform_hc_driver = {
 
 static u64 platform_uhci_dma_mask = DMA_BIT_MASK(32);
 
-static int __devinit uhci_hcd_platform_probe(struct platform_device *pdev)
+static int uhci_hcd_platform_probe(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd;
 	struct uhci_hcd	*uhci;
diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 35d94ac..2363819 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -454,7 +454,7 @@ static const struct musb_platform_ops am35x_ops = {
 
 static u64 am35x_dmamask = DMA_BIT_MASK(32);
 
-static int __devinit am35x_probe(struct platform_device *pdev)
+static int am35x_probe(struct platform_device *pdev)
 {
 	struct musb_hdrc_platform_data	*pdata = pdev->dev.platform_data;
 	struct platform_device		*musb;
diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index 7e4d60a..12beb0e 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -448,7 +448,7 @@ static const struct musb_platform_ops bfin_ops = {
 
 static u64 bfin_dmamask = DMA_BIT_MASK(32);
 
-static int __devinit bfin_probe(struct platform_device *pdev)
+static int bfin_probe(struct platform_device *pdev)
 {
 	struct musb_hdrc_platform_data	*pdata = pdev->dev.platform_data;
 	struct platform_device		*musb;
diff --git a/drivers/usb/musb/cppi_dma.c b/drivers/usb/musb/cppi_dma.c
index 3a6c2fd..0968dd7 100644
--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -1317,8 +1317,7 @@ irqreturn_t cppi_interrupt(int irq, void *dev_id)
 EXPORT_SYMBOL_GPL(cppi_interrupt);
 
 /* Instantiate a software object representing a DMA controller. */
-struct dma_controller *__devinit
-dma_controller_create(struct musb *musb, void __iomem *mregs)
+struct dma_controller *dma_controller_create(struct musb *musb, void __iomem *mregs)
 {
 	struct cppi		*controller;
 	struct device		*dev = musb->controller;
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 51ace9b..c4fb235 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -471,7 +471,7 @@ static const struct musb_platform_ops da8xx_ops = {
 
 static u64 da8xx_dmamask = DMA_BIT_MASK(32);
 
-static int __devinit da8xx_probe(struct platform_device *pdev)
+static int da8xx_probe(struct platform_device *pdev)
 {
 	struct musb_hdrc_platform_data	*pdata = pdev->dev.platform_data;
 	struct platform_device		*musb;
diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index e01087b..8877c1a 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -504,7 +504,7 @@ static const struct musb_platform_ops davinci_ops = {
 
 static u64 davinci_dmamask = DMA_BIT_MASK(32);
 
-static int __devinit davinci_probe(struct platform_device *pdev)
+static int davinci_probe(struct platform_device *pdev)
 {
 	struct musb_hdrc_platform_data	*pdata = pdev->dev.platform_data;
 	struct platform_device		*musb;
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 69cfa18..f17a3e7 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1163,7 +1163,7 @@ static struct musb_fifo_cfg __devinitdata mode_5_cfg[] = {
  *
  * returns negative errno or offset for next fifo.
  */
-static int __devinit
+static int
 fifo_setup(struct musb *musb, struct musb_hw_ep  *hw_ep,
 		const struct musb_fifo_cfg *cfg, u16 offset)
 {
@@ -1238,7 +1238,7 @@ static struct musb_fifo_cfg __devinitdata ep0_cfg = {
 	.style = FIFO_RXTX, .maxpacket = 64,
 };
 
-static int __devinit ep_config_from_table(struct musb *musb)
+static int ep_config_from_table(struct musb *musb)
 {
 	const struct musb_fifo_cfg	*cfg;
 	unsigned		i, n;
@@ -1329,7 +1329,7 @@ done:
  * ep_config_from_hw - when MUSB_C_DYNFIFO_DEF is false
  * @param musb the controller
  */
-static int __devinit ep_config_from_hw(struct musb *musb)
+static int ep_config_from_hw(struct musb *musb)
 {
 	u8 epnum = 0;
 	struct musb_hw_ep *hw_ep;
@@ -1376,7 +1376,7 @@ enum { MUSB_CONTROLLER_MHDRC, MUSB_CONTROLLER_HDRC, };
 /* Initialize MUSB (M)HDRC part of the USB hardware subsystem;
  * configure endpoints, or take their config from silicon
  */
-static int __devinit musb_core_init(u16 musb_type, struct musb *musb)
+static int musb_core_init(u16 musb_type, struct musb *musb)
 {
 	u8 reg;
 	char *type;
@@ -1759,8 +1759,7 @@ static void musb_irq_work(struct work_struct *data)
  * Init support
  */
 
-static struct musb *__devinit
-allocate_instance(struct device *dev,
+static struct musb *allocate_instance(struct device *dev,
 		struct musb_hdrc_config *config, void __iomem *mbase)
 {
 	struct musb		*musb;
@@ -1835,7 +1834,7 @@ static void musb_free(struct musb *musb)
  * @ctrl: virtual address of controller registers,
  *	not yet corrected for platform-specific offsets
  */
-static int __devinit
+static int
 musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 {
 	int			status;
@@ -2010,7 +2009,7 @@ fail0:
 /* all implementations (PCI bridge to FPGA, VLYNQ, etc) should just
  * bridge to a platform device; this driver then suffices.
  */
-static int __devinit musb_probe(struct platform_device *pdev)
+static int musb_probe(struct platform_device *pdev)
 {
 	struct device	*dev = &pdev->dev;
 	int		irq = platform_get_irq_byname(pdev, "mc");
diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
index 1d6e8af..4c21679 100644
--- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -233,7 +233,7 @@ static const struct file_operations musb_test_mode_fops = {
 	.release		= single_release,
 };
 
-int __devinit musb_init_debugfs(struct musb *musb)
+int musb_init_debugfs(struct musb *musb)
 {
 	struct dentry		*root;
 	struct dentry		*file;
diff --git a/drivers/usb/musb/musb_dma.h b/drivers/usb/musb/musb_dma.h
index 24d3921..1b6b827 100644
--- a/drivers/usb/musb/musb_dma.h
+++ b/drivers/usb/musb/musb_dma.h
@@ -178,8 +178,7 @@ struct dma_controller {
 extern void musb_dma_completion(struct musb *musb, u8 epnum, u8 transmit);
 
 
-extern struct dma_controller *__devinit
-dma_controller_create(struct musb *, void __iomem *);
+extern struct dma_controller *dma_controller_create(struct musb *, void __iomem *);
 
 extern void dma_controller_destroy(struct dma_controller *);
 
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 5daea65..faeacd4 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -478,7 +478,7 @@ static struct musb_platform_ops dsps_ops = {
 
 static u64 musb_dmamask = DMA_BIT_MASK(32);
 
-static int __devinit dsps_create_musb_pdev(struct dsps_glue *glue, u8 id)
+static int dsps_create_musb_pdev(struct dsps_glue *glue, u8 id)
 {
 	struct device *dev = glue->dev;
 	struct platform_device *pdev = to_platform_device(dev);
@@ -591,7 +591,7 @@ err0:
 	return ret;
 }
 
-static int __devinit dsps_probe(struct platform_device *pdev)
+static int dsps_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *match;
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 4f23b12..8767874 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1787,7 +1787,7 @@ static void musb_gadget_release(struct device *dev)
 }
 
 
-static void __devinit
+static void
 init_peripheral_ep(struct musb *musb, struct musb_ep *ep, u8 epnum, int is_in)
 {
 	struct musb_hw_ep	*hw_ep = musb->endpoints + epnum;
@@ -1824,7 +1824,7 @@ init_peripheral_ep(struct musb *musb, struct musb_ep *ep, u8 epnum, int is_in)
  * Initialize the endpoints exposed to peripheral drivers, with backlinks
  * to the rest of the driver state.
  */
-static inline void __devinit musb_g_init_endpoints(struct musb *musb)
+static inline void musb_g_init_endpoints(struct musb *musb)
 {
 	u8			epnum;
 	struct musb_hw_ep	*hw_ep;
@@ -1857,7 +1857,7 @@ static inline void __devinit musb_g_init_endpoints(struct musb *musb)
 /* called once during driver setup to initialize and link into
  * the driver model; memory is zeroed.
  */
-int __devinit musb_gadget_setup(struct musb *musb)
+int musb_gadget_setup(struct musb *musb)
 {
 	int status;
 
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 0fc6ca6..3d1fd52 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -380,8 +380,7 @@ void dma_controller_destroy(struct dma_controller *c)
 	kfree(controller);
 }
 
-struct dma_controller *__devinit
-dma_controller_create(struct musb *musb, void __iomem *base)
+struct dma_controller *dma_controller_create(struct musb *musb, void __iomem *base)
 {
 	struct musb_dma_controller *controller;
 	struct device *dev = musb->controller;
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 1150b4b..06850f2 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -490,7 +490,7 @@ static const struct musb_platform_ops omap2430_ops = {
 
 static u64 omap2430_dmamask = DMA_BIT_MASK(32);
 
-static int __devinit omap2430_probe(struct platform_device *pdev)
+static int omap2430_probe(struct platform_device *pdev)
 {
 	struct musb_hdrc_platform_data	*pdata = pdev->dev.platform_data;
 	struct omap_musb_board_data	*data;
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index b816517..a03b7be 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -1153,7 +1153,7 @@ static const struct musb_platform_ops tusb_ops = {
 
 static u64 tusb_dmamask = DMA_BIT_MASK(32);
 
-static int __devinit tusb_probe(struct platform_device *pdev)
+static int tusb_probe(struct platform_device *pdev)
 {
 	struct musb_hdrc_platform_data	*pdata = pdev->dev.platform_data;
 	struct platform_device		*musb;
diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index bfca114..9716850 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -668,8 +668,7 @@ void dma_controller_destroy(struct dma_controller *c)
 	kfree(tusb_dma);
 }
 
-struct dma_controller *__devinit
-dma_controller_create(struct musb *musb, void __iomem *base)
+struct dma_controller *dma_controller_create(struct musb *musb, void __iomem *base)
 {
 	void __iomem		*tbase = musb->ctrl_base;
 	struct tusb_omap_dma	*tusb_dma;
diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
index 1d81557..6b12001 100644
--- a/drivers/usb/musb/ux500.c
+++ b/drivers/usb/musb/ux500.c
@@ -81,7 +81,7 @@ static const struct musb_platform_ops ux500_ops = {
 	.exit		= ux500_musb_exit,
 };
 
-static int __devinit ux500_probe(struct platform_device *pdev)
+static int ux500_probe(struct platform_device *pdev)
 {
 	struct musb_hdrc_platform_data	*pdata = pdev->dev.platform_data;
 	struct platform_device		*musb;
diff --git a/drivers/usb/musb/ux500_dma.c b/drivers/usb/musb/ux500_dma.c
index f1059e7..039e567 100644
--- a/drivers/usb/musb/ux500_dma.c
+++ b/drivers/usb/musb/ux500_dma.c
@@ -364,8 +364,7 @@ void dma_controller_destroy(struct dma_controller *c)
 	kfree(controller);
 }
 
-struct dma_controller *__devinit
-dma_controller_create(struct musb *musb, void __iomem *base)
+struct dma_controller *dma_controller_create(struct musb *musb, void __iomem *base)
 {
 	struct ux500_dma_controller *controller;
 	struct platform_device *pdev = to_platform_device(musb->controller);
diff --git a/drivers/usb/otg/ab8500-usb.c b/drivers/usb/otg/ab8500-usb.c
index 62ea0c2..f0ba931 100644
--- a/drivers/usb/otg/ab8500-usb.c
+++ b/drivers/usb/otg/ab8500-usb.c
@@ -468,7 +468,7 @@ static int ab8500_usb_v2_res_setup(struct platform_device *pdev,
 	return 0;
 }
 
-static int __devinit ab8500_usb_probe(struct platform_device *pdev)
+static int ab8500_usb_probe(struct platform_device *pdev)
 {
 	struct ab8500_usb	*ab;
 	struct usb_otg		*otg;
diff --git a/drivers/usb/otg/fsl_otg.c b/drivers/usb/otg/fsl_otg.c
index 77dad18..2b9a838 100644
--- a/drivers/usb/otg/fsl_otg.c
+++ b/drivers/usb/otg/fsl_otg.c
@@ -1110,7 +1110,7 @@ static const struct file_operations otg_fops = {
 	.release = fsl_otg_release,
 };
 
-static int __devinit fsl_otg_probe(struct platform_device *pdev)
+static int fsl_otg_probe(struct platform_device *pdev)
 {
 	int ret;
 
diff --git a/drivers/usb/otg/isp1301_omap.c b/drivers/usb/otg/isp1301_omap.c
index ceee211..af9cb11 100644
--- a/drivers/usb/otg/isp1301_omap.c
+++ b/drivers/usb/otg/isp1301_omap.c
@@ -1493,7 +1493,7 @@ isp1301_start_hnp(struct usb_otg *otg)
 
 /*-------------------------------------------------------------------------*/
 
-static int __devinit
+static int
 isp1301_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 {
 	int			status;
diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
index 0502c24..28f70e2 100644
--- a/drivers/usb/otg/nop-usb-xceiv.c
+++ b/drivers/usb/otg/nop-usb-xceiv.c
@@ -93,7 +93,7 @@ static int nop_set_host(struct usb_otg *otg, struct usb_bus *host)
 	return 0;
 }
 
-static int __devinit nop_usb_xceiv_probe(struct platform_device *pdev)
+static int nop_usb_xceiv_probe(struct platform_device *pdev)
 {
 	struct nop_usb_xceiv_platform_data *pdata = pdev->dev.platform_data;
 	struct nop_usb_xceiv	*nop;
diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 11b2a12..0a70193 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -575,7 +575,7 @@ static int twl4030_set_host(struct usb_otg *otg, struct usb_bus *host)
 	return 0;
 }
 
-static int __devinit twl4030_usb_probe(struct platform_device *pdev)
+static int twl4030_usb_probe(struct platform_device *pdev)
 {
 	struct twl4030_usb_data *pdata = pdev->dev.platform_data;
 	struct twl4030_usb	*twl;
diff --git a/drivers/usb/otg/twl6030-usb.c b/drivers/usb/otg/twl6030-usb.c
index fcadef7..8cd6cf4 100644
--- a/drivers/usb/otg/twl6030-usb.c
+++ b/drivers/usb/otg/twl6030-usb.c
@@ -310,7 +310,7 @@ static int twl6030_set_vbus(struct phy_companion *comparator, bool enabled)
 	return 0;
 }
 
-static int __devinit twl6030_usb_probe(struct platform_device *pdev)
+static int twl6030_usb_probe(struct platform_device *pdev)
 {
 	u32 ret;
 	struct twl6030_usb	*twl;
diff --git a/drivers/usb/phy/mv_u3d_phy.c b/drivers/usb/phy/mv_u3d_phy.c
index 80cf57e..eaddbe3 100644
--- a/drivers/usb/phy/mv_u3d_phy.c
+++ b/drivers/usb/phy/mv_u3d_phy.c
@@ -262,7 +262,7 @@ calstart:
 	return 0;
 }
 
-static int __devinit mv_u3d_phy_probe(struct platform_device *pdev)
+static int mv_u3d_phy_probe(struct platform_device *pdev)
 {
 	struct mv_u3d_phy *mv_u3d_phy;
 	struct mv_usb_platform_data *pdata;
diff --git a/drivers/usb/phy/omap-usb2.c b/drivers/usb/phy/omap-usb2.c
index f1ed872..c10fb8b 100644
--- a/drivers/usb/phy/omap-usb2.c
+++ b/drivers/usb/phy/omap-usb2.c
@@ -141,7 +141,7 @@ static int omap_usb2_suspend(struct usb_phy *x, int suspend)
 	return 0;
 }
 
-static int __devinit omap_usb2_probe(struct platform_device *pdev)
+static int omap_usb2_probe(struct platform_device *pdev)
 {
 	struct omap_usb			*phy;
 	struct usb_otg			*otg;
diff --git a/drivers/usb/phy/rcar-phy.c b/drivers/usb/phy/rcar-phy.c
index 703a295..84ac2a7 100644
--- a/drivers/usb/phy/rcar-phy.c
+++ b/drivers/usb/phy/rcar-phy.c
@@ -142,7 +142,7 @@ static void rcar_usb_phy_shutdown(struct usb_phy *phy)
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
-static int __devinit rcar_usb_phy_probe(struct platform_device *pdev)
+static int rcar_usb_phy_probe(struct platform_device *pdev)
 {
 	struct rcar_usb_phy_priv *priv;
 	struct resource *res0, *res1;
-- 
1.8.0
