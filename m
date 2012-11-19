Return-Path: <wfp5p@viridian.itc.virginia.edu>
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 298/493] video: remove use of __devinitdata
Date: Mon, 19 Nov 2012 13:24:07 -0500
Message-Id: <1353349642-3677-298-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: cbe-oss-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, Maik Broemme <mbroemme@plusserver.de>,
 Antonino Daplas <adaplas@gmail.com>,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
 Geoff Levand <geoff@infradead.org>,
 Thomas Winischhofer <thomas@winischhofer.net>, linux-geode@lists.infradead.org,
 Kristoffer Ericson <kristoffer.ericson@gmail.com>,
 Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
 Michal Januszewski <spock@gentoo.org>, Peter Jones <pjones@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-nvidia@lists.surfsouth.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Jaya Kumar <jayalk@intworks.biz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_HOTPLUG is going away as an option so __devinitdata is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de> 
Cc: Jaya Kumar <jayalk@intworks.biz> 
Cc: Paul Mackerras <paulus@samba.org> 
Cc: Russell King <linux@arm.linux.org.uk> 
Cc: Peter Jones <pjones@redhat.com> 
Cc: Ferenc Bakonyi <fero@drama.obuda.kando.hu> 
Cc: Antonino Daplas <adaplas@gmail.com> 
Cc: Maik Broemme <mbroemme@plusserver.de> 
Cc: Geoff Levand <geoff@infradead.org> 
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com> 
Cc: Thomas Winischhofer <thomas@winischhofer.net> 
Cc: Michal Januszewski <spock@gentoo.org> 
Cc: linux-fbdev@vger.kernel.org 
Cc: linux-arm-kernel@lists.infradead.org 
Cc: linux-geode@lists.infradead.org 
Cc: linux-nvidia@lists.surfsouth.com 
Cc: linuxppc-dev@lists.ozlabs.org 
Cc: cbe-oss-dev@lists.ozlabs.org 
---
 drivers/video/acornfb.c                |  8 +++---
 drivers/video/arcfb.c                  |  4 +--
 drivers/video/arkfb.c                  |  4 +--
 drivers/video/asiliantfb.c             |  6 ++---
 drivers/video/aty/aty128fb.c           | 20 +++++++--------
 drivers/video/aty/atyfb_base.c         | 46 +++++++++++++++++-----------------
 drivers/video/au1100fb.c               |  4 +--
 drivers/video/bf537-lq035.c            |  2 +-
 drivers/video/bfin_adv7393fb.c         |  2 +-
 drivers/video/broadsheetfb.c           |  4 +--
 drivers/video/bw2.c                    | 10 ++++----
 drivers/video/carminefb.c              |  4 +--
 drivers/video/cg14.c                   |  2 +-
 drivers/video/cg3.c                    | 10 ++++----
 drivers/video/chipsfb.c                |  4 +--
 drivers/video/cirrusfb.c               |  4 +--
 drivers/video/cobalt_lcdfb.c           |  2 +-
 drivers/video/console/sticore.c        |  4 +--
 drivers/video/cyber2000fb.c            |  2 +-
 drivers/video/da8xx-fb.c               |  4 +--
 drivers/video/dnfb.c                   |  4 +--
 drivers/video/efifb.c                  |  4 +--
 drivers/video/fm2fb.c                  |  8 +++---
 drivers/video/fsl-diu-fb.c             |  2 +-
 drivers/video/gbefb.c                  | 14 +++++------
 drivers/video/geode/gxfb_core.c        |  4 +--
 drivers/video/geode/lxfb_core.c        |  4 +--
 drivers/video/grvga.c                  |  2 +-
 drivers/video/hecubafb.c               |  4 +--
 drivers/video/hgafb.c                  |  4 +--
 drivers/video/hitfb.c                  |  4 +--
 drivers/video/i740fb.c                 |  6 ++---
 drivers/video/i810/i810_main.c         | 36 +++++++++++++-------------
 drivers/video/igafb.c                  |  2 +-
 drivers/video/imsttfb.c                |  6 ++---
 drivers/video/intelfb/intelfbdrv.c     |  2 +-
 drivers/video/kyro/fbdev.c             | 14 +++++------
 drivers/video/mb862xx/mb862xxfbdrv.c   |  4 +--
 drivers/video/mbx/mbxfb.c              |  4 +--
 drivers/video/metronomefb.c            |  4 +--
 drivers/video/neofb.c                  |  4 +--
 drivers/video/nvidia/nvidia.c          | 32 +++++++++++------------
 drivers/video/pm2fb.c                  | 10 ++++----
 drivers/video/pm3fb.c                  |  8 +++---
 drivers/video/pmag-ba-fb.c             |  4 +--
 drivers/video/pmagb-b-fb.c             |  6 ++---
 drivers/video/ps3fb.c                  |  2 +-
 drivers/video/pvr2fb.c                 | 14 +++++------
 drivers/video/pxafb.c                  |  2 +-
 drivers/video/q40fb.c                  |  4 +--
 drivers/video/riva/fbdev.c             | 18 ++++++-------
 drivers/video/s1d13xxxfb.c             |  4 +--
 drivers/video/s3fb.c                   |  6 ++---
 drivers/video/sa1100fb.c               |  2 +-
 drivers/video/savage/savagefb_driver.c |  6 ++---
 drivers/video/sgivwfb.c                |  6 ++---
 drivers/video/sis/sis_main.h           | 20 +++++++--------
 drivers/video/skeletonfb.c             |  7 +++---
 drivers/video/sm501fb.c                |  2 +-
 drivers/video/sstfb.c                  |  6 ++---
 drivers/video/tdfxfb.c                 |  8 +++---
 drivers/video/tmiofb.c                 |  2 +-
 drivers/video/tridentfb.c              | 14 +++++------
 drivers/video/uvesafb.c                | 24 +++++++++---------
 drivers/video/vfb.c                    |  4 +--
 drivers/video/vga16fb.c                |  4 +--
 drivers/video/via/via-core.c           |  2 +-
 drivers/video/vt8623fb.c               |  2 +-
 drivers/video/xilinxfb.c               |  2 +-
 69 files changed, 251 insertions(+), 252 deletions(-)

diff --git a/drivers/video/acornfb.c b/drivers/video/acornfb.c
index 772f1ce..6488a73 100644
--- a/drivers/video/acornfb.c
+++ b/drivers/video/acornfb.c
@@ -66,7 +66,7 @@
  * have.  Allow 1% either way on the nominal for TVs.
  */
 #define NR_MONTYPES	6
-static struct fb_monspecs monspecs[NR_MONTYPES] __devinitdata = {
+static struct fb_monspecs monspecs[NR_MONTYPES] = {
 	{	/* TV		*/
 		.hfmin	= 15469,
 		.hfmax	= 15781,
@@ -874,7 +874,7 @@ static struct fb_ops acornfb_ops = {
 /*
  * Everything after here is initialisation!!!
  */
-static struct fb_videomode modedb[] __devinitdata = {
+static struct fb_videomode modedb[] = {
 	{	/* 320x256 @ 50Hz */
 		NULL, 50,  320,  256, 125000,  92,  62,  35, 19,  38, 2,
 		FB_SYNC_COMP_HIGH_ACT,
@@ -926,7 +926,7 @@ static struct fb_videomode modedb[] __devinitdata = {
 	}
 };
 
-static struct fb_videomode acornfb_default_mode __devinitdata = {
+static struct fb_videomode acornfb_default_mode = {
 	.name =		NULL,
 	.refresh =	60,
 	.xres =		640,
@@ -1131,7 +1131,7 @@ static void acornfb_parse_dram(char *opt)
 static struct options {
 	char *name;
 	void (*parse)(char *opt);
-} opt_table[] __devinitdata = {
+} opt_table[] = {
 	{ "mon",     acornfb_parse_mon     },
 	{ "montype", acornfb_parse_montype },
 	{ "dram",    acornfb_parse_dram    },
diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
index 964431a..3ef36a9 100644
--- a/drivers/video/arcfb.c
+++ b/drivers/video/arcfb.c
@@ -79,7 +79,7 @@ struct arcfb_par {
 	spinlock_t lock;
 };
 
-static struct fb_fix_screeninfo arcfb_fix __devinitdata = {
+static struct fb_fix_screeninfo arcfb_fix = {
 	.id =		"arcfb",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_MONO01,
@@ -89,7 +89,7 @@ static struct fb_fix_screeninfo arcfb_fix __devinitdata = {
 	.accel =	FB_ACCEL_NONE,
 };
 
-static struct fb_var_screeninfo arcfb_var __devinitdata = {
+static struct fb_var_screeninfo arcfb_var = {
 	.xres		= 128,
 	.yres		= 64,
 	.xres_virtual	= 128,
diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index 750efbc..459b31e 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -100,7 +100,7 @@ static const struct svga_timing_regs ark_timing_regs     = {
 
 /* Module parameters */
 
-static char *mode_option __devinitdata = "640x480-8@60";
+static char *mode_option = "640x480-8@60";
 
 #ifdef CONFIG_MTRR
 static int mtrr = 1;
@@ -1184,7 +1184,7 @@ fail:
 
 /* List of boards that we are trying to support */
 
-static struct pci_device_id ark_devices[] __devinitdata = {
+static struct pci_device_id ark_devices[] = {
 	{PCI_DEVICE(0xEDD8, 0xA099)},
 	{0, 0, 0, 0, 0, 0, 0}
 };
diff --git a/drivers/video/asiliantfb.c b/drivers/video/asiliantfb.c
index 21744e9..d291750 100644
--- a/drivers/video/asiliantfb.c
+++ b/drivers/video/asiliantfb.c
@@ -474,7 +474,7 @@ static void chips_hw_init(struct fb_info *p)
 		write_fr(chips_init_fr[i].addr, chips_init_fr[i].data);
 }
 
-static struct fb_fix_screeninfo asiliantfb_fix __devinitdata = {
+static struct fb_fix_screeninfo asiliantfb_fix = {
 	.id =		"Asiliant 69000",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_PSEUDOCOLOR,
@@ -483,7 +483,7 @@ static struct fb_fix_screeninfo asiliantfb_fix __devinitdata = {
 	.smem_len =	0x200000,	/* 2MB */
 };
 
-static struct fb_var_screeninfo asiliantfb_var __devinitdata = {
+static struct fb_var_screeninfo asiliantfb_var = {
 	.xres 		= 640,
 	.yres 		= 480,
 	.xres_virtual 	= 640,
@@ -593,7 +593,7 @@ static void __devexit asiliantfb_remove(struct pci_dev *dp)
 	framebuffer_release(p);
 }
 
-static struct pci_device_id asiliantfb_pci_tbl[] __devinitdata = {
+static struct pci_device_id asiliantfb_pci_tbl[] = {
 	{ PCI_VENDOR_ID_CT, PCI_DEVICE_ID_CT_69000, PCI_ANY_ID, PCI_ANY_ID },
 	{ 0 }
 };
diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
index d9f88cc..4d02267 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -98,7 +98,7 @@
 
 #ifndef CONFIG_PPC_PMAC
 /* default mode */
-static struct fb_var_screeninfo default_var __devinitdata = {
+static struct fb_var_screeninfo default_var = {
 	/* 640x480, 60 Hz, Non-Interlaced (25.175 MHz dotclock) */
 	640, 480, 640, 480, 0, 0, 8, 0,
 	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
@@ -121,7 +121,7 @@ static struct fb_var_screeninfo default_var = {
 
 /* default modedb mode */
 /* 640x480, 60 Hz, Non-Interlaced (25.172 MHz dotclock) */
-static struct fb_videomode defaultmode __devinitdata = {
+static struct fb_videomode defaultmode = {
 	.refresh =	60,
 	.xres =		640,
 	.yres =		480,
@@ -333,7 +333,7 @@ static const struct aty128_meminfo sdr_sgram =
 static const struct aty128_meminfo ddr_sgram =
 	{ 4, 4, 3, 3, 2, 3, 1, 16, 31, 16, "64-bit DDR SGRAM" };
 
-static struct fb_fix_screeninfo aty128fb_fix __devinitdata = {
+static struct fb_fix_screeninfo aty128fb_fix = {
 	.id		= "ATY Rage128",
 	.type		= FB_TYPE_PACKED_PIXELS,
 	.visual		= FB_VISUAL_PSEUDOCOLOR,
@@ -343,24 +343,24 @@ static struct fb_fix_screeninfo aty128fb_fix __devinitdata = {
 	.accel		= FB_ACCEL_ATI_RAGE128,
 };
 
-static char *mode_option __devinitdata = NULL;
+static char *mode_option = NULL;
 
 #ifdef CONFIG_PPC_PMAC
-static int default_vmode __devinitdata = VMODE_1024_768_60;
-static int default_cmode __devinitdata = CMODE_8;
+static int default_vmode = VMODE_1024_768_60;
+static int default_cmode = CMODE_8;
 #endif
 
-static int default_crt_on __devinitdata = 0;
-static int default_lcd_on __devinitdata = 1;
+static int default_crt_on = 0;
+static int default_lcd_on = 1;
 
 #ifdef CONFIG_MTRR
 static bool mtrr = true;
 #endif
 
 #ifdef CONFIG_PMAC_BACKLIGHT
-static int backlight __devinitdata = 1;
+static int backlight = 1;
 #else
-static int backlight __devinitdata = 0;
+static int backlight = 0;
 #endif
 
 /* PLL constants */
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index ae75dd3..a3f117d 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -214,7 +214,7 @@ struct pci_mmap_map {
 	unsigned long prot_mask;
 };
 
-static struct fb_fix_screeninfo atyfb_fix __devinitdata = {
+static struct fb_fix_screeninfo atyfb_fix = {
 	.id		= "ATY Mach64",
 	.type		= FB_TYPE_PACKED_PIXELS,
 	.visual		= FB_VISUAL_PSEUDOCOLOR,
@@ -309,18 +309,18 @@ static int vram;
 static int pll;
 static int mclk;
 static int xclk;
-static int comp_sync __devinitdata = -1;
+static int comp_sync = -1;
 static char *mode;
 
 #ifdef CONFIG_PMAC_BACKLIGHT
-static int backlight __devinitdata = 1;
+static int backlight = 1;
 #else
-static int backlight __devinitdata = 0;
+static int backlight = 0;
 #endif
 
 #ifdef CONFIG_PPC
-static int default_vmode __devinitdata = VMODE_CHOOSE;
-static int default_cmode __devinitdata = CMODE_CHOOSE;
+static int default_vmode = VMODE_CHOOSE;
+static int default_cmode = CMODE_CHOOSE;
 
 module_param_named(vmode, default_vmode, int, 0);
 MODULE_PARM_DESC(vmode, "int: video mode for mac");
@@ -329,10 +329,10 @@ MODULE_PARM_DESC(cmode, "int: color mode for mac");
 #endif
 
 #ifdef CONFIG_ATARI
-static unsigned int mach64_count __devinitdata = 0;
-static unsigned long phys_vmembase[FB_MAX] __devinitdata = { 0, };
-static unsigned long phys_size[FB_MAX] __devinitdata = { 0, };
-static unsigned long phys_guiregbase[FB_MAX] __devinitdata = { 0, };
+static unsigned int mach64_count = 0;
+static unsigned long phys_vmembase[FB_MAX] = { 0, };
+static unsigned long phys_size[FB_MAX] = { 0, };
+static unsigned long phys_guiregbase[FB_MAX] = { 0, };
 #endif
 
 /* top -> down is an evolution of mach64 chipset, any corrections? */
@@ -371,7 +371,7 @@ static struct {
 	const char *name;
 	int pll, mclk, xclk, ecp_max;
 	u32 features;
-} aty_chips[] __devinitdata = {
+} aty_chips[] = {
 #ifdef CONFIG_FB_ATY_GX
 	/* Mach64 GX */
 	{ PCI_CHIP_MACH64GX, "ATI888GX00 (Mach64 GX)", 135, 50, 50, 0, ATI_CHIP_88800GX },
@@ -531,34 +531,34 @@ static int correct_chipset(struct atyfb_par *par)
 	return 0;
 }
 
-static char ram_dram[] __devinitdata = "DRAM";
-static char ram_resv[] __devinitdata = "RESV";
+static char ram_dram[] = "DRAM";
+static char ram_resv[] = "RESV";
 #ifdef CONFIG_FB_ATY_GX
-static char ram_vram[] __devinitdata = "VRAM";
+static char ram_vram[] = "VRAM";
 #endif /* CONFIG_FB_ATY_GX */
 #ifdef CONFIG_FB_ATY_CT
-static char ram_edo[] __devinitdata = "EDO";
-static char ram_sdram[] __devinitdata = "SDRAM (1:1)";
-static char ram_sgram[] __devinitdata = "SGRAM (1:1)";
-static char ram_sdram32[] __devinitdata = "SDRAM (2:1) (32-bit)";
-static char ram_wram[] __devinitdata = "WRAM";
-static char ram_off[] __devinitdata = "OFF";
+static char ram_edo[] = "EDO";
+static char ram_sdram[] = "SDRAM (1:1)";
+static char ram_sgram[] = "SGRAM (1:1)";
+static char ram_sdram32[] = "SDRAM (2:1) (32-bit)";
+static char ram_wram[] = "WRAM";
+static char ram_off[] = "OFF";
 #endif /* CONFIG_FB_ATY_CT */
 
 
 #ifdef CONFIG_FB_ATY_GX
-static char *aty_gx_ram[8] __devinitdata = {
+static char *aty_gx_ram[8] = {
 	ram_dram, ram_vram, ram_vram, ram_dram,
 	ram_dram, ram_vram, ram_vram, ram_resv
 };
 #endif /* CONFIG_FB_ATY_GX */
 
 #ifdef CONFIG_FB_ATY_CT
-static char *aty_ct_ram[8] __devinitdata = {
+static char *aty_ct_ram[8] = {
 	ram_off, ram_dram, ram_edo, ram_edo,
 	ram_sdram, ram_sgram, ram_wram, ram_resv
 };
-static char *aty_xl_ram[8] __devinitdata = {
+static char *aty_xl_ram[8] = {
 	ram_off, ram_dram, ram_edo, ram_edo,
 	ram_sdram, ram_sgram, ram_sdram32, ram_resv
 };
diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index b4b76dc..ddabaa8 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -83,7 +83,7 @@ struct fb_bitfield rgb_bitfields[][4] =
 	{ { 8, 4, 0 },  { 4, 4, 0 }, { 0, 4, 0 }, { 0, 0, 0 } },
 };
 
-static struct fb_fix_screeninfo au1100fb_fix __devinitdata = {
+static struct fb_fix_screeninfo au1100fb_fix = {
 	.id		= "AU1100 FB",
 	.xpanstep 	= 1,
 	.ypanstep 	= 1,
@@ -91,7 +91,7 @@ static struct fb_fix_screeninfo au1100fb_fix __devinitdata = {
 	.accel		= FB_ACCEL_NONE,
 };
 
-static struct fb_var_screeninfo au1100fb_var __devinitdata = {
+static struct fb_var_screeninfo au1100fb_var = {
 	.activate	= FB_ACTIVATE_NOW,
 	.height		= -1,
 	.width		= -1,
diff --git a/drivers/video/bf537-lq035.c b/drivers/video/bf537-lq035.c
index 0b7c757..5b8e95d 100644
--- a/drivers/video/bf537-lq035.c
+++ b/drivers/video/bf537-lq035.c
@@ -443,7 +443,7 @@ static struct fb_var_screeninfo bfin_lq035_fb_defined = {
 	.transp		= {0, 0, 0},
 };
 
-static struct fb_fix_screeninfo bfin_lq035_fb_fix __devinitdata = {
+static struct fb_fix_screeninfo bfin_lq035_fb_fix = {
 	.id		= KBUILD_MODNAME,
 	.smem_len	= ACTIVE_VIDEO_MEM_SIZE,
 	.type		= FB_TYPE_PACKED_PIXELS,
diff --git a/drivers/video/bfin_adv7393fb.c b/drivers/video/bfin_adv7393fb.c
index 85e9659..5754140 100644
--- a/drivers/video/bfin_adv7393fb.c
+++ b/drivers/video/bfin_adv7393fb.c
@@ -88,7 +88,7 @@ static struct fb_var_screeninfo bfin_adv7393_fb_defined = {
 	.transp = {0, 0, 0},
 };
 
-static struct fb_fix_screeninfo bfin_adv7393_fb_fix __devinitdata = {
+static struct fb_fix_screeninfo bfin_adv7393_fb_fix = {
 	.id = "BFIN ADV7393",
 	.smem_len = 720 * 480 * 2,
 	.type = FB_TYPE_PACKED_PIXELS,
diff --git a/drivers/video/broadsheetfb.c b/drivers/video/broadsheetfb.c
index bd15a9b..bc04699 100644
--- a/drivers/video/broadsheetfb.c
+++ b/drivers/video/broadsheetfb.c
@@ -91,7 +91,7 @@ static struct panel_info panel_table[] = {
 #define DPY_W 800
 #define DPY_H 600
 
-static struct fb_fix_screeninfo broadsheetfb_fix __devinitdata = {
+static struct fb_fix_screeninfo broadsheetfb_fix = {
 	.id =		"broadsheetfb",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_STATIC_PSEUDOCOLOR,
@@ -102,7 +102,7 @@ static struct fb_fix_screeninfo broadsheetfb_fix __devinitdata = {
 	.accel =	FB_ACCEL_NONE,
 };
 
-static struct fb_var_screeninfo broadsheetfb_var __devinitdata = {
+static struct fb_var_screeninfo broadsheetfb_var = {
 	.xres		= DPY_W,
 	.yres		= DPY_H,
 	.xres_virtual	= DPY_W,
diff --git a/drivers/video/bw2.c b/drivers/video/bw2.c
index 21a8587..7695927 100644
--- a/drivers/video/bw2.c
+++ b/drivers/video/bw2.c
@@ -191,35 +191,35 @@ static void bw2_init_fix(struct fb_info *info, int linebytes)
 	info->fix.accel = FB_ACCEL_SUN_BWTWO;
 }
 
-static u8 bw2regs_1600[] __devinitdata = {
+static u8 bw2regs_1600[] = {
 	0x14, 0x8b,	0x15, 0x28,	0x16, 0x03,	0x17, 0x13,
 	0x18, 0x7b,	0x19, 0x05,	0x1a, 0x34,	0x1b, 0x2e,
 	0x1c, 0x00,	0x1d, 0x0a,	0x1e, 0xff,	0x1f, 0x01,
 	0x10, 0x21,	0
 };
 
-static u8 bw2regs_ecl[] __devinitdata = {
+static u8 bw2regs_ecl[] = {
 	0x14, 0x65,	0x15, 0x1e,	0x16, 0x04,	0x17, 0x0c,
 	0x18, 0x5e,	0x19, 0x03,	0x1a, 0xa7,	0x1b, 0x23,
 	0x1c, 0x00,	0x1d, 0x08,	0x1e, 0xff,	0x1f, 0x01,
 	0x10, 0x20,	0
 };
 
-static u8 bw2regs_analog[] __devinitdata = {
+static u8 bw2regs_analog[] = {
 	0x14, 0xbb,	0x15, 0x2b,	0x16, 0x03,	0x17, 0x13,
 	0x18, 0xb0,	0x19, 0x03,	0x1a, 0xa6,	0x1b, 0x22,
 	0x1c, 0x01,	0x1d, 0x05,	0x1e, 0xff,	0x1f, 0x01,
 	0x10, 0x20,	0
 };
 
-static u8 bw2regs_76hz[] __devinitdata = {
+static u8 bw2regs_76hz[] = {
 	0x14, 0xb7,	0x15, 0x27,	0x16, 0x03,	0x17, 0x0f,
 	0x18, 0xae,	0x19, 0x03,	0x1a, 0xae,	0x1b, 0x2a,
 	0x1c, 0x01,	0x1d, 0x09,	0x1e, 0xff,	0x1f, 0x01,
 	0x10, 0x24,	0
 };
 
-static u8 bw2regs_66hz[] __devinitdata = {
+static u8 bw2regs_66hz[] = {
 	0x14, 0xbb,	0x15, 0x2b,	0x16, 0x04,	0x17, 0x14,
 	0x18, 0xae,	0x19, 0x03,	0x1a, 0xa8,	0x1b, 0x24,
 	0x1c, 0x01,	0x1d, 0x05,	0x1e, 0xff,	0x1f, 0x01,
diff --git a/drivers/video/carminefb.c b/drivers/video/carminefb.c
index 9d9eb08..ccbe958 100644
--- a/drivers/video/carminefb.c
+++ b/drivers/video/carminefb.c
@@ -78,7 +78,7 @@ struct carmine_fb {
 	u32 pseudo_palette[16];
 };
 
-static struct fb_fix_screeninfo carminefb_fix __devinitdata = {
+static struct fb_fix_screeninfo carminefb_fix = {
 	.id = "Carmine",
 	.type = FB_TYPE_PACKED_PIXELS,
 	.visual = FB_VISUAL_TRUECOLOR,
@@ -752,7 +752,7 @@ static void __devexit carminefb_remove(struct pci_dev *dev)
 }
 
 #define PCI_VENDOR_ID_FUJITU_LIMITED 0x10cf
-static struct pci_device_id carmine_devices[] __devinitdata = {
+static struct pci_device_id carmine_devices[] = {
 {
 	PCI_DEVICE(PCI_VENDOR_ID_FUJITU_LIMITED, 0x202b)},
 	{0, 0, 0, 0, 0, 0, 0}
diff --git a/drivers/video/cg14.c b/drivers/video/cg14.c
index e9d80c1..1b95656 100644
--- a/drivers/video/cg14.c
+++ b/drivers/video/cg14.c
@@ -367,7 +367,7 @@ static void cg14_init_fix(struct fb_info *info, int linebytes,
 	info->fix.accel = FB_ACCEL_SUN_CG14;
 }
 
-static struct sbus_mmap_map __cg14_mmap_map[CG14_MMAP_ENTRIES] __devinitdata = {
+static struct sbus_mmap_map __cg14_mmap_map[CG14_MMAP_ENTRIES] = {
 	{
 		.voff	= CG14_REGS,
 		.poff	= 0x80000000,
diff --git a/drivers/video/cg3.c b/drivers/video/cg3.c
index 6102d57..4d20257 100644
--- a/drivers/video/cg3.c
+++ b/drivers/video/cg3.c
@@ -279,32 +279,32 @@ static void cg3_rdi_maybe_fixup_var(struct fb_var_screeninfo *var,
 	}
 }
 
-static u8 cg3regvals_66hz[] __devinitdata = {	/* 1152 x 900, 66 Hz */
+static u8 cg3regvals_66hz[] = {	/* 1152 x 900, 66 Hz */
 	0x14, 0xbb,	0x15, 0x2b,	0x16, 0x04,	0x17, 0x14,
 	0x18, 0xae,	0x19, 0x03,	0x1a, 0xa8,	0x1b, 0x24,
 	0x1c, 0x01,	0x1d, 0x05,	0x1e, 0xff,	0x1f, 0x01,
 	0x10, 0x20,	0
 };
 
-static u8 cg3regvals_76hz[] __devinitdata = {	/* 1152 x 900, 76 Hz */
+static u8 cg3regvals_76hz[] = {	/* 1152 x 900, 76 Hz */
 	0x14, 0xb7,	0x15, 0x27,	0x16, 0x03,	0x17, 0x0f,
 	0x18, 0xae,	0x19, 0x03,	0x1a, 0xae,	0x1b, 0x2a,
 	0x1c, 0x01,	0x1d, 0x09,	0x1e, 0xff,	0x1f, 0x01,
 	0x10, 0x24,	0
 };
 
-static u8 cg3regvals_rdi[] __devinitdata = {	/* 640 x 480, cgRDI */
+static u8 cg3regvals_rdi[] = {	/* 640 x 480, cgRDI */
 	0x14, 0x70,	0x15, 0x20,	0x16, 0x08,	0x17, 0x10,
 	0x18, 0x06,	0x19, 0x02,	0x1a, 0x31,	0x1b, 0x51,
 	0x1c, 0x06,	0x1d, 0x0c,	0x1e, 0xff,	0x1f, 0x01,
 	0x10, 0x22,	0
 };
 
-static u8 *cg3_regvals[] __devinitdata = {
+static u8 *cg3_regvals[] = {
 	cg3regvals_66hz, cg3regvals_76hz, cg3regvals_rdi
 };
 
-static u_char cg3_dacvals[] __devinitdata = {
+static u_char cg3_dacvals[] = {
 	4, 0xff,	5, 0x00,	6, 0x70,	7, 0x00,	0
 };
 
diff --git a/drivers/video/chipsfb.c b/drivers/video/chipsfb.c
index bf131f2..71f46e3 100644
--- a/drivers/video/chipsfb.c
+++ b/drivers/video/chipsfb.c
@@ -292,7 +292,7 @@ static void __init chips_hw_init(void)
 		write_fr(chips_init_fr[i].addr, chips_init_fr[i].data);
 }
 
-static struct fb_fix_screeninfo chipsfb_fix __devinitdata = {
+static struct fb_fix_screeninfo chipsfb_fix = {
 	.id =		"C&T 65550",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_PSEUDOCOLOR,
@@ -309,7 +309,7 @@ static struct fb_fix_screeninfo chipsfb_fix __devinitdata = {
 	.smem_len =	0x100000,	/* 1MB */
 };
 
-static struct fb_var_screeninfo chipsfb_var __devinitdata = {
+static struct fb_var_screeninfo chipsfb_var = {
 	.xres = 800,
 	.yres = 600,
 	.xres_virtual = 800,
diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 0e73200..55037b1 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -372,8 +372,8 @@ struct cirrusfb_info {
 	void (*unmap)(struct fb_info *info);
 };
 
-static bool noaccel __devinitdata;
-static char *mode_option __devinitdata = "640x480@60";
+static bool noaccel;
+static char *mode_option = "640x480@60";
 
 /****************************************************************************/
 /**** BEGIN PROTOTYPES ******************************************************/
diff --git a/drivers/video/cobalt_lcdfb.c b/drivers/video/cobalt_lcdfb.c
index 9e1e5d2..bea956e 100644
--- a/drivers/video/cobalt_lcdfb.c
+++ b/drivers/video/cobalt_lcdfb.c
@@ -167,7 +167,7 @@ static void lcd_clear(struct fb_info *info)
 	lcd_write_control(info, LCD_RESET);
 }
 
-static struct fb_fix_screeninfo cobalt_lcdfb_fix __devinitdata = {
+static struct fb_fix_screeninfo cobalt_lcdfb_fix = {
 	.id		= "cobalt-lcd",
 	.type		= FB_TYPE_TEXT,
 	.type_aux	= FB_AUX_TEXT_MDA,
diff --git a/drivers/video/console/sticore.c b/drivers/video/console/sticore.c
index 0fbc03c..a4827da 100644
--- a/drivers/video/console/sticore.c
+++ b/drivers/video/console/sticore.c
@@ -285,8 +285,8 @@ __setup("sti=", sti_setup);
 
 
 
-static char __devinitdata	*font_name[MAX_STI_ROMS] = { "VGA8x16", };
-static int __devinitdata	font_index[MAX_STI_ROMS],
+static char *font_name[MAX_STI_ROMS] = { "VGA8x16", };
+static int font_index[MAX_STI_ROMS],
 				font_height[MAX_STI_ROMS],
 				font_width[MAX_STI_ROMS];
 #ifndef MODULE
diff --git a/drivers/video/cyber2000fb.c b/drivers/video/cyber2000fb.c
index 78bb6be..b93cabc 100644
--- a/drivers/video/cyber2000fb.c
+++ b/drivers/video/cyber2000fb.c
@@ -1336,7 +1336,7 @@ static void cyber2000fb_i2c_unregister(struct cfb_info *cfb)
  * These parameters give
  * 640x480, hsync 31.5kHz, vsync 60Hz
  */
-static struct fb_videomode __devinitdata cyber2000fb_default_mode = {
+static struct fb_videomode cyber2000fb_default_mode = {
 	.refresh	= 60,
 	.xres		= 640,
 	.yres		= 480,
diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 1face18..33b286b 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -185,7 +185,7 @@ struct da8xx_fb_par {
 };
 
 /* Variable Screen Information */
-static struct fb_var_screeninfo da8xx_fb_var __devinitdata = {
+static struct fb_var_screeninfo da8xx_fb_var = {
 	.xoffset = 0,
 	.yoffset = 0,
 	.transp = {0, 0, 0},
@@ -202,7 +202,7 @@ static struct fb_var_screeninfo da8xx_fb_var __devinitdata = {
 	.vmode = FB_VMODE_NONINTERLACED
 };
 
-static struct fb_fix_screeninfo da8xx_fb_fix __devinitdata = {
+static struct fb_fix_screeninfo da8xx_fb_fix = {
 	.id = "DA8xx FB Drv",
 	.type = FB_TYPE_PACKED_PIXELS,
 	.type_aux = 0,
diff --git a/drivers/video/dnfb.c b/drivers/video/dnfb.c
index 182b199..3526899 100644
--- a/drivers/video/dnfb.c
+++ b/drivers/video/dnfb.c
@@ -115,7 +115,7 @@ static struct fb_ops dn_fb_ops = {
 	.fb_imageblit	= cfb_imageblit,
 };
 
-struct fb_var_screeninfo dnfb_var __devinitdata = {
+struct fb_var_screeninfo dnfb_var = {
 	.xres		= 1280,
 	.yres		= 1024,
 	.xres_virtual	= 2048,
@@ -126,7 +126,7 @@ struct fb_var_screeninfo dnfb_var __devinitdata = {
 	.vmode		= FB_VMODE_NONINTERLACED,
 };
 
-static struct fb_fix_screeninfo dnfb_fix __devinitdata = {
+static struct fb_fix_screeninfo dnfb_fix = {
 	.id		= "Apollo Mono",
 	.smem_start	= (FRAME_BUFFER_START + IO_BASE),
 	.smem_len	= FRAME_BUFFER_LEN,
diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
index 932abaa..50fe668 100644
--- a/drivers/video/efifb.c
+++ b/drivers/video/efifb.c
@@ -20,7 +20,7 @@ static bool request_mem_succeeded = false;
 
 static struct pci_dev *default_vga;
 
-static struct fb_var_screeninfo efifb_defined __devinitdata = {
+static struct fb_var_screeninfo efifb_defined = {
 	.activate		= FB_ACTIVATE_NOW,
 	.height			= -1,
 	.width			= -1,
@@ -31,7 +31,7 @@ static struct fb_var_screeninfo efifb_defined __devinitdata = {
 	.vmode			= FB_VMODE_NONINTERLACED,
 };
 
-static struct fb_fix_screeninfo efifb_fix __devinitdata = {
+static struct fb_fix_screeninfo efifb_fix = {
 	.id			= "EFI VGA",
 	.type			= FB_TYPE_PACKED_PIXELS,
 	.accel			= FB_ACCEL_NONE,
diff --git a/drivers/video/fm2fb.c b/drivers/video/fm2fb.c
index a64c3ef..232e27c 100644
--- a/drivers/video/fm2fb.c
+++ b/drivers/video/fm2fb.c
@@ -127,7 +127,7 @@
 
 static volatile unsigned char *fm2fb_reg;
 
-static struct fb_fix_screeninfo fb_fix __devinitdata = {
+static struct fb_fix_screeninfo fb_fix = {
 	.smem_len =	FRAMEMASTER_REG,
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_TRUECOLOR,
@@ -136,12 +136,12 @@ static struct fb_fix_screeninfo fb_fix __devinitdata = {
 	.accel =	FB_ACCEL_NONE,
 };
 
-static int fm2fb_mode __devinitdata = -1;
+static int fm2fb_mode = -1;
 
 #define FM2FB_MODE_PAL	0
 #define FM2FB_MODE_NTSC	1
 
-static struct fb_var_screeninfo fb_var_modes[] __devinitdata = {
+static struct fb_var_screeninfo fb_var_modes[] = {
     {
 	/* 768 x 576, 32 bpp (PAL) */
 	768, 576, 768, 576, 0, 0, 32, 0,
@@ -214,7 +214,7 @@ static int fm2fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 static int fm2fb_probe(struct zorro_dev *z,
 				 const struct zorro_device_id *id);
 
-static struct zorro_device_id fm2fb_devices[] __devinitdata = {
+static struct zorro_device_id fm2fb_devices[] = {
 	{ ZORRO_PROD_BSC_FRAMEMASTER_II },
 	{ ZORRO_PROD_HELFRICH_RAINBOW_II },
 	{ 0 }
diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 6bdf805..8359c16 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -55,7 +55,7 @@
  * order if increasing resolution and frequency.  The 320x240-60 mode is
  * the initial AOI for the second and third planes.
  */
-static struct fb_videomode __devinitdata fsl_diu_mode_db[] = {
+static struct fb_videomode fsl_diu_mode_db[] = {
 	{
 		.refresh	= 60,
 		.xres		= 1024,
diff --git a/drivers/video/gbefb.c b/drivers/video/gbefb.c
index 2971511..f2e9788 100644
--- a/drivers/video/gbefb.c
+++ b/drivers/video/gbefb.c
@@ -91,10 +91,10 @@ static uint32_t pseudo_palette[16];
 static uint32_t gbe_cmap[256];
 static int gbe_turned_on; /* 0 turned off, 1 turned on */
 
-static char *mode_option __devinitdata = NULL;
+static char *mode_option = NULL;
 
 /* default CRT mode */
-static struct fb_var_screeninfo default_var_CRT __devinitdata = {
+static struct fb_var_screeninfo default_var_CRT = {
 	/* 640x480, 60 Hz, Non-Interlaced (25.175 MHz dotclock) */
 	.xres		= 640,
 	.yres		= 480,
@@ -125,7 +125,7 @@ static struct fb_var_screeninfo default_var_CRT __devinitdata = {
 };
 
 /* default LCD mode */
-static struct fb_var_screeninfo default_var_LCD __devinitdata = {
+static struct fb_var_screeninfo default_var_LCD = {
 	/* 1600x1024, 8 bpp */
 	.xres		= 1600,
 	.yres		= 1024,
@@ -157,7 +157,7 @@ static struct fb_var_screeninfo default_var_LCD __devinitdata = {
 
 /* default modedb mode */
 /* 640x480, 60 Hz, Non-Interlaced (25.172 MHz dotclock) */
-static struct fb_videomode default_mode_CRT __devinitdata = {
+static struct fb_videomode default_mode_CRT = {
 	.refresh	= 60,
 	.xres		= 640,
 	.yres		= 480,
@@ -172,7 +172,7 @@ static struct fb_videomode default_mode_CRT __devinitdata = {
 	.vmode		= FB_VMODE_NONINTERLACED,
 };
 /* 1600x1024 SGI flatpanel 1600sw */
-static struct fb_videomode default_mode_LCD __devinitdata = {
+static struct fb_videomode default_mode_LCD = {
 	/* 1600x1024, 8 bpp */
 	.xres		= 1600,
 	.yres		= 1024,
@@ -186,8 +186,8 @@ static struct fb_videomode default_mode_LCD __devinitdata = {
 	.vmode		= FB_VMODE_NONINTERLACED,
 };
 
-static struct fb_videomode *default_mode __devinitdata = &default_mode_CRT;
-static struct fb_var_screeninfo *default_var __devinitdata = &default_var_CRT;
+static struct fb_videomode *default_mode = &default_mode_CRT;
+static struct fb_var_screeninfo *default_var = &default_var_CRT;
 
 static int flat_panel_enabled = 0;
 
diff --git a/drivers/video/geode/gxfb_core.c b/drivers/video/geode/gxfb_core.c
index d3ad1a0..d40a9eb 100644
--- a/drivers/video/geode/gxfb_core.c
+++ b/drivers/video/geode/gxfb_core.c
@@ -40,7 +40,7 @@ static int vram;
 static int vt_switch;
 
 /* Modes relevant to the GX (taken from modedb.c) */
-static struct fb_videomode gx_modedb[] __devinitdata = {
+static struct fb_videomode gx_modedb[] = {
 	/* 640x480-60 VESA */
 	{ NULL, 60, 640, 480, 39682,  48, 16, 33, 10, 96, 2,
 	  0, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
@@ -110,7 +110,7 @@ static struct fb_videomode gx_modedb[] __devinitdata = {
 #ifdef CONFIG_OLPC
 #include <asm/olpc.h>
 
-static struct fb_videomode gx_dcon_modedb[] __devinitdata = {
+static struct fb_videomode gx_dcon_modedb[] = {
 	/* The only mode the DCON has is 1200x900 */
 	{ NULL, 50, 1200, 900, 17460, 24, 8, 4, 5, 8, 3,
 	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
diff --git a/drivers/video/geode/lxfb_core.c b/drivers/video/geode/lxfb_core.c
index 7428366..04f0098 100644
--- a/drivers/video/geode/lxfb_core.c
+++ b/drivers/video/geode/lxfb_core.c
@@ -35,7 +35,7 @@ static int vt_switch;
  * we try to make it something sane - 640x480-60 is sane
  */
 
-static struct fb_videomode geode_modedb[] __devinitdata = {
+static struct fb_videomode geode_modedb[] = {
 	/* 640x480-60 */
 	{ NULL, 60, 640, 480, 39682, 48, 8, 25, 2, 88, 2,
 	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
@@ -219,7 +219,7 @@ static struct fb_videomode geode_modedb[] __devinitdata = {
 #ifdef CONFIG_OLPC
 #include <asm/olpc.h>
 
-static struct fb_videomode olpc_dcon_modedb[] __devinitdata = {
+static struct fb_videomode olpc_dcon_modedb[] = {
 	/* The only mode the DCON has is 1200x900 */
 	{ NULL, 50, 1200, 900, 17460, 24, 8, 4, 5, 8, 3,
 	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
diff --git a/drivers/video/grvga.c b/drivers/video/grvga.c
index bf7ea95..3cdfacd 100644
--- a/drivers/video/grvga.c
+++ b/drivers/video/grvga.c
@@ -70,7 +70,7 @@ static const struct fb_videomode grvga_modedb[] = {
     }
  };
 
-static struct fb_fix_screeninfo grvga_fix __devinitdata = {
+static struct fb_fix_screeninfo grvga_fix = {
 	.id =		"AG SVGACTRL",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =       FB_VISUAL_PSEUDOCOLOR,
diff --git a/drivers/video/hecubafb.c b/drivers/video/hecubafb.c
index f8746a3f..298f977 100644
--- a/drivers/video/hecubafb.c
+++ b/drivers/video/hecubafb.c
@@ -47,7 +47,7 @@
 #define DPY_W 600
 #define DPY_H 800
 
-static struct fb_fix_screeninfo hecubafb_fix __devinitdata = {
+static struct fb_fix_screeninfo hecubafb_fix = {
 	.id =		"hecubafb",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_MONO01,
@@ -58,7 +58,7 @@ static struct fb_fix_screeninfo hecubafb_fix __devinitdata = {
 	.accel =	FB_ACCEL_NONE,
 };
 
-static struct fb_var_screeninfo hecubafb_var __devinitdata = {
+static struct fb_var_screeninfo hecubafb_var = {
 	.xres		= DPY_W,
 	.yres		= DPY_H,
 	.xres_virtual	= DPY_W,
diff --git a/drivers/video/hgafb.c b/drivers/video/hgafb.c
index 20bbeb4..43b3976 100644
--- a/drivers/video/hgafb.c
+++ b/drivers/video/hgafb.c
@@ -106,7 +106,7 @@ static DEFINE_SPINLOCK(hga_reg_lock);
 
 /* Framebuffer driver structures */
 
-static struct fb_var_screeninfo hga_default_var __devinitdata = {
+static struct fb_var_screeninfo hga_default_var = {
 	.xres		= 720,
 	.yres 		= 348,
 	.xres_virtual 	= 720,
@@ -120,7 +120,7 @@ static struct fb_var_screeninfo hga_default_var __devinitdata = {
 	.width 		= -1,
 };
 
-static struct fb_fix_screeninfo hga_fix __devinitdata = {
+static struct fb_fix_screeninfo hga_fix = {
 	.id 		= "HGA",
 	.type 		= FB_TYPE_PACKED_PIXELS,	/* (not sure) */
 	.visual 	= FB_VISUAL_MONO10,
diff --git a/drivers/video/hitfb.c b/drivers/video/hitfb.c
index 20d8a56..adb6708 100644
--- a/drivers/video/hitfb.c
+++ b/drivers/video/hitfb.c
@@ -30,14 +30,14 @@
 
 #define	WIDTH 640
 
-static struct fb_var_screeninfo hitfb_var __devinitdata = {
+static struct fb_var_screeninfo hitfb_var = {
 	.activate	= FB_ACTIVATE_NOW,
 	.height		= -1,
 	.width		= -1,
 	.vmode		= FB_VMODE_NONINTERLACED,
 };
 
-static struct fb_fix_screeninfo hitfb_fix __devinitdata = {
+static struct fb_fix_screeninfo hitfb_fix = {
 	.id		= "Hitachi HD64461",
 	.type		= FB_TYPE_PACKED_PIXELS,
 	.accel		= FB_ACCEL_NONE,
diff --git a/drivers/video/i740fb.c b/drivers/video/i740fb.c
index 1109617..05c7d94 100644
--- a/drivers/video/i740fb.c
+++ b/drivers/video/i740fb.c
@@ -33,10 +33,10 @@
 
 #include "i740_reg.h"
 
-static char *mode_option __devinitdata;
+static char *mode_option;
 
 #ifdef CONFIG_MTRR
-static int mtrr __devinitdata = 1;
+static int mtrr = 1;
 #endif
 
 struct i740fb_par {
@@ -91,7 +91,7 @@ struct i740fb_par {
 #define DACSPEED24_SD	128
 #define DACSPEED32	86
 
-static struct fb_fix_screeninfo i740fb_fix __devinitdata = {
+static struct fb_fix_screeninfo i740fb_fix = {
 	.id =		"i740fb",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_TRUECOLOR,
diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index 8c50b96..7f93dd8 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -74,8 +74,8 @@
  *
  * Experiment with v_offset to find out which works best for you.
  */
-static u32 v_offset_default __devinitdata; /* For 32 MiB Aper size, 8 should be the default */
-static u32 voffset          __devinitdata;
+static u32 v_offset_default; /* For 32 MiB Aper size, 8 should be the default */
+static u32 voffset;
 
 static int i810fb_cursor(struct fb_info *info, struct fb_cursor *cursor);
 static int  i810fb_init_pci (struct pci_dev *dev,
@@ -132,22 +132,22 @@ static struct pci_driver i810fb_driver = {
 	.resume   =     i810fb_resume,
 };
 
-static char *mode_option __devinitdata = NULL;
-static int vram       __devinitdata = 4;
-static int bpp        __devinitdata = 8;
-static bool mtrr      __devinitdata;
-static bool accel     __devinitdata;
-static int hsync1     __devinitdata;
-static int hsync2     __devinitdata;
-static int vsync1     __devinitdata;
-static int vsync2     __devinitdata;
-static int xres       __devinitdata;
+static char *mode_option = NULL;
+static int vram       = 4;
+static int bpp        = 8;
+static bool mtrr;
+static bool accel;
+static int hsync1;
+static int hsync2;
+static int vsync1;
+static int vsync2;
+static int xres;
 static int yres;
-static int vyres      __devinitdata;
-static bool sync      __devinitdata;
-static bool extvga    __devinitdata;
-static bool dcolor    __devinitdata;
-static bool ddc3      __devinitdata;
+static int vyres;
+static bool sync;
+static bool extvga;
+static bool dcolor;
+static bool ddc3;
 
 /*------------------------------------------------------------*/
 
@@ -1541,7 +1541,7 @@ static int i810fb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 	return 0;
 }
 
-static struct fb_ops i810fb_ops __devinitdata = {
+static struct fb_ops i810fb_ops = {
 	.owner =             THIS_MODULE,
 	.fb_open =           i810fb_open,
 	.fb_release =        i810fb_release,
diff --git a/drivers/video/igafb.c b/drivers/video/igafb.c
index 2d97752..79cbfa7 100644
--- a/drivers/video/igafb.c
+++ b/drivers/video/igafb.c
@@ -571,7 +571,7 @@ static int __init igafb_setup(char *options)
 
 module_init(igafb_init);
 MODULE_LICENSE("GPL");
-static struct pci_device_id igafb_pci_tbl[] __devinitdata = {
+static struct pci_device_id igafb_pci_tbl[] = {
 	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_1682,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ }
diff --git a/drivers/video/imsttfb.c b/drivers/video/imsttfb.c
index a7e8477..7060401 100644
--- a/drivers/video/imsttfb.c
+++ b/drivers/video/imsttfb.c
@@ -225,7 +225,7 @@ struct initvalues {
 	__u8 addr, value;
 };
 
-static struct initvalues ibm_initregs[] __devinitdata = {
+static struct initvalues ibm_initregs[] = {
 	{ CLKCTL,	0x21 },
 	{ SYNCCTL,	0x00 },
 	{ HSYNCPOS,	0x00 },
@@ -272,7 +272,7 @@ static struct initvalues ibm_initregs[] __devinitdata = {
 	{ KEYCTL,	0x00 }
 };
 
-static struct initvalues tvp_initregs[] __devinitdata = {
+static struct initvalues tvp_initregs[] = {
 	{ TVPIRICC,	0x00 },
 	{ TVPIRBRC,	0xe4 },
 	{ TVPIRLAC,	0x06 },
@@ -336,7 +336,7 @@ enum {
 static int inverse = 0;
 static char fontname[40] __initdata = { 0 };
 #if defined(CONFIG_PPC)
-static signed char init_vmode __devinitdata = -1, init_cmode __devinitdata = -1;
+static signed char init_vmode = -1, init_cmode = -1;
 #endif
 
 static struct imstt_regvals tvp_reg_init_2 = {
diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
index 860820c..184bbb7 100644
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -177,7 +177,7 @@ static int intelfb_set_fbinfo(struct intelfb_info *dinfo);
 #define INTELFB_CLASS_MASK 0
 #endif
 
-static struct pci_device_id intelfb_pci_table[] __devinitdata = {
+static struct pci_device_id intelfb_pci_table[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_830M, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_830M },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_845G, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_845G },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_85XGM, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_85XGM },
diff --git a/drivers/video/kyro/fbdev.c b/drivers/video/kyro/fbdev.c
index 2c498d8..2f0effd 100644
--- a/drivers/video/kyro/fbdev.c
+++ b/drivers/video/kyro/fbdev.c
@@ -40,14 +40,14 @@
 #define KHZ2PICOS(a) (1000000000UL/(a))
 
 /****************************************************************************/
-static struct fb_fix_screeninfo kyro_fix __devinitdata = {
+static struct fb_fix_screeninfo kyro_fix = {
 	.id		= "ST Kyro",
 	.type		= FB_TYPE_PACKED_PIXELS,
 	.visual		= FB_VISUAL_TRUECOLOR,
 	.accel		= FB_ACCEL_NONE,
 };
 
-static struct fb_var_screeninfo kyro_var __devinitdata = {
+static struct fb_var_screeninfo kyro_var = {
 	/* 640x480, 16bpp @ 60 Hz */
 	.xres		= 640,
 	.yres		= 480,
@@ -81,18 +81,18 @@ typedef struct {
 /* global graphics card info structure (one per card) */
 static device_info_t deviceInfo;
 
-static char *mode_option __devinitdata = NULL;
-static int nopan __devinitdata = 0;
-static int nowrap __devinitdata = 1;
+static char *mode_option = NULL;
+static int nopan = 0;
+static int nowrap = 1;
 #ifdef CONFIG_MTRR
-static int nomtrr __devinitdata = 0;
+static int nomtrr = 0;
 #endif
 
 /* PCI driver prototypes */
 static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
 static void kyrofb_remove(struct pci_dev *pdev);
 
-static struct fb_videomode kyro_modedb[] __devinitdata = {
+static struct fb_videomode kyro_modedb[] = {
 	{
 		/* 640x350 @ 85Hz */
 		NULL, 85, 640, 350, KHZ2PICOS(31500),
diff --git a/drivers/video/mb862xx/mb862xxfbdrv.c b/drivers/video/mb862xx/mb862xxfbdrv.c
index 9f88328..28ae8fb 100644
--- a/drivers/video/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/mb862xx/mb862xxfbdrv.c
@@ -823,7 +823,7 @@ static int __devexit of_platform_mb862xx_remove(struct platform_device *ofdev)
 /*
  * common types
  */
-static struct of_device_id __devinitdata of_platform_mb862xx_tbl[] = {
+static struct of_device_id of_platform_mb862xx_tbl[] = {
 	{ .compatible = "fujitsu,MB86276", },
 	{ .compatible = "fujitsu,lime", },
 	{ .compatible = "fujitsu,MB86277", },
@@ -984,7 +984,7 @@ static inline int mb862xx_pci_gdc_init(struct mb862xxfb_par *par)
 #define CHIP_ID(id)	\
 	{ PCI_DEVICE(PCI_VENDOR_ID_FUJITSU_LIMITED, id) }
 
-static struct pci_device_id mb862xx_pci_tbl[] __devinitdata = {
+static struct pci_device_id mb862xx_pci_tbl[] = {
 	/* MB86295/MB86296 */
 	CHIP_ID(PCI_DEVICE_ID_FUJITSU_CORALP),
 	CHIP_ID(PCI_DEVICE_ID_FUJITSU_CORALPA),
diff --git a/drivers/video/mbx/mbxfb.c b/drivers/video/mbx/mbxfb.c
index 91bf913..faa171f 100644
--- a/drivers/video/mbx/mbxfb.c
+++ b/drivers/video/mbx/mbxfb.c
@@ -79,7 +79,7 @@ struct mbxfb_info {
 
 };
 
-static struct fb_var_screeninfo mbxfb_default __devinitdata = {
+static struct fb_var_screeninfo mbxfb_default = {
 	.xres = 640,
 	.yres = 480,
 	.xres_virtual = 640,
@@ -102,7 +102,7 @@ static struct fb_var_screeninfo mbxfb_default __devinitdata = {
 	.sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 };
 
-static struct fb_fix_screeninfo mbxfb_fix  __devinitdata = {
+static struct fb_fix_screeninfo mbxfb_fix  = {
 	.id = "MBX",
 	.type = FB_TYPE_PACKED_PIXELS,
 	.visual = FB_VISUAL_TRUECOLOR,
diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
index d148067..6454888 100644
--- a/drivers/video/metronomefb.c
+++ b/drivers/video/metronomefb.c
@@ -99,7 +99,7 @@ static struct epd_frame epd_frame_table[] = {
 	},
 };
 
-static struct fb_fix_screeninfo metronomefb_fix __devinitdata = {
+static struct fb_fix_screeninfo metronomefb_fix = {
 	.id =		"metronomefb",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_STATIC_PSEUDOCOLOR,
@@ -110,7 +110,7 @@ static struct fb_fix_screeninfo metronomefb_fix __devinitdata = {
 	.accel =	FB_ACCEL_NONE,
 };
 
-static struct fb_var_screeninfo metronomefb_var __devinitdata = {
+static struct fb_var_screeninfo metronomefb_var = {
 	.xres		= DPY_W,
 	.yres		= DPY_H,
 	.xres_virtual	= DPY_W,
diff --git a/drivers/video/neofb.c b/drivers/video/neofb.c
index 4cd9e6d..b86fd96 100644
--- a/drivers/video/neofb.c
+++ b/drivers/video/neofb.c
@@ -88,7 +88,7 @@ static bool external;
 static bool libretto;
 static bool nostretch;
 static bool nopciburst;
-static char *mode_option __devinitdata = NULL;
+static char *mode_option = NULL;
 
 #ifdef MODULE
 
@@ -1632,7 +1632,7 @@ static struct fb_ops neofb_ops = {
 
 /* --------------------------------------------------------------------- */
 
-static struct fb_videomode __devinitdata mode800x480 = {
+static struct fb_videomode mode800x480 = {
 	.xres           = 800,
 	.yres           = 480,
 	.pixclock       = 25000,
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index ca8963c..b7f8feb 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -70,34 +70,34 @@ static struct pci_device_id nvidiafb_pci_tbl[] = {
 MODULE_DEVICE_TABLE(pci, nvidiafb_pci_tbl);
 
 /* command line data, set in nvidiafb_setup() */
-static int flatpanel __devinitdata = -1;	/* Autodetect later */
-static int fpdither __devinitdata = -1;
-static int forceCRTC __devinitdata = -1;
-static int hwcur __devinitdata = 0;
-static int noaccel __devinitdata = 0;
-static int noscale __devinitdata = 0;
-static int paneltweak __devinitdata = 0;
-static int vram __devinitdata = 0;
-static int bpp __devinitdata = 8;
-static int reverse_i2c __devinitdata;
+static int flatpanel = -1;	/* Autodetect later */
+static int fpdither = -1;
+static int forceCRTC = -1;
+static int hwcur = 0;
+static int noaccel = 0;
+static int noscale = 0;
+static int paneltweak = 0;
+static int vram = 0;
+static int bpp = 8;
+static int reverse_i2c;
 #ifdef CONFIG_MTRR
-static bool nomtrr __devinitdata = false;
+static bool nomtrr = false;
 #endif
 #ifdef CONFIG_PMAC_BACKLIGHT
-static int backlight __devinitdata = 1;
+static int backlight = 1;
 #else
-static int backlight __devinitdata = 0;
+static int backlight = 0;
 #endif
 
-static char *mode_option __devinitdata = NULL;
+static char *mode_option = NULL;
 
-static struct fb_fix_screeninfo __devinitdata nvidiafb_fix = {
+static struct fb_fix_screeninfo nvidiafb_fix = {
 	.type = FB_TYPE_PACKED_PIXELS,
 	.xpanstep = 8,
 	.ypanstep = 1,
 };
 
-static struct fb_var_screeninfo __devinitdata nvidiafb_default_var = {
+static struct fb_var_screeninfo nvidiafb_default_var = {
 	.xres = 640,
 	.yres = 480,
 	.xres_virtual = 640,
diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index 70192ba..f3ab16b 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -67,7 +67,7 @@
  * Driver data
  */
 static int hwcursor = 1;
-static char *mode_option __devinitdata;
+static char *mode_option;
 
 /*
  * The XFree GLINT driver will (I think to implement hardware cursor
@@ -80,10 +80,10 @@ static char *mode_option __devinitdata;
  */
 static bool lowhsync;
 static bool lowvsync;
-static bool noaccel __devinitdata;
+static bool noaccel;
 /* mtrr option */
 #ifdef CONFIG_MTRR
-static bool nomtrr __devinitdata;
+static bool nomtrr;
 #endif
 
 /*
@@ -107,7 +107,7 @@ struct pm2fb_par
  * Here we define the default structs fb_fix_screeninfo and fb_var_screeninfo
  * if we don't use modedb.
  */
-static struct fb_fix_screeninfo pm2fb_fix __devinitdata = {
+static struct fb_fix_screeninfo pm2fb_fix = {
 	.id =		"",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_PSEUDOCOLOR,
@@ -120,7 +120,7 @@ static struct fb_fix_screeninfo pm2fb_fix __devinitdata = {
 /*
  * Default video mode. In case the modedb doesn't work.
  */
-static struct fb_var_screeninfo pm2fb_var __devinitdata = {
+static struct fb_var_screeninfo pm2fb_var = {
 	/* "640x480, 8 bpp @ 60 Hz */
 	.xres =			640,
 	.yres =			480,
diff --git a/drivers/video/pm3fb.c b/drivers/video/pm3fb.c
index 1fdae1d..60d608b 100644
--- a/drivers/video/pm3fb.c
+++ b/drivers/video/pm3fb.c
@@ -56,12 +56,12 @@
  * Driver data
  */
 static int hwcursor = 1;
-static char *mode_option __devinitdata;
-static bool noaccel __devinitdata;
+static char *mode_option;
+static bool noaccel;
 
 /* mtrr option */
 #ifdef CONFIG_MTRR
-static bool nomtrr __devinitdata;
+static bool nomtrr;
 #endif
 
 /*
@@ -84,7 +84,7 @@ struct pm3_par {
  * if we don't use modedb. If we do use modedb see pm3fb_init how to use it
  * to get a fb_var_screeninfo. Otherwise define a default var as well.
  */
-static struct fb_fix_screeninfo pm3fb_fix __devinitdata = {
+static struct fb_fix_screeninfo pm3fb_fix = {
 	.id =		"Permedia3",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_PSEUDOCOLOR,
diff --git a/drivers/video/pmag-ba-fb.c b/drivers/video/pmag-ba-fb.c
index e5d2994..d1e46ce 100644
--- a/drivers/video/pmag-ba-fb.c
+++ b/drivers/video/pmag-ba-fb.c
@@ -43,7 +43,7 @@ struct pmagbafb_par {
 };
 
 
-static struct fb_var_screeninfo pmagbafb_defined __devinitdata = {
+static struct fb_var_screeninfo pmagbafb_defined = {
 	.xres		= 1024,
 	.yres		= 864,
 	.xres_virtual	= 1024,
@@ -67,7 +67,7 @@ static struct fb_var_screeninfo pmagbafb_defined __devinitdata = {
 	.vmode		= FB_VMODE_NONINTERLACED,
 };
 
-static struct fb_fix_screeninfo pmagbafb_fix __devinitdata = {
+static struct fb_fix_screeninfo pmagbafb_fix = {
 	.id		= "PMAG-BA",
 	.smem_len	= (1024 * 1024),
 	.type		= FB_TYPE_PACKED_PIXELS,
diff --git a/drivers/video/pmagb-b-fb.c b/drivers/video/pmagb-b-fb.c
index e731baf..0e13174 100644
--- a/drivers/video/pmagb-b-fb.c
+++ b/drivers/video/pmagb-b-fb.c
@@ -44,7 +44,7 @@ struct pmagbbfb_par {
 };
 
 
-static struct fb_var_screeninfo pmagbbfb_defined __devinitdata = {
+static struct fb_var_screeninfo pmagbbfb_defined = {
 	.bits_per_pixel	= 8,
 	.red.length	= 8,
 	.green.length	= 8,
@@ -57,7 +57,7 @@ static struct fb_var_screeninfo pmagbbfb_defined __devinitdata = {
 	.vmode		= FB_VMODE_NONINTERLACED,
 };
 
-static struct fb_fix_screeninfo pmagbbfb_fix __devinitdata = {
+static struct fb_fix_screeninfo pmagbbfb_fix = {
 	.id		= "PMAGB-BA",
 	.smem_len	= (2048 * 1024),
 	.type		= FB_TYPE_PACKED_PIXELS,
@@ -181,7 +181,7 @@ static void pmagbbfb_screen_setup(struct fb_info *info)
  */
 static void pmagbbfb_osc_setup(struct fb_info *info)
 {
-	static unsigned int pmagbbfb_freqs[] __devinitdata = {
+	static unsigned int pmagbbfb_freqs[] = {
 		130808, 119843, 104000, 92980, 74370, 72800,
 		69197, 66000, 65000, 50350, 36000, 32000, 25175
 	};
diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index 536a098..920c27b 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -259,7 +259,7 @@ static const struct fb_videomode ps3fb_modedb[] = {
 static int ps3fb_mode;
 module_param(ps3fb_mode, int, 0);
 
-static char *mode_option __devinitdata;
+static char *mode_option;
 
 static int ps3fb_cmp_mode(const struct fb_videomode *vmode,
 			  const struct fb_var_screeninfo *var)
diff --git a/drivers/video/pvr2fb.c b/drivers/video/pvr2fb.c
index 1192343..05ca970 100644
--- a/drivers/video/pvr2fb.c
+++ b/drivers/video/pvr2fb.c
@@ -112,11 +112,11 @@ enum { VO_PAL, VO_NTSC, VO_VGA };
 enum { PAL_ARGB1555, PAL_RGB565, PAL_ARGB4444, PAL_ARGB8888 };
 
 struct pvr2_params { unsigned int val; char *name; };
-static struct pvr2_params cables[] __devinitdata = {
+static struct pvr2_params cables[] = {
 	{ CT_VGA, "VGA" }, { CT_RGB, "RGB" }, { CT_COMPOSITE, "COMPOSITE" },
 };
 
-static struct pvr2_params outputs[] __devinitdata = {
+static struct pvr2_params outputs[] = {
 	{ VO_PAL, "PAL" }, { VO_NTSC, "NTSC" }, { VO_VGA, "VGA" },
 };
 
@@ -145,7 +145,7 @@ static struct pvr2fb_par {
 
 static struct fb_info *fb_info;
 
-static struct fb_fix_screeninfo pvr2_fix __devinitdata = {
+static struct fb_fix_screeninfo pvr2_fix = {
 	.id =		"NEC PowerVR2",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_TRUECOLOR,
@@ -154,7 +154,7 @@ static struct fb_fix_screeninfo pvr2_fix __devinitdata = {
 	.accel =	FB_ACCEL_NONE,
 };
 
-static struct fb_var_screeninfo pvr2_var __devinitdata = {
+static struct fb_var_screeninfo pvr2_var = {
 	.xres =		640,
 	.yres =		480,
 	.xres_virtual =	640,
@@ -226,7 +226,7 @@ static struct fb_ops pvr2fb_ops = {
 	.fb_imageblit	= cfb_imageblit,
 };
 
-static struct fb_videomode pvr2_modedb[] __devinitdata = {
+static struct fb_videomode pvr2_modedb[] = {
     /*
      * Broadcast video modes (PAL and NTSC).  I'm unfamiliar with
      * PAL-M and PAL-N, but from what I've read both modes parallel PAL and
@@ -256,7 +256,7 @@ static struct fb_videomode pvr2_modedb[] __devinitdata = {
 #define DEFMODE_VGA	2
 
 static int defmode = DEFMODE_NTSC;
-static char *mode_option __devinitdata = NULL;
+static char *mode_option = NULL;
 
 static inline void pvr2fb_set_pal_type(unsigned int type)
 {
@@ -967,7 +967,7 @@ static void __devexit pvr2fb_pci_remove(struct pci_dev *pdev)
 	pci_release_regions(pdev);
 }
 
-static struct pci_device_id pvr2fb_pci_tbl[] __devinitdata = {
+static struct pci_device_id pvr2fb_pci_tbl[] = {
 	{ PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_NEON250,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0, },
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 1ff1a16..9289bcf 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -2031,7 +2031,7 @@ static int pxafb_parse_options(struct device *dev, char *options)
 	return 0;
 }
 
-static char g_options[256] __devinitdata = "";
+static char g_options[256] = "";
 
 #ifndef MODULE
 static int __init pxafb_setup_options(void)
diff --git a/drivers/video/q40fb.c b/drivers/video/q40fb.c
index d1a7529..d44c735 100644
--- a/drivers/video/q40fb.c
+++ b/drivers/video/q40fb.c
@@ -27,7 +27,7 @@
 
 #define Q40_PHYS_SCREEN_ADDR 0xFE800000
 
-static struct fb_fix_screeninfo q40fb_fix __devinitdata = {
+static struct fb_fix_screeninfo q40fb_fix = {
 	.id		= "Q40",
 	.smem_len	= 1024*1024,
 	.type		= FB_TYPE_PACKED_PIXELS,
@@ -36,7 +36,7 @@ static struct fb_fix_screeninfo q40fb_fix __devinitdata = {
 	.accel		= FB_ACCEL_NONE,
 };
 
-static struct fb_var_screeninfo q40fb_var __devinitdata = {
+static struct fb_var_screeninfo q40fb_var = {
 	.xres		= 1024,
 	.yres		= 512,
 	.xres_virtual	= 1024,
diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index 49caea2..0cdf63b 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -205,28 +205,28 @@ MODULE_DEVICE_TABLE(pci, rivafb_pci_tbl);
  * ------------------------------------------------------------------------- */
 
 /* command line data, set in rivafb_setup() */
-static int flatpanel __devinitdata = -1; /* Autodetect later */
-static int forceCRTC __devinitdata = -1;
-static bool noaccel  __devinitdata = 0;
+static int flatpanel = -1; /* Autodetect later */
+static int forceCRTC = -1;
+static bool noaccel  = 0;
 #ifdef CONFIG_MTRR
-static bool nomtrr __devinitdata = 0;
+static bool nomtrr = 0;
 #endif
 #ifdef CONFIG_PMAC_BACKLIGHT
-static int backlight __devinitdata = 1;
+static int backlight = 1;
 #else
-static int backlight __devinitdata = 0;
+static int backlight = 0;
 #endif
 
-static char *mode_option __devinitdata = NULL;
+static char *mode_option = NULL;
 static bool strictmode       = 0;
 
-static struct fb_fix_screeninfo __devinitdata rivafb_fix = {
+static struct fb_fix_screeninfo rivafb_fix = {
 	.type		= FB_TYPE_PACKED_PIXELS,
 	.xpanstep	= 1,
 	.ypanstep	= 1,
 };
 
-static struct fb_var_screeninfo __devinitdata rivafb_default_var = {
+static struct fb_var_screeninfo rivafb_default_var = {
 	.xres		= 640,
 	.yres		= 480,
 	.xres_virtual	= 640,
diff --git a/drivers/video/s1d13xxxfb.c b/drivers/video/s1d13xxxfb.c
index f7839e1..395d166 100644
--- a/drivers/video/s1d13xxxfb.c
+++ b/drivers/video/s1d13xxxfb.c
@@ -84,7 +84,7 @@ static const char *s1d13xxxfb_prod_names[] = {
 /*
  * here we define the default struct fb_fix_screeninfo
  */
-static struct fb_fix_screeninfo __devinitdata s1d13xxxfb_fix = {
+static struct fb_fix_screeninfo s1d13xxxfb_fix = {
 	.id		= S1D_FBID,
 	.type		= FB_TYPE_PACKED_PIXELS,
 	.visual		= FB_VISUAL_PSEUDOCOLOR,
@@ -622,7 +622,7 @@ static struct fb_ops s1d13xxxfb_fbops = {
 	.fb_imageblit	= cfb_imageblit,
 };
 
-static int s1d13xxxfb_width_tab[2][4] __devinitdata = {
+static int s1d13xxxfb_width_tab[2][4] = {
 	{4, 8, 16, -1},
 	{9, 12, 18, -1},
 };
diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index e66ecbb..0ff9a77 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -153,10 +153,10 @@ static const struct svga_timing_regs s3_timing_regs     = {
 /* Module parameters */
 
 
-static char *mode_option __devinitdata;
+static char *mode_option;
 
 #ifdef CONFIG_MTRR
-static int mtrr __devinitdata = 1;
+static int mtrr = 1;
 #endif
 
 static int fasttext = 1;
@@ -1509,7 +1509,7 @@ static int s3_pci_resume(struct pci_dev* dev)
 
 /* List of boards that we are trying to support */
 
-static struct pci_device_id s3_devices[] __devinitdata = {
+static struct pci_device_id s3_devices[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8810), .driver_data = CHIP_XXX_TRIO},
 	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8811), .driver_data = CHIP_XXX_TRIO},
 	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8812), .driver_data = CHIP_M65_AURORA64VP},
diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index 5e79fea..cfbde5e 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -1116,7 +1116,7 @@ static int sa1100fb_map_video_memory(struct sa1100fb_info *fbi)
 }
 
 /* Fake monspecs to fill in fbinfo structure */
-static struct fb_monspecs monspecs __devinitdata = {
+static struct fb_monspecs monspecs = {
 	.hfmin	= 30000,
 	.hfmax	= 70000,
 	.vfmin	= 50,
diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index dbf8d62..4bfb8c6 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -69,7 +69,7 @@
 /* --------------------------------------------------------------------- */
 
 
-static char *mode_option __devinitdata = NULL;
+static char *mode_option = NULL;
 
 #ifdef MODULE
 
@@ -1664,7 +1664,7 @@ static struct fb_ops savagefb_ops = {
 
 /* --------------------------------------------------------------------- */
 
-static struct fb_var_screeninfo __devinitdata savagefb_var800x600x8 = {
+static struct fb_var_screeninfo savagefb_var800x600x8 = {
 	.accel_flags =	FB_ACCELF_TEXT,
 	.xres =		800,
 	.yres =		600,
@@ -2449,7 +2449,7 @@ static int savagefb_resume(struct pci_dev* dev)
 }
 
 
-static struct pci_device_id savagefb_devices[] __devinitdata = {
+static struct pci_device_id savagefb_devices[] = {
 	{PCI_VENDOR_ID_S3, PCI_CHIP_SUPSAV_MX128,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_SUPERSAVAGE},
 
diff --git a/drivers/video/sgivwfb.c b/drivers/video/sgivwfb.c
index c65ab22..23df880 100644
--- a/drivers/video/sgivwfb.c
+++ b/drivers/video/sgivwfb.c
@@ -47,7 +47,7 @@ static int ywrap = 0;
 
 static int flatpanel_id = -1;
 
-static struct fb_fix_screeninfo sgivwfb_fix __devinitdata = {
+static struct fb_fix_screeninfo sgivwfb_fix = {
 	.id		= "SGI Vis WS FB",
 	.type		= FB_TYPE_PACKED_PIXELS,
         .visual		= FB_VISUAL_PSEUDOCOLOR,
@@ -57,7 +57,7 @@ static struct fb_fix_screeninfo sgivwfb_fix __devinitdata = {
 	.line_length	= 640,
 };
 
-static struct fb_var_screeninfo sgivwfb_var __devinitdata = {
+static struct fb_var_screeninfo sgivwfb_var = {
 	/* 640x480, 8 bpp */
 	.xres		= 640,
 	.yres		= 480,
@@ -79,7 +79,7 @@ static struct fb_var_screeninfo sgivwfb_var __devinitdata = {
 	.vmode		= FB_VMODE_NONINTERLACED
 };
 
-static struct fb_var_screeninfo sgivwfb_var1600sw __devinitdata = {
+static struct fb_var_screeninfo sgivwfb_var1600sw = {
 	/* 1600x1024, 8 bpp */
 	.xres		= 1600,
 	.yres		= 1024,
diff --git a/drivers/video/sis/sis_main.h b/drivers/video/sis/sis_main.h
index 9540e97..32e23c2 100644
--- a/drivers/video/sis/sis_main.h
+++ b/drivers/video/sis/sis_main.h
@@ -98,7 +98,7 @@ static struct sisfb_chip_info {
 	int		hwcursor_size;
 	int		CRT2_write_enable;
 	const char	*chip_name;
-} sisfb_chip_info[] __devinitdata = {
+} sisfb_chip_info[] = {
 	{ SIS_300,    SIS_300_VGA, 0, HW_CURSOR_AREA_SIZE_300 * 2, SIS_CRT2_WENABLE_300, "SiS 300/305" },
 	{ SIS_540,    SIS_300_VGA, 0, HW_CURSOR_AREA_SIZE_300 * 2, SIS_CRT2_WENABLE_300, "SiS 540" },
 	{ SIS_630,    SIS_300_VGA, 0, HW_CURSOR_AREA_SIZE_300 * 2, SIS_CRT2_WENABLE_300, "SiS 630" },
@@ -113,7 +113,7 @@ static struct sisfb_chip_info {
 	{ XGI_40,     SIS_315_VGA, 1, HW_CURSOR_AREA_SIZE_315 * 4, SIS_CRT2_WENABLE_315, "XGI V3XT/V5/V8" },
 };
 
-static struct pci_device_id __devinitdata sisfb_pci_table[] = {
+static struct pci_device_id sisfb_pci_table[] = {
 #ifdef CONFIG_FB_SIS_300
 	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_300,     PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_540_VGA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
@@ -317,7 +317,7 @@ static struct _sis_lcd_data {
 	u16 xres;
 	u16 yres;
 	u8  default_mode_idx;
-} sis_lcd_data[] __devinitdata = {
+} sis_lcd_data[] = {
 	{ LCD_640x480,    640,  480,  23 },
 	{ LCD_800x600,    800,  600,  43 },
 	{ LCD_1024x600,  1024,  600,  67 },
@@ -339,21 +339,21 @@ static struct _sis_lcd_data {
 };
 
 /* CR36 evaluation */
-static unsigned short sis300paneltype[] __devinitdata = {
+static unsigned short sis300paneltype[] = {
 	LCD_UNKNOWN,   LCD_800x600,   LCD_1024x768,  LCD_1280x1024,
 	LCD_1280x960,  LCD_640x480,   LCD_1024x600,  LCD_1152x768,
 	LCD_UNKNOWN,   LCD_UNKNOWN,   LCD_UNKNOWN,   LCD_UNKNOWN,
 	LCD_UNKNOWN,   LCD_UNKNOWN,   LCD_UNKNOWN,   LCD_UNKNOWN
 };
 
-static unsigned short sis310paneltype[] __devinitdata = {
+static unsigned short sis310paneltype[] = {
 	LCD_UNKNOWN,   LCD_800x600,   LCD_1024x768,  LCD_1280x1024,
 	LCD_640x480,   LCD_1024x600,  LCD_1152x864,  LCD_1280x960,
 	LCD_1152x768,  LCD_1400x1050, LCD_1280x768,  LCD_1600x1200,
 	LCD_320x240_2, LCD_320x240_3, LCD_UNKNOWN,   LCD_UNKNOWN
 };
 
-static unsigned short sis661paneltype[] __devinitdata = {
+static unsigned short sis661paneltype[] = {
 	LCD_UNKNOWN,   LCD_800x600,   LCD_1024x768,  LCD_1280x1024,
 	LCD_640x480,   LCD_1024x600,  LCD_1152x864,  LCD_1280x960,
 	LCD_1280x854,  LCD_1400x1050, LCD_1280x768,  LCD_1600x1200,
@@ -466,7 +466,7 @@ static struct _sisfbddcsmodes {
 	u16 h;
 	u16 v;
 	u32 d;
-} sisfb_ddcsmodes[] __devinitdata = {
+} sisfb_ddcsmodes[] = {
 	{ 0x10000, 67, 75, 108000},
 	{ 0x08000, 48, 72,  50000},
 	{ 0x04000, 46, 75,  49500},
@@ -488,7 +488,7 @@ static struct _sisfbddcfmodes {
 	u16 v;
 	u16 h;
 	u32 d;
-} sisfb_ddcfmodes[] __devinitdata = {
+} sisfb_ddcfmodes[] = {
 	{ 1280, 1024, 85, 92, 157500},
 	{ 1600, 1200, 60, 75, 162000},
 	{ 1600, 1200, 65, 82, 175500},
@@ -505,7 +505,7 @@ static struct _chswtable {
 	u16  subsysCard;
 	char *vendorName;
 	char *cardName;
-} mychswtable[] __devinitdata = {
+} mychswtable[] = {
 	{ 0x1631, 0x1002, "Mitachi", "0x1002" },
 	{ 0x1071, 0x7521, "Mitac"  , "7521P"  },
 	{ 0,      0,      ""       , ""       }
@@ -525,7 +525,7 @@ static struct _customttable {
 	char  *cardName;
 	u32   SpecialID;
 	char  *optionName;
-} mycustomttable[] __devinitdata = {
+} mycustomttable[] = {
 	{ SIS_630, "2.00.07", "09/27/2002-13:38:25",
 	  0x3240A8,
 	  { 0x220, 0x227, 0x228, 0x229, 0x0ee },
diff --git a/drivers/video/skeletonfb.c b/drivers/video/skeletonfb.c
index 28a38ba..dde47f7 100644
--- a/drivers/video/skeletonfb.c
+++ b/drivers/video/skeletonfb.c
@@ -63,7 +63,7 @@
 /*
  * Driver data
  */
-static char *mode_option __devinitdata;
+static char *mode_option;
 
 /*
  *  If your driver supports multiple boards, you should make the  
@@ -84,7 +84,7 @@ struct xxx_par;
  * if we don't use modedb. If we do use modedb see xxxfb_init how to use it
  * to get a fb_var_screeninfo. Otherwise define a default var as well. 
  */
-static struct fb_fix_screeninfo xxxfb_fix __devinitdata = {
+static struct fb_fix_screeninfo xxxfb_fix = {
 	.id =		"FB's name", 
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_PSEUDOCOLOR,
@@ -706,8 +706,7 @@ static int xxxfb_probe(struct pci_dev *dev,
     info->screen_base = framebuffer_virtual_memory;
     info->fbops = &xxxfb_ops;
     info->fix = xxxfb_fix; /* this will be the only time xxxfb_fix will be
-			    * used, so mark it as __devinitdata
-			    */
+			    * used, so mark it as 			    */
     info->pseudo_palette = pseudo_palette; /* The pseudopalette is an
 					    * 16-member array
 					    */
diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
index 6703712..3b16889 100644
--- a/drivers/video/sm501fb.c
+++ b/drivers/video/sm501fb.c
@@ -46,7 +46,7 @@
 static char *fb_mode = "640x480-16@60";
 static unsigned long default_bpp = 16;
 
-static struct fb_videomode __devinitdata sm501_default_mode = {
+static struct fb_videomode sm501_default_mode = {
 	.refresh	= 60,
 	.xres		= 640,
 	.yres		= 480,
diff --git a/drivers/video/sstfb.c b/drivers/video/sstfb.c
index c4ce3ef..49f9338 100644
--- a/drivers/video/sstfb.c
+++ b/drivers/video/sstfb.c
@@ -104,7 +104,7 @@ static bool slowpci;		/* slow PCI settings */
 */
 #define DEFAULT_VIDEO_MODE "640x480@60"
 
-static char *mode_option __devinitdata = DEFAULT_VIDEO_MODE;
+static char *mode_option = DEFAULT_VIDEO_MODE;
 
 enum {
 	ID_VOODOO1 = 0,
@@ -113,7 +113,7 @@ enum {
 
 #define IS_VOODOO2(par) ((par)->type == ID_VOODOO2)
 
-static struct sst_spec voodoo_spec[] __devinitdata = {
+static struct sst_spec voodoo_spec[] = {
  { .name = "Voodoo Graphics", .default_gfx_clock = 50000, .max_gfxclk = 60 },
  { .name = "Voodoo2",	      .default_gfx_clock = 75000, .max_gfxclk = 85 },
 };
@@ -1105,7 +1105,7 @@ static void sst_set_vidmod_ics(struct fb_info *info, const int bpp)
  */
 
 
-static struct dac_switch dacs[] __devinitdata = {
+static struct dac_switch dacs[] = {
 	{	.name		= "TI TVP3409",
 		.detect		= sst_detect_ti,
 		.set_pll	= sst_set_pll_att_ti,
diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
index efbf5c9..09ec76319 100644
--- a/drivers/video/tdfxfb.c
+++ b/drivers/video/tdfxfb.c
@@ -100,7 +100,7 @@ static inline int mtrr_del(int reg, unsigned long base,
 #define VOODOO3_MAX_PIXCLOCK 300000
 #define VOODOO5_MAX_PIXCLOCK 350000
 
-static struct fb_fix_screeninfo tdfx_fix __devinitdata = {
+static struct fb_fix_screeninfo tdfx_fix = {
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_PSEUDOCOLOR,
 	.ypanstep =	1,
@@ -108,7 +108,7 @@ static struct fb_fix_screeninfo tdfx_fix __devinitdata = {
 	.accel =	FB_ACCEL_3DFX_BANSHEE
 };
 
-static struct fb_var_screeninfo tdfx_var __devinitdata = {
+static struct fb_var_screeninfo tdfx_var = {
 	/* "640x480, 8 bpp @ 60 Hz */
 	.xres =		640,
 	.yres =		480,
@@ -167,9 +167,9 @@ MODULE_DEVICE_TABLE(pci, tdfxfb_id_table);
 static int nopan;
 static int nowrap = 1;      /* not implemented (yet) */
 static int hwcursor = 1;
-static char *mode_option __devinitdata;
+static char *mode_option;
 /* mtrr option */
-static bool nomtrr __devinitdata;
+static bool nomtrr;
 
 /* -------------------------------------------------------------------------
  *			Hardware-specific funcions
diff --git a/drivers/video/tmiofb.c b/drivers/video/tmiofb.c
index 3f7527a..91246ab 100644
--- a/drivers/video/tmiofb.c
+++ b/drivers/video/tmiofb.c
@@ -191,7 +191,7 @@
 #define LCR_VCLKHW		0x1b4 /* VCLK High Width		*/
 #define LCR_OC			0x1b6 /* Output Control			*/
 
-static char *mode_option __devinitdata;
+static char *mode_option;
 
 struct tmiofb_par {
 	u32				pseudo_palette[16];
diff --git a/drivers/video/tridentfb.c b/drivers/video/tridentfb.c
index f1a8495..03edce6 100644
--- a/drivers/video/tridentfb.c
+++ b/drivers/video/tridentfb.c
@@ -53,19 +53,19 @@ static struct fb_fix_screeninfo tridentfb_fix = {
 /* defaults which are normally overriden by user values */
 
 /* video mode */
-static char *mode_option __devinitdata = "640x480-8@60";
-static int bpp __devinitdata = 8;
+static char *mode_option = "640x480-8@60";
+static int bpp = 8;
 
-static int noaccel __devinitdata;
+static int noaccel;
 
 static int center;
 static int stretch;
 
-static int fp __devinitdata;
-static int crt __devinitdata;
+static int fp;
+static int crt;
 
-static int memsize __devinitdata;
-static int memdiff __devinitdata;
+static int memsize;
+static int memdiff;
 static int nativex;
 
 module_param(mode_option, charp, 0);
diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index a776c8e..ad5e72d 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -36,26 +36,26 @@ static struct cb_id uvesafb_cn_id = {
 static char v86d_path[PATH_MAX] = "/sbin/v86d";
 static char v86d_started;	/* has v86d been started by uvesafb? */
 
-static struct fb_fix_screeninfo uvesafb_fix __devinitdata = {
+static struct fb_fix_screeninfo uvesafb_fix = {
 	.id	= "VESA VGA",
 	.type	= FB_TYPE_PACKED_PIXELS,
 	.accel	= FB_ACCEL_NONE,
 	.visual = FB_VISUAL_TRUECOLOR,
 };
 
-static int mtrr		__devinitdata = 3; /* enable mtrr by default */
+static int mtrr		= 3; /* enable mtrr by default */
 static bool blank	= 1;		   /* enable blanking by default */
 static int ypan		= 1; 		 /* 0: scroll, 1: ypan, 2: ywrap */
-static bool pmi_setpal	__devinitdata = true; /* use PMI for palette changes */
-static bool nocrtc	__devinitdata; /* ignore CRTC settings */
-static bool noedid	__devinitdata; /* don't try DDC transfers */
-static int vram_remap	__devinitdata; /* set amt. of memory to be used */
-static int vram_total	__devinitdata; /* set total amount of memory */
-static u16 maxclk	__devinitdata; /* maximum pixel clock */
-static u16 maxvf	__devinitdata; /* maximum vertical frequency */
-static u16 maxhf	__devinitdata; /* maximum horizontal frequency */
-static u16 vbemode	__devinitdata; /* force use of a specific VBE mode */
-static char *mode_option __devinitdata;
+static bool pmi_setpal	= true; /* use PMI for palette changes */
+static bool nocrtc; /* ignore CRTC settings */
+static bool noedid; /* don't try DDC transfers */
+static int vram_remap; /* set amt. of memory to be used */
+static int vram_total; /* set total amount of memory */
+static u16 maxclk; /* maximum pixel clock */
+static u16 maxvf; /* maximum vertical frequency */
+static u16 maxhf; /* maximum horizontal frequency */
+static u16 vbemode; /* force use of a specific VBE mode */
+static char *mode_option;
 static u8  dac_width	= 6;
 
 static struct uvesafb_ktask *uvfb_tasks[UVESAFB_TASKS_MAX];
diff --git a/drivers/video/vfb.c b/drivers/video/vfb.c
index f4cb015..8bc1f93 100644
--- a/drivers/video/vfb.c
+++ b/drivers/video/vfb.c
@@ -78,7 +78,7 @@ static void rvfree(void *mem, unsigned long size)
 	vfree(mem);
 }
 
-static struct fb_var_screeninfo vfb_default __devinitdata = {
+static struct fb_var_screeninfo vfb_default = {
 	.xres =		640,
 	.yres =		480,
 	.xres_virtual =	640,
@@ -100,7 +100,7 @@ static struct fb_var_screeninfo vfb_default __devinitdata = {
       	.vmode =	FB_VMODE_NONINTERLACED,
 };
 
-static struct fb_fix_screeninfo vfb_fix __devinitdata = {
+static struct fb_fix_screeninfo vfb_fix = {
 	.id =		"Virtual FB",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_PSEUDOCOLOR,
diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
index 0e53f39..99c0edb 100644
--- a/drivers/video/vga16fb.c
+++ b/drivers/video/vga16fb.c
@@ -65,7 +65,7 @@ struct vga16fb_par {
 
 /* --------------------------------------------------------------------- */
 
-static struct fb_var_screeninfo vga16fb_defined __devinitdata = {
+static struct fb_var_screeninfo vga16fb_defined = {
 	.xres		= 640,
 	.yres		= 480,
 	.xres_virtual	= 640,
@@ -85,7 +85,7 @@ static struct fb_var_screeninfo vga16fb_defined __devinitdata = {
 };
 
 /* name should not depend on EGA/VGA */
-static struct fb_fix_screeninfo vga16fb_fix __devinitdata = {
+static struct fb_fix_screeninfo vga16fb_fix = {
 	.id		= "VGA16 VGA",
 	.smem_start	= VGA_FB_PHYS,
 	.smem_len	= VGA_FB_PHYS_LEN,
diff --git a/drivers/video/via/via-core.c b/drivers/video/via/via-core.c
index abbcb1b..e0d95d5 100644
--- a/drivers/video/via/via-core.c
+++ b/drivers/video/via/via-core.c
@@ -725,7 +725,7 @@ static void __devexit via_pci_remove(struct pci_dev *pdev)
 }
 
 
-static struct pci_device_id via_pci_table[] __devinitdata = {
+static struct pci_device_id via_pci_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_CLE266_DID),
 	  .driver_data = UNICHROME_CLE266 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_K400_DID),
diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index c23c8c7..a3cbe8f 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -906,7 +906,7 @@ fail:
 
 /* List of boards that we are trying to support */
 
-static struct pci_device_id vt8623_devices[] __devinitdata = {
+static struct pci_device_id vt8623_devices[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_VIA, 0x3122)},
 	{0, 0, 0, 0, 0, 0, 0}
 };
diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index b5d317c..eab07ba 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -491,7 +491,7 @@ static int __devexit xilinxfb_of_remove(struct platform_device *op)
 }
 
 /* Match table for of_platform binding */
-static struct of_device_id xilinxfb_of_match[] __devinitdata = {
+static struct of_device_id xilinxfb_of_match[] = {
 	{ .compatible = "xlnx,xps-tft-1.00.a", },
 	{ .compatible = "xlnx,xps-tft-2.00.a", },
 	{ .compatible = "xlnx,xps-tft-2.01.a", },
-- 
1.8.0
