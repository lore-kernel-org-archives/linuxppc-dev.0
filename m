Return-Path: <sfr@canb.auug.org.au>
Date: Fri, 20 Aug 2010 19:52:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@linux-foundation.org>
Subject: [PATCH] MAINTAINERS: Fix ozlabs.org mailing list addresses
Message-Id: <20100820195245.63199751.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: cbe-oss-dev@lists.ozlabs.org, lguest@lists.ozlabs.org,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All these lists moved to lists.ozlabs.org quite a while ago.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 MAINTAINERS |   56 ++++++++++++++++++++++++++++----------------------------
 1 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b5b8baa..433f353 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -456,7 +456,7 @@ F:	drivers/infiniband/hw/amso1100/
 
 AOA (Apple Onboard Audio) ALSA DRIVER
 M:	Johannes Berg <johannes@sipsolutions.net>
-L:	linuxppc-dev@ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
 F:	sound/aoa/
@@ -1472,8 +1472,8 @@ F:	include/linux/can/platform/
 
 CELL BROADBAND ENGINE ARCHITECTURE
 M:	Arnd Bergmann <arnd@arndb.de>
-L:	linuxppc-dev@ozlabs.org
-L:	cbe-oss-dev@ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
+L:	cbe-oss-dev@lists.ozlabs.org
 W:	http://www.ibm.com/developerworks/power/cell/
 S:	Supported
 F:	arch/powerpc/include/asm/cell*.h
@@ -2371,13 +2371,13 @@ F:	include/linux/fb.h
 FREESCALE DMA DRIVER
 M:	Li Yang <leoli@freescale.com>
 M:	Zhang Wei <zw@zh-kernel.org>
-L:	linuxppc-dev@ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	drivers/dma/fsldma.*
 
 FREESCALE I2C CPM DRIVER
 M:	Jochen Friedrich <jochen@scram.de>
-L:	linuxppc-dev@ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/busses/i2c-cpm.c
@@ -2393,7 +2393,7 @@ F:	drivers/video/imxfb.c
 FREESCALE SOC FS_ENET DRIVER
 M:	Pantelis Antoniou <pantelis.antoniou@gmail.com>
 M:	Vitaly Bordug <vbordug@ru.mvista.com>
-L:	linuxppc-dev@ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/fs_enet/
@@ -2401,7 +2401,7 @@ F:	include/linux/fs_enet_pd.h
 
 FREESCALE QUICC ENGINE LIBRARY
 M:	Timur Tabi <timur@freescale.com>
-L:	linuxppc-dev@ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 F:	arch/powerpc/sysdev/qe_lib/
 F:	arch/powerpc/include/asm/*qe.h
@@ -2409,27 +2409,27 @@ F:	arch/powerpc/include/asm/*qe.h
 FREESCALE USB PERIPHERAL DRIVERS
 M:	Li Yang <leoli@freescale.com>
 L:	linux-usb@vger.kernel.org
-L:	linuxppc-dev@ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	drivers/usb/gadget/fsl*
 
 FREESCALE QUICC ENGINE UCC ETHERNET DRIVER
 M:	Li Yang <leoli@freescale.com>
 L:	netdev@vger.kernel.org
-L:	linuxppc-dev@ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	drivers/net/ucc_geth*
 
 FREESCALE QUICC ENGINE UCC UART DRIVER
 M:	Timur Tabi <timur@freescale.com>
-L:	linuxppc-dev@ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 F:	drivers/serial/ucc_uart.c
 
 FREESCALE SOC SOUND DRIVERS
 M:	Timur Tabi <timur@freescale.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-L:	linuxppc-dev@ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 F:	sound/soc/fsl/fsl*
 F:	sound/soc/fsl/mpc8610_hpcd.c
@@ -2564,7 +2564,7 @@ F:	mm/memory-failure.c
 F:	mm/hwpoison-inject.c
 
 HYPERVISOR VIRTUAL CONSOLE DRIVER
-L:	linuxppc-dev@ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
 S:	Odd Fixes
 F:	drivers/char/hvc_*
 
@@ -3476,7 +3476,7 @@ F:	drivers/usb/misc/legousbtower.c
 
 LGUEST
 M:	Rusty Russell <rusty@rustcorp.com.au>
-L:	lguest@ozlabs.org
+L:	lguest@lists.ozlabs.org
 W:	http://lguest.ozlabs.org/
 S:	Maintained
 F:	Documentation/lguest/
@@ -3495,7 +3495,7 @@ LINUX FOR POWERPC (32-BIT AND 64-BIT)
 M:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
 M:	Paul Mackerras <paulus@samba.org>
 W:	http://www.penguinppc.org/
-L:	linuxppc-dev@ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
 Q:	http://patchwork.ozlabs.org/project/linuxppc-dev/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
 S:	Supported
@@ -3505,14 +3505,14 @@ F:	arch/powerpc/
 LINUX FOR POWER MACINTOSH
 M:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
 W:	http://www.penguinppc.org/
-L:	linuxppc-dev@ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	arch/powerpc/platforms/powermac/
 F:	drivers/macintosh/
 
 LINUX FOR POWERPC EMBEDDED MPC5XXX
 M:	Grant Likely <grant.likely@secretlab.ca>
-L:	linuxppc-dev@ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
 T:	git git://git.secretlab.ca/git/linux-2.6.git
 S:	Maintained
 F:	arch/powerpc/platforms/512x/
@@ -3522,7 +3522,7 @@ LINUX FOR POWERPC EMBEDDED PPC4XX
 M:	Josh Boyer <jwboyer@linux.vnet.ibm.com>
 M:	Matt Porter <mporter@kernel.crashing.org>
 W:	http://www.penguinppc.org/
-L:	linuxppc-dev@ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git
 S:	Maintained
 F:	arch/powerpc/platforms/40x/
@@ -3531,7 +3531,7 @@ F:	arch/powerpc/platforms/44x/
 LINUX FOR POWERPC EMBEDDED XILINX VIRTEX
 M:	Grant Likely <grant.likely@secretlab.ca>
 W:	http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex
-L:	linuxppc-dev@ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
 T:	git git://git.secretlab.ca/git/linux-2.6.git
 S:	Maintained
 F:	arch/powerpc/*/*virtex*
@@ -3541,20 +3541,20 @@ LINUX FOR POWERPC EMBEDDED PPC8XX
 M:	Vitaly Bordug <vitb@kernel.crashing.org>
 M:	Marcelo Tosatti <marcelo@kvack.org>
 W:	http://www.penguinppc.org/
-L:	linuxppc-dev@ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	arch/powerpc/platforms/8xx/
 
 LINUX FOR POWERPC EMBEDDED PPC83XX AND PPC85XX
 M:	Kumar Gala <galak@kernel.crashing.org>
 W:	http://www.penguinppc.org/
-L:	linuxppc-dev@ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	arch/powerpc/platforms/83xx/
 
 LINUX FOR POWERPC PA SEMI PWRFICIENT
 M:	Olof Johansson <olof@lixom.net>
-L:	linuxppc-dev@ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	arch/powerpc/platforms/pasemi/
 F:	drivers/*/*pasemi*
@@ -4601,14 +4601,14 @@ F:	drivers/ata/sata_promise.*
 PS3 NETWORK SUPPORT
 M:	Geoff Levand <geoff@infradead.org>
 L:	netdev@vger.kernel.org
-L:	cbe-oss-dev@ozlabs.org
+L:	cbe-oss-dev@lists.ozlabs.org
 S:	Maintained
 F:	drivers/net/ps3_gelic_net.*
 
 PS3 PLATFORM SUPPORT
 M:	Geoff Levand <geoff@infradead.org>
-L:	linuxppc-dev@ozlabs.org
-L:	cbe-oss-dev@ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
+L:	cbe-oss-dev@lists.ozlabs.org
 S:	Maintained
 F:	arch/powerpc/boot/ps3*
 F:	arch/powerpc/include/asm/lv1call.h
@@ -4622,7 +4622,7 @@ F:	sound/ppc/snd_ps3*
 
 PS3VRAM DRIVER
 M:	Jim Paris <jim@jtan.com>
-L:	cbe-oss-dev@ozlabs.org
+L:	cbe-oss-dev@lists.ozlabs.org
 S:	Maintained
 F:	drivers/block/ps3vram.c
 
@@ -5068,7 +5068,7 @@ F:	drivers/mmc/host/sdhci.*
 
 SECURE DIGITAL HOST CONTROLLER INTERFACE, OPEN FIRMWARE BINDINGS (SDHCI-OF)
 M:	Anton Vorontsov <avorontsov@ru.mvista.com>
-L:	linuxppc-dev@ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
 L:	linux-mmc@vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/sdhci-of.*
@@ -5485,8 +5485,8 @@ F:	drivers/net/spider_net*
 
 SPU FILE SYSTEM
 M:	Jeremy Kerr <jk@ozlabs.org>
-L:	linuxppc-dev@ozlabs.org
-L:	cbe-oss-dev@ozlabs.org
+L:	linuxppc-dev@lists.ozlabs.org
+L:	cbe-oss-dev@lists.ozlabs.org
 W:	http://www.ibm.com/developerworks/power/cell/
 S:	Supported
 F:	Documentation/filesystems/spufs.txt
-- 
1.7.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
