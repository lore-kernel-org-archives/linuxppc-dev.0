Return-Path: <wfp5p@viridian.itc.virginia.edu>
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 158/493] video: remove use of __devinit
Date: Mon, 19 Nov 2012 13:21:47 -0500
Message-Id: <1353349642-3677-158-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: linux-fbdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Michal Januszewski <spock@gentoo.org>, Paul Mackerras <paulus@samba.org>,
 linux-nvidia@lists.surfsouth.com, Daniel Walker <dwalker@fifo99.com>,
 Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>,
 Wan ZongShun <mcuos.com@gmail.com>,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
 Jingoo Han <jg1.han@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 David Brown <davidb@codeaurora.org>, Jaya Kumar <jayalk@intworks.biz>,
 cbe-oss-dev@lists.ozlabs.org, Antonino Daplas <adaplas@gmail.com>,
 linux-arm-msm@vger.kernel.org, Thomas Winischhofer <thomas@winischhofer.net>,
 linux-geode@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Maik Broemme <mbroemme@plusserver.de>,
 Geoff Levand <geoff@infradead.org>, Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
 Tony Prisk <linux@prisktech.co.nz>, Bryan Huntsman <bryanh@codeaurora.org>,
 Kristoffer Ericson <kristoffer.ericson@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xensource.com
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
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de> 
Cc: Jaya Kumar <jayalk@intworks.biz> 
Cc: Paul Mackerras <paulus@samba.org> 
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org> 
Cc: Russell King <linux@arm.linux.org.uk> 
Cc: Jingoo Han <jg1.han@samsung.com> 
Cc: Ferenc Bakonyi <fero@drama.obuda.kando.hu> 
Cc: Antonino Daplas <adaplas@gmail.com> 
Cc: Maik Broemme <mbroemme@plusserver.de> 
Cc: David Brown <davidb@codeaurora.org> 
Cc: Daniel Walker <dwalker@fifo99.com> 
Cc: Bryan Huntsman <bryanh@codeaurora.org> 
Cc: Wan ZongShun <mcuos.com@gmail.com> 
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com> 
Cc: Geoff Levand <geoff@infradead.org> 
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com> 
Cc: Ben Dooks <ben-linux@fluff.org> 
Cc: Kukjin Kim <kgene.kim@samsung.com> 
Cc: Thomas Winischhofer <thomas@winischhofer.net> 
Cc: Michal Januszewski <spock@gentoo.org> 
Cc: Tony Prisk <linux@prisktech.co.nz> 
Cc: linux-fbdev@vger.kernel.org 
Cc: linux-arm-kernel@lists.infradead.org 
Cc: linux-geode@lists.infradead.org 
Cc: linux-nvidia@lists.surfsouth.com 
Cc: linux-arm-msm@vger.kernel.org 
Cc: linux-omap@vger.kernel.org 
Cc: linuxppc-dev@lists.ozlabs.org 
Cc: cbe-oss-dev@lists.ozlabs.org 
Cc: linux-samsung-soc@vger.kernel.org 
Cc: xen-devel@lists.xensource.com 
Cc: virtualization@lists.linux-foundation.org 
---
 drivers/video/acornfb.c                            | 14 ++--
 drivers/video/arcfb.c                              |  2 +-
 drivers/video/arkfb.c                              |  2 +-
 drivers/video/asiliantfb.c                         |  6 +-
 drivers/video/aty/aty128fb.c                       | 22 +++---
 drivers/video/aty/atyfb_base.c                     | 22 +++---
 drivers/video/aty/mach64_ct.c                      |  4 +-
 drivers/video/aty/mach64_cursor.c                  |  2 +-
 drivers/video/aty/radeon_base.c                    | 14 ++--
 drivers/video/aty/radeon_monitor.c                 | 16 ++---
 drivers/video/au1100fb.c                           |  2 +-
 drivers/video/au1200fb.c                           |  2 +-
 drivers/video/auo_k1900fb.c                        |  2 +-
 drivers/video/auo_k1901fb.c                        |  2 +-
 drivers/video/auo_k190x.c                          |  2 +-
 drivers/video/bf537-lq035.c                        |  6 +-
 drivers/video/bf54x-lq043fb.c                      |  2 +-
 drivers/video/bfin-lq035q1-fb.c                    |  6 +-
 drivers/video/bfin-t350mcqb-fb.c                   |  2 +-
 drivers/video/bfin_adv7393fb.c                     |  2 +-
 drivers/video/broadsheetfb.c                       |  8 +--
 drivers/video/bw2.c                                |  6 +-
 drivers/video/carminefb.c                          |  4 +-
 drivers/video/cg14.c                               |  4 +-
 drivers/video/cg3.c                                |  8 +--
 drivers/video/cg6.c                                |  8 +--
 drivers/video/chipsfb.c                            |  4 +-
 drivers/video/cirrusfb.c                           | 10 +--
 drivers/video/cobalt_lcdfb.c                       |  2 +-
 drivers/video/console/sticore.c                    | 47 ++++++-------
 drivers/video/cyber2000fb.c                        | 12 ++--
 drivers/video/da8xx-fb.c                           |  2 +-
 drivers/video/dnfb.c                               |  2 +-
 drivers/video/ep93xx-fb.c                          |  4 +-
 drivers/video/exynos/exynos_dp_core.c              |  2 +-
 drivers/video/ffb.c                                |  2 +-
 drivers/video/fm2fb.c                              |  4 +-
 drivers/video/fsl-diu-fb.c                         |  4 +-
 drivers/video/gbefb.c                              |  4 +-
 drivers/video/geode/gx1fb_core.c                   |  6 +-
 drivers/video/geode/gxfb_core.c                    | 10 +--
 drivers/video/geode/lxfb_core.c                    | 10 +--
 drivers/video/grvga.c                              |  4 +-
 drivers/video/gxt4500.c                            |  4 +-
 drivers/video/hecubafb.c                           |  2 +-
 drivers/video/hgafb.c                              |  4 +-
 drivers/video/hitfb.c                              |  2 +-
 drivers/video/hpfb.c                               |  4 +-
 drivers/video/i740fb.c                             |  4 +-
 drivers/video/i810/i810_main.c                     | 26 +++----
 drivers/video/i810/i810_main.h                     |  2 +-
 drivers/video/imsttfb.c                            |  4 +-
 drivers/video/intelfb/intelfbdrv.c                 | 16 ++---
 drivers/video/jz4740_fb.c                          |  2 +-
 drivers/video/kyro/fbdev.c                         |  2 +-
 drivers/video/leo.c                                |  2 +-
 drivers/video/mb862xx/mb862xxfbdrv.c               |  6 +-
 drivers/video/mbx/mbxdebugfs.c                     |  2 +-
 drivers/video/mbx/mbxfb.c                          | 10 +--
 drivers/video/metronomefb.c                        | 12 ++--
 drivers/video/msm/mddi.c                           |  6 +-
 drivers/video/mxsfb.c                              |  6 +-
 drivers/video/neofb.c                              | 12 ++--
 drivers/video/nuc900fb.c                           |  4 +-
 drivers/video/nvidia/nvidia.c                      | 12 ++--
 .../omap2/displays/panel-lgphilips-lb035q02.c      |  2 +-
 drivers/video/p9100.c                              |  2 +-
 drivers/video/platinumfb.c                         |  6 +-
 drivers/video/pm2fb.c                              |  2 +-
 drivers/video/pm3fb.c                              |  4 +-
 drivers/video/pmag-ba-fb.c                         |  2 +-
 drivers/video/pmagb-b-fb.c                         |  6 +-
 drivers/video/ps3fb.c                              |  2 +-
 drivers/video/pvr2fb.c                             |  6 +-
 drivers/video/pxa168fb.c                           |  4 +-
 drivers/video/pxa3xx-gcu.c                         |  2 +-
 drivers/video/pxafb.c                              | 20 +++---
 drivers/video/q40fb.c                              |  2 +-
 drivers/video/riva/fbdev.c                         | 20 +++---
 drivers/video/riva/rivafb-i2c.c                    |  6 +-
 drivers/video/s1d13xxxfb.c                         |  4 +-
 drivers/video/s3c-fb.c                             |  6 +-
 drivers/video/s3c2410fb.c                          |  8 +--
 drivers/video/s3fb.c                               |  6 +-
 drivers/video/sa1100fb.c                           |  6 +-
 drivers/video/savage/savagefb_driver.c             |  8 +--
 drivers/video/sgivwfb.c                            |  2 +-
 drivers/video/sh7760fb.c                           |  2 +-
 drivers/video/sh_mobile_lcdcfb.c                   | 16 ++---
 drivers/video/sh_mobile_meram.c                    |  2 +-
 drivers/video/sis/sis_main.c                       | 82 +++++++++++-----------
 drivers/video/skeletonfb.c                         |  2 +-
 drivers/video/sm501fb.c                            |  8 +--
 drivers/video/sstfb.c                              | 18 ++---
 drivers/video/sunxvr1000.c                         |  6 +-
 drivers/video/sunxvr2500.c                         |  6 +-
 drivers/video/sunxvr500.c                          |  6 +-
 drivers/video/tcx.c                                |  2 +-
 drivers/video/tdfxfb.c                             | 10 +--
 drivers/video/tgafb.c                              | 16 ++---
 drivers/video/tmiofb.c                             |  2 +-
 drivers/video/tridentfb.c                          |  8 +--
 drivers/video/uvesafb.c                            | 30 ++++----
 drivers/video/vermilion/vermilion.c                |  2 +-
 drivers/video/vfb.c                                |  2 +-
 drivers/video/vga16fb.c                            |  2 +-
 drivers/video/via/dvi.c                            |  8 +--
 drivers/video/via/dvi.h                            |  4 +-
 drivers/video/via/hw.c                             | 16 ++---
 drivers/video/via/hw.h                             |  4 +-
 drivers/video/via/lcd.c                            | 10 +--
 drivers/video/via/lcd.h                            |  6 +-
 drivers/video/via/via-core.c                       | 10 +--
 drivers/video/via/via-gpio.c                       |  2 +-
 drivers/video/via/viafbdev.c                       | 10 +--
 drivers/video/vt8500lcdfb.c                        |  2 +-
 drivers/video/vt8623fb.c                           |  2 +-
 drivers/video/w100fb.c                             |  6 +-
 drivers/video/wm8505fb.c                           |  2 +-
 drivers/video/wmt_ge_rops.c                        |  2 +-
 drivers/video/xen-fbfront.c                        |  4 +-
 drivers/video/xilinxfb.c                           |  2 +-
 122 files changed, 438 insertions(+), 443 deletions(-)

diff --git a/drivers/video/acornfb.c b/drivers/video/acornfb.c
index b303f17..772f1ce 100644
--- a/drivers/video/acornfb.c
+++ b/drivers/video/acornfb.c
@@ -942,7 +942,7 @@ static struct fb_videomode acornfb_default_mode __devinitdata = {
 	.vmode =	FB_VMODE_NONINTERLACED
 };
 
-static void __devinit acornfb_init_fbinfo(void)
+static void acornfb_init_fbinfo(void)
 {
 	static int first = 1;
 
@@ -1018,7 +1018,7 @@ static void __devinit acornfb_init_fbinfo(void)
  *	size can optionally be followed by 'M' or 'K' for
  *	MB or KB respectively.
  */
-static void __devinit acornfb_parse_mon(char *opt)
+static void acornfb_parse_mon(char *opt)
 {
 	char *p = opt;
 
@@ -1065,7 +1065,7 @@ bad:
 	current_par.montype = -1;
 }
 
-static void __devinit acornfb_parse_montype(char *opt)
+static void acornfb_parse_montype(char *opt)
 {
 	current_par.montype = -2;
 
@@ -1106,7 +1106,7 @@ static void __devinit acornfb_parse_montype(char *opt)
 	}
 }
 
-static void __devinit acornfb_parse_dram(char *opt)
+static void acornfb_parse_dram(char *opt)
 {
 	unsigned int size;
 
@@ -1138,7 +1138,7 @@ static struct options {
 	{ NULL, NULL }
 };
 
-static int __devinit acornfb_setup(char *options)
+static int acornfb_setup(char *options)
 {
 	struct options *optp;
 	char *opt;
@@ -1175,7 +1175,7 @@ static int __devinit acornfb_setup(char *options)
  * Detect type of monitor connected
  *  For now, we just assume SVGA
  */
-static int __devinit acornfb_detect_monitortype(void)
+static int acornfb_detect_monitortype(void)
 {
 	return 4;
 }
@@ -1216,7 +1216,7 @@ free_unused_pages(unsigned int virtual_start, unsigned int virtual_end)
 	printk("acornfb: freed %dK memory\n", mb_freed);
 }
 
-static int __devinit acornfb_probe(struct platform_device *dev)
+static int acornfb_probe(struct platform_device *dev)
 {
 	unsigned long size;
 	u_int h_sync, v_sync;
diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
index 00967d2..964431a 100644
--- a/drivers/video/arcfb.c
+++ b/drivers/video/arcfb.c
@@ -502,7 +502,7 @@ static struct fb_ops arcfb_ops = {
 	.fb_ioctl 	= arcfb_ioctl,
 };
 
-static int __devinit arcfb_probe(struct platform_device *dev)
+static int arcfb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
 	int retval = -ENOMEM;
diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index 6bcb6c1..750efbc 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -950,7 +950,7 @@ static struct fb_ops arkfb_ops = {
 
 
 /* PCI probe */
-static int __devinit ark_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int ark_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct pci_bus_region bus_reg;
 	struct resource vga_res;
diff --git a/drivers/video/asiliantfb.c b/drivers/video/asiliantfb.c
index 640cc69..21744e9 100644
--- a/drivers/video/asiliantfb.c
+++ b/drivers/video/asiliantfb.c
@@ -451,7 +451,7 @@ static struct chips_init_reg chips_init_xr[] =
 	{0xd1, 0x01},
 };
 
-static void __devinit chips_hw_init(struct fb_info *p)
+static void chips_hw_init(struct fb_info *p)
 {
 	int i;
 
@@ -504,7 +504,7 @@ static struct fb_var_screeninfo asiliantfb_var __devinitdata = {
 	.vsync_len 	= 2,
 };
 
-static int __devinit init_asiliant(struct fb_info *p, unsigned long addr)
+static int init_asiliant(struct fb_info *p, unsigned long addr)
 {
 	int err;
 
@@ -535,7 +535,7 @@ static int __devinit init_asiliant(struct fb_info *p, unsigned long addr)
 	return 0;
 }
 
-static int __devinit
+static int
 asiliantfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
 {
 	unsigned long addr, size;
diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
index 426e3f2..d9f88cc 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -449,9 +449,9 @@ static int aty128_encode_var(struct fb_var_screeninfo *var,
 static int aty128_decode_var(struct fb_var_screeninfo *var,
                              struct aty128fb_par *par);
 #if 0
-static void __devinit aty128_get_pllinfo(struct aty128fb_par *par,
+static void aty128_get_pllinfo(struct aty128fb_par *par,
 					 void __iomem *bios);
-static void __devinit __iomem *aty128_map_ROM(struct pci_dev *pdev,
+static void __iomem *aty128_map_ROM(struct pci_dev *pdev,
 					      const struct aty128fb_par *par);
 #endif
 static void aty128_timings(struct aty128fb_par *par);
@@ -582,7 +582,7 @@ static void aty_pll_writeupdate(const struct aty128fb_par *par)
 
 
 /* write to the scratch register to test r/w functionality */
-static int __devinit register_test(const struct aty128fb_par *par)
+static int register_test(const struct aty128fb_par *par)
 {
 	u32 val;
 	int flag = 0;
@@ -781,7 +781,7 @@ static u32 depth_to_dst(u32 depth)
 
 
 #ifndef __sparc__
-static void __iomem * __devinit aty128_map_ROM(const struct aty128fb_par *par,
+static void __iomem *aty128_map_ROM(const struct aty128fb_par *par,
 					       struct pci_dev *dev)
 {
 	u16 dptr;
@@ -868,7 +868,7 @@ static void __iomem * __devinit aty128_map_ROM(const struct aty128fb_par *par,
 	return NULL;
 }
 
-static void __devinit aty128_get_pllinfo(struct aty128fb_par *par,
+static void aty128_get_pllinfo(struct aty128fb_par *par,
 					 unsigned char __iomem *bios)
 {
 	unsigned int bios_hdr;
@@ -891,7 +891,7 @@ static void __devinit aty128_get_pllinfo(struct aty128fb_par *par,
 }           
 
 #ifdef CONFIG_X86
-static void __iomem *  __devinit aty128_find_mem_vbios(struct aty128fb_par *par)
+static void __iomem *aty128_find_mem_vbios(struct aty128fb_par *par)
 {
 	/* I simplified this code as we used to miss the signatures in
 	 * a lot of case. It's now closer to XFree, we just don't check
@@ -916,7 +916,7 @@ static void __iomem *  __devinit aty128_find_mem_vbios(struct aty128fb_par *par)
 #endif /* ndef(__sparc__) */
 
 /* fill in known card constants if pll_block is not available */
-static void __devinit aty128_timings(struct aty128fb_par *par)
+static void aty128_timings(struct aty128fb_par *par)
 {
 #ifdef CONFIG_PPC_OF
 	/* instead of a table lookup, assume OF has properly
@@ -1658,7 +1658,7 @@ static int aty128fb_sync(struct fb_info *info)
 }
 
 #ifndef MODULE
-static int __devinit aty128fb_setup(char *options)
+static int aty128fb_setup(char *options)
 {
 	char *this_opt;
 
@@ -1888,7 +1888,7 @@ static void aty128_early_resume(void *data)
 }
 #endif /* CONFIG_PPC_PMAC */
 
-static int __devinit aty128_init(struct pci_dev *pdev,
+static int aty128_init(struct pci_dev *pdev,
 				 const struct pci_device_id *ent)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
@@ -2039,7 +2039,7 @@ static int __devinit aty128_init(struct pci_dev *pdev,
 
 #ifdef CONFIG_PCI
 /* register a card    ++ajoshi */
-static int __devinit aty128_probe(struct pci_dev *pdev,
+static int aty128_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *ent)
 {
 	unsigned long fb_addr, reg_addr;
@@ -2558,7 +2558,7 @@ static int aty128_pci_resume(struct pci_dev *pdev)
 }
 
 
-static int __devinit aty128fb_init(void)
+static int aty128fb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index bab571b..ae75dd3 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -426,7 +426,7 @@ static struct {
 #endif /* CONFIG_FB_ATY_CT */
 };
 
-static int __devinit correct_chipset(struct atyfb_par *par)
+static int correct_chipset(struct atyfb_par *par)
 {
 	u8 rev;
 	u16 type;
@@ -588,7 +588,7 @@ static u32 atyfb_get_pixclock(struct fb_var_screeninfo *var,
  * Apple monitor sense
  */
 
-static int __devinit read_aty_sense(const struct atyfb_par *par)
+static int read_aty_sense(const struct atyfb_par *par)
 {
 	int sense, i;
 
@@ -2273,7 +2273,7 @@ static void aty_bl_exit(struct backlight_device *bd)
 
 #endif /* CONFIG_FB_ATY_BACKLIGHT */
 
-static void __devinit aty_calc_mem_refresh(struct atyfb_par *par, int xclk)
+static void aty_calc_mem_refresh(struct atyfb_par *par, int xclk)
 {
 	const int ragepro_tbl[] = {
 		44, 50, 55, 66, 75, 80, 100
@@ -2307,7 +2307,7 @@ static void __devinit aty_calc_mem_refresh(struct atyfb_par *par, int xclk)
 static struct fb_info *fb_list = NULL;
 
 #if defined(__i386__) && defined(CONFIG_FB_ATY_GENERIC_LCD)
-static int __devinit atyfb_get_timings_from_lcd(struct atyfb_par *par,
+static int atyfb_get_timings_from_lcd(struct atyfb_par *par,
 						struct fb_var_screeninfo *var)
 {
 	int ret = -EINVAL;
@@ -2333,7 +2333,7 @@ static int __devinit atyfb_get_timings_from_lcd(struct atyfb_par *par,
 }
 #endif /* defined(__i386__) && defined(CONFIG_FB_ATY_GENERIC_LCD) */
 
-static int __devinit aty_init(struct fb_info *info)
+static int aty_init(struct fb_info *info)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	const char *ramname = NULL, *xtal;
@@ -2787,7 +2787,7 @@ aty_init_exit:
 }
 
 #if defined(CONFIG_ATARI) && !defined(MODULE)
-static int __devinit store_video_par(char *video_str, unsigned char m64_num)
+static int store_video_par(char *video_str, unsigned char m64_num)
 {
 	char *p;
 	unsigned long vmembase, size, guiregbase;
@@ -2961,7 +2961,7 @@ static int atyfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 
 #ifdef __sparc__
 
-static int __devinit atyfb_setup_sparc(struct pci_dev *pdev,
+static int atyfb_setup_sparc(struct pci_dev *pdev,
 				       struct fb_info *info,
 				       unsigned long addr)
 {
@@ -3161,7 +3161,7 @@ static int __devinit atyfb_setup_sparc(struct pci_dev *pdev,
 
 #ifdef __i386__
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
-static void __devinit aty_init_lcd(struct atyfb_par *par, u32 bios_base)
+static void aty_init_lcd(struct atyfb_par *par, u32 bios_base)
 {
 	u32 driv_inf_tab, sig;
 	u16 lcd_ofs;
@@ -3392,7 +3392,7 @@ static void __devinit aty_init_lcd(struct atyfb_par *par, u32 bios_base)
 }
 #endif /* CONFIG_FB_ATY_GENERIC_LCD */
 
-static int __devinit init_from_bios(struct atyfb_par *par)
+static int init_from_bios(struct atyfb_par *par)
 {
 	u32 bios_base, rom_addr;
 	int ret;
@@ -3445,7 +3445,7 @@ static int __devinit init_from_bios(struct atyfb_par *par)
 }
 #endif /* __i386__ */
 
-static int __devinit atyfb_setup_generic(struct pci_dev *pdev,
+static int atyfb_setup_generic(struct pci_dev *pdev,
 					 struct fb_info *info,
 					 unsigned long addr)
 {
@@ -3525,7 +3525,7 @@ atyfb_setup_generic_fail:
 
 #endif /* !__sparc__ */
 
-static int __devinit atyfb_pci_probe(struct pci_dev *pdev,
+static int atyfb_pci_probe(struct pci_dev *pdev,
 				     const struct pci_device_id *ent)
 {
 	unsigned long addr, res_start, res_size;
diff --git a/drivers/video/aty/mach64_ct.c b/drivers/video/aty/mach64_ct.c
index 2745b85..31dd017 100644
--- a/drivers/video/aty/mach64_ct.c
+++ b/drivers/video/aty/mach64_ct.c
@@ -373,7 +373,7 @@ void aty_set_pll_ct(const struct fb_info *info, const union aty_pll *pll)
 #endif
 }
 
-static void __devinit aty_get_pll_ct(const struct fb_info *info,
+static void aty_get_pll_ct(const struct fb_info *info,
 				     union aty_pll *pll)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
@@ -397,7 +397,7 @@ static void __devinit aty_get_pll_ct(const struct fb_info *info,
 	}
 }
 
-static int __devinit aty_init_pll_ct(const struct fb_info *info,
+static int aty_init_pll_ct(const struct fb_info *info,
 				     union aty_pll *pll)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
diff --git a/drivers/video/aty/mach64_cursor.c b/drivers/video/aty/mach64_cursor.c
index 46f72ed..95ec042 100644
--- a/drivers/video/aty/mach64_cursor.c
+++ b/drivers/video/aty/mach64_cursor.c
@@ -183,7 +183,7 @@ static int atyfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 	return 0;
 }
 
-int __devinit aty_init_cursor(struct fb_info *info)
+int aty_init_cursor(struct fb_info *info)
 {
 	unsigned long addr;
 
diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index dacaa4e..7687179 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -293,7 +293,7 @@ static void radeon_unmap_ROM(struct radeonfb_info *rinfo, struct pci_dev *dev)
 	pci_unmap_rom(dev, rinfo->bios_seg);
 }
 
-static int __devinit radeon_map_ROM(struct radeonfb_info *rinfo, struct pci_dev *dev)
+static int radeon_map_ROM(struct radeonfb_info *rinfo, struct pci_dev *dev)
 {
 	void __iomem *rom;
 	u16 dptr;
@@ -388,7 +388,7 @@ static int __devinit radeon_map_ROM(struct radeonfb_info *rinfo, struct pci_dev
 }
 
 #ifdef CONFIG_X86
-static int  __devinit radeon_find_mem_vbios(struct radeonfb_info *rinfo)
+static int  radeon_find_mem_vbios(struct radeonfb_info *rinfo)
 {
 	/* I simplified this code as we used to miss the signatures in
 	 * a lot of case. It's now closer to XFree, we just don't check
@@ -423,7 +423,7 @@ static int  __devinit radeon_find_mem_vbios(struct radeonfb_info *rinfo)
  * Read XTAL (ref clock), SCLK and MCLK from Open Firmware device
  * tree. Hopefully, ATI OF driver is kind enough to fill these
  */
-static int __devinit radeon_read_xtal_OF (struct radeonfb_info *rinfo)
+static int radeon_read_xtal_OF (struct radeonfb_info *rinfo)
 {
 	struct device_node *dp = rinfo->of_node;
 	const u32 *val;
@@ -453,7 +453,7 @@ static int __devinit radeon_read_xtal_OF (struct radeonfb_info *rinfo)
 /*
  * Read PLL infos from chip registers
  */
-static int __devinit radeon_probe_pll_params(struct radeonfb_info *rinfo)
+static int radeon_probe_pll_params(struct radeonfb_info *rinfo)
 {
 	unsigned char ppll_div_sel;
 	unsigned Ns, Nm, M;
@@ -591,7 +591,7 @@ static int __devinit radeon_probe_pll_params(struct radeonfb_info *rinfo)
 /*
  * Retrieve PLL infos by different means (BIOS, Open Firmware, register probing...)
  */
-static void __devinit radeon_get_pllinfo(struct radeonfb_info *rinfo)
+static void radeon_get_pllinfo(struct radeonfb_info *rinfo)
 {
 	/*
 	 * In the case nothing works, these are defaults; they are mostly
@@ -1868,7 +1868,7 @@ static struct fb_ops radeonfb_ops = {
 };
 
 
-static int __devinit radeon_set_fbinfo (struct radeonfb_info *rinfo)
+static int radeon_set_fbinfo (struct radeonfb_info *rinfo)
 {
 	struct fb_info *info = rinfo->info;
 
@@ -2143,7 +2143,7 @@ static struct bin_attribute edid2_attr = {
 };
 
 
-static int __devinit radeonfb_pci_register (struct pci_dev *pdev,
+static int radeonfb_pci_register (struct pci_dev *pdev,
 				  const struct pci_device_id *ent)
 {
 	struct fb_info *info;
diff --git a/drivers/video/aty/radeon_monitor.c b/drivers/video/aty/radeon_monitor.c
index 5c23eac..d6d861b 100644
--- a/drivers/video/aty/radeon_monitor.c
+++ b/drivers/video/aty/radeon_monitor.c
@@ -62,7 +62,7 @@ static char *radeon_get_mon_name(int type)
  * models with broken OF probing by hard-coding known EDIDs for some Mac
  * laptops internal LVDS panel. (XXX: not done yet)
  */
-static int __devinit radeon_parse_montype_prop(struct device_node *dp, u8 **out_EDID,
+static int radeon_parse_montype_prop(struct device_node *dp, u8 **out_EDID,
 					       int hdno)
 {
         static char *propnames[] = { "DFP,EDID", "LCD,EDID", "EDID",
@@ -115,7 +115,7 @@ static int __devinit radeon_parse_montype_prop(struct device_node *dp, u8 **out_
 	return mt;
 }
 
-static int __devinit radeon_probe_OF_head(struct radeonfb_info *rinfo, int head_no,
+static int radeon_probe_OF_head(struct radeonfb_info *rinfo, int head_no,
 					  u8 **out_EDID)
 {
         struct device_node *dp;
@@ -163,7 +163,7 @@ static int __devinit radeon_probe_OF_head(struct radeonfb_info *rinfo, int head_
 #endif /* CONFIG_PPC_OF || CONFIG_SPARC */
 
 
-static int __devinit radeon_get_panel_info_BIOS(struct radeonfb_info *rinfo)
+static int radeon_get_panel_info_BIOS(struct radeonfb_info *rinfo)
 {
 	unsigned long tmp, tmp0;
 	char stmp[30];
@@ -251,7 +251,7 @@ static int __devinit radeon_get_panel_info_BIOS(struct radeonfb_info *rinfo)
  * doesn't quite work yet, but it's output is still useful for
  * debugging
  */
-static void __devinit radeon_parse_connector_info(struct radeonfb_info *rinfo)
+static void radeon_parse_connector_info(struct radeonfb_info *rinfo)
 {
 	int offset, chips, connectors, tmp, i, conn, type;
 
@@ -297,7 +297,7 @@ static void __devinit radeon_parse_connector_info(struct radeonfb_info *rinfo)
  * as well and currently is only implemented for the CRT DAC, the
  * code for the TVDAC is commented out in XFree as "non working"
  */
-static int __devinit radeon_crt_is_connected(struct radeonfb_info *rinfo, int is_crt_dac)
+static int radeon_crt_is_connected(struct radeonfb_info *rinfo, int is_crt_dac)
 {
     int	          connected = 0;
 
@@ -369,7 +369,7 @@ static int __devinit radeon_crt_is_connected(struct radeonfb_info *rinfo, int is
  * Parse the "monitor_layout" string if any. This code is mostly
  * copied from XFree's radeon driver
  */
-static int __devinit radeon_parse_monitor_layout(struct radeonfb_info *rinfo,
+static int radeon_parse_monitor_layout(struct radeonfb_info *rinfo,
 						 const char *monitor_layout)
 {
 	char s1[5], s2[5];
@@ -433,7 +433,7 @@ static int __devinit radeon_parse_monitor_layout(struct radeonfb_info *rinfo,
  * try to retrieve EDID. The algorithm here comes from XFree's radeon
  * driver
  */
-void __devinit radeon_probe_screens(struct radeonfb_info *rinfo,
+void radeon_probe_screens(struct radeonfb_info *rinfo,
 				    const char *monitor_layout, int ignore_edid)
 {
 #ifdef CONFIG_FB_RADEON_I2C
@@ -753,7 +753,7 @@ static int is_powerblade(const char *model)
  * Build the modedb for head 1 (head 2 will come later), check panel infos
  * from either BIOS or EDID, and pick up the default mode
  */
-void __devinit radeon_check_modes(struct radeonfb_info *rinfo, const char *mode_option)
+void radeon_check_modes(struct radeonfb_info *rinfo, const char *mode_option)
 {
 	struct fb_info * info = rinfo->info;
 	int has_default_mode = 0;
diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index fe3b6ec..b4b76dc 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -469,7 +469,7 @@ static int au1100fb_setup(struct au1100fb_device *fbdev)
 	return 0;
 }
 
-static int __devinit au1100fb_drv_probe(struct platform_device *dev)
+static int au1100fb_drv_probe(struct platform_device *dev)
 {
 	struct au1100fb_device *fbdev = NULL;
 	struct resource *regs_res;
diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
index 4538b07..b270a5c 100644
--- a/drivers/video/au1200fb.c
+++ b/drivers/video/au1200fb.c
@@ -1673,7 +1673,7 @@ out:
 }
 
 /* AU1200 LCD controller device driver */
-static int __devinit au1200fb_drv_probe(struct platform_device *dev)
+static int au1200fb_drv_probe(struct platform_device *dev)
 {
 	struct au1200fb_device *fbdev;
 	struct au1200fb_platdata *pd;
diff --git a/drivers/video/auo_k1900fb.c b/drivers/video/auo_k1900fb.c
index 1581dbf..46ec47b 100644
--- a/drivers/video/auo_k1900fb.c
+++ b/drivers/video/auo_k1900fb.c
@@ -156,7 +156,7 @@ static bool auok1900fb_need_refresh(struct auok190xfb_par *par)
 	return (par->update_cnt > 10);
 }
 
-static int __devinit auok1900fb_probe(struct platform_device *pdev)
+static int auok1900fb_probe(struct platform_device *pdev)
 {
 	struct auok190x_init_data init;
 	struct auok190x_board *board;
diff --git a/drivers/video/auo_k1901fb.c b/drivers/video/auo_k1901fb.c
index 94a0e01..9eb7eeb 100644
--- a/drivers/video/auo_k1901fb.c
+++ b/drivers/video/auo_k1901fb.c
@@ -209,7 +209,7 @@ static bool auok1901fb_need_refresh(struct auok190xfb_par *par)
 	return (par->update_cnt > 10);
 }
 
-static int __devinit auok1901fb_probe(struct platform_device *pdev)
+static int auok1901fb_probe(struct platform_device *pdev)
 {
 	struct auok190x_init_data init;
 	struct auok190x_board *board;
diff --git a/drivers/video/auo_k190x.c b/drivers/video/auo_k190x.c
index c03ecdd..70aa5d4 100644
--- a/drivers/video/auo_k190x.c
+++ b/drivers/video/auo_k190x.c
@@ -773,7 +773,7 @@ EXPORT_SYMBOL_GPL(auok190x_pm);
  * Common probe and remove code
  */
 
-int __devinit auok190x_common_probe(struct platform_device *pdev,
+int auok190x_common_probe(struct platform_device *pdev,
 				    struct auok190x_init_data *init)
 {
 	struct auok190x_board *board = init->board;
diff --git a/drivers/video/bf537-lq035.c b/drivers/video/bf537-lq035.c
index 8081c7b..0b7c757 100644
--- a/drivers/video/bf537-lq035.c
+++ b/drivers/video/bf537-lq035.c
@@ -87,7 +87,7 @@ static void set_vcomm(void)
 		pr_err("i2c_smbus_write_byte_data fail: %d\n", nr);
 }
 
-static int __devinit ad5280_probe(struct i2c_client *client,
+static int ad5280_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
 	int ret;
@@ -360,7 +360,7 @@ static int config_dma(void)
 	return 0;
 }
 
-static int __devinit request_ports(void)
+static int request_ports(void)
 {
 	u16 tmr_req[] = TIMERS;
 
@@ -686,7 +686,7 @@ static struct lcd_ops bfin_lcd_ops = {
 
 static struct lcd_device *lcd_dev;
 
-static int __devinit bfin_lq035_probe(struct platform_device *pdev)
+static int bfin_lq035_probe(struct platform_device *pdev)
 {
 	struct backlight_properties props;
 	dma_addr_t dma_handle;
diff --git a/drivers/video/bf54x-lq043fb.c b/drivers/video/bf54x-lq043fb.c
index aff8520..9f72580 100644
--- a/drivers/video/bf54x-lq043fb.c
+++ b/drivers/video/bf54x-lq043fb.c
@@ -497,7 +497,7 @@ static irqreturn_t bfin_bf54x_irq_error(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit bfin_bf54x_probe(struct platform_device *pdev)
+static int bfin_bf54x_probe(struct platform_device *pdev)
 {
 #ifndef NO_BL_SUPPORT
 	struct backlight_properties props;
diff --git a/drivers/video/bfin-lq035q1-fb.c b/drivers/video/bfin-lq035q1-fb.c
index acd438c..353fb7c 100644
--- a/drivers/video/bfin-lq035q1-fb.c
+++ b/drivers/video/bfin-lq035q1-fb.c
@@ -137,7 +137,7 @@ static int lq035q1_control(struct spi_device *spi, unsigned char reg, unsigned s
 	return ret;
 }
 
-static int __devinit lq035q1_spidev_probe(struct spi_device *spi)
+static int lq035q1_spidev_probe(struct spi_device *spi)
 {
 	int ret;
 	struct spi_control *ctl;
@@ -358,7 +358,7 @@ static inline void bfin_lq035q1_free_ports(unsigned ppi16)
 		gpio_free(P_IDENT(P_PPI0_FS3));
 }
 
-static int __devinit bfin_lq035q1_request_ports(struct platform_device *pdev,
+static int bfin_lq035q1_request_ports(struct platform_device *pdev,
 						unsigned ppi16)
 {
 	int ret;
@@ -555,7 +555,7 @@ static irqreturn_t bfin_lq035q1_irq_error(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit bfin_lq035q1_probe(struct platform_device *pdev)
+static int bfin_lq035q1_probe(struct platform_device *pdev)
 {
 	struct bfin_lq035q1fb_info *info;
 	struct fb_info *fbinfo;
diff --git a/drivers/video/bfin-t350mcqb-fb.c b/drivers/video/bfin-t350mcqb-fb.c
index c753abd..9456865 100644
--- a/drivers/video/bfin-t350mcqb-fb.c
+++ b/drivers/video/bfin-t350mcqb-fb.c
@@ -418,7 +418,7 @@ static irqreturn_t bfin_t350mcqb_irq_error(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit bfin_t350mcqb_probe(struct platform_device *pdev)
+static int bfin_t350mcqb_probe(struct platform_device *pdev)
 {
 #ifndef NO_BL_SUPPORT
 	struct backlight_properties props;
diff --git a/drivers/video/bfin_adv7393fb.c b/drivers/video/bfin_adv7393fb.c
index a32ef5a..85e9659 100644
--- a/drivers/video/bfin_adv7393fb.c
+++ b/drivers/video/bfin_adv7393fb.c
@@ -368,7 +368,7 @@ adv7393_write_proc(struct file *file, const char __user * buffer,
 	return count;
 }
 
-static int __devinit bfin_adv7393_fb_probe(struct i2c_client *client,
+static int bfin_adv7393_fb_probe(struct i2c_client *client,
 					   const struct i2c_device_id *id)
 {
 	int ret = 0;
diff --git a/drivers/video/broadsheetfb.c b/drivers/video/broadsheetfb.c
index 377dde3..bd15a9b 100644
--- a/drivers/video/broadsheetfb.c
+++ b/drivers/video/broadsheetfb.c
@@ -774,7 +774,7 @@ static DEVICE_ATTR(loadstore_waveform, S_IWUSR, NULL,
 			broadsheet_loadstore_waveform);
 
 /* upper level functions that manipulate the display and other stuff */
-static void __devinit broadsheet_init_display(struct broadsheetfb_par *par)
+static void broadsheet_init_display(struct broadsheetfb_par *par)
 {
 	u16 args[5];
 	int xres = par->info->var.xres;
@@ -834,7 +834,7 @@ static void __devinit broadsheet_init_display(struct broadsheetfb_par *par)
 	par->board->wait_for_rdy(par);
 }
 
-static void __devinit broadsheet_identify(struct broadsheetfb_par *par)
+static void broadsheet_identify(struct broadsheetfb_par *par)
 {
 	u16 rev, prc;
 	struct device *dev = par->info->device;
@@ -849,7 +849,7 @@ static void __devinit broadsheet_identify(struct broadsheetfb_par *par)
 		dev_warn(dev, "Unrecognized Broadsheet Revision\n");
 }
 
-static void __devinit broadsheet_init(struct broadsheetfb_par *par)
+static void broadsheet_init(struct broadsheetfb_par *par)
 {
 	broadsheet_send_command(par, BS_CMD_INIT_SYS_RUN);
 	/* the controller needs a second */
@@ -1058,7 +1058,7 @@ static struct fb_deferred_io broadsheetfb_defio = {
 	.deferred_io	= broadsheetfb_dpy_deferred_io,
 };
 
-static int __devinit broadsheetfb_probe(struct platform_device *dev)
+static int broadsheetfb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
 	struct broadsheet_board *board;
diff --git a/drivers/video/bw2.c b/drivers/video/bw2.c
index bc88682..21a8587 100644
--- a/drivers/video/bw2.c
+++ b/drivers/video/bw2.c
@@ -179,7 +179,7 @@ static int bw2_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
  *  Initialisation
  */
 
-static void __devinit bw2_init_fix(struct fb_info *info, int linebytes)
+static void bw2_init_fix(struct fb_info *info, int linebytes)
 {
 	strlcpy(info->fix.id, "bwtwo", sizeof(info->fix.id));
 
@@ -226,7 +226,7 @@ static u8 bw2regs_66hz[] __devinitdata = {
 	0x10, 0x20,	0
 };
 
-static int __devinit bw2_do_default_mode(struct bw2_par *par,
+static int bw2_do_default_mode(struct bw2_par *par,
 					 struct fb_info *info,
 					 int *linebytes)
 {
@@ -273,7 +273,7 @@ static int __devinit bw2_do_default_mode(struct bw2_par *par,
 	return 0;
 }
 
-static int __devinit bw2_probe(struct platform_device *op)
+static int bw2_probe(struct platform_device *op)
 {
 	struct device_node *dp = op->dev.of_node;
 	struct fb_info *info;
diff --git a/drivers/video/carminefb.c b/drivers/video/carminefb.c
index 27561cc..9d9eb08 100644
--- a/drivers/video/carminefb.c
+++ b/drivers/video/carminefb.c
@@ -537,7 +537,7 @@ static struct fb_ops carminefb_ops = {
 	.fb_setcolreg	= carmine_setcolreg,
 };
 
-static int __devinit alloc_carmine_fb(void __iomem *regs, void __iomem *smem_base,
+static int alloc_carmine_fb(void __iomem *regs, void __iomem *smem_base,
 		int smem_offset, struct device *device, struct fb_info **rinfo)
 {
 	int ret;
@@ -606,7 +606,7 @@ static void cleanup_fb_device(struct fb_info *info)
 	}
 }
 
-static int __devinit carminefb_probe(struct pci_dev *dev,
+static int carminefb_probe(struct pci_dev *dev,
 		const struct pci_device_id *ent)
 {
 	struct carmine_hw *hw;
diff --git a/drivers/video/cg14.c b/drivers/video/cg14.c
index 6889f0c..e9d80c1 100644
--- a/drivers/video/cg14.c
+++ b/drivers/video/cg14.c
@@ -352,7 +352,7 @@ static int cg14_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
  *  Initialisation
  */
 
-static void __devinit cg14_init_fix(struct fb_info *info, int linebytes,
+static void cg14_init_fix(struct fb_info *info, int linebytes,
 				    struct device_node *dp)
 {
 	const char *name = dp->name;
@@ -463,7 +463,7 @@ static void cg14_unmap_regs(struct platform_device *op, struct fb_info *info,
 			   info->screen_base, info->fix.smem_len);
 }
 
-static int __devinit cg14_probe(struct platform_device *op)
+static int cg14_probe(struct platform_device *op)
 {
 	struct device_node *dp = op->dev.of_node;
 	struct fb_info *info;
diff --git a/drivers/video/cg3.c b/drivers/video/cg3.c
index 0bd94d4..6102d57 100644
--- a/drivers/video/cg3.c
+++ b/drivers/video/cg3.c
@@ -243,7 +243,7 @@ static int cg3_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
  *  Initialisation
  */
 
-static void __devinit cg3_init_fix(struct fb_info *info, int linebytes,
+static void cg3_init_fix(struct fb_info *info, int linebytes,
 				   struct device_node *dp)
 {
 	strlcpy(info->fix.id, dp->name, sizeof(info->fix.id));
@@ -256,7 +256,7 @@ static void __devinit cg3_init_fix(struct fb_info *info, int linebytes,
 	info->fix.accel = FB_ACCEL_SUN_CGTHREE;
 }
 
-static void __devinit cg3_rdi_maybe_fixup_var(struct fb_var_screeninfo *var,
+static void cg3_rdi_maybe_fixup_var(struct fb_var_screeninfo *var,
 					      struct device_node *dp)
 {
 	const char *params;
@@ -308,7 +308,7 @@ static u_char cg3_dacvals[] __devinitdata = {
 	4, 0xff,	5, 0x00,	6, 0x70,	7, 0x00,	0
 };
 
-static int __devinit cg3_do_default_mode(struct cg3_par *par)
+static int cg3_do_default_mode(struct cg3_par *par)
 {
 	enum cg3_type type;
 	u8 *p;
@@ -346,7 +346,7 @@ static int __devinit cg3_do_default_mode(struct cg3_par *par)
 	return 0;
 }
 
-static int __devinit cg3_probe(struct platform_device *op)
+static int cg3_probe(struct platform_device *op)
 {
 	struct device_node *dp = op->dev.of_node;
 	struct fb_info *info;
diff --git a/drivers/video/cg6.c b/drivers/video/cg6.c
index 70c7013..3204e5a 100644
--- a/drivers/video/cg6.c
+++ b/drivers/video/cg6.c
@@ -607,7 +607,7 @@ static int cg6_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
  *  Initialisation
  */
 
-static void __devinit cg6_init_fix(struct fb_info *info, int linebytes)
+static void cg6_init_fix(struct fb_info *info, int linebytes)
 {
 	struct cg6_par *par = (struct cg6_par *)info->par;
 	const char *cg6_cpu_name, *cg6_card_name;
@@ -649,7 +649,7 @@ static void __devinit cg6_init_fix(struct fb_info *info, int linebytes)
 }
 
 /* Initialize Brooktree DAC */
-static void __devinit cg6_bt_init(struct cg6_par *par)
+static void cg6_bt_init(struct cg6_par *par)
 {
 	struct bt_regs __iomem *bt = par->bt;
 
@@ -663,7 +663,7 @@ static void __devinit cg6_bt_init(struct cg6_par *par)
 	sbus_writel(0x00 << 24, &bt->control);
 }
 
-static void __devinit cg6_chip_init(struct fb_info *info)
+static void cg6_chip_init(struct fb_info *info)
 {
 	struct cg6_par *par = (struct cg6_par *)info->par;
 	struct cg6_tec __iomem *tec = par->tec;
@@ -737,7 +737,7 @@ static void cg6_unmap_regs(struct platform_device *op, struct fb_info *info,
 			   info->fix.smem_len);
 }
 
-static int __devinit cg6_probe(struct platform_device *op)
+static int cg6_probe(struct platform_device *op)
 {
 	struct device_node *dp = op->dev.of_node;
 	struct fb_info *info;
diff --git a/drivers/video/chipsfb.c b/drivers/video/chipsfb.c
index 809857d..bf131f2 100644
--- a/drivers/video/chipsfb.c
+++ b/drivers/video/chipsfb.c
@@ -330,7 +330,7 @@ static struct fb_var_screeninfo chipsfb_var __devinitdata = {
 	.vsync_len = 8,
 };
 
-static void __devinit init_chips(struct fb_info *p, unsigned long addr)
+static void init_chips(struct fb_info *p, unsigned long addr)
 {
 	memset(p->screen_base, 0, 0x100000);
 
@@ -347,7 +347,7 @@ static void __devinit init_chips(struct fb_info *p, unsigned long addr)
 	chips_hw_init();
 }
 
-static int __devinit
+static int
 chipsfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
 {
 	struct fb_info *p;
diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 3ce6e55..0e73200 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -1892,7 +1892,7 @@ static int release_io_ports;
  * based on the DRAM bandwidth bit and DRAM bank switching bit.  This
  * works with 1MB, 2MB and 4MB configurations (which the Motorola boards
  * seem to have. */
-static unsigned int __devinit cirrusfb_get_memsize(struct fb_info *info,
+static unsigned int cirrusfb_get_memsize(struct fb_info *info,
 						   u8 __iomem *regbase)
 {
 	unsigned long mem;
@@ -2003,7 +2003,7 @@ static struct fb_ops cirrusfb_ops = {
 	.fb_imageblit	= cirrusfb_imageblit,
 };
 
-static int __devinit cirrusfb_set_fbinfo(struct fb_info *info)
+static int cirrusfb_set_fbinfo(struct fb_info *info)
 {
 	struct cirrusfb_info *cinfo = info->par;
 	struct fb_var_screeninfo *var = &info->var;
@@ -2052,7 +2052,7 @@ static int __devinit cirrusfb_set_fbinfo(struct fb_info *info)
 	return 0;
 }
 
-static int __devinit cirrusfb_register(struct fb_info *info)
+static int cirrusfb_register(struct fb_info *info)
 {
 	struct cirrusfb_info *cinfo = info->par;
 	int err;
@@ -2109,7 +2109,7 @@ static void __devexit cirrusfb_cleanup(struct fb_info *info)
 }
 
 #ifdef CONFIG_PCI
-static int __devinit cirrusfb_pci_register(struct pci_dev *pdev,
+static int cirrusfb_pci_register(struct pci_dev *pdev,
 					   const struct pci_device_id *ent)
 {
 	struct cirrusfb_info *cinfo;
@@ -2237,7 +2237,7 @@ static struct pci_driver cirrusfb_pci_driver = {
 #endif /* CONFIG_PCI */
 
 #ifdef CONFIG_ZORRO
-static int __devinit cirrusfb_zorro_register(struct zorro_dev *z,
+static int cirrusfb_zorro_register(struct zorro_dev *z,
 					     const struct zorro_device_id *ent)
 {
 	struct fb_info *info;
diff --git a/drivers/video/cobalt_lcdfb.c b/drivers/video/cobalt_lcdfb.c
index 9f2dc21..9e1e5d2 100644
--- a/drivers/video/cobalt_lcdfb.c
+++ b/drivers/video/cobalt_lcdfb.c
@@ -331,7 +331,7 @@ static struct fb_ops cobalt_lcd_fbops = {
 	.fb_cursor	= cobalt_lcdfb_cursor,
 };
 
-static int __devinit cobalt_lcdfb_probe(struct platform_device *dev)
+static int cobalt_lcdfb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
 	struct resource *res;
diff --git a/drivers/video/console/sticore.c b/drivers/video/console/sticore.c
index 39571f9..0fbc03c 100644
--- a/drivers/video/console/sticore.c
+++ b/drivers/video/console/sticore.c
@@ -238,7 +238,7 @@ static void sti_flush(unsigned long start, unsigned long end)
 	flush_icache_range(start, end);
 }
 
-static void __devinit sti_rom_copy(unsigned long base, unsigned long count,
+static void sti_rom_copy(unsigned long base, unsigned long count,
 				   void *dest)
 {
 	unsigned long dest_start = (unsigned long) dest;
@@ -266,7 +266,7 @@ static void __devinit sti_rom_copy(unsigned long base, unsigned long count,
 static char default_sti_path[21] __read_mostly;
 
 #ifndef MODULE
-static int __devinit sti_setup(char *str)
+static int sti_setup(char *str)
 {
 	if (str)
 		strlcpy (default_sti_path, str, sizeof (default_sti_path));
@@ -290,7 +290,7 @@ static int __devinitdata	font_index[MAX_STI_ROMS],
 				font_height[MAX_STI_ROMS],
 				font_width[MAX_STI_ROMS];
 #ifndef MODULE
-static int __devinit sti_font_setup(char *str)
+static int sti_font_setup(char *str)
 {
 	char *x;
 	int i = 0;
@@ -343,7 +343,7 @@ __setup("sti_font=", sti_font_setup);
 
 
 	
-static void __devinit
+static void
 sti_dump_globcfg(struct sti_glob_cfg *glob_cfg, unsigned int sti_mem_request)
 {
 	struct sti_glob_cfg_ext *cfg;
@@ -383,7 +383,7 @@ sti_dump_globcfg(struct sti_glob_cfg *glob_cfg, unsigned int sti_mem_request)
 		cfg->sti_mem_addr, sti_mem_request));
 }
 
-static void __devinit
+static void
 sti_dump_outptr(struct sti_struct *sti)
 {
 	DPRINTK((KERN_INFO
@@ -397,7 +397,7 @@ sti_dump_outptr(struct sti_struct *sti)
 		 sti->outptr.attributes));
 }
 
-static int __devinit
+static int
 sti_init_glob_cfg(struct sti_struct *sti,
 	    unsigned long rom_address, unsigned long hpa)
 {
@@ -479,7 +479,7 @@ sti_init_glob_cfg(struct sti_struct *sti,
 }
 
 #ifdef CONFIG_FB
-static struct sti_cooked_font __devinit
+static struct sti_cooked_font
 *sti_select_fbfont(struct sti_cooked_rom *cooked_rom, const char *fbfont_name)
 {
 	const struct font_desc *fbfont;
@@ -535,14 +535,14 @@ static struct sti_cooked_font __devinit
 	return cooked_font;
 }
 #else
-static struct sti_cooked_font __devinit
+static struct sti_cooked_font
 *sti_select_fbfont(struct sti_cooked_rom *cooked_rom, const char *fbfont_name)
 {
 	return NULL;
 }
 #endif
 
-static struct sti_cooked_font __devinit
+static struct sti_cooked_font
 *sti_select_font(struct sti_cooked_rom *rom,
 		 int (*search_font_fnc)(struct sti_cooked_rom *, int, int))
 {
@@ -569,7 +569,7 @@ static struct sti_cooked_font __devinit
 }
 
 
-static void __devinit
+static void
 sti_dump_rom(struct sti_rom *rom)
 {
 	printk(KERN_INFO "    id %04x-%04x, conforms to spec rev. %d.%02x\n",
@@ -587,7 +587,7 @@ sti_dump_rom(struct sti_rom *rom)
 }
 
 
-static int __devinit
+static int
 sti_cook_fonts(struct sti_cooked_rom *cooked_rom,
 			struct sti_rom *raw_rom)
 {
@@ -622,7 +622,7 @@ sti_cook_fonts(struct sti_cooked_rom *cooked_rom,
 }
 
 
-static int __devinit
+static int
 sti_search_font(struct sti_cooked_rom *rom, int height, int width)
 {
 	struct sti_cooked_font *font;
@@ -639,8 +639,7 @@ sti_search_font(struct sti_cooked_rom *rom, int height, int width)
 #define BMODE_RELOCATE(offset)		offset = (offset) / 4;
 #define BMODE_LAST_ADDR_OFFS		0x50
 
-static void * __devinit
-sti_bmode_font_raw(struct sti_cooked_font *f)
+static void *sti_bmode_font_raw(struct sti_cooked_font *f)
 {
 	unsigned char *n, *p, *q;
 	int size = f->raw->bytes_per_char*256+sizeof(struct sti_rom_font);
@@ -657,7 +656,7 @@ sti_bmode_font_raw(struct sti_cooked_font *f)
 	return n + 3;
 }
 
-static void __devinit
+static void
 sti_bmode_rom_copy(unsigned long base, unsigned long count, void *dest)
 {
 	unsigned long dest_start = (unsigned long) dest;
@@ -672,8 +671,7 @@ sti_bmode_rom_copy(unsigned long base, unsigned long count, void *dest)
 	sti_flush(dest_start, (unsigned long)dest);
 }
 
-static struct sti_rom * __devinit
-sti_get_bmode_rom (unsigned long address)
+static struct sti_rom *sti_get_bmode_rom (unsigned long address)
 {
 	struct sti_rom *raw;
 	u32 size;
@@ -708,7 +706,7 @@ sti_get_bmode_rom (unsigned long address)
 	return raw;
 }
 
-static struct sti_rom __devinit *sti_get_wmode_rom(unsigned long address)
+static struct sti_rom *sti_get_wmode_rom(unsigned long address)
 {
 	struct sti_rom *raw;
 	unsigned long size;
@@ -723,7 +721,7 @@ static struct sti_rom __devinit *sti_get_wmode_rom(unsigned long address)
 	return raw;
 }
 
-static int __devinit sti_read_rom(int wordmode, struct sti_struct *sti,
+static int sti_read_rom(int wordmode, struct sti_struct *sti,
 				  unsigned long address)
 {
 	struct sti_cooked_rom *cooked;
@@ -806,8 +804,7 @@ out_err:
 	return 0;
 }
 
-static struct sti_struct * __devinit
-sti_try_rom_generic(unsigned long address, unsigned long hpa, struct pci_dev *pd)
+static struct sti_struct *sti_try_rom_generic(unsigned long address, unsigned long hpa, struct pci_dev *pd)
 {
 	struct sti_struct *sti;
 	int ok;
@@ -921,7 +918,7 @@ out_err:
 	return NULL;
 }
 
-static void __devinit sticore_check_for_default_sti(struct sti_struct *sti, char *path)
+static void sticore_check_for_default_sti(struct sti_struct *sti, char *path)
 {
 	if (strcmp (path, default_sti_path) == 0)
 		default_sti = sti;
@@ -932,7 +929,7 @@ static void __devinit sticore_check_for_default_sti(struct sti_struct *sti, char
  * in the additional address field addr[1] while on
  * older Systems the PDC stores it in page0->proc_sti 
  */
-static int __devinit sticore_pa_init(struct parisc_device *dev)
+static int sticore_pa_init(struct parisc_device *dev)
 {
 	char pa_path[21];
 	struct sti_struct *sti = NULL;
@@ -953,7 +950,7 @@ static int __devinit sticore_pa_init(struct parisc_device *dev)
 }
 
 
-static int __devinit sticore_pci_init(struct pci_dev *pd,
+static int sticore_pci_init(struct pci_dev *pd,
 		const struct pci_device_id *ent)
 {
 #ifdef CONFIG_PCI
@@ -1043,7 +1040,7 @@ static struct parisc_driver pa_sti_driver = {
 
 static int sticore_initialized __read_mostly;
 
-static void __devinit sti_init_roms(void)
+static void sti_init_roms(void)
 {
 	if (sticore_initialized)
 		return;
diff --git a/drivers/video/cyber2000fb.c b/drivers/video/cyber2000fb.c
index 9b75b29..78bb6be 100644
--- a/drivers/video/cyber2000fb.c
+++ b/drivers/video/cyber2000fb.c
@@ -1230,7 +1230,7 @@ static int cyber2000fb_ddc_getsda(void *data)
 	return retval;
 }
 
-static int __devinit cyber2000fb_setup_ddc_bus(struct cfb_info *cfb)
+static int cyber2000fb_setup_ddc_bus(struct cfb_info *cfb)
 {
 	strlcpy(cfb->ddc_adapter.name, cfb->fb.fix.id,
 		sizeof(cfb->ddc_adapter.name));
@@ -1305,7 +1305,7 @@ static int cyber2000fb_i2c_getscl(void *data)
 	return ret;
 }
 
-static int __devinit cyber2000fb_i2c_register(struct cfb_info *cfb)
+static int cyber2000fb_i2c_register(struct cfb_info *cfb)
 {
 	strlcpy(cfb->i2c_adapter.name, cfb->fb.fix.id,
 		sizeof(cfb->i2c_adapter.name));
@@ -1404,7 +1404,7 @@ static void cyberpro_init_hw(struct cfb_info *cfb)
 	}
 }
 
-static struct cfb_info __devinit *cyberpro_alloc_fb_info(unsigned int id,
+static struct cfb_info *cyberpro_alloc_fb_info(unsigned int id,
 							 char *name)
 {
 	struct cfb_info *cfb;
@@ -1524,7 +1524,7 @@ static int cyber2000fb_setup(char *options)
  *  - memory mapped access to the registers
  *  - initialised mem_ctl1 and mem_ctl2 appropriately.
  */
-static int __devinit cyberpro_common_probe(struct cfb_info *cfb)
+static int cyberpro_common_probe(struct cfb_info *cfb)
 {
 	u_long smem_size;
 	u_int h_sync, v_sync;
@@ -1646,7 +1646,7 @@ static void cyberpro_common_resume(struct cfb_info *cfb)
 
 #include <mach/framebuffer.h>
 
-static int __devinit cyberpro_vl_probe(void)
+static int cyberpro_vl_probe(void)
 {
 	struct cfb_info *cfb;
 	int err = -ENOMEM;
@@ -1780,7 +1780,7 @@ static int cyberpro_pci_enable_mmio(struct cfb_info *cfb)
 	return 0;
 }
 
-static int __devinit
+static int
 cyberpro_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct cfb_info *cfb;
diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index b3aaf3b..1face18 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1230,7 +1230,7 @@ static unsigned int da8xxfb_pixel_clk_period(struct da8xx_fb_par *par)
 	return pix_clk_period_picosec;
 }
 
-static int __devinit fb_probe(struct platform_device *device)
+static int fb_probe(struct platform_device *device)
 {
 	struct da8xx_lcdc_platform_data *fb_pdata =
 						device->dev.platform_data;
diff --git a/drivers/video/dnfb.c b/drivers/video/dnfb.c
index 49e3dda..182b199 100644
--- a/drivers/video/dnfb.c
+++ b/drivers/video/dnfb.c
@@ -224,7 +224,7 @@ void dnfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
  * Initialization
  */
 
-static int __devinit dnfb_probe(struct platform_device *dev)
+static int dnfb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
 	int err = 0;
diff --git a/drivers/video/ep93xx-fb.c b/drivers/video/ep93xx-fb.c
index 2f08122..ef4ca55 100644
--- a/drivers/video/ep93xx-fb.c
+++ b/drivers/video/ep93xx-fb.c
@@ -484,7 +484,7 @@ static void ep93xxfb_dealloc_videomem(struct fb_info *info)
 				  info->screen_base, info->fix.smem_start);
 }
 
-static int __devinit ep93xxfb_probe(struct platform_device *pdev)
+static int ep93xxfb_probe(struct platform_device *pdev)
 {
 	struct ep93xxfb_mach_info *mach_info = pdev->dev.platform_data;
 	struct fb_info *info;
@@ -627,7 +627,7 @@ static struct platform_driver ep93xxfb_driver = {
 	},
 };
 
-static int __devinit ep93xxfb_init(void)
+static int ep93xxfb_init(void)
 {
 	return platform_driver_register(&ep93xxfb_driver);
 }
diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index 07c0453..47f0448 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -856,7 +856,7 @@ static irqreturn_t exynos_dp_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int __devinit exynos_dp_probe(struct platform_device *pdev)
+static int exynos_dp_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct exynos_dp_device *dp;
diff --git a/drivers/video/ffb.c b/drivers/video/ffb.c
index d78dc9a..46aee0e 100644
--- a/drivers/video/ffb.c
+++ b/drivers/video/ffb.c
@@ -893,7 +893,7 @@ static void ffb_init_fix(struct fb_info *info)
 	info->fix.accel = FB_ACCEL_SUN_CREATOR;
 }
 
-static int __devinit ffb_probe(struct platform_device *op)
+static int ffb_probe(struct platform_device *op)
 {
 	struct device_node *dp = op->dev.of_node;
 	struct ffb_fbc __iomem *fbc;
diff --git a/drivers/video/fm2fb.c b/drivers/video/fm2fb.c
index d0533b7..a64c3ef 100644
--- a/drivers/video/fm2fb.c
+++ b/drivers/video/fm2fb.c
@@ -211,7 +211,7 @@ static int fm2fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
      *  Initialisation
      */
 
-static int __devinit fm2fb_probe(struct zorro_dev *z,
+static int fm2fb_probe(struct zorro_dev *z,
 				 const struct zorro_device_id *id);
 
 static struct zorro_device_id fm2fb_devices[] __devinitdata = {
@@ -227,7 +227,7 @@ static struct zorro_driver fm2fb_driver = {
 	.probe		= fm2fb_probe,
 };
 
-static int __devinit fm2fb_probe(struct zorro_dev *z,
+static int fm2fb_probe(struct zorro_dev *z,
 				 const struct zorro_device_id *id)
 {
 	struct fb_info *info;
diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index ede9e55..6bdf805 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -1244,7 +1244,7 @@ static struct fb_ops fsl_diu_ops = {
 	.fb_release = fsl_diu_release,
 };
 
-static int __devinit install_fb(struct fb_info *info)
+static int install_fb(struct fb_info *info)
 {
 	int rc;
 	struct mfb_info *mfbi = info->par;
@@ -1491,7 +1491,7 @@ static ssize_t show_monitor(struct device *device,
 	return 0;
 }
 
-static int __devinit fsl_diu_probe(struct platform_device *pdev)
+static int fsl_diu_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct mfb_info *mfbi;
diff --git a/drivers/video/gbefb.c b/drivers/video/gbefb.c
index f19571b..2971511 100644
--- a/drivers/video/gbefb.c
+++ b/drivers/video/gbefb.c
@@ -1098,7 +1098,7 @@ static void gbefb_create_sysfs(struct device *dev)
  * Initialization
  */
 
-static int __devinit gbefb_setup(char *options)
+static int gbefb_setup(char *options)
 {
 	char *this_opt;
 
@@ -1129,7 +1129,7 @@ static int __devinit gbefb_setup(char *options)
 	return 0;
 }
 
-static int __devinit gbefb_probe(struct platform_device *p_dev)
+static int gbefb_probe(struct platform_device *p_dev)
 {
 	int i, ret = 0;
 	struct fb_info *info;
diff --git a/drivers/video/geode/gx1fb_core.c b/drivers/video/geode/gx1fb_core.c
index 094c352..4bdd47f 100644
--- a/drivers/video/geode/gx1fb_core.c
+++ b/drivers/video/geode/gx1fb_core.c
@@ -195,7 +195,7 @@ static int gx1fb_blank(int blank_mode, struct fb_info *info)
 	return par->vid_ops->blank_display(info, blank_mode);
 }
 
-static int __devinit gx1fb_map_video_memory(struct fb_info *info, struct pci_dev *dev)
+static int gx1fb_map_video_memory(struct fb_info *info, struct pci_dev *dev)
 {
 	struct geodefb_par *par = info->par;
 	unsigned gx_base;
@@ -268,7 +268,7 @@ static struct fb_ops gx1fb_ops = {
 	.fb_imageblit	= cfb_imageblit,
 };
 
-static struct fb_info * __devinit gx1fb_init_fbinfo(struct device *dev)
+static struct fb_info *gx1fb_init_fbinfo(struct device *dev)
 {
 	struct geodefb_par *par;
 	struct fb_info *info;
@@ -318,7 +318,7 @@ static struct fb_info * __devinit gx1fb_init_fbinfo(struct device *dev)
 	return info;
 }
 
-static int __devinit gx1fb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+static int gx1fb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct geodefb_par *par;
 	struct fb_info *info;
diff --git a/drivers/video/geode/gxfb_core.c b/drivers/video/geode/gxfb_core.c
index b4f19db..d3ad1a0 100644
--- a/drivers/video/geode/gxfb_core.c
+++ b/drivers/video/geode/gxfb_core.c
@@ -117,7 +117,7 @@ static struct fb_videomode gx_dcon_modedb[] __devinitdata = {
 	  FB_VMODE_NONINTERLACED, 0 }
 };
 
-static void __devinit get_modedb(struct fb_videomode **modedb,
+static void get_modedb(struct fb_videomode **modedb,
 		unsigned int *size)
 {
 	if (olpc_has_dcon()) {
@@ -130,7 +130,7 @@ static void __devinit get_modedb(struct fb_videomode **modedb,
 }
 
 #else
-static void __devinit get_modedb(struct fb_videomode **modedb,
+static void get_modedb(struct fb_videomode **modedb,
 		unsigned int *size)
 {
 	*modedb = (struct fb_videomode *) gx_modedb;
@@ -228,7 +228,7 @@ static int gxfb_blank(int blank_mode, struct fb_info *info)
 	return gx_blank_display(info, blank_mode);
 }
 
-static int __devinit gxfb_map_video_memory(struct fb_info *info,
+static int gxfb_map_video_memory(struct fb_info *info,
 		struct pci_dev *dev)
 {
 	struct gxfb_par *par = info->par;
@@ -293,7 +293,7 @@ static struct fb_ops gxfb_ops = {
 	.fb_imageblit	= cfb_imageblit,
 };
 
-static struct fb_info *__devinit gxfb_init_fbinfo(struct device *dev)
+static struct fb_info *gxfb_init_fbinfo(struct device *dev)
 {
 	struct gxfb_par *par;
 	struct fb_info *info;
@@ -374,7 +374,7 @@ static int gxfb_resume(struct pci_dev *pdev)
 }
 #endif
 
-static int __devinit gxfb_probe(struct pci_dev *pdev,
+static int gxfb_probe(struct pci_dev *pdev,
 		const struct pci_device_id *id)
 {
 	struct gxfb_par *par;
diff --git a/drivers/video/geode/lxfb_core.c b/drivers/video/geode/lxfb_core.c
index 416851c..7428366 100644
--- a/drivers/video/geode/lxfb_core.c
+++ b/drivers/video/geode/lxfb_core.c
@@ -226,7 +226,7 @@ static struct fb_videomode olpc_dcon_modedb[] __devinitdata = {
 	  FB_VMODE_NONINTERLACED, 0 }
 };
 
-static void __devinit get_modedb(struct fb_videomode **modedb,
+static void get_modedb(struct fb_videomode **modedb,
 		unsigned int *size)
 {
 	if (olpc_has_dcon()) {
@@ -239,7 +239,7 @@ static void __devinit get_modedb(struct fb_videomode **modedb,
 }
 
 #else
-static void __devinit get_modedb(struct fb_videomode **modedb,
+static void get_modedb(struct fb_videomode **modedb,
 		unsigned int *size)
 {
 	*modedb = (struct fb_videomode *) geode_modedb;
@@ -336,7 +336,7 @@ static int lxfb_blank(int blank_mode, struct fb_info *info)
 }
 
 
-static int __devinit lxfb_map_video_memory(struct fb_info *info,
+static int lxfb_map_video_memory(struct fb_info *info,
 					struct pci_dev *dev)
 {
 	struct lxfb_par *par = info->par;
@@ -414,7 +414,7 @@ static struct fb_ops lxfb_ops = {
 	.fb_imageblit	= cfb_imageblit,
 };
 
-static struct fb_info * __devinit lxfb_init_fbinfo(struct device *dev)
+static struct fb_info *lxfb_init_fbinfo(struct device *dev)
 {
 	struct lxfb_par *par;
 	struct fb_info *info;
@@ -498,7 +498,7 @@ static int lxfb_resume(struct pci_dev *pdev)
 #define lxfb_resume NULL
 #endif
 
-static int __devinit lxfb_probe(struct pci_dev *pdev,
+static int lxfb_probe(struct pci_dev *pdev,
 			     const struct pci_device_id *id)
 {
 	struct lxfb_par *par;
diff --git a/drivers/video/grvga.c b/drivers/video/grvga.c
index 3ddf206..bf7ea95 100644
--- a/drivers/video/grvga.c
+++ b/drivers/video/grvga.c
@@ -267,7 +267,7 @@ static struct fb_ops grvga_ops = {
 	.fb_imageblit	= cfb_imageblit
 };
 
-static int __devinit grvga_parse_custom(char *options,
+static int grvga_parse_custom(char *options,
 				     struct fb_var_screeninfo *screendata)
 {
 	char *this_opt;
@@ -329,7 +329,7 @@ static int __devinit grvga_parse_custom(char *options,
 	return 0;
 }
 
-static int __devinit grvga_probe(struct platform_device *dev)
+static int grvga_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
 	int retval = -ENOMEM;
diff --git a/drivers/video/gxt4500.c b/drivers/video/gxt4500.c
index d4f103e..c0130a4 100644
--- a/drivers/video/gxt4500.c
+++ b/drivers/video/gxt4500.c
@@ -610,7 +610,7 @@ static struct fb_ops gxt4500_ops = {
 };
 
 /* PCI functions */
-static int __devinit gxt4500_probe(struct pci_dev *pdev,
+static int gxt4500_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *ent)
 {
 	int err;
@@ -761,7 +761,7 @@ static struct pci_driver gxt4500_driver = {
 	.remove = gxt4500_remove,
 };
 
-static int __devinit gxt4500_init(void)
+static int gxt4500_init(void)
 {
 #ifndef MODULE
 	if (fb_get_options("gxt4500", &mode_option))
diff --git a/drivers/video/hecubafb.c b/drivers/video/hecubafb.c
index b28a520..f8746a3f 100644
--- a/drivers/video/hecubafb.c
+++ b/drivers/video/hecubafb.c
@@ -211,7 +211,7 @@ static struct fb_deferred_io hecubafb_defio = {
 	.deferred_io	= hecubafb_dpy_deferred_io,
 };
 
-static int __devinit hecubafb_probe(struct platform_device *dev)
+static int hecubafb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
 	struct hecuba_board *board;
diff --git a/drivers/video/hgafb.c b/drivers/video/hgafb.c
index f8a7036..20bbeb4 100644
--- a/drivers/video/hgafb.c
+++ b/drivers/video/hgafb.c
@@ -276,7 +276,7 @@ static void hga_blank(int blank_mode)
 	spin_unlock_irqrestore(&hga_reg_lock, flags);
 }
 
-static int __devinit hga_card_detect(void)
+static int hga_card_detect(void)
 {
 	int count = 0;
 	void __iomem *p, *q;
@@ -546,7 +546,7 @@ static struct fb_ops hgafb_ops = {
 	 *  Initialization
 	 */
 
-static int __devinit hgafb_probe(struct platform_device *pdev)
+static int hgafb_probe(struct platform_device *pdev)
 {
 	struct fb_info *info;
 
diff --git a/drivers/video/hitfb.c b/drivers/video/hitfb.c
index 4ceb978..20d8a56 100644
--- a/drivers/video/hitfb.c
+++ b/drivers/video/hitfb.c
@@ -324,7 +324,7 @@ static struct fb_ops hitfb_ops = {
 	.fb_imageblit	= cfb_imageblit,
 };
 
-static int __devinit hitfb_probe(struct platform_device *dev)
+static int hitfb_probe(struct platform_device *dev)
 {
 	unsigned short lcdclor, ldr3, ldvndr;
 	struct fb_info *info;
diff --git a/drivers/video/hpfb.c b/drivers/video/hpfb.c
index 1f15523..aa2abe8 100644
--- a/drivers/video/hpfb.c
+++ b/drivers/video/hpfb.c
@@ -206,7 +206,7 @@ static struct fb_ops hpfb_ops = {
 #define HPFB_FBOMSB	0x5d	/* Frame buffer offset		*/
 #define HPFB_FBOLSB	0x5f
 
-static int __devinit hpfb_init_one(unsigned long phys_base,
+static int hpfb_init_one(unsigned long phys_base,
 				   unsigned long virt_base)
 {
 	unsigned long fboff, fb_width, fb_height, fb_start;
@@ -327,7 +327,7 @@ unmap_screen_base:
 /* 
  * Initialise the framebuffer
  */
-static int __devinit hpfb_dio_probe(struct dio_dev * d, const struct dio_device_id * ent)
+static int hpfb_dio_probe(struct dio_dev * d, const struct dio_device_id * ent)
 {
 	unsigned long paddr, vaddr;
 
diff --git a/drivers/video/i740fb.c b/drivers/video/i740fb.c
index 1d3c8ee..1109617 100644
--- a/drivers/video/i740fb.c
+++ b/drivers/video/i740fb.c
@@ -163,7 +163,7 @@ static int i740fb_ddc_getsda(void *data)
 	return !!(i740inreg(par, XRX, REG_DDC_STATE) & DDC_SDA);
 }
 
-static int __devinit i740fb_setup_ddc_bus(struct fb_info *info)
+static int i740fb_setup_ddc_bus(struct fb_info *info)
 {
 	struct i740fb_par *par = info->par;
 
@@ -1007,7 +1007,7 @@ static struct fb_ops i740fb_ops = {
 
 /* ------------------------------------------------------------------------- */
 
-static int __devinit i740fb_probe(struct pci_dev *dev,
+static int i740fb_probe(struct pci_dev *dev,
 				  const struct pci_device_id *ent)
 {
 	struct fb_info *info;
diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index 5c06781..8c50b96 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -78,7 +78,7 @@ static u32 v_offset_default __devinitdata; /* For 32 MiB Aper size, 8 should be
 static u32 voffset          __devinitdata;
 
 static int i810fb_cursor(struct fb_info *info, struct fb_cursor *cursor);
-static int  __devinit i810fb_init_pci (struct pci_dev *dev,
+static int  i810fb_init_pci (struct pci_dev *dev,
 				       const struct pci_device_id *entry);
 static void __exit i810fb_remove_pci(struct pci_dev *dev);
 static int i810fb_resume(struct pci_dev *dev);
@@ -1628,7 +1628,7 @@ fail:
  *                  AGP resource allocation                            *
  ***********************************************************************/
   
-static void __devinit i810_fix_pointers(struct i810fb_par *par)
+static void i810_fix_pointers(struct i810fb_par *par)
 {
       	par->fb.physical = par->aperture.physical+(par->fb.offset << 12);
 	par->fb.virtual = par->aperture.virtual+(par->fb.offset << 12);
@@ -1640,7 +1640,7 @@ static void __devinit i810_fix_pointers(struct i810fb_par *par)
 		(par->cursor_heap.offset << 12);
 }
 
-static void __devinit i810_fix_offsets(struct i810fb_par *par)
+static void i810_fix_offsets(struct i810fb_par *par)
 {
 	if (vram + 1 > par->aperture.size >> 20)
 		vram = (par->aperture.size >> 20) - 1;
@@ -1660,7 +1660,7 @@ static void __devinit i810_fix_offsets(struct i810fb_par *par)
 	par->cursor_heap.size = 4096;
 }
 
-static int __devinit i810_alloc_agp_mem(struct fb_info *info)
+static int i810_alloc_agp_mem(struct fb_info *info)
 {
 	struct i810fb_par *par = info->par;
 	int size;
@@ -1723,7 +1723,7 @@ static int __devinit i810_alloc_agp_mem(struct fb_info *info)
  * Sets the user monitor's horizontal and vertical
  * frequency limits
  */
-static void __devinit i810_init_monspecs(struct fb_info *info)
+static void i810_init_monspecs(struct fb_info *info)
 {
 	if (!hsync1)
 		hsync1 = HFMIN;
@@ -1755,7 +1755,7 @@ static void __devinit i810_init_monspecs(struct fb_info *info)
  * @par: pointer to i810fb_par structure
  * @info: pointer to current fb_info structure
  */
-static void __devinit i810_init_defaults(struct i810fb_par *par, 
+static void i810_init_defaults(struct i810fb_par *par,
 				      struct fb_info *info)
 {
 	mutex_init(&par->open_lock);
@@ -1812,7 +1812,7 @@ static void __devinit i810_init_defaults(struct i810fb_par *par,
  * i810_init_device - initialize device
  * @par: pointer to i810fb_par structure
  */
-static void __devinit i810_init_device(struct i810fb_par *par)
+static void i810_init_device(struct i810fb_par *par)
 {
 	u8 reg;
 	u8 __iomem *mmio = par->mmio_start_virtual;
@@ -1833,7 +1833,7 @@ static void __devinit i810_init_device(struct i810fb_par *par)
 
 }
 
-static int __devinit 
+static int
 i810_allocate_pci_resource(struct i810fb_par *par, 
 			   const struct pci_device_id *entry)
 {
@@ -1892,7 +1892,7 @@ i810_allocate_pci_resource(struct i810fb_par *par,
 	return 0;
 }
 
-static void __devinit i810fb_find_init_mode(struct fb_info *info)
+static void i810fb_find_init_mode(struct fb_info *info)
 {
 	struct fb_videomode mode;
 	struct fb_var_screeninfo var;
@@ -1956,7 +1956,7 @@ static void __devinit i810fb_find_init_mode(struct fb_info *info)
 }
 
 #ifndef MODULE
-static int __devinit i810fb_setup(char *options)
+static int i810fb_setup(char *options)
 {
 	char *this_opt, *suffix = NULL;
 
@@ -2007,7 +2007,7 @@ static int __devinit i810fb_setup(char *options)
 }
 #endif
 
-static int __devinit i810fb_init_pci (struct pci_dev *dev, 
+static int i810fb_init_pci (struct pci_dev *dev,
 				   const struct pci_device_id *entry)
 {
 	struct fb_info    *info;
@@ -2136,7 +2136,7 @@ static void __exit i810fb_remove_pci(struct pci_dev *dev)
 }                                                	
 
 #ifndef MODULE
-static int __devinit i810fb_init(void)
+static int i810fb_init(void)
 {
 	char *option = NULL;
 
@@ -2154,7 +2154,7 @@ static int __devinit i810fb_init(void)
 
 #ifdef MODULE
 
-static int __devinit i810fb_init(void)
+static int i810fb_init(void)
 {
 	hsync1 *= 1000;
 	hsync2 *= 1000;
diff --git a/drivers/video/i810/i810_main.h b/drivers/video/i810/i810_main.h
index 51d4f3d4..a25afaa 100644
--- a/drivers/video/i810/i810_main.h
+++ b/drivers/video/i810/i810_main.h
@@ -64,7 +64,7 @@ static inline void flush_cache(void)
 
 #include <asm/mtrr.h>
 
-static inline void __devinit set_mtrr(struct i810fb_par *par)
+static inline void set_mtrr(struct i810fb_par *par)
 {
 	par->mtrr_reg = mtrr_add((u32) par->aperture.physical, 
 		 par->aperture.size, MTRR_TYPE_WRCOMB, 1);
diff --git a/drivers/video/imsttfb.c b/drivers/video/imsttfb.c
index 1bb3934..a7e8477 100644
--- a/drivers/video/imsttfb.c
+++ b/drivers/video/imsttfb.c
@@ -1349,7 +1349,7 @@ static struct fb_ops imsttfb_ops = {
 	.fb_ioctl 	= imsttfb_ioctl,
 };
 
-static void __devinit
+static void
 init_imstt(struct fb_info *info)
 {
 	struct imstt_par *par = info->par;
@@ -1466,7 +1466,7 @@ init_imstt(struct fb_info *info)
 		info->node, info->fix.id, info->fix.smem_len >> 20, tmp);
 }
 
-static int __devinit
+static int
 imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	unsigned long addr, size;
diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
index 971b5d0..860820c 100644
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -132,7 +132,7 @@
 #include "intelfbhw.h"
 #include "../edid.h"
 
-static void __devinit get_initial_mode(struct intelfb_info *dinfo);
+static void get_initial_mode(struct intelfb_info *dinfo);
 static void update_dinfo(struct intelfb_info *dinfo,
 			 struct fb_var_screeninfo *var);
 static int intelfb_open(struct fb_info *info, int user);
@@ -162,10 +162,10 @@ static int intelfb_sync(struct fb_info *info);
 static int intelfb_ioctl(struct fb_info *info,
 			 unsigned int cmd, unsigned long arg);
 
-static int __devinit intelfb_pci_register(struct pci_dev *pdev,
+static int intelfb_pci_register(struct pci_dev *pdev,
 					  const struct pci_device_id *ent);
 static void __devexit intelfb_pci_unregister(struct pci_dev *pdev);
-static int __devinit intelfb_set_fbinfo(struct intelfb_info *dinfo);
+static int intelfb_set_fbinfo(struct intelfb_info *dinfo);
 
 /*
  * Limiting the class to PCI_CLASS_DISPLAY_VGA prevents function 1 of the
@@ -415,7 +415,7 @@ module_exit(intelfb_exit);
  ***************************************************************/
 
 #ifdef CONFIG_MTRR
-static inline void __devinit set_mtrr(struct intelfb_info *dinfo)
+static inline void set_mtrr(struct intelfb_info *dinfo)
 {
 	dinfo->mtrr_reg = mtrr_add(dinfo->aperture.physical,
 				   dinfo->aperture.size, MTRR_TYPE_WRCOMB, 1);
@@ -497,7 +497,7 @@ static void cleanup(struct intelfb_info *dinfo)
 } while (0)
 
 
-static int __devinit intelfb_pci_register(struct pci_dev *pdev,
+static int intelfb_pci_register(struct pci_dev *pdev,
 					  const struct pci_device_id *ent)
 {
 	struct fb_info *info;
@@ -970,7 +970,7 @@ static __inline__ int var_to_refresh(const struct fb_var_screeninfo *var)
  *                Various intialisation functions              *
  ***************************************************************/
 
-static void __devinit get_initial_mode(struct intelfb_info *dinfo)
+static void get_initial_mode(struct intelfb_info *dinfo)
 {
 	struct fb_var_screeninfo *var;
 	int xtot, ytot;
@@ -1037,7 +1037,7 @@ static void __devinit get_initial_mode(struct intelfb_info *dinfo)
 	}
 }
 
-static int __devinit intelfb_init_var(struct intelfb_info *dinfo)
+static int intelfb_init_var(struct intelfb_info *dinfo)
 {
 	struct fb_var_screeninfo *var;
 	int msrc = 0;
@@ -1118,7 +1118,7 @@ static int __devinit intelfb_init_var(struct intelfb_info *dinfo)
 	return 0;
 }
 
-static int __devinit intelfb_set_fbinfo(struct intelfb_info *dinfo)
+static int intelfb_set_fbinfo(struct intelfb_info *dinfo)
 {
 	struct fb_info *info = dinfo->info;
 
diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
index cb867b6..f5c645a 100644
--- a/drivers/video/jz4740_fb.c
+++ b/drivers/video/jz4740_fb.c
@@ -619,7 +619,7 @@ static struct  fb_ops jzfb_ops = {
 	.fb_setcolreg = jzfb_setcolreg,
 };
 
-static int __devinit jzfb_probe(struct platform_device *pdev)
+static int jzfb_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct jzfb *jzfb;
diff --git a/drivers/video/kyro/fbdev.c b/drivers/video/kyro/fbdev.c
index 2293f6a..2c498d8 100644
--- a/drivers/video/kyro/fbdev.c
+++ b/drivers/video/kyro/fbdev.c
@@ -667,7 +667,7 @@ static struct fb_ops kyrofb_ops = {
 	.fb_imageblit	= cfb_imageblit,
 };
 
-static int __devinit kyrofb_probe(struct pci_dev *pdev,
+static int kyrofb_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *ent)
 {
 	struct fb_info *info;
diff --git a/drivers/video/leo.c b/drivers/video/leo.c
index 52a8678..8c64c79 100644
--- a/drivers/video/leo.c
+++ b/drivers/video/leo.c
@@ -547,7 +547,7 @@ static void leo_unmap_regs(struct platform_device *op, struct fb_info *info,
 		of_iounmap(&op->resource[0], info->screen_base, 0x800000);
 }
 
-static int __devinit leo_probe(struct platform_device *op)
+static int leo_probe(struct platform_device *op)
 {
 	struct device_node *dp = op->dev.of_node;
 	struct fb_info *info;
diff --git a/drivers/video/mb862xx/mb862xxfbdrv.c b/drivers/video/mb862xx/mb862xxfbdrv.c
index 3025cbb..9f88328 100644
--- a/drivers/video/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/mb862xx/mb862xxfbdrv.c
@@ -668,7 +668,7 @@ static int mb862xx_gdc_init(struct mb862xxfb_par *par)
 	return 0;
 }
 
-static int __devinit of_platform_mb862xx_probe(struct platform_device *ofdev)
+static int of_platform_mb862xx_probe(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
 	struct device *dev = &ofdev->dev;
@@ -995,7 +995,7 @@ static struct pci_device_id mb862xx_pci_tbl[] __devinitdata = {
 
 MODULE_DEVICE_TABLE(pci, mb862xx_pci_tbl);
 
-static int __devinit mb862xx_pci_probe(struct pci_dev *pdev,
+static int mb862xx_pci_probe(struct pci_dev *pdev,
 				       const struct pci_device_id *ent)
 {
 	struct mb862xxfb_par *par;
@@ -1178,7 +1178,7 @@ static struct pci_driver mb862xxfb_pci_driver = {
 };
 #endif
 
-static int __devinit mb862xxfb_init(void)
+static int mb862xxfb_init(void)
 {
 	int ret = -ENODEV;
 
diff --git a/drivers/video/mbx/mbxdebugfs.c b/drivers/video/mbx/mbxdebugfs.c
index 12dec76..474f94f 100644
--- a/drivers/video/mbx/mbxdebugfs.c
+++ b/drivers/video/mbx/mbxdebugfs.c
@@ -213,7 +213,7 @@ static const struct file_operations misc_fops = {
 	.llseek = default_llseek,
 };
 
-static void __devinit mbxfb_debugfs_init(struct fb_info *fbi)
+static void mbxfb_debugfs_init(struct fb_info *fbi)
 {
 	struct mbxfb_info *mfbi = fbi->par;
 	struct mbxfb_debugfs_data *dbg;
diff --git a/drivers/video/mbx/mbxfb.c b/drivers/video/mbx/mbxfb.c
index a8ba922..91bf913 100644
--- a/drivers/video/mbx/mbxfb.c
+++ b/drivers/video/mbx/mbxfb.c
@@ -687,7 +687,7 @@ static struct fb_ops mbxfb_ops = {
   Enable external SDRAM controller. Assume that all clocks are active
   by now.
 */
-static void __devinit setup_memc(struct fb_info *fbi)
+static void setup_memc(struct fb_info *fbi)
 {
 	unsigned long tmp;
 	int i;
@@ -747,7 +747,7 @@ static void enable_clocks(struct fb_info *fbi)
 	write_reg_dly(0x00000001, PIXCLKDIV);
 }
 
-static void __devinit setup_graphics(struct fb_info *fbi)
+static void setup_graphics(struct fb_info *fbi)
 {
 	unsigned long gsctrl;
 	unsigned long vscadr;
@@ -781,7 +781,7 @@ static void __devinit setup_graphics(struct fb_info *fbi)
 	write_reg_dly(vscadr, VSCADR);
 }
 
-static void __devinit setup_display(struct fb_info *fbi)
+static void setup_display(struct fb_info *fbi)
 {
 	unsigned long dsctrl = 0;
 
@@ -795,7 +795,7 @@ static void __devinit setup_display(struct fb_info *fbi)
 	write_reg_dly((readl(DSCTRL) | DSCTRL_SYNCGEN_EN), DSCTRL);
 }
 
-static void __devinit enable_controller(struct fb_info *fbi)
+static void enable_controller(struct fb_info *fbi)
 {
 	u32 svctrl, shctrl;
 
@@ -881,7 +881,7 @@ static int mbxfb_resume(struct platform_device *dev)
 
 #define res_size(_r) (((_r)->end - (_r)->start) + 1)
 
-static int __devinit mbxfb_probe(struct platform_device *dev)
+static int mbxfb_probe(struct platform_device *dev)
 {
 	int ret;
 	struct fb_info *fbi;
diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
index c0c358c..d148067 100644
--- a/drivers/video/metronomefb.c
+++ b/drivers/video/metronomefb.c
@@ -167,7 +167,7 @@ static u16 calc_img_cksum(u16 *start, int length)
 }
 
 /* here we decode the incoming waveform file and populate metromem */
-static int __devinit load_waveform(u8 *mem, size_t size, int m, int t,
+static int load_waveform(u8 *mem, size_t size, int m, int t,
 				struct metronomefb_par *par)
 {
 	int tta;
@@ -338,7 +338,7 @@ static int metronome_display_cmd(struct metronomefb_par *par)
 	return par->board->met_wait_event_intr(par);
 }
 
-static int __devinit metronome_powerup_cmd(struct metronomefb_par *par)
+static int metronome_powerup_cmd(struct metronomefb_par *par)
 {
 	int i;
 	u16 cs;
@@ -367,7 +367,7 @@ static int __devinit metronome_powerup_cmd(struct metronomefb_par *par)
 	return par->board->met_wait_event(par);
 }
 
-static int __devinit metronome_config_cmd(struct metronomefb_par *par)
+static int metronome_config_cmd(struct metronomefb_par *par)
 {
 	/* setup config command
 	we can't immediately set the opcode since the controller
@@ -385,7 +385,7 @@ static int __devinit metronome_config_cmd(struct metronomefb_par *par)
 	return par->board->met_wait_event(par);
 }
 
-static int __devinit metronome_init_cmd(struct metronomefb_par *par)
+static int metronome_init_cmd(struct metronomefb_par *par)
 {
 	int i;
 	u16 cs;
@@ -411,7 +411,7 @@ static int __devinit metronome_init_cmd(struct metronomefb_par *par)
 	return par->board->met_wait_event(par);
 }
 
-static int __devinit metronome_init_regs(struct metronomefb_par *par)
+static int metronome_init_regs(struct metronomefb_par *par)
 {
 	int res;
 
@@ -569,7 +569,7 @@ static struct fb_deferred_io metronomefb_defio = {
 	.deferred_io	= metronomefb_dpy_deferred_io,
 };
 
-static int __devinit metronomefb_probe(struct platform_device *dev)
+static int metronomefb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
 	struct metronome_board *board;
diff --git a/drivers/video/msm/mddi.c b/drivers/video/msm/mddi.c
index 35ac9e8..88e9f41c 100644
--- a/drivers/video/msm/mddi.c
+++ b/drivers/video/msm/mddi.c
@@ -417,7 +417,7 @@ static void mddi_resume(struct msm_mddi_client_data *cdata)
 	mddi_set_auto_hibernate(&mddi->client_data, 1);
 }
 
-static int __devinit mddi_get_client_caps(struct mddi_info *mddi)
+static int mddi_get_client_caps(struct mddi_info *mddi)
 {
 	int i, j;
 
@@ -619,7 +619,7 @@ uint32_t mddi_remote_read(struct msm_mddi_client_data *cdata, uint32_t reg)
 
 static struct mddi_info mddi_info[2];
 
-static int __devinit mddi_clk_setup(struct platform_device *pdev,
+static int mddi_clk_setup(struct platform_device *pdev,
 				    struct mddi_info *mddi,
 				    unsigned long clk_rate)
 {
@@ -664,7 +664,7 @@ static int __init mddi_rev_data_setup(struct mddi_info *mddi)
 	return 0;
 }
 
-static int __devinit mddi_probe(struct platform_device *pdev)
+static int mddi_probe(struct platform_device *pdev)
 {
 	struct msm_mddi_platform_data *pdata = pdev->dev.platform_data;
 	struct mddi_info *mddi = &mddi_info[pdev->id];
diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index ddac96d..be26b36 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -586,7 +586,7 @@ static struct fb_ops mxsfb_ops = {
 	.fb_imageblit = cfb_imageblit,
 };
 
-static int __devinit mxsfb_restore_mode(struct mxsfb_info *host)
+static int mxsfb_restore_mode(struct mxsfb_info *host)
 {
 	struct fb_info *fb_info = &host->fb_info;
 	unsigned line_count;
@@ -677,7 +677,7 @@ static int __devinit mxsfb_restore_mode(struct mxsfb_info *host)
 	return 0;
 }
 
-static int __devinit mxsfb_init_fbinfo(struct mxsfb_info *host)
+static int mxsfb_init_fbinfo(struct mxsfb_info *host)
 {
 	struct fb_info *fb_info = &host->fb_info;
 	struct fb_var_screeninfo *var = &fb_info->var;
@@ -772,7 +772,7 @@ static const struct of_device_id mxsfb_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mxsfb_dt_ids);
 
-static int __devinit mxsfb_probe(struct platform_device *pdev)
+static int mxsfb_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id =
 			of_match_device(mxsfb_dt_ids, &pdev->dev);
diff --git a/drivers/video/neofb.c b/drivers/video/neofb.c
index 15c3bef..4cd9e6d 100644
--- a/drivers/video/neofb.c
+++ b/drivers/video/neofb.c
@@ -1646,7 +1646,7 @@ static struct fb_videomode __devinitdata mode800x480 = {
 	.vmode          = FB_VMODE_NONINTERLACED
 };
 
-static int __devinit neo_map_mmio(struct fb_info *info,
+static int neo_map_mmio(struct fb_info *info,
 				  struct pci_dev *dev)
 {
 	struct neofb_par *par = info->par;
@@ -1707,7 +1707,7 @@ static void neo_unmap_mmio(struct fb_info *info)
 			   info->fix.mmio_len);
 }
 
-static int __devinit neo_map_video(struct fb_info *info,
+static int neo_map_video(struct fb_info *info,
 				   struct pci_dev *dev, int video_len)
 {
 	//unsigned long addr;
@@ -1772,7 +1772,7 @@ static void neo_unmap_video(struct fb_info *info)
 			   info->fix.smem_len);
 }
 
-static int __devinit neo_scan_monitor(struct fb_info *info)
+static int neo_scan_monitor(struct fb_info *info)
 {
 	struct neofb_par *par = info->par;
 	unsigned char type, display;
@@ -1851,7 +1851,7 @@ static int __devinit neo_scan_monitor(struct fb_info *info)
 	return 0;
 }
 
-static int __devinit neo_init_hw(struct fb_info *info)
+static int neo_init_hw(struct fb_info *info)
 {
 	struct neofb_par *par = info->par;
 	int videoRam = 896;
@@ -1939,7 +1939,7 @@ static int __devinit neo_init_hw(struct fb_info *info)
 }
 
 
-static struct fb_info *__devinit neo_alloc_fb_info(struct pci_dev *dev, const struct
+static struct fb_info *neo_alloc_fb_info(struct pci_dev *dev, const struct
 						   pci_device_id *id)
 {
 	struct fb_info *info;
@@ -2038,7 +2038,7 @@ static void neo_free_fb_info(struct fb_info *info)
 
 /* --------------------------------------------------------------------- */
 
-static int __devinit neofb_probe(struct pci_dev *dev,
+static int neofb_probe(struct pci_dev *dev,
 				 const struct pci_device_id *id)
 {
 	struct fb_info *info;
diff --git a/drivers/video/nuc900fb.c b/drivers/video/nuc900fb.c
index 475dfee..32581c7 100644
--- a/drivers/video/nuc900fb.c
+++ b/drivers/video/nuc900fb.c
@@ -387,7 +387,7 @@ static int nuc900fb_init_registers(struct fb_info *info)
  *    The buffer should be a non-cached, non-buffered, memory region
  *    to allow palette and pixel writes without flushing the cache.
  */
-static int __devinit nuc900fb_map_video_memory(struct fb_info *info)
+static int nuc900fb_map_video_memory(struct fb_info *info)
 {
 	struct nuc900fb_info *fbi = info->par;
 	dma_addr_t map_dma;
@@ -499,7 +499,7 @@ static inline void nuc900fb_cpufreq_deregister(struct nuc900fb_info *info)
 
 static char driver_name[] = "nuc900fb";
 
-static int __devinit nuc900fb_probe(struct platform_device *pdev)
+static int nuc900fb_probe(struct platform_device *pdev)
 {
 	struct nuc900fb_info *fbi;
 	struct nuc900fb_display *display;
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index 0bbed28..ca8963c 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -1105,7 +1105,7 @@ fail:
 #define nvidiafb_resume NULL
 #endif
 
-static int __devinit nvidia_set_fbinfo(struct fb_info *info)
+static int nvidia_set_fbinfo(struct fb_info *info)
 {
 	struct fb_monspecs *specs = &info->monspecs;
 	struct fb_videomode modedb;
@@ -1201,7 +1201,7 @@ static int __devinit nvidia_set_fbinfo(struct fb_info *info)
 	return nvidiafb_check_var(&info->var, info);
 }
 
-static u32 __devinit nvidia_get_chipset(struct fb_info *info)
+static u32 nvidia_get_chipset(struct fb_info *info)
 {
 	struct nvidia_par *par = info->par;
 	u32 id = (par->pci_dev->vendor << 16) | par->pci_dev->device;
@@ -1224,7 +1224,7 @@ static u32 __devinit nvidia_get_chipset(struct fb_info *info)
 	return id;
 }
 
-static u32 __devinit nvidia_get_arch(struct fb_info *info)
+static u32 nvidia_get_arch(struct fb_info *info)
 {
 	struct nvidia_par *par = info->par;
 	u32 arch = 0;
@@ -1276,7 +1276,7 @@ static u32 __devinit nvidia_get_arch(struct fb_info *info)
 	return arch;
 }
 
-static int __devinit nvidiafb_probe(struct pci_dev *pd,
+static int nvidiafb_probe(struct pci_dev *pd,
 				    const struct pci_device_id *ent)
 {
 	struct nvidia_par *par;
@@ -1473,7 +1473,7 @@ static void __devexit nvidiafb_remove(struct pci_dev *pd)
  * ------------------------------------------------------------------------- */
 
 #ifndef MODULE
-static int __devinit nvidiafb_setup(char *options)
+static int nvidiafb_setup(char *options)
 {
 	char *this_opt;
 
@@ -1538,7 +1538,7 @@ static struct pci_driver nvidiafb_driver = {
  *
  * ------------------------------------------------------------------------- */
 
-static int __devinit nvidiafb_init(void)
+static int nvidiafb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
diff --git a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
index bae244f..4ed48af 100644
--- a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
+++ b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
@@ -250,7 +250,7 @@ static void init_lb035q02_panel(struct spi_device *spi)
 	lb035q02_write_reg(spi, 0x3b, 0x0806);
 }
 
-static int __devinit lb035q02_panel_spi_probe(struct spi_device *spi)
+static int lb035q02_panel_spi_probe(struct spi_device *spi)
 {
 	init_lb035q02_panel(spi);
 	return omap_dss_register_driver(&lb035q02_driver);
diff --git a/drivers/video/p9100.c b/drivers/video/p9100.c
index f402a69..62d8339 100644
--- a/drivers/video/p9100.c
+++ b/drivers/video/p9100.c
@@ -249,7 +249,7 @@ static void p9100_init_fix(struct fb_info *info, int linebytes, struct device_no
 	info->fix.accel = FB_ACCEL_SUN_CGTHREE;
 }
 
-static int __devinit p9100_probe(struct platform_device *op)
+static int p9100_probe(struct platform_device *op)
 {
 	struct device_node *dp = op->dev.of_node;
 	struct fb_info *info;
diff --git a/drivers/video/platinumfb.c b/drivers/video/platinumfb.c
index 6694923..f638002 100644
--- a/drivers/video/platinumfb.c
+++ b/drivers/video/platinumfb.c
@@ -313,7 +313,7 @@ static void platinum_set_hardware(struct fb_info_platinum *pinfo)
 /*
  * Set misc info vars for this driver
  */
-static void __devinit platinum_init_info(struct fb_info *info, struct fb_info_platinum *pinfo)
+static void platinum_init_info(struct fb_info *info, struct fb_info_platinum *pinfo)
 {
 	/* Fill fb_info */
 	info->fbops = &platinumfb_ops;
@@ -338,7 +338,7 @@ static void __devinit platinum_init_info(struct fb_info *info, struct fb_info_pl
 }
 
 
-static int __devinit platinum_init_fb(struct fb_info *info)
+static int platinum_init_fb(struct fb_info *info)
 {
 	struct fb_info_platinum *pinfo = info->par;
 	struct fb_var_screeninfo var;
@@ -533,7 +533,7 @@ static int __init platinumfb_setup(char *options)
 #define invalidate_cache(addr)
 #endif
 
-static int __devinit platinumfb_probe(struct platform_device* odev)
+static int platinumfb_probe(struct platform_device* odev)
 {
 	struct device_node	*dp = odev->dev.of_node;
 	struct fb_info		*info;
diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index c4f639a..70192ba 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -1515,7 +1515,7 @@ static struct fb_ops pm2fb_ops = {
  * @param	pdev	PCI device.
  * @param	id	PCI device ID.
  */
-static int __devinit pm2fb_probe(struct pci_dev *pdev,
+static int pm2fb_probe(struct pci_dev *pdev,
 				 const struct pci_device_id *id)
 {
 	struct pm2fb_par *default_par;
diff --git a/drivers/video/pm3fb.c b/drivers/video/pm3fb.c
index e9d8e23..1fdae1d 100644
--- a/drivers/video/pm3fb.c
+++ b/drivers/video/pm3fb.c
@@ -1229,7 +1229,7 @@ static struct fb_ops pm3fb_ops = {
 
 /* mmio register are already mapped when this function is called */
 /* the pm3fb_fix.smem_start is also set */
-static unsigned long __devinit pm3fb_size_memory(struct pm3_par *par)
+static unsigned long pm3fb_size_memory(struct pm3_par *par)
 {
 	unsigned long	memsize = 0;
 	unsigned long	tempBypass, i, temp1, temp2;
@@ -1314,7 +1314,7 @@ static unsigned long __devinit pm3fb_size_memory(struct pm3_par *par)
 	return memsize;
 }
 
-static int __devinit pm3fb_probe(struct pci_dev *dev,
+static int pm3fb_probe(struct pci_dev *dev,
 				  const struct pci_device_id *ent)
 {
 	struct fb_info *info;
diff --git a/drivers/video/pmag-ba-fb.c b/drivers/video/pmag-ba-fb.c
index 9b4a60b..e5d2994 100644
--- a/drivers/video/pmag-ba-fb.c
+++ b/drivers/video/pmag-ba-fb.c
@@ -141,7 +141,7 @@ static void __init pmagbafb_erase_cursor(struct fb_info *info)
 }
 
 
-static int __devinit pmagbafb_probe(struct device *dev)
+static int pmagbafb_probe(struct device *dev)
 {
 	struct tc_dev *tdev = to_tc_dev(dev);
 	resource_size_t start, len;
diff --git a/drivers/video/pmagb-b-fb.c b/drivers/video/pmagb-b-fb.c
index 4e7a9c4..e731baf 100644
--- a/drivers/video/pmagb-b-fb.c
+++ b/drivers/video/pmagb-b-fb.c
@@ -147,7 +147,7 @@ static void __init pmagbbfb_erase_cursor(struct fb_info *info)
 /*
  * Set up screen parameters.
  */
-static void __devinit pmagbbfb_screen_setup(struct fb_info *info)
+static void pmagbbfb_screen_setup(struct fb_info *info)
 {
 	struct pmagbbfb_par *par = info->par;
 
@@ -179,7 +179,7 @@ static void __devinit pmagbbfb_screen_setup(struct fb_info *info)
 /*
  * Determine oscillator configuration.
  */
-static void __devinit pmagbbfb_osc_setup(struct fb_info *info)
+static void pmagbbfb_osc_setup(struct fb_info *info)
 {
 	static unsigned int pmagbbfb_freqs[] __devinitdata = {
 		130808, 119843, 104000, 92980, 74370, 72800,
@@ -246,7 +246,7 @@ static void __devinit pmagbbfb_osc_setup(struct fb_info *info)
 };
 
 
-static int __devinit pmagbbfb_probe(struct device *dev)
+static int pmagbbfb_probe(struct device *dev)
 {
 	struct tc_dev *tdev = to_tc_dev(dev);
 	resource_size_t start, len;
diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index 0b340d6..536a098 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -965,7 +965,7 @@ static struct fb_fix_screeninfo ps3fb_fix __initdata = {
 	.accel =	FB_ACCEL_NONE,
 };
 
-static int __devinit ps3fb_probe(struct ps3_system_bus_device *dev)
+static int ps3fb_probe(struct ps3_system_bus_device *dev)
 {
 	struct fb_info *info;
 	struct ps3fb_par *par;
diff --git a/drivers/video/pvr2fb.c b/drivers/video/pvr2fb.c
index 69fc2c3..1192343 100644
--- a/drivers/video/pvr2fb.c
+++ b/drivers/video/pvr2fb.c
@@ -763,7 +763,7 @@ out_unmap:
  * in for flexibility anyways. Who knows, maybe someone has tv-out on a
  * PCI-based version of these things ;-)
  */
-static int __devinit pvr2fb_common_init(void)
+static int pvr2fb_common_init(void)
 {
 	struct pvr2fb_par *par = currentpar;
 	unsigned long modememused, rev;
@@ -922,7 +922,7 @@ static void __exit pvr2fb_dc_exit(void)
 #endif /* CONFIG_SH_DREAMCAST */
 
 #ifdef CONFIG_PCI
-static int __devinit pvr2fb_pci_probe(struct pci_dev *pdev,
+static int pvr2fb_pci_probe(struct pci_dev *pdev,
 				      const struct pci_device_id *ent)
 {
 	int ret;
@@ -993,7 +993,7 @@ static void __exit pvr2fb_pci_exit(void)
 }
 #endif /* CONFIG_PCI */
 
-static int __devinit pvr2_get_param(const struct pvr2_params *p, const char *s,
+static int pvr2_get_param(const struct pvr2_params *p, const char *s,
                                    int val, int size)
 {
 	int i;
diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
index a8fd898..49af862 100644
--- a/drivers/video/pxa168fb.c
+++ b/drivers/video/pxa168fb.c
@@ -560,7 +560,7 @@ static struct fb_ops pxa168fb_ops = {
 	.fb_imageblit	= cfb_imageblit,
 };
 
-static int __devinit pxa168fb_init_mode(struct fb_info *info,
+static int pxa168fb_init_mode(struct fb_info *info,
 			      struct pxa168fb_mach_info *mi)
 {
 	struct pxa168fb_info *fbi = info->par;
@@ -600,7 +600,7 @@ static int __devinit pxa168fb_init_mode(struct fb_info *info,
 	return ret;
 }
 
-static int __devinit pxa168fb_probe(struct platform_device *pdev)
+static int pxa168fb_probe(struct platform_device *pdev)
 {
 	struct pxa168fb_mach_info *mi;
 	struct fb_info *info = 0;
diff --git a/drivers/video/pxa3xx-gcu.c b/drivers/video/pxa3xx-gcu.c
index 4493a47..f163474 100644
--- a/drivers/video/pxa3xx-gcu.c
+++ b/drivers/video/pxa3xx-gcu.c
@@ -574,7 +574,7 @@ free_buffers(struct platform_device *dev,
 	priv->free = NULL;
 }
 
-static int __devinit
+static int
 pxa3xx_gcu_probe(struct platform_device *dev)
 {
 	int i, ret, irq;
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index ffa62e2..1ff1a16 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -869,7 +869,7 @@ static struct fb_ops overlay_fb_ops = {
 	.fb_set_par		= overlayfb_set_par,
 };
 
-static void __devinit init_pxafb_overlay(struct pxafb_info *fbi,
+static void init_pxafb_overlay(struct pxafb_info *fbi,
 					 struct pxafb_layer *ofb, int id)
 {
 	sprintf(ofb->fb.fix.id, "overlay%d", id + 1);
@@ -903,7 +903,7 @@ static inline int pxafb_overlay_supported(void)
 	return 0;
 }
 
-static int __devinit pxafb_overlay_map_video_memory(struct pxafb_info *pxafb,
+static int pxafb_overlay_map_video_memory(struct pxafb_info *pxafb,
 	struct pxafb_layer *ofb)
 {
 	/* We assume that user will use at most video_mem_size for overlay fb,
@@ -927,7 +927,7 @@ static int __devinit pxafb_overlay_map_video_memory(struct pxafb_info *pxafb,
 	return 0;
 }
 
-static void __devinit pxafb_overlay_init(struct pxafb_info *fbi)
+static void pxafb_overlay_init(struct pxafb_info *fbi)
 {
 	int i, ret;
 
@@ -1706,7 +1706,7 @@ static const struct dev_pm_ops pxafb_pm_ops = {
 };
 #endif
 
-static int __devinit pxafb_init_video_memory(struct pxafb_info *fbi)
+static int pxafb_init_video_memory(struct pxafb_info *fbi)
 {
 	int size = PAGE_ALIGN(fbi->video_mem_size);
 
@@ -1789,7 +1789,7 @@ decode_mode:
 		fbi->video_mem_size = video_mem_size;
 }
 
-static struct pxafb_info * __devinit pxafb_init_fbinfo(struct device *dev)
+static struct pxafb_info *pxafb_init_fbinfo(struct device *dev)
 {
 	struct pxafb_info *fbi;
 	void *addr;
@@ -1853,7 +1853,7 @@ static struct pxafb_info * __devinit pxafb_init_fbinfo(struct device *dev)
 }
 
 #ifdef CONFIG_FB_PXA_PARAMETERS
-static int __devinit parse_opt_mode(struct device *dev, const char *this_opt)
+static int parse_opt_mode(struct device *dev, const char *this_opt)
 {
 	struct pxafb_mach_info *inf = dev->platform_data;
 
@@ -1912,7 +1912,7 @@ done:
 	return 0;
 }
 
-static int __devinit parse_opt(struct device *dev, char *this_opt)
+static int parse_opt(struct device *dev, char *this_opt)
 {
 	struct pxafb_mach_info *inf = dev->platform_data;
 	struct pxafb_mode_info *mode = &inf->modes[0];
@@ -2012,7 +2012,7 @@ static int __devinit parse_opt(struct device *dev, char *this_opt)
 	return 0;
 }
 
-static int __devinit pxafb_parse_options(struct device *dev, char *options)
+static int pxafb_parse_options(struct device *dev, char *options)
 {
 	char *this_opt;
 	int ret;
@@ -2061,7 +2061,7 @@ MODULE_PARM_DESC(options, "LCD parameters (see Documentation/fb/pxafb.txt)");
 #ifdef DEBUG_VAR
 /* Check for various illegal bit-combinations. Currently only
  * a warning is given. */
-static void __devinit pxafb_check_options(struct device *dev,
+static void pxafb_check_options(struct device *dev,
 					  struct pxafb_mach_info *inf)
 {
 	if (inf->lcd_conn)
@@ -2094,7 +2094,7 @@ static void __devinit pxafb_check_options(struct device *dev,
 #define pxafb_check_options(...)	do {} while (0)
 #endif
 
-static int __devinit pxafb_probe(struct platform_device *dev)
+static int pxafb_probe(struct platform_device *dev)
 {
 	struct pxafb_info *fbi;
 	struct pxafb_mach_info *inf;
diff --git a/drivers/video/q40fb.c b/drivers/video/q40fb.c
index a104e8c..d1a7529 100644
--- a/drivers/video/q40fb.c
+++ b/drivers/video/q40fb.c
@@ -83,7 +83,7 @@ static struct fb_ops q40fb_ops = {
 	.fb_imageblit	= cfb_imageblit,
 };
 
-static int __devinit q40fb_probe(struct platform_device *dev)
+static int q40fb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
 
diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index 693ed5e..49caea2 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -1709,7 +1709,7 @@ static struct fb_ops riva_fb_ops = {
 	.fb_sync 	= rivafb_sync,
 };
 
-static int __devinit riva_set_fbinfo(struct fb_info *info)
+static int riva_set_fbinfo(struct fb_info *info)
 {
 	unsigned int cmap_len;
 	struct riva_par *par = info->par;
@@ -1747,7 +1747,7 @@ static int __devinit riva_set_fbinfo(struct fb_info *info)
 }
 
 #ifdef CONFIG_PPC_OF
-static int __devinit riva_get_EDID_OF(struct fb_info *info, struct pci_dev *pd)
+static int riva_get_EDID_OF(struct fb_info *info, struct pci_dev *pd)
 {
 	struct riva_par *par = info->par;
 	struct device_node *dp;
@@ -1780,7 +1780,7 @@ static int __devinit riva_get_EDID_OF(struct fb_info *info, struct pci_dev *pd)
 #endif /* CONFIG_PPC_OF */
 
 #if defined(CONFIG_FB_RIVA_I2C) && !defined(CONFIG_PPC_OF)
-static int __devinit riva_get_EDID_i2c(struct fb_info *info)
+static int riva_get_EDID_i2c(struct fb_info *info)
 {
 	struct riva_par *par = info->par;
 	struct fb_var_screeninfo var;
@@ -1803,7 +1803,7 @@ static int __devinit riva_get_EDID_i2c(struct fb_info *info)
 }
 #endif /* CONFIG_FB_RIVA_I2C */
 
-static void __devinit riva_update_default_var(struct fb_var_screeninfo *var,
+static void riva_update_default_var(struct fb_var_screeninfo *var,
 					      struct fb_info *info)
 {
 	struct fb_monspecs *specs = &info->monspecs;
@@ -1836,7 +1836,7 @@ static void __devinit riva_update_default_var(struct fb_var_screeninfo *var,
 }
 
 
-static void __devinit riva_get_EDID(struct fb_info *info, struct pci_dev *pdev)
+static void riva_get_EDID(struct fb_info *info, struct pci_dev *pdev)
 {
 	NVTRACE_ENTER();
 #ifdef CONFIG_PPC_OF
@@ -1850,7 +1850,7 @@ static void __devinit riva_get_EDID(struct fb_info *info, struct pci_dev *pdev)
 }
 
 
-static void __devinit riva_get_edidinfo(struct fb_info *info)
+static void riva_get_edidinfo(struct fb_info *info)
 {
 	struct fb_var_screeninfo *var = &rivafb_default_var;
 	struct riva_par *par = info->par;
@@ -1871,7 +1871,7 @@ static void __devinit riva_get_edidinfo(struct fb_info *info)
  *
  * ------------------------------------------------------------------------- */
 
-static u32 __devinit riva_get_arch(struct pci_dev *pd)
+static u32 riva_get_arch(struct pci_dev *pd)
 {
     	u32 arch = 0;
 
@@ -1909,7 +1909,7 @@ static u32 __devinit riva_get_arch(struct pci_dev *pd)
 	return arch;
 }
 
-static int __devinit rivafb_probe(struct pci_dev *pd,
+static int rivafb_probe(struct pci_dev *pd,
 			     	const struct pci_device_id *ent)
 {
 	struct riva_par *default_par;
@@ -2145,7 +2145,7 @@ static void __devexit rivafb_remove(struct pci_dev *pd)
  * ------------------------------------------------------------------------- */
 
 #ifndef MODULE
-static int __devinit rivafb_setup(char *options)
+static int rivafb_setup(char *options)
 {
 	char *this_opt;
 
@@ -2197,7 +2197,7 @@ static struct pci_driver rivafb_driver = {
  *
  * ------------------------------------------------------------------------- */
 
-static int __devinit rivafb_init(void)
+static int rivafb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
diff --git a/drivers/video/riva/rivafb-i2c.c b/drivers/video/riva/rivafb-i2c.c
index 167400e..db78ac8 100644
--- a/drivers/video/riva/rivafb-i2c.c
+++ b/drivers/video/riva/rivafb-i2c.c
@@ -86,7 +86,7 @@ static int riva_gpio_getsda(void* data)
 	return val;
 }
 
-static int __devinit riva_setup_i2c_bus(struct riva_i2c_chan *chan,
+static int riva_setup_i2c_bus(struct riva_i2c_chan *chan,
 					const char *name,
 					unsigned int i2c_class)
 {
@@ -124,7 +124,7 @@ static int __devinit riva_setup_i2c_bus(struct riva_i2c_chan *chan,
 	return rc;
 }
 
-void __devinit riva_create_i2c_busses(struct riva_par *par)
+void riva_create_i2c_busses(struct riva_par *par)
 {
 	par->chan[0].par	= par;
 	par->chan[1].par	= par;
@@ -150,7 +150,7 @@ void riva_delete_i2c_busses(struct riva_par *par)
 	}
 }
 
-int __devinit riva_probe_i2c_connector(struct riva_par *par, int conn, u8 **out_edid)
+int riva_probe_i2c_connector(struct riva_par *par, int conn, u8 **out_edid)
 {
 	u8 *edid = NULL;
 
diff --git a/drivers/video/s1d13xxxfb.c b/drivers/video/s1d13xxxfb.c
index 28b1c6c..f7839e1 100644
--- a/drivers/video/s1d13xxxfb.c
+++ b/drivers/video/s1d13xxxfb.c
@@ -642,7 +642,7 @@ static int s1d13xxxfb_width_tab[2][4] __devinitdata = {
  *	Note: some of the hardcoded values here might need some love to
  *	work on various chips, and might need to no longer be hardcoded.
  */
-static void __devinit
+static void
 s1d13xxxfb_fetch_hw_state(struct fb_info *info)
 {
 	struct fb_var_screeninfo *var = &info->var;
@@ -764,7 +764,7 @@ s1d13xxxfb_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devinit
+static int
 s1d13xxxfb_probe(struct platform_device *pdev)
 {
 	struct s1d13xxxfb_par *default_par;
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 71981a5..141fefd 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1079,7 +1079,7 @@ static void s3c_fb_missing_pixclock(struct fb_videomode *mode)
  *
  * Allocate memory for the given framebuffer.
  */
-static int __devinit s3c_fb_alloc_memory(struct s3c_fb *sfb,
+static int s3c_fb_alloc_memory(struct s3c_fb *sfb,
 					 struct s3c_fb_win *win)
 {
 	struct s3c_fb_pd_win *windata = win->windata;
@@ -1170,7 +1170,7 @@ static void s3c_fb_release_win(struct s3c_fb *sfb, struct s3c_fb_win *win)
  * Allocate and do the basic initialisation for one of the hardware's graphics
  * windows.
  */
-static int __devinit s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
+static int s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 				      struct s3c_fb_win_variant *variant,
 				      struct s3c_fb_win **res)
 {
@@ -1358,7 +1358,7 @@ static void s3c_fb_clear_win(struct s3c_fb *sfb, int win)
 	}
 }
 
-static int __devinit s3c_fb_probe(struct platform_device *pdev)
+static int s3c_fb_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *platid;
 	struct s3c_fb_driverdata *fbdrv;
diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index fbf3cea..528cec6 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -637,7 +637,7 @@ static struct fb_ops s3c2410fb_ops = {
  *	cache.  Once this area is remapped, all virtual memory
  *	access to the video memory should occur at the new region.
  */
-static int __devinit s3c2410fb_map_video_memory(struct fb_info *info)
+static int s3c2410fb_map_video_memory(struct fb_info *info)
 {
 	struct s3c2410fb_info *fbi = info->par;
 	dma_addr_t map_dma;
@@ -819,7 +819,7 @@ static inline void s3c2410fb_cpufreq_deregister(struct s3c2410fb_info *info)
 
 static const char driver_name[] = "s3c2410fb";
 
-static int __devinit s3c24xxfb_probe(struct platform_device *pdev,
+static int s3c24xxfb_probe(struct platform_device *pdev,
 				  enum s3c_drv_type drv_type)
 {
 	struct s3c2410fb_info *info;
@@ -1010,12 +1010,12 @@ dealloc_fb:
 	return ret;
 }
 
-static int __devinit s3c2410fb_probe(struct platform_device *pdev)
+static int s3c2410fb_probe(struct platform_device *pdev)
 {
 	return s3c24xxfb_probe(pdev, DRV_S3C2410);
 }
 
-static int __devinit s3c2412fb_probe(struct platform_device *pdev)
+static int s3c2412fb_probe(struct platform_device *pdev)
 {
 	return s3c24xxfb_probe(pdev, DRV_S3C2412);
 }
diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index 1b4f146..e66ecbb 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -255,7 +255,7 @@ static int s3fb_ddc_getsda(void *data)
 	return !!(s3fb_ddc_read(par) & DDC_SDA_IN);
 }
 
-static int __devinit s3fb_setup_ddc_bus(struct fb_info *info)
+static int s3fb_setup_ddc_bus(struct fb_info *info)
 {
 	struct s3fb_info *par = info->par;
 
@@ -1066,7 +1066,7 @@ static struct fb_ops s3fb_ops = {
 
 /* ------------------------------------------------------------------------- */
 
-static int __devinit s3_identification(struct s3fb_info *par)
+static int s3_identification(struct s3fb_info *par)
 {
 	int chip = par->chip;
 
@@ -1122,7 +1122,7 @@ static int __devinit s3_identification(struct s3fb_info *par)
 
 /* PCI probe */
 
-static int __devinit s3_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int s3_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct pci_bus_region bus_reg;
 	struct resource vga_res;
diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index b632584..5e79fea 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -1090,7 +1090,7 @@ static int sa1100fb_resume(struct platform_device *dev)
  *      cache.  Once this area is remapped, all virtual memory
  *      access to the video memory should occur at the new region.
  */
-static int __devinit sa1100fb_map_video_memory(struct sa1100fb_info *fbi)
+static int sa1100fb_map_video_memory(struct sa1100fb_info *fbi)
 {
 	/*
 	 * We reserve one page for the palette, plus the size
@@ -1124,7 +1124,7 @@ static struct fb_monspecs monspecs __devinitdata = {
 };
 
 
-static struct sa1100fb_info * __devinit sa1100fb_init_fbinfo(struct device *dev)
+static struct sa1100fb_info *sa1100fb_init_fbinfo(struct device *dev)
 {
 	struct sa1100fb_mach_info *inf = dev->platform_data;
 	struct sa1100fb_info *fbi;
@@ -1205,7 +1205,7 @@ static struct sa1100fb_info * __devinit sa1100fb_init_fbinfo(struct device *dev)
 	return fbi;
 }
 
-static int __devinit sa1100fb_probe(struct platform_device *pdev)
+static int sa1100fb_probe(struct platform_device *pdev)
 {
 	struct sa1100fb_info *fbi;
 	struct resource *res;
diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index a1cc484..dbf8d62 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -1715,7 +1715,7 @@ static void savage_disable_mmio(struct savagefb_par *par)
 }
 
 
-static int __devinit savage_map_mmio(struct fb_info *info)
+static int savage_map_mmio(struct fb_info *info)
 {
 	struct savagefb_par *par = info->par;
 	DBG("savage_map_mmio");
@@ -1761,7 +1761,7 @@ static void savage_unmap_mmio(struct fb_info *info)
 	}
 }
 
-static int __devinit savage_map_video(struct fb_info *info,
+static int savage_map_video(struct fb_info *info,
 				      int video_len)
 {
 	struct savagefb_par *par = info->par;
@@ -2052,7 +2052,7 @@ static int savage_init_hw(struct savagefb_par *par)
 	return videoRambytes;
 }
 
-static int __devinit savage_init_fb_info(struct fb_info *info,
+static int savage_init_fb_info(struct fb_info *info,
 					 struct pci_dev *dev,
 					 const struct pci_device_id *id)
 {
@@ -2178,7 +2178,7 @@ static int __devinit savage_init_fb_info(struct fb_info *info,
 
 /* --------------------------------------------------------------------- */
 
-static int __devinit savagefb_probe(struct pci_dev* dev,
+static int savagefb_probe(struct pci_dev* dev,
 				    const struct pci_device_id* id)
 {
 	struct fb_info *info;
diff --git a/drivers/video/sgivwfb.c b/drivers/video/sgivwfb.c
index b5c30b9..c65ab22 100644
--- a/drivers/video/sgivwfb.c
+++ b/drivers/video/sgivwfb.c
@@ -745,7 +745,7 @@ int __init sgivwfb_setup(char *options)
 /*
  *  Initialisation
  */
-static int __devinit sgivwfb_probe(struct platform_device *dev)
+static int sgivwfb_probe(struct platform_device *dev)
 {
 	struct sgivw_par *par;
 	struct fb_info *info;
diff --git a/drivers/video/sh7760fb.c b/drivers/video/sh7760fb.c
index ff93339..0ad44d1 100644
--- a/drivers/video/sh7760fb.c
+++ b/drivers/video/sh7760fb.c
@@ -431,7 +431,7 @@ static int sh7760fb_alloc_mem(struct fb_info *info)
 	return 0;
 }
 
-static int __devinit sh7760fb_probe(struct platform_device *pdev)
+static int sh7760fb_probe(struct platform_device *pdev)
 {
 	struct fb_info *info;
 	struct resource *res;
diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 699487c..d776bfe 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1639,7 +1639,7 @@ sh_mobile_lcdc_overlay_fb_unregister(struct sh_mobile_lcdc_overlay *ovl)
 	unregister_framebuffer(ovl->info);
 }
 
-static int __devinit
+static int
 sh_mobile_lcdc_overlay_fb_register(struct sh_mobile_lcdc_overlay *ovl)
 {
 	struct sh_mobile_lcdc_priv *lcdc = ovl->channel->lcdc;
@@ -1678,7 +1678,7 @@ sh_mobile_lcdc_overlay_fb_cleanup(struct sh_mobile_lcdc_overlay *ovl)
 	framebuffer_release(info);
 }
 
-static int __devinit
+static int
 sh_mobile_lcdc_overlay_fb_init(struct sh_mobile_lcdc_overlay *ovl)
 {
 	struct sh_mobile_lcdc_priv *priv = ovl->channel->lcdc;
@@ -2117,7 +2117,7 @@ sh_mobile_lcdc_channel_fb_unregister(struct sh_mobile_lcdc_chan *ch)
 		unregister_framebuffer(ch->info);
 }
 
-static int __devinit
+static int
 sh_mobile_lcdc_channel_fb_register(struct sh_mobile_lcdc_chan *ch)
 {
 	struct fb_info *info = ch->info;
@@ -2165,7 +2165,7 @@ sh_mobile_lcdc_channel_fb_cleanup(struct sh_mobile_lcdc_chan *ch)
 	framebuffer_release(info);
 }
 
-static int __devinit
+static int
 sh_mobile_lcdc_channel_fb_init(struct sh_mobile_lcdc_chan *ch,
 			       const struct fb_videomode *mode,
 			       unsigned int num_modes)
@@ -2475,7 +2475,7 @@ static int sh_mobile_lcdc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devinit sh_mobile_lcdc_check_interface(struct sh_mobile_lcdc_chan *ch)
+static int sh_mobile_lcdc_check_interface(struct sh_mobile_lcdc_chan *ch)
 {
 	int interface_type = ch->cfg->interface_type;
 
@@ -2515,7 +2515,7 @@ static int __devinit sh_mobile_lcdc_check_interface(struct sh_mobile_lcdc_chan *
 	return 0;
 }
 
-static int __devinit
+static int
 sh_mobile_lcdc_overlay_init(struct sh_mobile_lcdc_priv *priv,
 			  struct sh_mobile_lcdc_overlay *ovl)
 {
@@ -2570,7 +2570,7 @@ sh_mobile_lcdc_overlay_init(struct sh_mobile_lcdc_priv *priv,
 	return 0;
 }
 
-static int __devinit
+static int
 sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 			    struct sh_mobile_lcdc_chan *ch)
 {
@@ -2675,7 +2675,7 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 	return sh_mobile_lcdc_channel_fb_init(ch, mode, num_modes);
 }
 
-static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
+static int sh_mobile_lcdc_probe(struct platform_device *pdev)
 {
 	struct sh_mobile_lcdc_info *pdata = pdev->dev.platform_data;
 	struct sh_mobile_lcdc_priv *priv;
diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_meram.c
index 7a0ba8b..e0f0985 100644
--- a/drivers/video/sh_mobile_meram.c
+++ b/drivers/video/sh_mobile_meram.c
@@ -620,7 +620,7 @@ static UNIVERSAL_DEV_PM_OPS(sh_mobile_meram_dev_pm_ops,
  * Probe/remove and driver init/exit
  */
 
-static int __devinit sh_mobile_meram_probe(struct platform_device *pdev)
+static int sh_mobile_meram_probe(struct platform_device *pdev)
 {
 	struct sh_mobile_meram_priv *priv;
 	struct sh_mobile_meram_info *pdata = pdev->dev.platform_data;
diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index 5193138..820a002 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -106,7 +106,7 @@ sisfb_setdefaultparms(void)
 
 /* ------------- Parameter parsing -------------- */
 
-static void __devinit
+static void
 sisfb_search_vesamode(unsigned int vesamode, bool quiet)
 {
 	int i = 0, j = 0;
@@ -146,7 +146,7 @@ sisfb_search_vesamode(unsigned int vesamode, bool quiet)
 		printk(KERN_ERR "sisfb: Invalid VESA mode 0x%x'\n", vesamode);
 }
 
-static void __devinit
+static void
 sisfb_search_mode(char *name, bool quiet)
 {
 	unsigned int j = 0, xres = 0, yres = 0, depth = 0, rate = 0;
@@ -225,7 +225,7 @@ sisfb_search_mode(char *name, bool quiet)
 }
 
 #ifndef MODULE
-static void __devinit
+static void
 sisfb_get_vga_mode_from_kernel(void)
 {
 #ifdef CONFIG_X86
@@ -345,7 +345,7 @@ sisfb_search_specialtiming(const char *name)
 
 /* ----------- Various detection routines ----------- */
 
-static void __devinit
+static void
 sisfb_detect_custom_timing(struct sis_video_info *ivideo)
 {
 	unsigned char *biosver = NULL;
@@ -403,7 +403,7 @@ sisfb_detect_custom_timing(struct sis_video_info *ivideo)
 	} while(mycustomttable[i].chipID);
 }
 
-static bool __devinit
+static bool
 sisfb_interpret_edid(struct sisfb_monitor *monitor, u8 *buffer)
 {
 	int i, j, xres, yres, refresh, index;
@@ -505,7 +505,7 @@ sisfb_interpret_edid(struct sisfb_monitor *monitor, u8 *buffer)
 	return monitor->datavalid;
 }
 
-static void __devinit
+static void
 sisfb_handle_ddc(struct sis_video_info *ivideo, struct sisfb_monitor *monitor, int crtno)
 {
 	unsigned short temp, i, realcrtno = crtno;
@@ -1898,8 +1898,7 @@ static struct fb_ops sisfb_ops = {
 
 /* ---------------- Chip generation dependent routines ---------------- */
 
-static struct pci_dev * __devinit
-sisfb_get_northbridge(int basechipid)
+static struct pci_dev *sisfb_get_northbridge(int basechipid)
 {
 	struct pci_dev *pdev = NULL;
 	int nbridgenum, nbridgeidx, i;
@@ -1938,7 +1937,7 @@ sisfb_get_northbridge(int basechipid)
 	return pdev;
 }
 
-static int __devinit
+static int
 sisfb_get_dram_size(struct sis_video_info *ivideo)
 {
 #if defined(CONFIG_FB_SIS_300) || defined(CONFIG_FB_SIS_315)
@@ -2038,7 +2037,7 @@ sisfb_get_dram_size(struct sis_video_info *ivideo)
 
 /* -------------- video bridge device detection --------------- */
 
-static void __devinit
+static void
 sisfb_detect_VB_connect(struct sis_video_info *ivideo)
 {
 	u8 cr32, temp;
@@ -2164,7 +2163,7 @@ sisfb_detect_VB_connect(struct sis_video_info *ivideo)
 
 /* ------------------ Sensing routines ------------------ */
 
-static bool __devinit
+static bool
 sisfb_test_DDC1(struct sis_video_info *ivideo)
 {
     unsigned short old;
@@ -2177,7 +2176,7 @@ sisfb_test_DDC1(struct sis_video_info *ivideo)
     return (count != -1);
 }
 
-static void __devinit
+static void
 sisfb_sense_crt1(struct sis_video_info *ivideo)
 {
     bool mustwait = false;
@@ -2259,7 +2258,7 @@ sisfb_sense_crt1(struct sis_video_info *ivideo)
 }
 
 /* Determine and detect attached devices on SiS30x */
-static void __devinit
+static void
 SiS_SenseLCD(struct sis_video_info *ivideo)
 {
 	unsigned char buffer[256];
@@ -2347,7 +2346,7 @@ SiS_SenseLCD(struct sis_video_info *ivideo)
 	ivideo->SiS_Pr.PanelSelfDetected = true;
 }
 
-static int __devinit
+static int
 SISDoSense(struct sis_video_info *ivideo, u16 type, u16 test)
 {
     int temp, mytest, result, i, j;
@@ -2377,7 +2376,7 @@ SISDoSense(struct sis_video_info *ivideo, u16 type, u16 test)
     return result;
 }
 
-static void __devinit
+static void
 SiS_Sense30x(struct sis_video_info *ivideo)
 {
     u8  backupP4_0d,backupP2_00,backupP2_4d,backupSR_1e,biosflag=0;
@@ -2518,7 +2517,7 @@ SiS_Sense30x(struct sis_video_info *ivideo)
 }
 
 /* Determine and detect attached TV's on Chrontel */
-static void __devinit
+static void
 SiS_SenseCh(struct sis_video_info *ivideo)
 {
 #if defined(CONFIG_FB_SIS_300) || defined(CONFIG_FB_SIS_315)
@@ -2643,7 +2642,7 @@ SiS_SenseCh(struct sis_video_info *ivideo)
     }
 }
 
-static void __devinit
+static void
 sisfb_get_VB_type(struct sis_video_info *ivideo)
 {
 	char stdstr[]    = "sisfb: Detected";
@@ -2906,7 +2905,7 @@ sisfb_engine_init(struct sis_video_info *ivideo)
 	ivideo->engineok = 1;
 }
 
-static void __devinit
+static void
 sisfb_detect_lcd_type(struct sis_video_info *ivideo)
 {
 	u8 reg;
@@ -2962,7 +2961,7 @@ sisfb_detect_lcd_type(struct sis_video_info *ivideo)
 			ivideo->lcdxres, ivideo->lcdyres);
 }
 
-static void __devinit
+static void
 sisfb_save_pdc_emi(struct sis_video_info *ivideo)
 {
 #ifdef CONFIG_FB_SIS_300
@@ -3081,7 +3080,7 @@ sisfb_save_pdc_emi(struct sis_video_info *ivideo)
 
 /* -------------------- Memory manager routines ---------------------- */
 
-static u32 __devinit
+static u32
 sisfb_getheapstart(struct sis_video_info *ivideo)
 {
 	u32 ret = ivideo->sisfb_parm_mem * 1024;
@@ -3128,7 +3127,7 @@ sisfb_getheapstart(struct sis_video_info *ivideo)
 	return ret;
 }
 
-static u32 __devinit
+static u32
 sisfb_getheapsize(struct sis_video_info *ivideo)
 {
 	u32 max = ivideo->video_size - ivideo->hwcursor_size - ivideo->cmdQueueSize;
@@ -3154,7 +3153,7 @@ sisfb_getheapsize(struct sis_video_info *ivideo)
 	return ret;
 }
 
-static int __devinit
+static int
 sisfb_heap_init(struct sis_video_info *ivideo)
 {
 	struct SIS_OH *poh;
@@ -4061,7 +4060,7 @@ static int __init sisfb_setup(char *options)
 }
 #endif
 
-static int __devinit
+static int
 sisfb_check_rom(void __iomem *rom_base, struct sis_video_info *ivideo)
 {
 	void __iomem *rom;
@@ -4089,8 +4088,7 @@ sisfb_check_rom(void __iomem *rom_base, struct sis_video_info *ivideo)
 	return 1;
 }
 
-static unsigned char * __devinit
-sisfb_find_rom(struct pci_dev *pdev)
+static unsigned char *sisfb_find_rom(struct pci_dev *pdev)
 {
 	struct sis_video_info *ivideo = pci_get_drvdata(pdev);
 	void __iomem *rom_base;
@@ -4149,7 +4147,7 @@ sisfb_find_rom(struct pci_dev *pdev)
 	return myrombase;
 }
 
-static void __devinit
+static void
 sisfb_post_map_vram(struct sis_video_info *ivideo, unsigned int *mapsize,
 			unsigned int min)
 {
@@ -4176,7 +4174,7 @@ sisfb_post_map_vram(struct sis_video_info *ivideo, unsigned int *mapsize,
 }
 
 #ifdef CONFIG_FB_SIS_300
-static int __devinit
+static int
 sisfb_post_300_buswidth(struct sis_video_info *ivideo)
 {
 	void __iomem *FBAddress = ivideo->video_vbase;
@@ -4242,7 +4240,7 @@ static const unsigned short __devinitconst SiS_DRAMType[17][5] = {
 	{0x09,0x08,0x01,0x01,0x00}
 };
 
-static int __devinit
+static int
 sisfb_post_300_rwtest(struct sis_video_info *ivideo, int iteration, int buswidth,
 			int PseudoRankCapacity, int PseudoAdrPinCount,
 			unsigned int mapsize)
@@ -4309,7 +4307,7 @@ sisfb_post_300_rwtest(struct sis_video_info *ivideo, int iteration, int buswidth
 	return 0;
 }
 
-static void __devinit
+static void
 sisfb_post_300_ramsize(struct pci_dev *pdev, unsigned int mapsize)
 {
 	struct	sis_video_info *ivideo = pci_get_drvdata(pdev);
@@ -4335,7 +4333,7 @@ sisfb_post_300_ramsize(struct pci_dev *pdev, unsigned int mapsize)
 	}
 }
 
-static void __devinit
+static void
 sisfb_post_sis300(struct pci_dev *pdev)
 {
 	struct sis_video_info *ivideo = pci_get_drvdata(pdev);
@@ -4547,7 +4545,7 @@ sisfb_post_sis300(struct pci_dev *pdev)
 
 #ifdef CONFIG_FB_SIS_315
 #if 0
-static void __devinit
+static void
 sisfb_post_sis315330(struct pci_dev *pdev)
 {
 	/* TODO */
@@ -4559,7 +4557,7 @@ static inline int sisfb_xgi_is21(struct sis_video_info *ivideo)
 	return ivideo->chip_real_id == XGI_21;
 }
 
-static void __devinit
+static void
 sisfb_post_xgi_delay(struct sis_video_info *ivideo, int delay)
 {
 	unsigned int i;
@@ -4571,7 +4569,7 @@ sisfb_post_xgi_delay(struct sis_video_info *ivideo, int delay)
 	}
 }
 
-static int __devinit
+static int
 sisfb_find_host_bridge(struct sis_video_info *ivideo, struct pci_dev *mypdev,
 				unsigned short pcivendor)
 {
@@ -4591,7 +4589,7 @@ sisfb_find_host_bridge(struct sis_video_info *ivideo, struct pci_dev *mypdev,
 	return ret;
 }
 
-static int __devinit
+static int
 sisfb_post_xgi_rwtest(struct sis_video_info *ivideo, int starta,
 			unsigned int enda, unsigned int mapsize)
 {
@@ -4623,7 +4621,7 @@ sisfb_post_xgi_rwtest(struct sis_video_info *ivideo, int starta,
 	return 1;
 }
 
-static int __devinit
+static int
 sisfb_post_xgi_ramsize(struct sis_video_info *ivideo)
 {
 	unsigned int buswidth, ranksize, channelab, mapsize;
@@ -4876,7 +4874,7 @@ bail_out:
 	return status;
 }
 
-static void __devinit
+static void
 sisfb_post_xgi_setclocks(struct sis_video_info *ivideo, u8 regb)
 {
 	u8 v1, v2, v3;
@@ -4932,7 +4930,7 @@ sisfb_post_xgi_setclocks(struct sis_video_info *ivideo, u8 regb)
 	sisfb_post_xgi_delay(ivideo, 0x43);
 }
 
-static void __devinit
+static void
 sisfb_post_xgi_ddr2_mrs_default(struct sis_video_info *ivideo, u8 regb)
 {
 	unsigned char *bios = ivideo->bios_abase;
@@ -4973,7 +4971,7 @@ sisfb_post_xgi_ddr2_mrs_default(struct sis_video_info *ivideo, u8 regb)
 	sisfb_post_xgi_delay(ivideo, 1);
 }
 
-static void __devinit
+static void
 sisfb_post_xgi_ddr2_mrs_xg21(struct sis_video_info *ivideo)
 {
 	sisfb_post_xgi_setclocks(ivideo, 1);
@@ -5015,7 +5013,7 @@ sisfb_post_xgi_ddr2_mrs_xg21(struct sis_video_info *ivideo)
 	sisfb_post_xgi_delay(ivideo, 1);
 }
 
-static void __devinit
+static void
 sisfb_post_xgi_ddr2(struct sis_video_info *ivideo, u8 regb)
 {
 	unsigned char *bios = ivideo->bios_abase;
@@ -5061,7 +5059,7 @@ sisfb_post_xgi_ddr2(struct sis_video_info *ivideo, u8 regb)
 		sisfb_post_xgi_ddr2_mrs_default(ivideo, regb);
 }
 
-static u8 __devinit
+static u8
 sisfb_post_xgi_ramtype(struct sis_video_info *ivideo)
 {
 	unsigned char *bios = ivideo->bios_abase;
@@ -5101,7 +5099,7 @@ sisfb_post_xgi_ramtype(struct sis_video_info *ivideo)
 	return ramtype;
 }
 
-static int __devinit
+static int
 sisfb_post_xgi(struct pci_dev *pdev)
 {
 	struct sis_video_info *ivideo = pci_get_drvdata(pdev);
@@ -5839,7 +5837,7 @@ sisfb_post_xgi(struct pci_dev *pdev)
 }
 #endif
 
-static int __devinit
+static int
 sisfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct sisfb_chip_info	*chipinfo = &sisfb_chip_info[ent->driver_data];
diff --git a/drivers/video/skeletonfb.c b/drivers/video/skeletonfb.c
index ce61d9d..28a38ba 100644
--- a/drivers/video/skeletonfb.c
+++ b/drivers/video/skeletonfb.c
@@ -678,7 +678,7 @@ static struct fb_ops xxxfb_ops = {
      */
 
 /* static int __init xxfb_probe (struct platform_device *pdev) -- for platform devs */
-static int __devinit xxxfb_probe(struct pci_dev *dev,
+static int xxxfb_probe(struct pci_dev *dev,
 			      const struct pci_device_id *ent)
 {
     struct fb_info *info;
diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
index 3690eff..6703712 100644
--- a/drivers/video/sm501fb.c
+++ b/drivers/video/sm501fb.c
@@ -1664,7 +1664,7 @@ static void sm501fb_stop(struct sm501fb_info *info)
 			   resource_size(info->regs_res));
 }
 
-static int __devinit sm501fb_init_fb(struct fb_info *fb,
+static int sm501fb_init_fb(struct fb_info *fb,
 			   enum sm501_controller head,
 			   const char *fbname)
 {
@@ -1850,7 +1850,7 @@ static struct sm501_platdata_fb sm501fb_def_pdata = {
 static char driver_name_crt[] = "sm501fb-crt";
 static char driver_name_pnl[] = "sm501fb-panel";
 
-static int __devinit sm501fb_probe_one(struct sm501fb_info *info,
+static int sm501fb_probe_one(struct sm501fb_info *info,
 				       enum sm501_controller head)
 {
 	unsigned char *name = (head == HEAD_CRT) ? "crt" : "panel";
@@ -1892,7 +1892,7 @@ static void sm501_free_init_fb(struct sm501fb_info *info,
 	fb_dealloc_cmap(&fbi->cmap);
 }
 
-static int __devinit sm501fb_start_one(struct sm501fb_info *info,
+static int sm501fb_start_one(struct sm501fb_info *info,
 				       enum sm501_controller head,
 				       const char *drvname)
 {
@@ -1922,7 +1922,7 @@ static int __devinit sm501fb_start_one(struct sm501fb_info *info,
 	return 0;
 }
 
-static int __devinit sm501fb_probe(struct platform_device *pdev)
+static int sm501fb_probe(struct platform_device *pdev)
 {
 	struct sm501fb_info *info;
 	struct device *dev = &pdev->dev;
diff --git a/drivers/video/sstfb.c b/drivers/video/sstfb.c
index 871e074..c4ce3ef 100644
--- a/drivers/video/sstfb.c
+++ b/drivers/video/sstfb.c
@@ -822,7 +822,7 @@ static void sstfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 /* 
  * get lfb size 
  */
-static int __devinit sst_get_memsize(struct fb_info *info, __u32 *memsize)
+static int sst_get_memsize(struct fb_info *info, __u32 *memsize)
 {
 	u8 __iomem *fbbase_virt = info->screen_base;
 
@@ -865,7 +865,7 @@ static int __devinit sst_get_memsize(struct fb_info *info, __u32 *memsize)
 /* fbi should be idle, and fifo emty and mem disabled */
 /* supposed to detect AT&T ATT20C409 and Ti TVP3409 ramdacs */
 
-static int __devinit sst_detect_att(struct fb_info *info)
+static int sst_detect_att(struct fb_info *info)
 {
 	struct sstfb_par *par = info->par;
 	int i, mir, dir;
@@ -890,7 +890,7 @@ static int __devinit sst_detect_att(struct fb_info *info)
 	return 0;
 }
 
-static int __devinit sst_detect_ti(struct fb_info *info)
+static int sst_detect_ti(struct fb_info *info)
 {
 	struct sstfb_par *par = info->par;
 	int i, mir, dir;
@@ -926,7 +926,7 @@ static int __devinit sst_detect_ti(struct fb_info *info)
  * touched...
  * is it really safe ? how can i reset this ramdac ? geee...
  */
-static int __devinit sst_detect_ics(struct fb_info *info)
+static int sst_detect_ics(struct fb_info *info)
 {
 	struct sstfb_par *par = info->par;
 	int m_clk0_1, m_clk0_7, m_clk1_b;
@@ -1121,7 +1121,7 @@ static struct dac_switch dacs[] __devinitdata = {
 		.set_vidmod	= sst_set_vidmod_ics },
 };
 
-static int __devinit sst_detect_dactype(struct fb_info *info, struct sstfb_par *par)
+static int sst_detect_dactype(struct fb_info *info, struct sstfb_par *par)
 {
 	int i, ret = 0;
 
@@ -1140,7 +1140,7 @@ static int __devinit sst_detect_dactype(struct fb_info *info, struct sstfb_par *
 /*
  * Internal Routines
  */
-static int __devinit sst_init(struct fb_info *info, struct sstfb_par *par)
+static int sst_init(struct fb_info *info, struct sstfb_par *par)
 {
 	u32 fbiinit0, fbiinit1, fbiinit4;
 	struct pci_dev *dev = par->dev;
@@ -1271,7 +1271,7 @@ static void  __devexit sst_shutdown(struct fb_info *info)
 /*
  * Interface to the world
  */
-static int  __devinit sstfb_setup(char *options)
+static int  sstfb_setup(char *options)
 {
 	char *this_opt;
 
@@ -1317,7 +1317,7 @@ static struct fb_ops sstfb_ops = {
 	.fb_ioctl	= sstfb_ioctl,
 };
 
-static int __devinit sstfb_probe(struct pci_dev *pdev,
+static int sstfb_probe(struct pci_dev *pdev,
 			const struct pci_device_id *id)
 {
 	struct fb_info *info;
@@ -1494,7 +1494,7 @@ static struct pci_driver sstfb_driver = {
 };
 
 
-static int __devinit sstfb_init(void)
+static int sstfb_init(void)
 {
 	char *option = NULL;
 
diff --git a/drivers/video/sunxvr1000.c b/drivers/video/sunxvr1000.c
index cc9bf5f..9e86e3c 100644
--- a/drivers/video/sunxvr1000.c
+++ b/drivers/video/sunxvr1000.c
@@ -25,7 +25,7 @@ struct gfb_info {
 	u32			pseudo_palette[16];
 };
 
-static int __devinit gfb_get_props(struct gfb_info *gp)
+static int gfb_get_props(struct gfb_info *gp)
 {
 	gp->width = of_getintprop_default(gp->of_node, "width", 0);
 	gp->height = of_getintprop_default(gp->of_node, "height", 0);
@@ -66,7 +66,7 @@ static struct fb_ops gfb_ops = {
 	.fb_imageblit		= cfb_imageblit,
 };
 
-static int __devinit gfb_set_fbinfo(struct gfb_info *gp)
+static int gfb_set_fbinfo(struct gfb_info *gp)
 {
 	struct fb_info *info = gp->info;
 	struct fb_var_screeninfo *var = &info->var;
@@ -111,7 +111,7 @@ static int __devinit gfb_set_fbinfo(struct gfb_info *gp)
         return 0;
 }
 
-static int __devinit gfb_probe(struct platform_device *op)
+static int gfb_probe(struct platform_device *op)
 {
 	struct device_node *dp = op->dev.of_node;
 	struct fb_info *info;
diff --git a/drivers/video/sunxvr2500.c b/drivers/video/sunxvr2500.c
index 49bd77a..b6a14d2 100644
--- a/drivers/video/sunxvr2500.c
+++ b/drivers/video/sunxvr2500.c
@@ -29,7 +29,7 @@ struct s3d_info {
 	u32			pseudo_palette[16];
 };
 
-static int __devinit s3d_get_props(struct s3d_info *sp)
+static int s3d_get_props(struct s3d_info *sp)
 {
 	sp->width = of_getintprop_default(sp->of_node, "width", 0);
 	sp->height = of_getintprop_default(sp->of_node, "height", 0);
@@ -70,7 +70,7 @@ static struct fb_ops s3d_ops = {
 	.fb_imageblit		= cfb_imageblit,
 };
 
-static int __devinit s3d_set_fbinfo(struct s3d_info *sp)
+static int s3d_set_fbinfo(struct s3d_info *sp)
 {
 	struct fb_info *info = sp->info;
 	struct fb_var_screeninfo *var = &info->var;
@@ -115,7 +115,7 @@ static int __devinit s3d_set_fbinfo(struct s3d_info *sp)
         return 0;
 }
 
-static int __devinit s3d_pci_register(struct pci_dev *pdev,
+static int s3d_pci_register(struct pci_dev *pdev,
 				      const struct pci_device_id *ent)
 {
 	struct fb_info *info;
diff --git a/drivers/video/sunxvr500.c b/drivers/video/sunxvr500.c
index e94c799..afcdab1 100644
--- a/drivers/video/sunxvr500.c
+++ b/drivers/video/sunxvr500.c
@@ -51,7 +51,7 @@ struct e3d_info {
 	u32			pseudo_palette[16];
 };
 
-static int __devinit e3d_get_props(struct e3d_info *ep)
+static int e3d_get_props(struct e3d_info *ep)
 {
 	ep->width = of_getintprop_default(ep->of_node, "width", 0);
 	ep->height = of_getintprop_default(ep->of_node, "height", 0);
@@ -193,7 +193,7 @@ static struct fb_ops e3d_ops = {
 	.fb_imageblit		= e3d_imageblit,
 };
 
-static int __devinit e3d_set_fbinfo(struct e3d_info *ep)
+static int e3d_set_fbinfo(struct e3d_info *ep)
 {
 	struct fb_info *info = ep->info;
 	struct fb_var_screeninfo *var = &info->var;
@@ -238,7 +238,7 @@ static int __devinit e3d_set_fbinfo(struct e3d_info *ep)
         return 0;
 }
 
-static int __devinit e3d_pci_register(struct pci_dev *pdev,
+static int e3d_pci_register(struct pci_dev *pdev,
 				      const struct pci_device_id *ent)
 {
 	struct device_node *of_node;
diff --git a/drivers/video/tcx.c b/drivers/video/tcx.c
index 9f57539..cfdc1bb 100644
--- a/drivers/video/tcx.c
+++ b/drivers/video/tcx.c
@@ -362,7 +362,7 @@ static void tcx_unmap_regs(struct platform_device *op, struct fb_info *info,
 			   info->screen_base, info->fix.smem_len);
 }
 
-static int __devinit tcx_probe(struct platform_device *op)
+static int tcx_probe(struct platform_device *op)
 {
 	struct device_node *dp = op->dev.of_node;
 	struct fb_info *info;
diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
index bbb0d95..efbf5c9 100644
--- a/drivers/video/tdfxfb.c
+++ b/drivers/video/tdfxfb.c
@@ -135,7 +135,7 @@ static struct fb_var_screeninfo tdfx_var __devinitdata = {
 /*
  * PCI driver prototypes
  */
-static int __devinit tdfxfb_probe(struct pci_dev *pdev,
+static int tdfxfb_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *id);
 static void __devexit tdfxfb_remove(struct pci_dev *pdev);
 
@@ -1279,7 +1279,7 @@ static int tdfxfb_ddc_getsda(void *data)
 	return (0 != (tdfx_inl(par, VIDSERPARPORT) & DDC_SDA_IN));
 }
 
-static int __devinit tdfxfb_setup_ddc_bus(struct tdfxfb_i2c_chan *chan,
+static int tdfxfb_setup_ddc_bus(struct tdfxfb_i2c_chan *chan,
 					  const char *name, struct device *dev)
 {
 	int rc;
@@ -1308,7 +1308,7 @@ static int __devinit tdfxfb_setup_ddc_bus(struct tdfxfb_i2c_chan *chan,
 	return rc;
 }
 
-static int __devinit tdfxfb_setup_i2c_bus(struct tdfxfb_i2c_chan *chan,
+static int tdfxfb_setup_i2c_bus(struct tdfxfb_i2c_chan *chan,
 					  const char *name, struct device *dev)
 {
 	int rc;
@@ -1336,7 +1336,7 @@ static int __devinit tdfxfb_setup_i2c_bus(struct tdfxfb_i2c_chan *chan,
 	return rc;
 }
 
-static void __devinit tdfxfb_create_i2c_busses(struct fb_info *info)
+static void tdfxfb_create_i2c_busses(struct fb_info *info)
 {
 	struct tdfx_par *par = info->par;
 
@@ -1388,7 +1388,7 @@ static int tdfxfb_probe_i2c_connector(struct tdfx_par *par,
  *      Initializes and allocates resources for PCI device @pdev.
  *
  */
-static int __devinit tdfxfb_probe(struct pci_dev *pdev,
+static int tdfxfb_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *id)
 {
 	struct tdfx_par *default_par;
diff --git a/drivers/video/tgafb.c b/drivers/video/tgafb.c
index 7333152..63fc5ba 100644
--- a/drivers/video/tgafb.c
+++ b/drivers/video/tgafb.c
@@ -61,7 +61,7 @@ static void tgafb_fillrect(struct fb_info *, const struct fb_fillrect *);
 static void tgafb_copyarea(struct fb_info *, const struct fb_copyarea *);
 static int tgafb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info);
 
-static int __devinit tgafb_register(struct device *dev);
+static int tgafb_register(struct device *dev);
 static void __devexit tgafb_unregister(struct device *dev);
 
 static const char *mode_option;
@@ -93,7 +93,7 @@ static struct fb_ops tgafb_ops = {
 /*
  *  PCI registration operations
  */
-static int __devinit tgafb_pci_register(struct pci_dev *,
+static int tgafb_pci_register(struct pci_dev *,
 					const struct pci_device_id *);
 static void __devexit tgafb_pci_unregister(struct pci_dev *);
 
@@ -110,7 +110,7 @@ static struct pci_driver tgafb_pci_driver = {
 	.remove			= tgafb_pci_unregister,
 };
 
-static int __devinit
+static int
 tgafb_pci_register(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	return tgafb_register(&pdev->dev);
@@ -127,7 +127,7 @@ tgafb_pci_unregister(struct pci_dev *pdev)
 /*
  *  TC registration operations
  */
-static int __devinit tgafb_tc_register(struct device *);
+static int tgafb_tc_register(struct device *);
 static int __devexit tgafb_tc_unregister(struct device *);
 
 static struct tc_device_id const tgafb_tc_table[] = {
@@ -147,7 +147,7 @@ static struct tc_driver tgafb_tc_driver = {
 	},
 };
 
-static int __devinit
+static int
 tgafb_tc_register(struct device *dev)
 {
 	int status = tgafb_register(dev);
@@ -1546,7 +1546,7 @@ static int tgafb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info
 	return 0;
 }
 
-static int __devinit
+static int
 tgafb_register(struct device *dev)
 {
 	static const struct fb_videomode modedb_tc = {
@@ -1729,7 +1729,7 @@ tgafb_exit(void)
 }
 
 #ifndef MODULE
-static int __devinit
+static int
 tgafb_setup(char *arg)
 {
 	char *this_opt;
@@ -1751,7 +1751,7 @@ tgafb_setup(char *arg)
 }
 #endif /* !MODULE */
 
-static int __devinit
+static int
 tgafb_init(void)
 {
 	int status;
diff --git a/drivers/video/tmiofb.c b/drivers/video/tmiofb.c
index 7c8133e..3f7527a 100644
--- a/drivers/video/tmiofb.c
+++ b/drivers/video/tmiofb.c
@@ -675,7 +675,7 @@ static struct fb_ops tmiofb_ops = {
 
 /*--------------------------------------------------------------------------*/
 
-static int __devinit tmiofb_probe(struct platform_device *dev)
+static int tmiofb_probe(struct platform_device *dev)
 {
 	const struct mfd_cell *cell = mfd_get_cell(dev);
 	struct tmio_fb_data *data = dev->dev.platform_data;
diff --git a/drivers/video/tridentfb.c b/drivers/video/tridentfb.c
index a3f207b..f1a8495 100644
--- a/drivers/video/tridentfb.c
+++ b/drivers/video/tridentfb.c
@@ -637,7 +637,7 @@ static inline void crtc_unlock(struct tridentfb_par *par)
 }
 
 /*  Return flat panel's maximum x resolution */
-static int __devinit get_nativex(struct tridentfb_par *par)
+static int get_nativex(struct tridentfb_par *par)
 {
 	int x, y, tmp;
 
@@ -771,7 +771,7 @@ static void set_number_of_lines(struct tridentfb_par *par, int lines)
  * If we see that FP is active we assume we have one.
  * Otherwise we have a CRT display. User can override.
  */
-static int __devinit is_flatpanel(struct tridentfb_par *par)
+static int is_flatpanel(struct tridentfb_par *par)
 {
 	if (fp)
 		return 1;
@@ -781,7 +781,7 @@ static int __devinit is_flatpanel(struct tridentfb_par *par)
 }
 
 /* Try detecting the video memory size */
-static unsigned int __devinit get_memsize(struct tridentfb_par *par)
+static unsigned int get_memsize(struct tridentfb_par *par)
 {
 	unsigned char tmp, tmp2;
 	unsigned int k;
@@ -1331,7 +1331,7 @@ static struct fb_ops tridentfb_ops = {
 	.fb_sync = tridentfb_sync,
 };
 
-static int __devinit trident_pci_probe(struct pci_dev *dev,
+static int trident_pci_probe(struct pci_dev *dev,
 				       const struct pci_device_id *id)
 {
 	int err;
diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index 2f8f82d..a776c8e 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -418,7 +418,7 @@ static void uvesafb_vbe_state_restore(struct uvesafb_par *par, u8 *state_buf)
 	uvesafb_free(task);
 }
 
-static int __devinit uvesafb_vbe_getinfo(struct uvesafb_ktask *task,
+static int uvesafb_vbe_getinfo(struct uvesafb_ktask *task,
 		struct uvesafb_par *par)
 {
 	int err;
@@ -477,7 +477,7 @@ static int __devinit uvesafb_vbe_getinfo(struct uvesafb_ktask *task,
 	return 0;
 }
 
-static int __devinit uvesafb_vbe_getmodes(struct uvesafb_ktask *task,
+static int uvesafb_vbe_getmodes(struct uvesafb_ktask *task,
 		struct uvesafb_par *par)
 {
 	int off = 0, err;
@@ -556,7 +556,7 @@ static int __devinit uvesafb_vbe_getmodes(struct uvesafb_ktask *task,
  * x86 and not x86_64.
  */
 #ifdef CONFIG_X86_32
-static int __devinit uvesafb_vbe_getpmi(struct uvesafb_ktask *task,
+static int uvesafb_vbe_getpmi(struct uvesafb_ktask *task,
 		struct uvesafb_par *par)
 {
 	int i, err;
@@ -602,7 +602,7 @@ static int __devinit uvesafb_vbe_getpmi(struct uvesafb_ktask *task,
  * Check whether a video mode is supported by the Video BIOS and is
  * compatible with the monitor limits.
  */
-static int __devinit uvesafb_is_valid_mode(struct fb_videomode *mode,
+static int uvesafb_is_valid_mode(struct fb_videomode *mode,
 		struct fb_info *info)
 {
 	if (info->monspecs.gtf) {
@@ -618,7 +618,7 @@ static int __devinit uvesafb_is_valid_mode(struct fb_videomode *mode,
 	return 1;
 }
 
-static int __devinit uvesafb_vbe_getedid(struct uvesafb_ktask *task,
+static int uvesafb_vbe_getedid(struct uvesafb_ktask *task,
 		struct fb_info *info)
 {
 	struct uvesafb_par *par = info->par;
@@ -684,7 +684,7 @@ static int __devinit uvesafb_vbe_getedid(struct uvesafb_ktask *task,
 	return err;
 }
 
-static void __devinit uvesafb_vbe_getmonspecs(struct uvesafb_ktask *task,
+static void uvesafb_vbe_getmonspecs(struct uvesafb_ktask *task,
 		struct fb_info *info)
 {
 	struct uvesafb_par *par = info->par;
@@ -765,7 +765,7 @@ static void __devinit uvesafb_vbe_getmonspecs(struct uvesafb_ktask *task,
 	return;
 }
 
-static void __devinit uvesafb_vbe_getstatesize(struct uvesafb_ktask *task,
+static void uvesafb_vbe_getstatesize(struct uvesafb_ktask *task,
 		struct uvesafb_par *par)
 {
 	int err;
@@ -794,7 +794,7 @@ static void __devinit uvesafb_vbe_getstatesize(struct uvesafb_ktask *task,
 	par->vbe_state_size = 64 * (task->t.regs.ebx & 0xffff);
 }
 
-static int __devinit uvesafb_vbe_init(struct fb_info *info)
+static int uvesafb_vbe_init(struct fb_info *info)
 {
 	struct uvesafb_ktask *task = NULL;
 	struct uvesafb_par *par = info->par;
@@ -839,7 +839,7 @@ out:	uvesafb_free(task);
 	return err;
 }
 
-static int __devinit uvesafb_vbe_init_mode(struct fb_info *info)
+static int uvesafb_vbe_init_mode(struct fb_info *info)
 {
 	struct list_head *pos;
 	struct fb_modelist *modelist;
@@ -1444,7 +1444,7 @@ static struct fb_ops uvesafb_ops = {
 	.fb_set_par	= uvesafb_set_par,
 };
 
-static void __devinit uvesafb_init_info(struct fb_info *info,
+static void uvesafb_init_info(struct fb_info *info,
 		struct vbe_mode_ib *mode)
 {
 	unsigned int size_vmode;
@@ -1540,7 +1540,7 @@ static void __devinit uvesafb_init_info(struct fb_info *info,
 		info->fbops->fb_pan_display = NULL;
 }
 
-static void __devinit uvesafb_init_mtrr(struct fb_info *info)
+static void uvesafb_init_mtrr(struct fb_info *info)
 {
 #ifdef CONFIG_MTRR
 	if (mtrr && !(info->fix.smem_start & (PAGE_SIZE - 1))) {
@@ -1582,7 +1582,7 @@ static void __devinit uvesafb_init_mtrr(struct fb_info *info)
 #endif /* CONFIG_MTRR */
 }
 
-static void __devinit uvesafb_ioremap(struct fb_info *info)
+static void uvesafb_ioremap(struct fb_info *info)
 {
 #ifdef CONFIG_X86
 	switch (mtrr) {
@@ -1738,7 +1738,7 @@ static struct attribute_group uvesafb_dev_attgrp = {
 	.attrs = uvesafb_dev_attrs,
 };
 
-static int __devinit uvesafb_probe(struct platform_device *dev)
+static int uvesafb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
 	struct vbe_mode_ib *mode = NULL;
@@ -1882,7 +1882,7 @@ static struct platform_driver uvesafb_driver = {
 static struct platform_device *uvesafb_device;
 
 #ifndef MODULE
-static int __devinit uvesafb_setup(char *options)
+static int uvesafb_setup(char *options)
 {
 	char *this_opt;
 
@@ -1950,7 +1950,7 @@ static ssize_t store_v86d(struct device_driver *dev, const char *buf,
 
 static DRIVER_ATTR(v86d, S_IRUGO | S_IWUSR, show_v86d, store_v86d);
 
-static int __devinit uvesafb_init(void)
+static int uvesafb_init(void)
 {
 	int err;
 
diff --git a/drivers/video/vermilion/vermilion.c b/drivers/video/vermilion/vermilion.c
index a2bacf8..3e92d0e 100644
--- a/drivers/video/vermilion/vermilion.c
+++ b/drivers/video/vermilion/vermilion.c
@@ -452,7 +452,7 @@ static void vmlfb_set_pref_pixel_format(struct fb_var_screeninfo *var)
  * struct per pipe. Currently we have only one pipe.
  */
 
-static int __devinit vml_pci_probe(struct pci_dev *dev,
+static int vml_pci_probe(struct pci_dev *dev,
 				   const struct pci_device_id *id)
 {
 	struct vml_info *vinfo;
diff --git a/drivers/video/vfb.c b/drivers/video/vfb.c
index c7f69252..f4cb015 100644
--- a/drivers/video/vfb.c
+++ b/drivers/video/vfb.c
@@ -477,7 +477,7 @@ static int __init vfb_setup(char *options)
      *  Initialisation
      */
 
-static int __devinit vfb_probe(struct platform_device *dev)
+static int vfb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
 	int retval = -ENOMEM;
diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
index 1ab146a..0e53f39 100644
--- a/drivers/video/vga16fb.c
+++ b/drivers/video/vga16fb.c
@@ -1303,7 +1303,7 @@ static int __init vga16fb_setup(char *options)
 }
 #endif
 
-static int __devinit vga16fb_probe(struct platform_device *dev)
+static int vga16fb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
 	struct vga16fb_par *par;
diff --git a/drivers/video/via/dvi.c b/drivers/video/via/dvi.c
index 6be72f0..1c9b68c 100644
--- a/drivers/video/via/dvi.c
+++ b/drivers/video/via/dvi.c
@@ -25,7 +25,7 @@
 static void tmds_register_write(int index, u8 data);
 static int tmds_register_read(int index);
 static int tmds_register_read_bytes(int index, u8 *buff, int buff_len);
-static void __devinit dvi_get_panel_size_from_DDCv1(
+static void dvi_get_panel_size_from_DDCv1(
 	struct tmds_chip_information *tmds_chip,
 	struct tmds_setting_information *tmds_setting);
 static int viafb_dvi_query_EDID(void);
@@ -35,7 +35,7 @@ static inline bool check_tmds_chip(int device_id_subaddr, int device_id)
 	return tmds_register_read(device_id_subaddr) == device_id;
 }
 
-void __devinit viafb_init_dvi_size(struct tmds_chip_information *tmds_chip,
+void viafb_init_dvi_size(struct tmds_chip_information *tmds_chip,
 	struct tmds_setting_information *tmds_setting)
 {
 	DEBUG_MSG(KERN_INFO "viafb_init_dvi_size()\n");
@@ -47,7 +47,7 @@ void __devinit viafb_init_dvi_size(struct tmds_chip_information *tmds_chip,
 	return;
 }
 
-bool __devinit viafb_tmds_trasmitter_identify(void)
+bool viafb_tmds_trasmitter_identify(void)
 {
 	unsigned char sr2a = 0, sr1e = 0, sr3e = 0;
 
@@ -285,7 +285,7 @@ static int viafb_dvi_query_EDID(void)
 }
 
 /* Get Panel Size Using EDID1 Table */
-static void __devinit dvi_get_panel_size_from_DDCv1(
+static void dvi_get_panel_size_from_DDCv1(
 	struct tmds_chip_information *tmds_chip,
 	struct tmds_setting_information *tmds_setting)
 {
diff --git a/drivers/video/via/dvi.h b/drivers/video/via/dvi.h
index db75785..4c6bfba 100644
--- a/drivers/video/via/dvi.h
+++ b/drivers/video/via/dvi.h
@@ -56,8 +56,8 @@
 int viafb_dvi_sense(void);
 void viafb_dvi_disable(void);
 void viafb_dvi_enable(void);
-bool __devinit viafb_tmds_trasmitter_identify(void);
-void __devinit viafb_init_dvi_size(struct tmds_chip_information *tmds_chip,
+bool viafb_tmds_trasmitter_identify(void);
+void viafb_init_dvi_size(struct tmds_chip_information *tmds_chip,
 	struct tmds_setting_information *tmds_setting);
 void viafb_dvi_set_mode(const struct fb_var_screeninfo *var,
 	u16 cxres, u16 cyres, int iga);
diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
index 898590d..80233da 100644
--- a/drivers/video/via/hw.c
+++ b/drivers/video/via/hw.c
@@ -465,9 +465,9 @@ static struct via_device_mapping device_mapping[] = {
 static struct via_clock clock;
 
 static void load_fix_bit_crtc_reg(void);
-static void __devinit init_gfx_chip_info(int chip_type);
-static void __devinit init_tmds_chip_info(void);
-static void __devinit init_lvds_chip_info(void);
+static void init_gfx_chip_info(int chip_type);
+static void init_tmds_chip_info(void);
+static void init_lvds_chip_info(void);
 static void device_screen_off(void);
 static void device_screen_on(void);
 static void set_display_channel(void);
@@ -1507,7 +1507,7 @@ void viafb_fill_crtc_timing(const struct fb_var_screeninfo *var,
 	viafb_set_vclock(PICOS2KHZ(var->pixclock) * 1000, iga);
 }
 
-void __devinit viafb_init_chip_info(int chip_type)
+void viafb_init_chip_info(int chip_type)
 {
 	via_clock_init(&clock, chip_type);
 	init_gfx_chip_info(chip_type);
@@ -1540,7 +1540,7 @@ void viafb_update_device_setting(int hres, int vres, int bpp, int flag)
 	}
 }
 
-static void __devinit init_gfx_chip_info(int chip_type)
+static void init_gfx_chip_info(int chip_type)
 {
 	u8 tmp;
 
@@ -1593,7 +1593,7 @@ static void __devinit init_gfx_chip_info(int chip_type)
 	}
 }
 
-static void __devinit init_tmds_chip_info(void)
+static void init_tmds_chip_info(void)
 {
 	viafb_tmds_trasmitter_identify();
 
@@ -1638,7 +1638,7 @@ static void __devinit init_tmds_chip_info(void)
 		&viaparinfo->shared->tmds_setting_info);
 }
 
-static void __devinit init_lvds_chip_info(void)
+static void init_lvds_chip_info(void)
 {
 	viafb_lvds_trasmitter_identify();
 	viafb_init_lcd_size();
@@ -1672,7 +1672,7 @@ static void __devinit init_lvds_chip_info(void)
 		  viaparinfo->chip_info->lvds_chip_info.output_interface);
 }
 
-void __devinit viafb_init_dac(int set_iga)
+void viafb_init_dac(int set_iga)
 {
 	int i;
 	u8 tmp;
diff --git a/drivers/video/via/hw.h b/drivers/video/via/hw.h
index 6be243c..a820575 100644
--- a/drivers/video/via/hw.h
+++ b/drivers/video/via/hw.h
@@ -663,8 +663,8 @@ void viafb_set_dpa_gfx(int output_interface, struct GFX_DPA_SETTING\
 int viafb_setmode(void);
 void viafb_fill_var_timing_info(struct fb_var_screeninfo *var,
 	const struct fb_videomode *mode);
-void __devinit viafb_init_chip_info(int chip_type);
-void __devinit viafb_init_dac(int set_iga);
+void viafb_init_chip_info(int chip_type);
+void viafb_init_dac(int set_iga);
 int viafb_get_refresh(int hres, int vres, u32 float_refresh);
 void viafb_update_device_setting(int hres, int vres, int bpp, int flag);
 
diff --git a/drivers/video/via/lcd.c b/drivers/video/via/lcd.c
index 1650379..980ee1b 100644
--- a/drivers/video/via/lcd.c
+++ b/drivers/video/via/lcd.c
@@ -49,7 +49,7 @@ static struct _lcd_scaling_factor lcd_scaling_factor_CLE = {
 };
 
 static bool lvds_identify_integratedlvds(void);
-static void __devinit fp_id_to_vindex(int panel_id);
+static void fp_id_to_vindex(int panel_id);
 static int lvds_register_read(int index);
 static void load_lcd_scaling(int set_hres, int set_vres, int panel_hres,
 		      int panel_vres);
@@ -81,7 +81,7 @@ static inline bool check_lvds_chip(int device_id_subaddr, int device_id)
 	return lvds_register_read(device_id_subaddr) == device_id;
 }
 
-void __devinit viafb_init_lcd_size(void)
+void viafb_init_lcd_size(void)
 {
 	DEBUG_MSG(KERN_INFO "viafb_init_lcd_size()\n");
 
@@ -139,7 +139,7 @@ static bool lvds_identify_integratedlvds(void)
 	return true;
 }
 
-bool __devinit viafb_lvds_trasmitter_identify(void)
+bool viafb_lvds_trasmitter_identify(void)
 {
 	if (viafb_lvds_identify_vt1636(VIA_PORT_31)) {
 		viaparinfo->chip_info->lvds_chip_info.i2c_port = VIA_PORT_31;
@@ -180,7 +180,7 @@ bool __devinit viafb_lvds_trasmitter_identify(void)
 	return false;
 }
 
-static void __devinit fp_id_to_vindex(int panel_id)
+static void fp_id_to_vindex(int panel_id)
 {
 	DEBUG_MSG(KERN_INFO "fp_get_panel_id()\n");
 
@@ -914,7 +914,7 @@ static void check_diport_of_integrated_lvds(
 		  plvds_chip_info->output_interface);
 }
 
-void __devinit viafb_init_lvds_output_interface(struct lvds_chip_information
+void viafb_init_lvds_output_interface(struct lvds_chip_information
 				*plvds_chip_info,
 				struct lvds_setting_information
 				*plvds_setting_info)
diff --git a/drivers/video/via/lcd.h b/drivers/video/via/lcd.h
index 8f3e4e0..5c988a0 100644
--- a/drivers/video/via/lcd.h
+++ b/drivers/video/via/lcd.h
@@ -71,15 +71,15 @@ void viafb_enable_lvds_vt1636(struct lvds_setting_information
 			struct lvds_chip_information *plvds_chip_info);
 void viafb_lcd_disable(void);
 void viafb_lcd_enable(void);
-void __devinit viafb_init_lcd_size(void);
-void __devinit viafb_init_lvds_output_interface(struct lvds_chip_information
+void viafb_init_lcd_size(void);
+void viafb_init_lvds_output_interface(struct lvds_chip_information
 				*plvds_chip_info,
 				struct lvds_setting_information
 				*plvds_setting_info);
 void viafb_lcd_set_mode(const struct fb_var_screeninfo *var, u16 cxres,
 	u16 cyres, struct lvds_setting_information *plvds_setting_info,
 	struct lvds_chip_information *plvds_chip_info);
-bool __devinit viafb_lvds_trasmitter_identify(void);
+bool viafb_lvds_trasmitter_identify(void);
 void viafb_init_lvds_output_interface(struct lvds_chip_information
 				*plvds_chip_info,
 				struct lvds_setting_information
diff --git a/drivers/video/via/via-core.c b/drivers/video/via/via-core.c
index 29b3af8..abbcb1b 100644
--- a/drivers/video/via/via-core.c
+++ b/drivers/video/via/via-core.c
@@ -80,7 +80,7 @@ static inline int viafb_mmio_read(int reg)
  */
 static u32 viafb_enabled_ints;
 
-static void __devinit viafb_int_init(void)
+static void viafb_int_init(void)
 {
 	viafb_enabled_ints = 0;
 
@@ -475,7 +475,7 @@ static int viafb_get_fb_size_from_pci(int chip_type)
 /*
  * Figure out and map our MMIO regions.
  */
-static int __devinit via_pci_setup_mmio(struct viafb_dev *vdev)
+static int via_pci_setup_mmio(struct viafb_dev *vdev)
 {
 	int ret;
 	/*
@@ -550,7 +550,7 @@ static struct viafb_subdev_info {
 };
 #define N_SUBDEVS ARRAY_SIZE(viafb_subdevs)
 
-static int __devinit via_create_subdev(struct viafb_dev *vdev,
+static int via_create_subdev(struct viafb_dev *vdev,
 		struct viafb_subdev_info *info)
 {
 	int ret;
@@ -573,7 +573,7 @@ static int __devinit via_create_subdev(struct viafb_dev *vdev,
 	return ret;
 }
 
-static int __devinit via_setup_subdevs(struct viafb_dev *vdev)
+static int via_setup_subdevs(struct viafb_dev *vdev)
 {
 	int i;
 
@@ -671,7 +671,7 @@ static int via_resume(struct pci_dev *pdev)
 }
 #endif /* CONFIG_PM */
 
-static int __devinit via_pci_probe(struct pci_dev *pdev,
+static int via_pci_probe(struct pci_dev *pdev,
 		const struct pci_device_id *ent)
 {
 	int ret;
diff --git a/drivers/video/via/via-gpio.c b/drivers/video/via/via-gpio.c
index d69cfef..e408679 100644
--- a/drivers/video/via/via-gpio.c
+++ b/drivers/video/via/via-gpio.c
@@ -212,7 +212,7 @@ EXPORT_SYMBOL_GPL(viafb_gpio_lookup);
 /*
  * Platform device stuff.
  */
-static __devinit int viafb_gpio_probe(struct platform_device *platdev)
+static int viafb_gpio_probe(struct platform_device *platdev)
 {
 	struct viafb_dev *vdev = platdev->dev.platform_data;
 	struct via_port_cfg *port_cfg = vdev->port_cfg;
diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index c80e770..bb41017 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -1072,7 +1072,7 @@ static int __init parse_active_dev(void)
 	return 0;
 }
 
-static int __devinit parse_port(char *opt_str, int *output_interface)
+static int parse_port(char *opt_str, int *output_interface)
 {
 	if (!strncmp(opt_str, "DVP0", 4))
 		*output_interface = INTERFACE_DVP0;
@@ -1089,7 +1089,7 @@ static int __devinit parse_port(char *opt_str, int *output_interface)
 	return 0;
 }
 
-static void __devinit parse_lcd_port(void)
+static void parse_lcd_port(void)
 {
 	parse_port(viafb_lcd_port, &viaparinfo->chip_info->lvds_chip_info.
 		output_interface);
@@ -1102,7 +1102,7 @@ static void __devinit parse_lcd_port(void)
 		  output_interface);
 }
 
-static void __devinit parse_dvi_port(void)
+static void parse_dvi_port(void)
 {
 	parse_port(viafb_dvi_port, &viaparinfo->chip_info->tmds_chip_info.
 		output_interface);
@@ -1727,7 +1727,7 @@ static struct viafb_pm_hooks viafb_fb_pm_hooks = {
 
 #endif
 
-static void __devinit i2c_bus_probe(struct viafb_shared *shared)
+static void i2c_bus_probe(struct viafb_shared *shared)
 {
 	/* should be always CRT */
 	printk(KERN_INFO "viafb: Probing I2C bus 0x26\n");
@@ -1753,7 +1753,7 @@ static void i2c_bus_free(struct viafb_shared *shared)
 	via_aux_free(shared->i2c_2C);
 }
 
-int __devinit via_fb_pci_probe(struct viafb_dev *vdev)
+int via_fb_pci_probe(struct viafb_dev *vdev)
 {
 	u32 default_xres, default_yres;
 	struct fb_var_screeninfo default_var;
diff --git a/drivers/video/vt8500lcdfb.c b/drivers/video/vt8500lcdfb.c
index 22063bb..1b94610 100644
--- a/drivers/video/vt8500lcdfb.c
+++ b/drivers/video/vt8500lcdfb.c
@@ -273,7 +273,7 @@ static irqreturn_t vt8500lcd_handle_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit vt8500lcd_probe(struct platform_device *pdev)
+static int vt8500lcd_probe(struct platform_device *pdev)
 {
 	struct vt8500lcd_info *fbi;
 	struct resource *res;
diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index f0bce7a..c23c8c7 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -660,7 +660,7 @@ static struct fb_ops vt8623fb_ops = {
 
 /* PCI probe */
 
-static int __devinit vt8623_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int vt8623_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct pci_bus_region bus_reg;
 	struct resource vga_res;
diff --git a/drivers/video/w100fb.c b/drivers/video/w100fb.c
index 614e1bd..1c2eaf2 100644
--- a/drivers/video/w100fb.c
+++ b/drivers/video/w100fb.c
@@ -54,7 +54,7 @@ static void w100_update_enable(void);
 static void w100_update_disable(void);
 static void calc_hsync(struct w100fb_par *par);
 static void w100_init_graphic_engine(struct w100fb_par *par);
-struct w100_pll_info *w100_get_xtal_table(unsigned int freq) __devinit;
+struct w100_pll_info *w100_get_xtal_table(unsigned int freq);
 
 /* Pseudo palette size */
 #define MAX_PALETTES      16
@@ -630,7 +630,7 @@ static int w100fb_resume(struct platform_device *dev)
 #endif
 
 
-int __devinit w100fb_probe(struct platform_device *pdev)
+int w100fb_probe(struct platform_device *pdev)
 {
 	int err = -EIO;
 	struct w100fb_mach_info *inf;
@@ -1021,7 +1021,7 @@ static struct pll_entries {
 	{ 0 },
 };
 
-struct w100_pll_info __devinit *w100_get_xtal_table(unsigned int freq)
+struct w100_pll_info *w100_get_xtal_table(unsigned int freq)
 {
 	struct pll_entries *pll_entry = w100_pll_tables;
 
diff --git a/drivers/video/wm8505fb.c b/drivers/video/wm8505fb.c
index 5c126af..456694a 100644
--- a/drivers/video/wm8505fb.c
+++ b/drivers/video/wm8505fb.c
@@ -260,7 +260,7 @@ static struct fb_ops wm8505fb_ops = {
 	.fb_blank	= wm8505fb_blank,
 };
 
-static int __devinit wm8505fb_probe(struct platform_device *pdev)
+static int wm8505fb_probe(struct platform_device *pdev)
 {
 	struct wm8505fb_info	*fbi;
 	struct resource		*res;
diff --git a/drivers/video/wmt_ge_rops.c b/drivers/video/wmt_ge_rops.c
index 46b7a09..e65361d 100644
--- a/drivers/video/wmt_ge_rops.c
+++ b/drivers/video/wmt_ge_rops.c
@@ -124,7 +124,7 @@ int wmt_ge_sync(struct fb_info *p)
 }
 EXPORT_SYMBOL_GPL(wmt_ge_sync);
 
-static int __devinit wmt_ge_rops_probe(struct platform_device *pdev)
+static int wmt_ge_rops_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 
diff --git a/drivers/video/xen-fbfront.c b/drivers/video/xen-fbfront.c
index 917bb56..ee44be8 100644
--- a/drivers/video/xen-fbfront.c
+++ b/drivers/video/xen-fbfront.c
@@ -358,7 +358,7 @@ static irqreturn_t xenfb_event_handler(int rq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit xenfb_probe(struct xenbus_device *dev,
+static int xenfb_probe(struct xenbus_device *dev,
 				 const struct xenbus_device_id *id)
 {
 	struct xenfb_info *info;
@@ -487,7 +487,7 @@ error:
 	return ret;
 }
 
-static __devinit void
+static void
 xenfb_make_preferred_console(void)
 {
 	struct console *c;
diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index 20a7c0e..b5d317c 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -403,7 +403,7 @@ static int xilinxfb_release(struct device *dev)
  * OF bus binding
  */
 
-static int __devinit xilinxfb_of_probe(struct platform_device *op)
+static int xilinxfb_of_probe(struct platform_device *op)
 {
 	const u32 *prop;
 	u32 *p;
-- 
1.8.0
